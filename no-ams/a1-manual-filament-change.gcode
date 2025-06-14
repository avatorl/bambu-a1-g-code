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

; SOUND NOTIFICATION =====================

G1 X128 F20000                            ; Move to X=128 (middle point)

; Sound notification about pause
;
;music_long: 8
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
;Tick 200, Time 2 sec
M73 P25 R0
M1006 C25 D200 M35 
;Tick 400, Time 4 sec
M73 P50 R0
M1006 C37 D200 M69 
;Tick 600, Time 6 sec
M73 P75 R0
M1006 C49 D200 M52 
;Tick 800, Time 8 sec
M73 P100 R0
M1006 C61 D200 M69 
M1006 W
M18

; PAUSE: wait for user
M400 U1                                   ; Custom Bambu G-code: pause and wait for user interaction

; Sound notification about filament # to load

{if next_extruder == 0}                   ; filament # 1
;
;music_long: 0
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C25 D200 M35 
M1006 W
M18
{endif}

{if next_extruder == 1}                  ; filament # 2
;
;music_long: 2
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C25 D200 M35 
;Tick 200, Time 2 sec
M73 P100 R0
M1006 C37 D200 M69 
M1006 W
M18
{endif}

{if next_extruder == 2}                  ; filament # 3
;
;music_long: 4
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C25 D200 M35 
;Tick 200, Time 2 sec
M73 P50 R0
M1006 C37 D200 M69 
;Tick 400, Time 4 sec
M73 P100 R0
M1006 C25 D200 M35 
M1006 W
M18
{endif}

{if next_extruder == 3}                  ; filament # 4
;
;music_long: 6
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C25 D200 M35 
;Tick 200, Time 2 sec
M73 P33 R0
M1006 C37 D200 M69 
;Tick 400, Time 4 sec
M73 P66 R0
M1006 C25 D200 M35 
;Tick 600, Time 6 sec
M73 P100 R0
M1006 C37 D200 M69 
M1006 W
M18
{endif}

{if next_extruder == 4}                  ; filament # 5
;
;music_long: 8
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C25 D200 M35 
;Tick 200, Time 2 sec
M73 P25 R0
M1006 C37 D200 M69 
;Tick 400, Time 4 sec
M73 P50 R0
M1006 C25 D200 M35 
;Tick 600, Time 6 sec
M73 P75 R0
M1006 C37 D200 M69 
;Tick 800, Time 8 sec
M73 P100 R0
M1006 C25 D200 M35 
M1006 W
M18
{endif}

{if next_extruder == 5}                  ; filament # 6
;
;music_long: 10
M17
M400 S1
M1006 S1
M1006 L70 M70 N99
M1006 C25 D200 M35 
;Tick 200, Time 2 sec
M73 P20 R0
M1006 C37 D200 M69 
;Tick 400, Time 4 sec
M73 P40 R0
M1006 C25 D200 M35 
;Tick 600, Time 6 sec
M73 P60 R0
M1006 C37 D200 M69 
;Tick 800, Time 8 sec
M73 P80 R0
M1006 C25 D200 M35 
;Tick 1000, Time 10 sec
M73 P100 R0
M1006 C37 D200 M69 
M1006 W
M18
{endif}

; END OF SOUND NOTIFICATION ==============

; move to the left
G1 X-35 F20000                            ; Rapid move to the left (X=-35)
G1 X-48 F600                              ; Slow move further left (X=-48) for precise positioning

M400                                      ; Wait for moves to finish

; unload
G1 E-100 F1000                            ; Retract (unload) 100 mm of filament at 1000 mm/min

M400                                      ; Wait for retraction to complete

; PAUSE: wait for user
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
