# Manual filament change for Bambu Lab A1 without AMS

## About

This method allows multi-color printing without using the AMS. It supports 3D models with multiple colors on the same layer. Manual filament replacement is required, so it is practical only for flat models (keychains, signs, labels, maps, decorations, etc.), or for models where multi-color printing is needed only on the bottom and/or top surfaces or on the limited number of layers anywhere in the middle of the model. It is not suitable for models that require hundreds of filament changes.

### Supported features

➡️ Automated filament unload before pause (just pull it out, with no need to use the _Unload_ menu)

➡️ Pause with sound notification (if sound is enabled in _Print Options_ in Bambu Studio)

➡️ Sound notification ([Morse code](https://en.wikipedia.org/wiki/Morse_code)) indicating which filament # should be inserted (if sound is enabled in _Print Options_ in Bambu Studio)

➡️ Automated filament load after pressing Resume Printing (just push the new filament in and press Resume Printing, with no need to use the Load menu)

➡️ Flushing (in accordance with _Falshing volumes_ in Bambu Studio)

➡️ Flow dynamics calibration for each color (if enabled before printing) ❗ testing required to make sure it really works

### An example of a multi-color model printed using this method

<img src="https://github.com/user-attachments/assets/435a6253-d006-457c-8e5f-e64e57a1cacc" alt="Description" width="300">

---

To support this work download, print & boost this model: https://makerworld.com/en/models/1534741-multi-color-without-ams-with-ams-test#profileId-1609872

---

## Create Printer Preset

1. In Bambu Studio click this button to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

2. Copy [G-code](https://github.com/avatorl/bambu-a1-G-code/blob/main/change-filament/a1-manual-filament-change-v2.gcode) and paste into **Change filament G-code** field of the **Machine gcode** tab (replace any code existing in the field).

![image](https://github.com/user-attachments/assets/06cd59a5-19a9-49f0-94f5-c07c40b21a72)

3. Save as new preset:

![image](https://github.com/user-attachments/assets/850a1baa-05ba-445f-b83b-5f5876db5705)

---

## Print a Model using the Preset

1. Select the preset for printing:

![image](https://github.com/user-attachments/assets/89e483ac-0636-4304-848d-033257718826)

2. Start printing a multicolor model with as many filament changes as you're comfortable handling manually.

_For example, I printed a model with 6 filaments and 15 filament changes._

3. Wait for the pause. _If "Allow Prompt Sound" is enabled in Print Options, you will be notified of a pause by a sound._
  
4. **Pull out** the filament, **push in** the next filament, click **Resume Printing**.

There is no need to use the built-in _Unload_ and _Load_ procedures - just pull out, push in, resume printing.

Hold the filament between two fingers for a few seconds until you feel it has been caught by the extruder.

Inserting new filament right after the pause is faster than doing it a bit later, because the nozzle starts cooling down and will need to be reheated afterward.

Repeat steps 3-4 for each pause.

---

**❓ How can I know which color to load?**

➡️ Method 1: In the slicer, on the "Preview" tab, use the vertical (layers) and horizontal sliders to see the color printing order.

❗ Re-slicing, even without any changes in printing settings, may change filament change order. Don't use this method after re-slicing.

➡️ Method 2: Export sliced file, extract and open G-code file and search for all _"M1020 S"_ commands.

_"M1020 S0"_ - change to project filament #1, 
_"M1020 S1"_ - change to project filament #2, 
_"M1020 S2"_ - change to project filament #3, 
and so on.

For example, _"M1020 S5"_ inG-code means project filament #6 (red color) on this screenshot:

![image](https://github.com/user-attachments/assets/4ba6c987-1c45-41ec-b10a-5d344758ebcc)

❗ Re-slicing, even without any changes to the print settings, may change the filament change order in the G-code. Make sure you exported and printed the same version of the G-code.

➡️ Method 3: Listen for [Morse code](https://en.wikipedia.org/wiki/Morse_code) sound 2 seconds after the pause sound notification.

Morse code for digit 1 - change to project filament #1,
Morse code for digit 2 - change to project filament #2,
...,
Morse code for digit 9 - change to project filament #9.

Morse code notification works for up to 9 filaments. There will be no Morse code sound for filaments #10+.

Morse codes (a sequence of dits and dahs) for digits from 1 to 9:

![image](https://github.com/user-attachments/assets/80723999-5300-436e-9ae8-c9ab8b1bdc2e)

Corresponding project filaments:

![image](https://github.com/user-attachments/assets/3588b2ec-703b-413d-8054-9661f2532e12)

---

Bambu Lab forum post for discussion https://forum.bambulab.com/t/multi-color-printing-on-a1-without-ams-G-code-modification/172930.

Or [create an issue](https://github.com/avatorl/bambu-a1-g-code/issues/new) here.

I think Bambu Lab A1 Mini can use the same code with only minor modification. It requires different X coordinates for the filament cutter in the "cut filament" code section.

And I believe this code can be modified to use the AMS for the first 4 colors and manual filament changes for any additional colors.

---

❗ WARNING! This is unofficial G-code. It is not authorized, endorsed, or supported by Bambu Lab. The author is not responsible for any negative consequences resulting from the use of this code, including but not limited to filament waste, printing task failure, or printer damage. Use with caution at your own responsibility.

❗ There is no public  documentation for Bambu version of G-code, therefore I may be wrong about what some code lines do and don't do (possibly incorrect comments in the code).
