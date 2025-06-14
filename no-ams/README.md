# Manual filament change for Bambu Lab A1 without AMS

## Create Printer Preset

Click to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

Copy [a1-manual-filament-change.gcode](https://github.com/avatorl/bambu-a1-g-code/blob/main/no-ams/a1-manual-filament-change.gcode) g-code and insert into **Change filament G-code** field of the **Machine gcode** tab (replace any code existing in the field).

![image](https://github.com/user-attachments/assets/06cd59a5-19a9-49f0-94f5-c07c40b21a72)

Save as new preset:

![image](https://github.com/user-attachments/assets/850a1baa-05ba-445f-b83b-5f5876db5705)

## Print a Model using the Preset

Select new preset for printing:

![image](https://github.com/user-attachments/assets/89e483ac-0636-4304-848d-033257718826)

Print a multi-color model with as many filament changes as you're comfortable handling.

When paused, pull out the filament, push in the new filament, press continue. There is no need to use the built-in Unload and Load procedures - **just pull out, push in, continue**.

_Tested on a 3D-map model with 9 filament changes._


