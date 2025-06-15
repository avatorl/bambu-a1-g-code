; =========================================================================
; G-code for manual filament change on Bambu Lab A1 3D printer without AMS
; https://github.com/avatorl/bambu-a1-g-code/tree/main/no-ams
; 2025-06-15
; =========================================================================

M104 S[nozzle_temperature_range_high]     ; Set nozzle temperature to high range (starts heating but doesn't wait)

G1 Z{max_layer_z + 10} F1200              ; Move Z-axis up by 10 mm above the highest print layer at 1200 mm/min

; move to the right and cut ===============================================

G1 X260 F20000                            ; Fast move to X=260 at 20000 mm/min (move to right side)
G1 X278 F400                              ; Slow move to X=278 (move to cutter position)
G1 X281 E-5 F80                           ; Extrude reverse 5 mm of filament (retract/cut) while moving to X=281
G1 X260 F6000                             ; Move back to X=260 at moderate speed

M400                                      ; Wait for all moves to finish

; move to the left ========================================================

G1 X-35 F20000                            ; Rapid move to the left (X=-35)
G1 X-48 F600                              ; Slow move further left (X=-48) for precise positioning

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

; move to the right to tell filament slot # (see in the slicer) ===========
; number of screws visible on the left side of the toolhead during the pause = filament slot #

{if next_extruder == 0}
  G1 X-10 F1000
{endif}

{if next_extruder == 1}
  G1 X15 F2000
{endif}

{if next_extruder == 2}
  G1 X40 F3000
{endif}

{if next_extruder == 3}
  G1 X65 F4000
{endif}

{if next_extruder == 4}
  G1 X90 F5000
{endif}

{if next_extruder == 5}
  G1 X115 F10000
{endif}

{if next_extruder == 6}
  G1 X140 F10000
{endif}

{if next_extruder == 7}
  G1 X165 F10000
{endif}

{if next_extruder == 8}
  G1 X190 F10000
{endif}

{if next_extruder == 9}
  G1 X215 F10000
{endif}

{if next_extruder == 10}
  G1 X240 F10000
{endif}

; wait for user ===========================================================

M400 U1                                   ; PAUSE and wait for user interaction

; move to the left ========================================================

G1 X-35 F20000                            ; Rapid move to the left (X=-35)
G1 X-48 F600                              ; Slow move further left (X=-48) for precise positioning

M400                                      ; Wait for moves to finish

; load new filament =======================================================

M109 S[nozzle_temperature_range_high]     ; Set nozzle temperature and wait until it reaches target

G1 E200 F500                              ; Load 200 mm of filament into nozzle at 500 mm/min

M400                                      ; Wait for extrusion to complete

; poop ====================================================================

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

; continue printing ========================================================
