In this module, you'll learn how to program the Altair 8800 emulator.

The Altair emulator is running an Open Source Intel 8080 emulator. Layered on the Intel 8080 emulator is Altair BASIC and CP/M. You may not have heard of [CP/M](https://en.wikipedia.org/wiki/CP/M), it was an early microcomputer operating system that predates DOS.

The Altair Emulator can be programmed in two ways:

1. Entering Intel 8080 [Opcodes](https://en.wikipedia.org/wiki/Opcode) using the Altair front panel switches
1. or, using a higher-level programming language.

![Altair on Azure Sphere application architecture.](../media/azure-sphere-app-architecture.png)

When you start the Altair emulator, it boots up Altair BASIC ready for your first program. You can boot CP/M after the Altair emulator has started. From CP/M you can program the Altair emulator using Microsoft BASIC, BD Software C, and Microsoft MACRO-80 Assembler.

## Saving files

Files can only be saved from CP/M on the Altair emulator and you must have the virtual disk server running. From CP/M you can start **MBASIC (Microsoft Basic)**, and write and save apps to the virtual B: drive. For **C** and **Assembler** applications you can edit with the WordStar text editor and save files to the virtual B: drive.

The following are useful reference manuals for the Altair emulator:

* [Altair 8800 BASIC Reference Manual](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/MITS_Altair8800Basic4.1Reference_April1977.pdf?azure-portal=true)
* [Intel 8080 Assembly Language Programming Manual](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true)
* [CP/M Reference Manual](http://www.cpm.z80.de/manuals/cpm22-m.pdf)
* [Microsoft Basic 80](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_BASIC-80.pdf?azure-portal=true)
* [BDS C User's Guide](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/BDS_C_Compiler.pdf?azure-portal=true)
* [Microsoft MACRO-80 Assembler](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_M80_Assembler.pdf?azure-portal=true)
* [Microsoft LINK-80 Loader](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_L80_Linker.pdf?azure-portal=true)
* [Word-Master user's guide](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Word-Master_Manual.pdf?azure-portal=true)
* [CP/M BDOS System Calls](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/CP_M_information_archive_BDOS_system_calls.pdf)

In this module, you will:

* Understand Altair BASIC and CP/M, and how to use them.
* Learn how to program the Altair emulator using Altair BASIC.
* Write an Altair BASIC application.
* Learn about programming options and configurations for the Altair emulator.

## Prerequisites

TBD