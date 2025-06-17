# Manual filament change for Bambu Lab A1 without AMS

This method allows multi-color printing without using the AMS. It supports models with multiple colors on the same layer. Manual filament replacement is required, so it is practical only for flat models (keychains, signs, labels, maps, decorations and so on) or for models where multi-color printing (labels, logos) is needed only on the bottom and/or top surfaces. It is not suitable for models that require dozens or hundreds of filament changes.

An example of multi-color model printer using this method:

<img src="https://github.com/user-attachments/assets/435a6253-d006-457c-8e5f-e64e57a1cacc" alt="Description" width="300">


## Create Printer Preset

1. In Bambu Studio click this button to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

2. Copy g-code and paste into **Change filament G-code** field of the **Machine gcode** tab (replace any code existing in the field).

➡️ [G-code version 2](https://github.com/avatorl/bambu-a1-g-code/blob/main/change-filament/a1-manual-filament-change-v2.gcode)

Supported features:

- flushing (in accordance with _Falshing volumes_ in Bambu Studio)
- flow dynamics calibration for each new filament (if was enabled before printing)
- sound notification about pause (if sound is enabled in _Print Options_ in Bambu Studio)
- Morse code notification about filament number (if sounds is enabled)

![image](https://github.com/user-attachments/assets/06cd59a5-19a9-49f0-94f5-c07c40b21a72)

3. Save as new preset:

![image](https://github.com/user-attachments/assets/850a1baa-05ba-445f-b83b-5f5876db5705)

## Print a Model using the Preset

1. Select the preset for printing:

![image](https://github.com/user-attachments/assets/89e483ac-0636-4304-848d-033257718826)

2. Start printing a multicolor model with as many filament changes as you're comfortable handling manually.

4. Wait for the pause. _If "Allow Prompt Sound" is enabled in Print Options, you will be notified of a pause by a sound._
  
5. **Pull out** the filament, **push in** the next filament, click **Resume Printing**.

There is no need to use the built-in Unload and Load procedures - just pull out, push in, resume printing.

How can I know which color to load?

➡️ Option 1: In the slicer, on the "Preview" tab, use the vertical (layers) and horizontal sliders to see the color printing order.

➡️ Option 2: Export sliced file, extract and open g-code file and search for all "M1020 S" commands. M1020 S0 - change to filament #1, M1020 S1 - change to filament #2, and so on.

For example, M1020 S5 means filament #6 (red color) on this screenshot:

![image](https://github.com/user-attachments/assets/4ba6c987-1c45-41ec-b10a-5d344758ebcc)

➡️ Option 3: Listen for Morse code sound 2 seconds after the pause sound notification. Works for up to 9 filaments.

![image](https://github.com/user-attachments/assets/3cf1a09c-a869-49ce-88f5-69145a5a7d32)

![image](https://github.com/user-attachments/assets/3588b2ec-703b-413d-8054-9661f2532e12)

Repeat steps 3-4 for each pause.

---

❗ Re-slicing, even without any changes in printing settings, may change filament change order.

---

❗WARNING! This is unofficial G-code. It is not authorized, endorsed, or supported by Bambu Lab. The author is not responsible for any negative consequences resulting from the use of this code, including but not limited to filament waste, printing task failure, or printer damage. I may also be wrong about what the code does and doesn't do, including possibly incorrect comments in the code or on this page. Use with caution at your own responsibility.
