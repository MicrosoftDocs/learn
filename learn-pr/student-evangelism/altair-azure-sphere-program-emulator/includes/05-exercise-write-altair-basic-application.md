In this exercise, you'll learn how to start Altair BASIC and write your first Altair BASIC application.

By default, the Altair emulator boots CP/M. To change the boot order, and boot Altair Basic, then:

1. From Visual studio code, update the **BOOT CONFIG** in the CMakeList.txt file of the Altair emulator project.

    ```text
    # BOOT CONFIG #####################################################################################################
    #
    # Comment out the "add_compile_definitions(BOOT_CPM) line below to boot Altair BASIC 4.0
    #
    add_compile_definitions(BOOT_CPM)
    #
    ###################################################################################################################
    ```

1. Redeploy the Altair emulator to your Azure Sphere. Press <kbd>ctrl+F5</kbd>

## Connect to the Web Terminal

1. Switch back the Web Terminal in your web browser.
1. If required, authenticate the Web Terminal.
1. The Altair emulator may have started running before you connected to the Web Terminal. So, press the **RESET** button on the Azure Sphere to restart the Altair emulator. When the Azure Sphere restarts, the Altair BASIC will prompt for the following information.

* **MEMORY SIZE?** Press the Enter key to accept the default.
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

In the following unit, you'll learn how to program the Altair emulator using the front panel.
