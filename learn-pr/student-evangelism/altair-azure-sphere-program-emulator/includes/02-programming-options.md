In this unit, you'll learn background information about programming the Altair emulator from CP/M.

When you start the Altair emulator, it runs CP/M by default. From CP/M, you can program the Altair emulator by using Microsoft BASIC, BD Software C, and Microsoft MACRO-80 Assembler.

> [!NOTE]
> You can change the boot order so that the Altair emulator starts by running Altair BASIC. You set the boot order from the **Boot Config** section in the *cmake/altair_config.cmake* file.

## Saving files to disk

Files can be saved to disk when the Altair emulator is running CP/M. To save files to disk, you must run the virtual disk server or have an Avnet Azure Sphere Starter Kit with the MikroE microSD Click.

## Introduction to CP/M

For more information about CP/M, see the [CP/M Wikipedia article](https://en.wikipedia.org/wiki/CP/M?azure-portal=true).

CP/M originally stood for Control Program/Monitor. Later, CP/M became known as Control Program for Microcomputers. It was a mass-market operating system created in 1974 for Intel 8080/85-based microcomputers by Gary Kildall of Digital Research, Inc. 

The first version was single-tasking on 8-bit processors with support for up to 64 kilobytes of memory. Later versions of CP/M added multiple-user variations and were migrated to 16-bit processors.

## Programming options on CP/M

From CP/M, you can start MBASIC (Microsoft BASIC), and write and save apps to virtual drive B. For C and assembler applications, you can edit with the WordStar text editor and save files to virtual drive B.