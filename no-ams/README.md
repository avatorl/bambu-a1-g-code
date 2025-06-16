# Manual filament change for Bambu Lab A1 without AMS

## Create Printer Preset

1. Click to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

2. Copy [a1-manual-filament-change.gcode](https://github.com/avatorl/bambu-a1-g-code/blob/main/no-ams/a1-manual-filament-change.gcode) g-code and paste into **Change filament G-code** field of the **Machine gcode** tab (replace any code existing in the field).

![image](https://github.com/user-attachments/assets/06cd59a5-19a9-49f0-94f5-c07c40b21a72)

3. Save as new preset:

![image](https://github.com/user-attachments/assets/850a1baa-05ba-445f-b83b-5f5876db5705)

## Print a Model using the Preset

1. Select the preset for printing:

![image](https://github.com/user-attachments/assets/89e483ac-0636-4304-848d-033257718826)

2. Start printing a multicolor model with as many filament changes as you're comfortable handling manually.

3. Wait for the pause. _If "Allow Prompt Sound" is enabled in Print Options, you will be notified of a pause by a sound._
  
4. **Pull out** the filament, **push in** the next filament, click **Resume Printing**.

There is no need to use the built-in Unload and Load procedures - just pull out, push in, resume printing.

❗ I believe the same K-factor (initial filament) is used for all following filaments.

➡️ Option 1: See in the slicer on the "Preview" tab (using the horizontal and vertical sliders) which color should be loaded after each pause.

➡️ Option 2: Export g-code and search for all M1020 S commands. M1020 S0 - change to filament #1, M1020 S1 - change to filament #2, and so on.

![image](https://github.com/user-attachments/assets/4ba6c987-1c45-41ec-b10a-5d344758ebcc)

❗ Re-slicing, even without any changes in printing settings, may change filament change order.

Repeat steps 3-4 for each pause.

---

Original Code: https://github.com/steven52880/bambu-a1-manual-filamant-change
