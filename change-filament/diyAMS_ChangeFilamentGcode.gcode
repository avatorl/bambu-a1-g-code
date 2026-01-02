; =========================================================================
; External Feeder–Assisted Filament Change for Bambu Lab A1 (EXPERIMENTAL)
; Not an AMS… but kinda feels like it
; =========================================================================
; NOTE:
; This system provides AMS-like behavior using an external feeder,
; without using the AMS port, AMS firmware, or internal printer hardware.
; =========================================================================
; Original Author & Base Logic:
;   avatorl
;   https://github.com/avatorl/bambu-a1-g-code
;
; Original Files:
;   a) AMS reference version (A1 2025-10-31):
;      link
;   a) AMS reference version (A1 2025-02-06):
;      https://github.com/avatorl/bambu-a1-g-code/blob/main/change-filament/change-filament-original.gcode
;   b) Manual Filament Change v2:
;      https://github.com/avatorl/bambu-a1-g-code/blob/main/change-filament/a1-manual-filament-change-v2.gcode
;   c) Manual filament change v1:
;      https://github.com/avatorl/bambu-a1-g-code/blob/main/change-filament/a1-manual-filament-change-v1.gcode
;
; =========================================================================
; This file is a DERIVATIVE WORK based on the original implementation above.
;
; Modifications in this version:
;   - External feeder integration (NO AMS, firmware-safe)
;   - Removal of sound-based filament selection
;   - External feeder-controlled filament unload/load
;
; All credit for the original filament change logic belongs to avatorl.
; This version only extends the workflow to support external hardware.
; =========================================================================

; === Initialization ===
G392 S0									; turn off clog detection
M204 S9000								; set print acceleration

; === Lift toolhead ===
G1 Z{max_layer_z + 3.0} F1200			                        ; lift nozzle 3mm above highest layer
M400									; wait for all moves to finish

; === Reheat nozzle ===
M106 P1 S0								; turn off part cooling fan

{if old_filament_temp > 142 && next_extruder < 255}
M104 S[old_filament_temp]						; restore old filament temperature (if above 142°C)
{endif}

; === Cut filament ===
M412 S0              ; disable runout detection temporarily
G1 E-15 F1000        ; retract 15 mm
G1 X267 F18000       ; fast move to cutter
G1 X278 F400         ; slow move to cutter
; If cutter error occurs, reduce X value slightly (use 2nd/3rd row)
G1 X283 E-5 F80
; Alternatives:
; G1 X282 E-5 F80
; G1 X281 E-5 F80

G1 X260 F6000                           ; move away from cutter
M400                                    ; wait for all moves to finish

; === Purge wiper ===
G1 X-38.2 F18000     ; fast move to wiper start
G1 X-48.2 F3000      ; slow move to wiper end
M400                 ; wait

; === Unload filament ===
G1 E-30 F1000        ; retract 30 mm
M400                 ; wait
G1 Y246 F10000       ; fast bed move
G1 Y256 F1000        ; bed to feeder listening mode
M400 S2              ; wait 2 sec

; === Filament number communication ===
; Because apparently 4 colors wasn’t enough…
;
; next_extruder == 0 → filament #1
; ...
; next_extruder == 30 → filament #31
; Slots spaced in 10 mm increments from X-38.2 (slot 1) to X261.8 (slot 31).
; Higher filament number = farther right.
;
; Would you really print with 31 different filaments? (Yes, it's supported… but why???)

{if next_extruder >= 0 && next_extruder <= 30}
G1 X{-38.2 + (next_extruder * 10)} F3000 ; safe slot move
M400 S3
{else}
M400 U1 ;invalid slot user pause
{endif}


; Excessive, but included for anyone crazy enough to attempt 31 filaments

; === Reset wiper & feeder listening ===
G1 X-38.2 Y128 F18000
G1 X-48.2 F3000
M400


; === Wait for external feeder ===
; This is the part where the printer just stares into space
; while the feeder does the heavy lifting.

M400 S15             ; external feeder swaps filament here
; Future: replace with timed pauses

; External Feeder will:
;   - Pull out old filament
;   - Push in new filament

; === Load new filament ===
M109 S[nozzle_temperature_range_high] 	; set nozzle temp & wait
M412 S1					; re-enable filament runout detection
G1 E13 F200          			; gentle initial load
G1 E2 F20				; slower load
M400              			; short pause

G92 E0					; reset extruder
G1 E70 F500          			
G1 E5 F120                              ; complete load (total 90 mm)
M400                 			; wait

; Inform firmware: new filament active
G92 E0
M1002 set_filament_type:{filament_type[next_extruder]}
M1002 set_filament_loaded:1
M1002 set_filament_changed:1

; === Purge (no AMS) ===
M109 S[nozzle_temperature_range_high]
M106 P1 S60
G92 E0
G1 E18 F{new_filament_e_feedrate}
G1 E2 F120
G1 E18 F{new_filament_e_feedrate}
G1 E2 F120
G1 E18 F{new_filament_e_feedrate}
G1 E2 F120
G1 E18 F{new_filament_e_feedrate}
G1 E2 F120
G1 E18 F{new_filament_e_feedrate}
G1 E2 F50
M400


; === Wipe after purge ===
M106 P1 S178         ; fan speed
M400 S3              ; wait 3 sec

G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
M106 P1 S0
M400

; === Finalizing ===
M400
M106 P1 S60
M109 S[new_filament_temp]
G1 E6 F{new_filament_e_feedrate} ; compensate for spillage
M400
G92 E0                           ; reset extruder
G1 E-[new_retract_length_toolchange] F1800

; wipe
M400
M106 P1 S178
M400 S3
G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
M400

G1 Z{max_layer_z + 3.0} F3000
M106 P1 S0          ; turn off fan

; === Restore acceleration ===
{if layer_z <= (initial_layer_print_height + 0.001)}
M204 S[initial_layer_acceleration]
{else}
M204 S[default_acceleration]
{endif}

G392 S0              ; disable clog detection
M629                 ; finalize filament change lifecycle

; === Resume printing ===
