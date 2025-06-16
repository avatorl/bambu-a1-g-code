# Manual filament change for Bambu Lab A1 without AMS

## Create Printer Preset

1. In Bambu Studio click this button to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

2. Copy g-code and paste into **Change filament G-code** field of the **Machine gcode** tab (replace any code existing in the field).

➡️ G-code version 1 (no flushing, no dynamic flow calibration - fast change): [no-ams/a1-manual-filament-change-v2.gcode](https://github.com/avatorl/bambu-a1-g-code/blob/main/no-ams/a1-manual-filament-change.gcode)

➡️ G-code version 2 (flushing, dynamic flow calibration - print quality): [a1-manual-filament-change-v2.gcode](https://github.com/avatorl/bambu-a1-g-code/blob/main/no-ams/a1-manual-filament-change-v2.gcode
)


![image](https://github.com/user-attachments/assets/06cd59a5-19a9-49f0-94f5-c07c40b21a72)

3. Save as new preset:

![image](https://github.com/user-attachments/assets/850a1baa-05ba-445f-b83b-5f5876db5705)

## Print a Model using the Preset

1. Select the preset for printing:

![image](https://github.com/user-attachments/assets/89e483ac-0636-4304-848d-033257718826)

2. Start printing a multicolor model with as many filament changes as you're comfortable handling manually.

   This method works well for flat models (e.g., keychains, signs, labels) or for models where multi-color printing is required only on the bottom and/or top surfaces.

4. Wait for the pause. _If "Allow Prompt Sound" is enabled in Print Options, you will be notified of a pause by a sound._
  
5. **Pull out** the filament, **push in** the next filament, click **Resume Printing**.

There is no need to use the built-in Unload and Load procedures - just pull out, push in, resume printing.

How can I know which color to load?

➡️ Option 1: In the slicer, on the "Preview" tab, use the vertical (layers) and horizontal sliders to see the color printing order.

➡️ Option 2: Export sliced file, extract and open g-code file and search for all "M1020 S" commands. M1020 S0 - change to filament #1, M1020 S1 - change to filament #2, and so on.

For example, M1020 S5 means filament #6 (red color) on this screenshot:

![image](https://github.com/user-attachments/assets/4ba6c987-1c45-41ec-b10a-5d344758ebcc)

Repeat steps 3-4 for each pause.

---

❗ I believe the same K-factor (K-factor of the initial filament) is used for all following filaments.

❗ Re-slicing, even without any changes in printing settings, may change filament change order.
