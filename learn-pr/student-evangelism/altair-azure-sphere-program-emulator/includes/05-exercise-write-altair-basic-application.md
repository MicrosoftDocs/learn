In this exercise, you'll learn how to start Altair BASIC and write your first Altair BASIC application.

Altair BASIC was the first high-level programing language for the Altair 8800. For this exercise, imagine you were a games developer in the 1970s building a game on the Altair 8800. This exercise, is an introduction to Altair BASIC, the rest is up to your imagination.

By default, the Altair emulator boots CP/M. To change the boot order, and boot Altair BASIC, then follow these instructions.

1. From Visual studio code, open the Altair emulator CMakeList.txt file, and update the **BOOT CONFIG**.

    ```cmake
    # BOOT CONFIG #####################################################################################################
    #
    # Comment out the "add_compile_definitions(BOOT_CPM) line below to boot Altair BASIC 4.0
    #
    add_compile_definitions(BOOT_CPM)
    #
    ###################################################################################################################
    ```

1. Redeploy the Altair emulator to your Azure Sphere. Press **ctrl+F5**

## Connect to the Web Terminal

To program the Altair, you first need to **Connect** the Web Terminal to the Altair 8800 emulator running on the Azure Sphere. Once connected, you can load, or write and run Altair BASIC apps.

1. Switch back the Web Terminal in your web browser.
1. If necessary, authenticate the Web Terminal.
1. The Altair emulator may have started running before you connected to the Web Terminal. If so, press the **RESET** button on the Azure Sphere to restart the Altair emulator. When the Azure Sphere restarts, the Altair BASIC will prompt for the following information.

    * **MEMORY SIZE?** Press the Enter key to accept the default.
    * **TERMINAL  WIDTH?** Press the Enter key to accept the default.
    * **WANT SIN-COS-TAN-ATN?** Y or N

Altair BASIC will respond with the amount of memory and version information.

> [!div class="mx-imgBorder"]
> ![The illustration shows Altair BASIC starting.](../media/altair-basic-init.png)

## Type your first program

From the Web Terminal, type in your first Altair BASIC application.

```basic
10 for i = 1 to 1000
20 print i
30 next i
```

Your Web Terminal should look similar to the following image.

> [!div class="mx-imgBorder"]
> ![The illustration shows Altair BASIC with your first program.](../media/altair-basic-first-program.png)

To run the program, type

```basic
run
```

and press Enter, and your program will count to 1000.

## Useful commands

* list
* new
* load
* **ctrl+c** to halt a program

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

The application will start, and you will be prompted to go first.

```basic
*** WELCOME TO TIC-TAC-TOE ***
> YOU ARE X's <
DO YOU WANT TO GO FIRST? 
```

In the following unit, you'll learn how to program the Altair emulator from the front panel.
