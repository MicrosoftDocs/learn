In this exercise, you'll learn how to boot CP/M and start programming.

## Microsoft BASIC 80

Microsoft BASIC 80 is also included on the A: drive.

To Start Microsoft Basic, type

```bash
mbasic B:TEST.BAS
```

This will start Microsoft Basic and create a file on the B: drive called TEST.BAS. You can save and load files from Basic.

```basic
save "B:TEST.BAS"
```

```basic
load "B:TEST.BAS"
```

To quit Basic type

```basic
system
```

For more information on Microsoft Basic, see [Microsoft Basic 80](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_BASIC-80.pdf?azure-portal=true).

## Word-Master Text Editor

The CP/M disk image includes the Word-Master text editor. To use Word-Master, you must switch the Web Terminal to **Character Mode**. In Character Mode, the Web Terminal sends each character you type as an MQTT message to the Altair emulator.

To toggle between **Line input mode** and **Character input mode** press <kbd>ctrl+L</kbd>. When finished with Word-Master switch back to **Line input mode** as the Web Terminal communications over MQTT in "Line input mode" is more efficient.

![Altair running Word Master text editor](../media/word-master-character-mode.png)

View the [Word-Master user's guide](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Word-Master_Manual.pdf?azure-portal=true).

The following table lists the ctrl characters used by Word-Master. This list is sourced from the [Experiencing the Altair 8800](https://glasstty.com/?p=1235) blog.

```text
VIDEO MODE SUMMARY

^O   INSERTION ON/OFF           RUB  DELETE CHR LEFT
^S   CURSOR LEFT CHAR           ^G   DELETE CHR RIGHT
^D   CURSOR RIGHT CHAR          ^\   DELETE WORD LEFT
^A   CURSOR LEFT WORD           ^T   DELETE WORD RIGHT
^F   CURSOR RIGHT WORD          ^U   DELETE LINE LEFT
^Q   CURSOR RIGHT TAB           ^K   DELETE LINE RIGHT
^E   CURSOR UP LINE             ^Y   DELETE WHOLE LINE
^X   CURSOR DOWN LINE           ^I   PUT TAB IN FILE
^^   CURSOR TOP/BOT SCREEN      ^N   PUT CRLF IN FILE
^B   CURSOR RIGHT/LEFT LINE     ^@   DO NEXT CHR 4X
^W   FILE DOWN 1 LINE           ^P   NEXT CHR IN FILE
^Z   FILE UP 1 LINE             ^V   NEXT CHR(S) TO VIDEO
^R   FILE DOWN SCREEN           ESC  EXIT VIDEO MODE
^C   FILE UP SCREEN             ^J   DISPLAY THIS

```

### Word-Master key mappings

In **Character input mode**, the following keyboard mappings will improve your editing experience.

```text
Keyboard key            Word-Master Ctrl Sequence
----------------------------------------------
Insert                  ^O   INSERTION ON/OFF
Delete                  ^G   DELETE CHR RIGHT
Cursor Left             ^S   CURSOR LEFT CHAR
Cursor Right            ^D   CURSOR RIGHT CHAR
Cursor Up               ^E   CURSOR UP LINE
Cursor Down             ^X   CURSOR DOWN LINE
```

## Compiling Assembler applications

The CP/M disk image includes a demo assembler application. Follow these steps to edit and assemble and load the demo file.

### Step 1: Copy the demo app to the B: drive

Copy the **demo.asm** file to the read/write B: drive using the **pip** command.

```bash
pip b:=a:demo.asm
```

### Step 2: Edit the demo.asm file with Word-Master

```bash
a:wm b:demo.asm
```

### Step 3: Assemble the demo.asm file

```bash
a:asm b:demo
```

### Step 4: Load and Link the assembled code

```bash
a:load b:demo
```

### Step 4: Run the application

```bash
b:demo
```

## Compiling C applications

The CP/M disk image includes a simple C application. Follow these steps to edit and compile and link the hw.c (helloworld) file.

### Step 1: Copy the hw.c source code to the B: drive

Copy the **hw.c** file to the read/write B: drive using the **pip** command.

```bash
pip b:=a:hw.c
```

### Step 2: Edit the hw.c file with Word-Master

```bash
a:wm b:hw.c
```

### Step 3: Compile the hw.c file

```bash
a:cc hw
```

### Step 4: Link the hw app

```bash
a:clink hw
```

### Step 4: Run the application

```bash
b:hw
```

### Step 5: Stop the hw application executing

To stop the application press <kbd>ctrl+c</kbd>