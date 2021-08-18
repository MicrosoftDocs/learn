In this exercise, you will learn how to write your first Altair BASIC application, and how to start CP/M and write applications in Basic, C, and Assembler.

## Altair Basic

On startup, the Altair emulator will load the Altair BASIC and you will be prompted for the following information:

* **MEMORY SIZE?** If you plan to just run Altair BASIC then just press the Enter key. If you plan to boot into CP/M then enter 32000 followed by the Enter key.
* **TERMINAL  WIDTH?** Press the Enter key to accept the default.
* **WANT SIN-COS-TAN-ATN?** Y or N

Altair BASIC will respond with the amount of memory and version information.

> [!div class="mx-imgBorder"]
> ![The illustration shows Altair BASIC starting.](../media/altair-basic-init.png)

### Type your first program

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

### Useful commands

* list
* new
* load

Refer to the [Altair 8800 BASIC Reference Manual](https://altairclone.com/downloads/manuals/BASIC%20Manual%2075.pdf?azure-portal=true) for more information.

### Loading applications

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

