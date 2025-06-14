; set temp
M104 S[nozzle_temperature_range_high]     ; Set nozzle temperature to high range (starts heating but doesn't wait)

; move up
G1 Z{max_layer_z + 10} F1200              ; Move Z-axis up by 10 mm above the highest print layer at 1200 mm/min

; move to the right and cut
G1 X260 F20000                            ; Fast move to X=260 at 20000 mm/min (move to right side)
G1 X278 F400                              ; Slow move to X=278 (move to cutter position)
G1 X281 E-5 F80                           ; Extrude reverse 5 mm of filament (retract/cut) while moving to X=281
G1 X260 F6000                             ; Move back to X=260 at moderate speed

M400                                      ; Wait for all moves to finish (buffer flush)

; move to the left
G1 X-35 F20000                            ; Rapid move to the left (X=-35)
G1 X-48 F600                              ; Slow move further left (X=-48) for precise positioning

M400                                      ; Wait for moves to finish

; unload
G1 E-100 F1000                            ; Retract (unload) 100 mm of filament at 1000 mm/min

M400                                      ; Wait for retraction to complete

{if next_extruder == 1}
; filament slot #1
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C37 D50 M69 
M1006 C0 D950 
;Tick 1000, Time 10 sec
M73 P50 R0
M1006 C37 D50 M69 
M1006 C0 D950 
;Tick 2000, Time 20 sec
M73 P100 R0
M1006 C37 D50 M69 
M1006 W
M18
{endif}

{if next_extruder == 2}
; filament slot #2
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 100, Time 1 sec
M73 P4 R0
M1006 C37 D50 M69 
M1006 C0 D850 
;Tick 1000, Time 10 sec
M73 P47 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 1100, Time 11 sec
M73 P52 R0
M1006 C37 D50 M69 
M1006 C0 D850 
;Tick 2000, Time 20 sec
M73 P95 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 2100, Time 21 sec
M73 P100 R0
M1006 C37 D50 M69 
M1006 W
M18
{endif}

{if next_extruder == 3}
; filament slot #3
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 100, Time 1 sec
M73 P4 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 200, Time 2 sec
M73 P9 R0
M1006 C37 D50 M69 
M1006 C0 D750 
;Tick 1000, Time 10 sec
M73 P45 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 1100, Time 11 sec
M73 P50 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 1200, Time 12 sec
M73 P54 R0
M1006 C37 D50 M69 
M1006 C0 D750 
;Tick 2000, Time 20 sec
M73 P90 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 2100, Time 21 sec
M73 P95 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 2200, Time 22 sec
M73 P100 R0
M1006 C37 D50 M69 
M1006 W
M18
{endif}

{if next_extruder == 4}
; filament slot #4
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 100, Time 1 sec
M73 P4 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 200, Time 2 sec
M73 P8 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 300, Time 3 sec
M73 P13 R0
M1006 C37 D50 M69 
M1006 C0 D650 
;Tick 1000, Time 10 sec
M73 P43 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 1100, Time 11 sec
M73 P47 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 1200, Time 12 sec
M73 P52 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 1300, Time 13 sec
M73 P56 R0
M1006 C37 D50 M69 
M1006 C0 D650 
;Tick 2000, Time 20 sec
M73 P86 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 2100, Time 21 sec
M73 P91 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 2200, Time 22 sec
M73 P95 R0
M1006 C37 D50 M69 
M1006 C0 D50 
;Tick 2300, Time 23 sec
M73 P100 R0
M1006 C37 D50 M69 
M1006 W
M18
{endif}

{if next_extruder == 5}
;music_long: 33
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C0 D50 E37 F50 N31 
M1006 C0 D50 E39 F50 N52 
;Tick 100, Time 1 sec
M73 P3 R0
M1006 C0 D50 E41 F50 N38 
M1006 C0 D50 E43 F50 N38 
;Tick 200, Time 2 sec
M73 P6 R0
M1006 C19 D50 M38 E45 F50 N45 
M1006 C19 D150 M38 E0 F150 
;Tick 400, Time 4 sec
M73 P12 R0
M1006 C0 D600 E0 F600 
;Tick 1000, Time 10 sec
M73 P30 R0
M1006 C0 D100 E30 F100 N24 
;Tick 1100, Time 11 sec
M73 P33 R0
M1006 C0 D100 E0 F100 
;Tick 1200, Time 12 sec
M73 P36 R0
M1006 C0 D200 E30 F200 N24 
;Tick 1400, Time 14 sec
M73 P42 R0
M1006 C0 D100 E0 F100 
;Tick 1500, Time 15 sec
M73 P45 R0
M1006 C0 D200 E30 F200 N24 
;Tick 1700, Time 17 sec
M73 P51 R0
M1006 C0 D100 E0 F100 
;Tick 1800, Time 18 sec
M73 P54 R0
M1006 C0 D200 E30 F200 N24 
;Tick 2000, Time 20 sec
M73 P60 R0
M1006 C0 D200 E0 F200 
;Tick 2200, Time 22 sec
M73 P66 R0
M1006 C18 D100 M24 E0 F100 
;Tick 2300, Time 23 sec
M73 P69 R0
M1006 C0 D100 E0 F100 
;Tick 2400, Time 24 sec
M73 P72 R0
M1006 C18 D200 M24 E0 F200 
;Tick 2600, Time 26 sec
M73 P78 R0
M1006 C0 D100 E0 F100 
;Tick 2700, Time 27 sec
M73 P81 R0
M1006 C18 D200 M24 E0 F200 
;Tick 2900, Time 29 sec
M73 P87 R0
M1006 C0 D100 E0 F100 
;Tick 3000, Time 30 sec
M73 P90 R0
M1006 C18 D200 M24 E0 F200 
;Tick 3200, Time 32 sec
M73 P96 R0
M1006 C0 D100 E0 F100 
;Tick 3300, Time 33 sec
M73 P100 R0
M1006 C18 D200 M24 E0 F200 
M1006 W
M18
{endif}

; wait for user
M400 U1                                   ; Custom Bambu G-code: pause and wait for user interaction

; set temp
M109 S[nozzle_temperature_range_high]     ; Set nozzle temperature and wait until it reaches target

; load
G1 E200 F500                              ; Load 200 mm of filament into nozzle at 500 mm/min

M400                                      ; Wait for extrusion to complete

; poop
M400                                      ; Wait again (before poop routine)
M106 P1 S178                              ; Turn on fan P1 at speed 178 (likely part cooling fan)
M400 S3                                   ; Wait 3 seconds

G1 X-38.2 F18000                          ; Fast move to start of poop path (X=-38.2)
G1 X-48.2 F3000                           ; Slow move to end of poop path (X=-48.2) while extruding
G1 X-38.2 F18000                          ; Repeat fast move to start
G1 X-48.2 F3000                           ; Repeat slow poop path
G1 X-38.2 F18000                          ; One more round
G1 X-48.2 F3000                           ; And another slow extrusion move

M400                                      ; Wait for moves to complete
M106 P1 S0                                ; Turn off fan P1
