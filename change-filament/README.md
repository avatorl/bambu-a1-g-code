# Manual filament change for Bambu Lab A1 without AMS

## About

This method allows **multi-color printing** without using the AMS. It supports 3D models with multiple color changes on the same layer. Manual filament replacement is required, so it is practical only for flat models (keychains, signs, labels, decorations, etc.) or for models where multi-color printing is needed only on the bottom and/or top surfaces (such as boxes with labels) or on a limited number of layers anywhere in the middle of the model. It is not suitable for models that require hundreds of filament changes.

This method also supports **multi-material printing** (e.g., PLA core inside a TPU model) and allows the use of a different filament type for the support interface (e.g., a PETG support interface in a PLA print, PLA support interface in a TPU print) in cases where the model or support interface is flat and such printing requires only a handful of material changes.

Even if you have AMS, this method may be helpful with **regular TPU** (without using AMS and TPU for AMS).

How many manual filament changes is too much? Find out your own limit. This method ensures as little time as possible is needed per manual filament change (pull out, push, resume). You can see in the comments that someone printed a model with 46 color changes.

### Supported features

➡️ There is no need to add a pause manually in the slicer. A print profile designed for AMS can be used as is (just replace the printer profile with this one).

➡️ Automatic filament unloading before pause (simply pull filament out without using the Unload menu)

➡️ Automatic pause with sound notification (if sound is enabled in Print Options in Bambu Studio)

➡️ Sound notification ([Morse code](https://en.wikipedia.org/wiki/Morse_code)) indicates which filament # should be inserted

➡️ Automatic filament load after pressing Resume Printing (simply push the new filament in and press Resume Printing without using the Load menu)

➡️ Filament flushing in accordance with Purging volumes matrix in Bambu Studio.

➡️ Flow dynamics calibration for each color (if enabled before printing)

### An example of a multi-color model printed using this method

<img src="https://github.com/user-attachments/assets/435a6253-d006-457c-8e5f-e64e57a1cacc" alt="Description" width="300">

---

To support this work download, print & boost this model: https://makerworld.com/en/models/1534741-multi-color-without-ams-with-ams-test#profileId-1609872

---

## Create Printer Preset

1. In Bambu Studio click this button to edit **printer settings preset**:

![image](https://github.com/user-attachments/assets/cba181f0-c58c-4677-b402-d3094aaf58bf)

❗Only for Bambu Lab A1, not compatible with  Bambu Lab A1 Mini

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

**Multi-material printing is possible** (e.g., TPU and PLA, PLA with a PETG support interface, and other variations).

Ignore the alert and just click Confirm. The printer will pause (controlled by custom G-code).

<img width="530" height="206" alt="image" src="https://github.com/user-attachments/assets/8bf7e6aa-3ebe-4bfc-80c7-9205eb662825" />

3. Wait for the pause. _If "Allow Prompt Sound" is enabled in Print Options, you will be notified of a pause by a sound._
  
4. **Pull out** the filament, **push in** the next filament, click **Resume Printing**.

There is no need to use the built-in _Unload_ and _Load_ procedures - just pull out, push in, resume printing.

Hold the filament between two fingers for a few seconds until you feel it has been caught by the extruder.

Inserting new filament right after the pause is faster than doing it a bit later, because the nozzle starts cooling down to 142°C and will need to be reheated afterward.

Repeat steps 3-4 for each pause.

_Filament replacement will take less time if done right after a pause. Otherwise, additional time will be required for reheating the nozzle._

---

### How can I know which color to load? ###

➡️ Method 1: In the slicer, on the "Preview" tab, use the vertical (layers) and horizontal sliders to see the color printing order.

[Screen Recodring](https://www.dropbox.com/scl/fi/z6gaeb16i7c8jvk20jfyj/bambu-studio_GH1MCBXD56.mp4?rlkey=8znxxgiaz6s3shov7f9dqy1xs&dl=0)

❗ Re-slicing the model, even without any changes to print settings, may alter the filament change order. Avoid this method if the model has already been re-sliced after being sent to the printer.

➡️ Method 2: Export the sliced .gcode.3mf file, unzip it (you can simply rename the .3mf extension to .3mf.zip), extract and open the G-code file (located in the Metadata folder inside the .3mf.zip archive), and search for all "M1020 S" commands using Notepad (or preferably Notepad++).

[Screen Recording](https://www.dropbox.com/scl/fi/3z5of3s66da3euobdb601/bambu-studio_YYQJFr1TtI.mp4?rlkey=ml6wx1w285e6ry0jpgcvy4nen&dl=0)

_"M1020 S0"_ - change to project filament #1, 
_"M1020 S1"_ - change to project filament #2, 
_"M1020 S2"_ - change to project filament #3, 
and so on.

For example, _"M1020 S5"_ inG-code means project filament #6 (red color) on this screenshot:

![image](https://github.com/user-attachments/assets/4ba6c987-1c45-41ec-b10a-5d344758ebcc)

❗ Re-slicing, even without any changes to the print settings, may change the filament change order in the G-code. Make sure you exported and printed the same version of the G-code. Avoid this method if the model has already been re-sliced after being sent to the printer.

❗ "M1020 S" commands appear in G-code only when custom filament change code is used. You won't find this command in the G-code generated with the default printer settings.

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

### Printing the support/raft base/interface using a different filament type ###

1. Select **Filament for Supports**.

   ![image](https://github.com/user-attachments/assets/dc81011d-f891-4204-85e8-2785942b800e)

2. In "Send print job" dialog match all filaments (regardless of filament type) with the same external spool.

   ![image](https://github.com/user-attachments/assets/d9f39d6e-acb8-42db-8833-abb9016abe7c)

3. Send the printing job for printing.

4. Ignore "The printer won't pause during printing" warning and click **Confirm**. The printer will be paused for filamet changes by the custom G-code.

   ![image](https://github.com/user-attachments/assets/7af60d2b-8eaa-4118-81b6-9c4e492762b5)

---

Bambu Lab forum post for discussion https://forum.bambulab.com/t/multi-color-printing-on-a1-without-ams-G-code-modification/172930.

Or [create an issue](https://github.com/avatorl/bambu-a1-g-code/issues/new) here.

I think Bambu Lab A1 Mini can use the same code with only minor modification. It requires different X coordinates for the filament cutter in the "cut filament" code section.

And I believe this code can be modified to use the AMS for the first 4 colors and manual filament changes for any additional colors.

---

❗ WARNING! This is unofficial G-code. It is not authorized, endorsed, or supported by Bambu Lab. The author is not responsible for any negative consequences resulting from the use of this code, including but not limited to filament waste, printing task failure, or printer damage. Use with caution at your own responsibility.

❗ There is no public  documentation for Bambu version of G-code, therefore I may be wrong about what some code lines do and don't do (possibly incorrect comments in the code).
