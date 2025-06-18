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

M106 P1 S0								; turn off part cooling fan

{if old_filament_temp > 142}
	M104 S[old_filament_temp]					; restore old filament temperature if above 142°C
{endif}

; cut filament (no AMS) ==================================================

G1 X267 F18000                          ; fast move to X=267 (filament cutter position)
G1 X278 F400                            ; slow move to precise cutter position
G1 X281 E-5 F80                         ; extrude reverse 5 mm of filament (retract/cut) while moving to X=281
G1 X267 F6000                           ; move back to X=267 at moderate speed
M400                                    ; wait for all moves to finish

; move to the left =======================================================

G1 X-38.2 F18000                        ; fast move to start of wiper (X=-38.2)
G1 X-48.2 F3000                         ; slow move to end of wiper (X=-48.2)
M400                                    ; wait for moves to finish

; unload filament ========================================================

G1 E-100 F1000                            ; retract (unload) 100 mm of filament at 1000 mm/min
M400                                      ; wait for retraction to complete

; play sound ==============================================================
; MIDI to g-code: https://wiki.bambulab.com/en/A1-mini/Midi

; pause notification (music)
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

; filament # sound notification using Morse code https://en.wikipedia.org/wiki/Morse_code
; Morse code for disgits 0 to 9 is used for the notification (up to 9 filaments)
;
; next_extruder == 0 means filament slot (in Bambu Studio) # 1
; ...
; next_extruder == 8 means filament slot (in Bambu Studio) # 9

M400 S2                                  ; wait 2 sec before playing Morse code

; play Morse code ========================================================

{if next_extruder == 0} ; filament #1

	; .---- (Morse code)
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

	; ..--- (Morse code)
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

	; ...-- (Morse code)
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

	; ....- (Morse code)
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

	; ..... (Morse code)
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

	; -.... (Morse code)
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

	; --... (Morse code)
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

	; ---.. (Morse code)
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

	; ----. (Morse code)
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

; wait for user ===========================================================

M400 U1                                 	; pause (with notification on the screen) and wait for user interaction

; load new filament =======================================================

M109 S[nozzle_temperature_range_high]   	; set nozzle temperature and wait until it reaches target

G1 E200 F500                            	; load 200 mm of filament into nozzle at 500 mm/min

M400                                      	; wait for extrusion to complete

; poop ====================================================================

M106 P1 S178                              	; turn on fan P1 at speed 178 (part cooling fan)
M400 S3                                   	; wait 3 seconds

G1 X-38.2 F18000                          	; fast move to start of poop path (X=-38.2)
G1 X-48.2 F3000                           	; slow move to end of poop path (X=-48.2) while extruding
G1 X-38.2 F18000                          	; repeat fast move to start
G1 X-48.2 F3000                           	; repeat slow poop path
G1 X-38.2 F18000                          	; one more round
G1 X-48.2 F3000                           	; and another slow extrusion move
M400                                      	; wait for moves to complete

G92 E0						; resetting the extruder position
M628 S0						; ???

; filament flush =========================================================

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

; more flush if required =================================================

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

; more flush if required =================================================

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

; more flush if required =================================================

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

; more flush if required =================================================

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

; more flush if required =================================================

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

; more flush if required =================================================

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

M629				; ???

; ??? ====================================================================

M400
M106 P1 S60
M109 S[new_filament_temp]
G1 E6 F{new_filament_e_feedrate} 				; compensate for filament spillage during waiting temperature
M400
G92 E0											; resetting the extruder position
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

; Flow dynamics calibrtion ??? ===========================================

M622.1 S0
M9833 F{outer_wall_volumetric_speed/2.4} A0.3 	; cali dynamic extrusion compensation
M1002 judge_flag filament_need_cali_flag
M622 J1
  G92 E0										; resetting the extruder position
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

G392 S0

M1007 S1							;

; continue printing ======================================================
