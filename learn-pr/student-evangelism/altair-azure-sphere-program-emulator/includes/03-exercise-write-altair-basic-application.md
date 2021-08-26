In this exercise, you'll learn how to write your first Altair BASIC application. Following that, you'll learn how to start CP/M and write applications with Basic, C, and Assembler.

## Altair Basic

The Altair emulator would have started running before your connected to the Web Terminal. So, press the **RESET** button on the Azure Sphere to restart the Altair emulator. When it restarts you will be prompted for the following information:

* **MEMORY SIZE?** If you only plan to run Altair BASIC, press the Enter key. If you plan to boot into CP/M, then enter 32000 followed by the Enter key.
* **TERMINAL  WIDTH?** Press the Enter key to accept the default.
* **WANT SIN-COS-TAN-ATN?** Y or N

Altair BASIC will respond with the amount of memory and version information.

> [!div class="mx-imgBorder"]
> ![The illustration shows Altair BASIC starting.](../media/altair-basic-init.png)

## Type your first program

```basic
10 for i = 1 to 1000
20 print i
30 next i
```

To run the program, type

```basic
run
```

and press Enter.

## Useful commands

* list
* new
* load
* <kbd>ctrl+c</kbd> to halt a program

For more information about Altair BASIC, see the [Altair 8800 BASIC Reference Manual](https://altairclone.com/downloads/manuals/BASIC%20Manual%2075.pdf?azure-portal=true).

## Loading applications

There are six preloaded Altair BASIC applications:

* STARTREK.BAS
* TICTACTOE.BAS
* SIMPLE.BAS
* LOOPY.BAS
* WEATHER.BAS
* IOT.BAS

To load an application type **load** followed by the application name in speech marks. For example:

```basic
load "TICTACTOE.BAS"
```

Then run the application.

```text
run
```

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

To run IOT.BAS, follow these steps.

```text
new
```

```basic
load "IOT.BAS"
```

Then run the application.

```text
run
```

When you run this application, temperature and pressure data will be published to IoT Central. You can view the data on the Environment tab for your device.

> [!div class="mx-imgBorder"]
> ![The illustration shows an IoT Central chart.](../media/iot-central-environment-chart.png)

## Extend the IOT.BAS app

Make the IOT.BAS application read the temperature and pressure every 5 seconds. When the temperature and pressure are read, the data is sent to IoT Central and plotted on the Environment chart.

To pause the app for approximately 5 seconds, just add a loop.

```basic
250 FOR J = 0 TO 50000: NEXT J
```

In the follow unit, you'll learn how to boot CP/M and start programming.
