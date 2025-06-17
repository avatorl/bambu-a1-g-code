;===================== date: 20250206 =====================
{if !spiral_mode && print_sequence != "by object"}
; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z{max_layer_z + 0.4}
G1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    {if layer_num == 2}
      M400
      G90
      M83
      M204 S5000
      G0 Z2 F4000
      G0 X261 Y250 F20000
      M400 P200
      G39 S1
      G0 Z2 F4000
    {endif}


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      {if !in_head_wrap_detect_zone}
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        {if layer_num > 2}
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z{max_layer_z + 0.4} F4000
            G39.3 S1
            G0 Z{max_layer_z + 0.4} F4000
            G392 S0
          {endif}
        M623
    {endif}
    M623
M623
; SKIPPABLE_END
{endif}
