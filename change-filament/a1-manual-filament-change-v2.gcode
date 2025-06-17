; =========================================================================
; G-code for manual filament change on Bambu Lab A1 3D printer without AMS
; Version 2, based on the original AMS version A1 20250206 and Version 1
; GitHub: https://github.com/avatorl/bambu-a1-g-code/tree/main/no-ams
; ========================================================================

; initialization

M1007 S0								; turn off mass estimation
G392 S0									; turn off clog detect
M204 S9000 								; set print acceleration

; lift the toolhead

G1 Z{max_layer_z + 3.0} F1200           ; lift nozzle 3mm above highest layer to avoid hitting the print
M400                                    ; wait for all moves to finish

; reheat the nozzle

M106 P1 S0
M106 P2 S0

{if old_filament_temp > 142 && next_extruder < 255}
	M104 S[old_filament_temp]
{endif}

; cut filament (no AMS) ==================================================

G1 X267 F18000                            ; Fast move to X=267 at 18000 mm/min (move to right side)
G1 X278 F400                              ; Slow move to X=278 (move to cutter position)
G1 X281 E-5 F80                           ; Extrude reverse 5 mm of filament (retract/cut) while moving to X=281
G1 X267 F6000                             ; Move back to X=267 at moderate speed
M400                                      ; Wait for all moves to finish

; move to the left =======================================================

G1 X-38.2 F18000                          ; Fast move to start of wiper (X=-38.2)
G1 X-48.2 F3000                           ; Slow move to end of wiper (X=-48.2)
M400                                      ; Wait for moves to finish

; unload ==================================================================

G1 E-100 F1000                            ; Retract (unload) 100 mm of filament at 1000 mm/min
M400                                      ; Wait for retraction to complete

; play sound ==============================================================

M17                                      ; Enable Steppers
M400 S1                                  ; wait 1 sec
M1006 S1
M1006 A0 B0 L100 C37 D10 M100 E37 F10 N100
M1006 A0 B0 L100 C41 D10 M100 E41 F10 N100
M1006 A0 B0 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A43 B10 L100 C39 D10 M100 E46 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C39 D10 M100 E43 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C41 D10 M100 E41 F10 N100
M1006 A0 B0 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B0 L100 C49 D10 M100 E49 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B10 L100 C39 D10 M100 E48 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C39 D10 M100 E44 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A43 B10 L100 C39 D10 M100 E46 F10 N100
M1006 W

; wait for user ===========================================================

M400 U1                                 	; PAUSE and wait for user interaction

; load new filament =======================================================

M109 S[nozzle_temperature_range_high]   	; Set nozzle temperature and wait until it reaches target

G1 E200 F500                            	; Load 200 mm of filament into nozzle at 500 mm/min

M400                                      	; Wait for extrusion to complete

; poop ====================================================================

M106 P1 S178                              	; Turn on fan P1 at speed 178 (likely part cooling fan)
M400 S3                                   	; Wait 3 seconds

G1 X-38.2 F18000                          	; Fast move to start of poop path (X=-38.2)
G1 X-48.2 F3000                           	; Slow move to end of poop path (X=-48.2) while extruding
G1 X-38.2 F18000                          	; Repeat fast move to start
G1 X-48.2 F3000                           	; Repeat slow poop path
G1 X-38.2 F18000                          	; One more round
G1 X-48.2 F3000                           	; And another slow extrusion move
M400                                      	; Wait for moves to complete

G1 Y128 F9000
M400

G92 E0
M628 S0

{if flush_length_1 > 1}

	; FLUSH_START
	; always use highest temperature to flush
	M400
	M1002 set_filament_type:UNKNOWN
	M109 S[nozzle_temperature_range_high]
	M106 P1 S60
	
	{if flush_length_1 > 23.7}
	
		G1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part
		G1 E{(flush_length_1 - 23.7) * 0.02} F50
		G1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}
		G1 E{(flush_length_1 - 23.7) * 0.02} F50
		G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}
		G1 E{(flush_length_1 - 23.7) * 0.02} F50
		G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}
		G1 E{(flush_length_1 - 23.7) * 0.02} F50
		G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}
		
	{else}
	
		G1 E{flush_length_1} F{old_filament_e_feedrate}
		
	{endif}
	
	; FLUSH_END
	G1 E-[old_retract_length_toolchange] F1800
	G1 E[old_retract_length_toolchange] F300
	M400
	M1002 set_filament_type:{filament_type[next_extruder]}
	
{endif}

{if flush_length_1 > 45 && flush_length_2 > 1}

	; WIPE
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
	M106 P1 S0
	
{endif}

{if flush_length_2 > 1}

	M106 P1 S60
	; FLUSH_START
	G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_2 * 0.02} F50
	G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_2 * 0.02} F50
	G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_2 * 0.02} F50
	G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_2 * 0.02} F50
	G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_2 * 0.02} F50
	; FLUSH_END
	G1 E-[new_retract_length_toolchange] F1800
	G1 E[new_retract_length_toolchange] F300
	
{endif}

{if flush_length_2 > 45 && flush_length_3 > 1}

	; WIPE
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
	M106 P1 S0
	
{endif}

{if flush_length_3 > 1}

	M106 P1 S60
	; FLUSH_START
	G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_3 * 0.02} F50
	G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_3 * 0.02} F50
	G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_3 * 0.02} F50
	G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_3 * 0.02} F50
	G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_3 * 0.02} F50
	; FLUSH_END
	G1 E-[new_retract_length_toolchange] F1800
	G1 E[new_retract_length_toolchange] F300
	
{endif}

{if flush_length_3 > 45 && flush_length_4 > 1}

	; WIPE
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
	M106 P1 S0
	
{endif}

{if flush_length_4 > 1}

	M106 P1 S60
	; FLUSH_START
	G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_4 * 0.02} F50
	G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_4 * 0.02} F50
	G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_4 * 0.02} F50
	G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_4 * 0.02} F50
	G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
	G1 E{flush_length_4 * 0.02} F50
	; FLUSH_END

{endif}

M629

M400
M106 P1 S60
M109 S[new_filament_temp]
G1 E6 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature
M400
G92 E0
G1 E-[new_retract_length_toolchange] F1800
M400
M106 P1 S178
M400 S3
G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
G1 X-38.2 F18000
G1 X-48.2 F3000
M400
G1 Z{max_layer_z + 3.0} F3000
	M106 P1 S0
	
{if layer_z <= (initial_layer_print_height + 0.001)}
	M204 S[initial_layer_acceleration]
{else}
	M204 S[default_acceleration]
{endif}

M622.1 S0
M9833 F{outer_wall_volumetric_speed/2.4} A0.3 ; cali dynamic extrusion compensation
M1002 judge_flag filament_need_cali_flag
M622 J1
  G92 E0
  G1 E-[new_retract_length_toolchange] F1800
  M400
  
  M106 P1 S178
  M400 S4
  G1 X-38.2 F18000
  G1 X-48.2 F3000
  G1 X-38.2 F18000 ;wipe and shake
  G1 X-48.2 F3000
  G1 X-38.2 F12000 ;wipe and shake
  G1 X-48.2 F3000
  M400
  M106 P1 S0 
M623

M621 S[next_extruder]A
G392 S0

M1007 S1

; continue printing ========================================================

