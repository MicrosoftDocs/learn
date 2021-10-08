In this exercise, you'll learn how to start programming the Altair emulator.

## Connect to the Web Terminal

1. Switch back the Web Terminal in your web browser.
1. If required, authenticate the Web Terminal.
1. The Altair emulator may have started running before you connected to the Web Terminal. If so, press the **RESET** button on the Azure Sphere to restart the Altair emulator. When the Azure Sphere restarts, the CP/M **>** prompt will be displayed in the Web Terminal.

## Getting started with CP/M

For more information about CP/M, see the [CP/M Reference Manual](http://www.cpm.z80.de/manuals/cpm22-m.pdf?azure-portal=true).

Here are some CP/M commands to get you started.

1. Directory listing.

    ```cpm
    dir
    ```

1. Erase a file.

    ```cpm
    era *.txt
    ```

1. Copy Microsoft Basic "mbasic.com" from the A: drive to the B: drive.

    ```cpm
    pip b:=a:mbasic.com
    ```

1. List the contents of a file.

    ```cpm
    type hw.c
    ```

1. Rename a file

    ```cpm
    ren hello.c=hw.c
    ```

## Get started with Microsoft BASIC 80

For more information on Microsoft Basic, see [Microsoft Basic 80](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_BASIC-80.pdf?azure-portal=true).

Microsoft BASIC 80 is included on the A: drive.

1. To Start Microsoft Basic, from the CP/M command prompt, type

    ```bash
    mbasic B:TEST.BAS
    ```

    Microsoft Basic will start and it will open or create a file called TEST.BAS on the B: drive.

1. Type your first program

    ```basic
    10 for i = 1 to 1000
    20 print i
    30 next i
    ```

1. Save your program to disk

    ```basic
    save "B:TEST.BAS"
    ```

1. Load your program from disk.

    ```basic
    load "B:TEST.BAS"
    ```

1. To stop a program executing

    Press **ctrl+c**.

1. To quit Basic type

    ```basic
    system
    ```

1. You can learn more about Basic from the Basic applications included with the Altair emulator. The Basic apps included are:

    * DISKRW.BAS
    * STARTREK.BAS
    * TICTACTOE.BAS
    * SIMPLE.BAS
    * LOOPY.BAS
    * WEATHER.BAS
    * IOT.BAS

## The Altair emulator and Internet of Things

The BASIC language has extensibility mechanism called ports. The Altair emulator includes support for ports and these ports are used by the **IOT.BAS** application. The IOT.BAS application calls **in** port 43 to read the temperature and port 44 to read the air pressure. These calls are routed to the C sphere_port_in in main.c of the Altair emulator.

If you have an Avnet Azure Sphere Starter Kit, then the temperature and pressure data is read from the onboard sensors. If you have a SEEED Azure Sphere then random temperature and pressure data is used.

The following BASIC program is a listing of IOT.BAS.

```basic
10 PRINT
20 PRINT "Avnet onboard temperature and pressure sensor App"
30 PRINT
70 A$=""
80 C=INP(43)
90 IF C = 0 THEN GOTO 120
100 A$=A$+CHR$(C)
110 GOTO 80
120 PRINT "Temperature is ";A$;" degrees Celsius."
130 A$=""
140 C=INP(44)
150 IF C = 0 THEN GOTO 180
160 A$=A$+CHR$(C)
170 GOTO 140
180 PRINT "Air pressure is ";A$;" hPa."
210 PRINT
```

This is the sphere_port_in C function found in main.c of the Altair emulator application.

```c
/// <summary>
/// Support for BASIC Port In for IOT.BAS temperature and pressure example
/// Example shows environment temperature and pressure example
/// </summary>
/// <param name="port"></param>
/// <returns></returns>
static uint8_t sphere_port_in(uint8_t port) {
  static bool reading_data = false;
  static char data[10];
  static int readPtr = 0;
  uint8_t retVal = 0;
  if (port == 43) {
    if (!reading_data) {
      readPtr = 0;
      snprintf(data, 10, "%d", onboard_telemetry.latest.temperature);
      publish_telemetry(onboard_telemetry.latest.temperature, onboard_telemetry.latest.pressure);
      reading_data = true;
    }
    retVal = data[readPtr++];
    if (retVal == 0x00) {
      reading_data = false;
    }
  }
  if (port == 44) {
    if (!reading_data) {
      readPtr = 0;
      snprintf(data, 10, "%d", onboard_telemetry.latest.pressure);
      reading_data = true;
    }
    retVal = data[readPtr++];
    if (retVal == 0x00) {
      reading_data = false;
    }
  }
  return retVal;
}
```

### Run the IOT.BAS application

1. To Start Microsoft Basic, from the CP/M command prompt, type

    ```cpm
    mbasic A:IOT.BAS
    ```

    Microsoft Basic will start and it will open the IOT.BAS application.

1. Run the IoT application.

    ```basic
    run
    ```

When you run this application, temperature and pressure data will be published to IoT Central. You can view the data in the IoT Central web portal under the Environment tab for your device.

> [!div class="mx-imgBorder"]
> ![The illustration shows an IoT Central chart.](../media/iot-central-environment-chart.png)

### Extend the IOT.BAS app

Make the IOT.BAS application read the temperature and pressure every 5 seconds. When the temperature and pressure are read, the data is sent to IoT Central and plotted on the Environment chart.

To pause the app for approximately 5 seconds, just add a loop.

```basic
250 FOR J = 0 TO 30000: NEXT J
```

Remember you can save changes you make using the Basic **Save** command.

```basic
save "B:IOT.BAS"
```

## Get started with the Word-Master Text Editor

The CP/M disk image includes the Word-Master text editor. To use Word-Master, you must switch the Web Terminal to **Character Mode**. In Character Mode, the Web Terminal sends each character you type as an MQTT message to the Altair emulator.

To toggle between **Line input mode** and **Character input mode** press **ctrl+L**. When finished with Word-Master switch back to **Line input mode** as the Web Terminal communications over MQTT in "Line input mode" is more efficient.

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

1. Copy the demo app to the B: drive

    Copy the **demo.asm** file to the B: drive using the **pip** command.

    ```bash
    pip b:=a:demo.asm
    ```

1. Edit the demo.asm file with Word-Master. From the CP/M command prompt, type

    ```bash
    a:wm b:demo.asm
    ```

1. Switch the Web Terminal to **Character Mode**.

    Press **ctrl+l**

1. Make your changes to the demo.asm file.

1. Save your updates to the demo.asm file.

    1. Press the **Esc** key.
    1. Press **e** to exit, your file changes will be saved to disk.

1. Switch the Web Terminal to **Line Mode**.

    Press **ctrl+l**

1. Assemble the demo.asm file.

    ```bash
    a:asm b:demo
    ```

1. Load and Link the assembled code.

    ```bash
    a:load b:demo
    ```

1. Run the demo application.

    ```bash
    b:demo
    ```

## Compiling C applications

The CP/M disk image includes a simple C application. Follow these steps to edit and compile and link the hw.c (helloworld) file.

1. Copy the hw.c source code to the B: drive

    Copy the **hw.c** file to the read/write B: drive using the **pip** command.

    ```bash
    pip b:=a:hw.c
    ```

1. Edit the hw.c file with Word-Master

    ```bash
    a:wm b:hw.c
    ```

1. Switch the Web Terminal to **Character Mode**.

    Press ctrl+l

1. Make your changes to the hw.c file.

1. Save your updates to the hw.c file.

    1. Press the **Esc** key.
    1. Press **e** to exit, your file changes will be saved to disk. 

1. Switch the Web Terminal to **Line Mode**.

    Press **ctrl+l**

1. Compile the hw.c file

    ```bash
    a:cc hw
    ```

1. Link the hw app

    ```bash
    a:clink hw
    ```

1. Run the application

    ```bash
    b:hw
    ```

1. Stop the hw application executing

    To stop the application press **ctrl+c**
