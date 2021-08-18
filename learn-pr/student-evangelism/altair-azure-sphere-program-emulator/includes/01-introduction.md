In this module, you will learn how how to program the Altair 8800 emulator.

The Altair emulator is running an Open Source Intel 8080 emulator, and on top of the emulator is layered Altair BASIC and CP/M. [CP/M](https://en.wikipedia.org/wiki/CP/M) is an early microcomputer operating system that predates DOS.

The Altair Emulator can be programmed in two ways, either by entering Intel 8080 [Opcodes](https://en.wikipedia.org/wiki/Opcode) using the Altair front panel switches or with a higher-level programming language.

![Altair on Azure Sphere application architecture](../media/azure-sphere-app-architecture.png)

When you first start the Altair emulator, it boots up Altair BASIC and you can program directly in BASIC. After Altair BASIC has started you can also boot the Altair emulator into CP/M. From CP/M you can program the Altair emulator using Microsoft BASIC, BD Software C, and Microsoft MACRO-80 Assembler. 

## Saving files

It's important to appreciate that you can only save files when you are running CP/M on the emulator and you must also have the virtual disk server running. From CP/M you can start **MBASIC (Microsoft Basic)**, and write and save apps to the virtual B: drive. For **C** and **Assembler** applications you can edit with the WordStar text editor and save files to the virtual B: drive.

The following are useful reference manuals for the Altair emulator:

1. [Altair 8800 BASIC Reference Manual](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/MITS_Altair8800Basic4.1Reference_April1977.pdf?azure-portal=true)
1. [Intel 8080 Assembly Language Programming Manual](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true)
1. [CP/M Reference Manual](http://www.cpm.z80.de/manuals/cpm22-m.pdf)
1. [Microsoft Basic 80](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_BASIC-80.pdf?azure-portal=true)
1. [BDS C User's Guide](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/BDS_C_Compiler.pdf?azure-portal=true)
1. [Microsoft MACRO-80 Assembler](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_M80_Assembler.pdf?azure-portal=true)
1. [Microsoft LINK-80 Loader](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Microsoft_L80_Linker.pdf?azure-portal=true)
1. [Word-Master user's guide](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/Word-Master_Manual.pdf?azure-portal=true)
1. [CP/M BDOS System Calls](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/CP_M_information_archive_BDOS_system_calls.pdf)


In the next unit, you will learn how to program the Altair emulator using Altair BASIC.