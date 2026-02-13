; =========================================================================
; G-code for manual filament change on Bambu Lab A1 3D printer without AMS
; Version 3.0.1 - 2026-02-08
; =========================================================================
; GitHub repository (the most recent version):
;   https://raw.githubusercontent.com/avatorl/bambu-a1-g-code/refs/heads/main/change-filament/a1-manual-filament-change-v2.gcode
; Description and Usage Instructions:
;   https://github.com/avatorl/bambu-a1-g-code/blob/main/change-filament/README.md
; MakerWorld model for filament change testing:
;   https://makerworld.shop/products/3d-printed-bambu-lab-a1-mini-filament-change-tester
; ========================================================================
; Sound notifications created using:
;   MIDI to g-code (tool and instructions): https://wiki.bambulab.com/en/A1-mini/Midi
;   Morse code https://en.wikipedia.org/wiki/Morse_code
; ========================================================================

; initialization (original Bambu Lab code)================================
;===== A1 20251031 =======================
M1007 S0                                ; turn off mass estimation
G392 S0                                 
; M620 S[next_extruder]A                ; AMS specific command, not needed for manual filament change
M204 S9000                              ; set acceleration to 9000 mm/s^2 for all moves during filament change  
G1 Z{max_layer_z + 3.0} F1200           ; move Z up to avoid hitting the print when moving to the side for filament change

M400                                    ; wait for all moves to finish
M106 P1 S0                              ; turn off part cooling fan
M106 P2 S0                              
{if old_filament_temp > 142 && next_extruder < 255}
M104 S[old_filament_temp]               ; set temperature back to old filament temperature
{endif}

G1 X267 F18000                          ; move to the side for filament change    

; AMS specific commands, not needed for manual filament change
; {if long_retractions_when_cut[previous_extruder]}
; M620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F1200
; {else}
; M620.11 S0
; {endif}
; M400

; AMS specific commands, not needed for manual filament change
; M620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}
; M620.10 A0 F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
; T[next_extruder]
; M620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}
; M620.10 A1 F{flush_volumetric_speeds[next_extruder]/2.4053*60} L[flush_length] H[nozzle_diameter] T{flush_temperatures[next_extruder]}

; unload filament (custom code ) =========================================

M400                                    ; wait for all moves to finish
G1 X283 F400                            ; slow move to precise cutter position and cut the filament with the cutter
G1 E-5 F1000                            ; retract 5mm of filament
G1 X267 F6000                           ; move away from cutter at moderate speed
M400                                    ; wait for all moves to finish

G1 X-38.2 F18000                        ; fast move to start of wiper
G1 X-48.2 F3000                         ; slow move to end of wiper
M400                                    ; wait for moves to finish

G1 E-100 F1000                          ; retract 100 mm of filament
M400                                    ; wait for retraction to complete

; play pause notification sound (custom code ) ===========================

M17                                      ; enable Steppers
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

; filament # sound notification using Morse code for digits 1 to 9 =======
;
; next_extruder == 0 means filament #1
; ...
; next_extruder == 8 means filament #9
;
; it's possible to print in more than 9 filaments, 
; 	but there will be no filament # sound notification for filaments #10+

M400 S2                                 ; wait 2 sec before playing Morse code

; play Morse code for filament number (custom code) ======================

{if next_extruder == 0} ; filament #1

; .---- (Morse code for 1)
;music_long: 6
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 100, Time 1 sec
M73 P16 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
;Tick 250, Time 2 sec
M73 P33 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 300, Time 3 sec
M73 P50 R0
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
;Tick 400, Time 4 sec
M73 P66 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
;Tick 550, Time 5 sec
M73 P83 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 600, Time 6 sec
M73 P100 R0
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
M1006 W

{endif}

{if next_extruder == 1} ; filament #2

; ..--- (Morse code for 2)
;music_long: 5.5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 100, Time 1 sec
M73 P18 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 200, Time 2 sec
M73 P36 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
;Tick 350, Time 3 sec
M73 P54 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 400, Time 4 sec
M73 P72 R0
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
;Tick 500, Time 5 sec
M73 P90 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
M1006 W

{endif}

{if next_extruder == 2} ; filament #3

; ...-- (Morse code for 3)
;music_long: 5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 100, Time 1 sec
M73 P20 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 200, Time 2 sec
M73 P40 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 300, Time 3 sec
M73 P60 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
;Tick 450, Time 4 sec
M73 P80 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 500, Time 5 sec
M73 P100 R0
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
M1006 W

{endif}

{if next_extruder == 3} ; filament #4

; ....- (Morse code for 4)
;music_long: 4.5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 100, Time 1 sec
M73 P22 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 200, Time 2 sec
M73 P44 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 300, Time 3 sec
M73 P66 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 400, Time 4 sec
M73 P88 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A37 B100 L53 C37 D100 M69 E37 F100 N31 
M1006 W

{endif}

{if next_extruder == 4} ; filament #5

; ..... (Morse code for 5)
;music_long: 4.5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 100, Time 1 sec
M73 P22 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 200, Time 2 sec
M73 P44 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 300, Time 3 sec
M73 P66 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 400, Time 4 sec
M73 P88 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 W

{endif}

{if next_extruder == 5} ; filament #6

; -.... (Morse code for 6)
;music_long: 5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 150, Time 1 sec
M73 P20 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 200, Time 2 sec
M73 P40 R0
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 A0 B50 C0 D50 E0 F50 
;Tick 300, Time 3 sec
M73 P60 R0
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 A0 B50 C0 D50 E0 F50 
;Tick 400, Time 4 sec
M73 P80 R0
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 A0 B50 C0 D50 E0 F50 
;Tick 500, Time 5 sec
M73 P100 R0
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 W

{endif}

{if next_extruder == 6} ; filament #7

; --... (Morse code for 7)
;music_long: 5.5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 150, Time 1 sec
M73 P18 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 200, Time 2 sec
M73 P36 R0
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 300, Time 3 sec
M73 P54 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 400, Time 4 sec
M73 P72 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
;Tick 500, Time 5 sec
M73 P90 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 W

{endif}

{if next_extruder == 7} ; filament #8

; ---.. (Morse code for 8)
;music_long: 6
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 150, Time 1 sec
M73 P16 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 200, Time 2 sec
M73 P33 R0
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 300, Time 3 sec
M73 P50 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 450, Time 4 sec
M73 P66 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 500, Time 5 sec
M73 P83 R0
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 A0 B50 C0 D50 E0 F50 
;Tick 600, Time 6 sec
M73 P100 R0
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 W

{endif}

{if next_extruder == 8} ; filament #9

; ----. (Morse code for 9)
;music_long: 6.5
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 150, Time 1 sec
M73 P15 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 200, Time 2 sec
M73 P30 R0
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 300, Time 3 sec
M73 P46 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 450, Time 4 sec
M73 P61 R0
M1006 A0 B50 C0 D50 E0 F50 
;Tick 500, Time 5 sec
M73 P76 R0
M1006 A49 B100 L69 C49 D100 M52 E49 F100 N31 
;Tick 600, Time 6 sec
M73 P92 R0
M1006 A0 B50 C0 D50 E0 F50 
M1006 A49 B50 L69 C49 D50 M52 E49 F50 N31 
M1006 W

{endif}

; PAUSE, wait for user ===================================================

M400 U1                                 	; pause, with notification on the screen, and wait for user interaction

; ========================================================================
; At this point:
; 	pull out old filament
; 	push in new filament
; 	press Resume Printing
; ========================================================================

; load new filament ======================================================

M109 S[nozzle_temperature_range_high]   	; set nozzle temperature and wait until it reaches target

G1 E45 F500                            	    ; grabs filament and starts feeding
M400                                      	; wait for extrusion to complete

; wipe and purge =========================================================

M106 P1 S178                              	; part cooling fan speed
M400 S3                                   	; wait 3 seconds

G1 X-38.2 F18000                          	; wipe pass 1: fast move to start of wiper
G1 X-48.2 F3000                           	; wipe pass 1: slow move to end of wiper
G1 X-38.2 F18000                          	; wipe pass 2
G1 X-48.2 F3000
G1 X-38.2 F18000                          	; wipe pass 3
G1 X-48.2 F3000
M400                                      	; wait for moves to complete

; ========================================================================

; original Bambu Lab code for flushing and calibration ===================

G1 Y128 F9000

{if next_extruder < 255}

; AMS specific commands, not needed for manual filament change
; {if long_retractions_when_cut[previous_extruder]}
; M620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
; M628 S1
; G92 E0
; G1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
; M400
; M629 S1
; {else}
; M620.11 S0
; {endif}


M400
G92 E0
M628 S0

{if flush_length_1 > 1}
; FLUSH_START
; always use highest temperature to flush
M400
M1002 set_filament_type:UNKNOWN
M109 S[flush_temperatures[next_extruder]]
M106 P1 S60
{if flush_length_1 > 23.7}
G1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
{else}
G1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}
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
G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
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
G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
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
G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}
G1 E{flush_length_4 * 0.02} F50
; FLUSH_END
{endif}

M629

M400
M106 P1 S60
M109 S[new_filament_temp]
; G1 E6 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature
; Changed E6 to E12 because small poop someties is not wiped off correctly
G1 E12 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature
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
{else}
G1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000
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

; M621 S[next_extruder]A          ; AMS specific command, not needed for manual filament change
G392 S0

M1007 S1

; continue printing ======================================================
