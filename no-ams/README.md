# Manual filament change for Bambu Lab A1 without AMS

## Create Printer Preset

1. Click to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

2. Copy [a1-manual-filament-change.gcode](https://github.com/avatorl/bambu-a1-g-code/blob/main/no-ams/a1-manual-filament-change.gcode) g-code and paste into **Change filament G-code** field of the **Machine gcode** tab (replace any code existing in the field).

![image](https://github.com/user-attachments/assets/06cd59a5-19a9-49f0-94f5-c07c40b21a72)

3. Save as new preset:

![image](https://github.com/user-attachments/assets/850a1baa-05ba-445f-b83b-5f5876db5705)

## Print a Model using the Preset

1. Select new preset for printing:

![image](https://github.com/user-attachments/assets/89e483ac-0636-4304-848d-033257718826)

2. Start printing a multicolor model with as many filament changes as you're comfortable handling manually.

3. Wait for the pause. **Pull out** the filament, **push in** the new filament, click Resume.

There is no need to use the built-in Unload and Load procedures - just pull out, resume, push in.

Repeat step 3 for each pause.

---

Tested on a 3D-map model with 9 filament changes.

---

Original Code: https://github.com/steven52880/bambu-a1-manual-filamant-change
