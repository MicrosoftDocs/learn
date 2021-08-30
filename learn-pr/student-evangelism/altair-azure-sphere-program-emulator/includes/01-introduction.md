In this module, you'll learn how to program the Altair 8800 emulator.

The Altair emulator is running an Open Source Intel 8080 emulator. Layered on the Intel 8080 emulator is Altair BASIC and CP/M.

The Altair Emulator can be programmed in two ways:

1. Entering Intel 8080 [Opcodes](https://en.wikipedia.org/wiki/Opcode) using the Altair front panel switches
1. or, using a higher-level programming language.

![Altair on Azure Sphere application architecture.](../media/azure-sphere-app-architecture.png)

When you start the Altair emulator, it boots up CP/M. From CP/M you can program the Altair emulator using Microsoft BASIC, BD Software C, and Microsoft MACRO-80 Assembler. You can boot the Altair emulator into Altair BASIC by updating the CMakeList.txt **Boot Config** section.

## Saving files

Files can only be saved from CP/M on the Altair emulator. You must have the virtual disk server running or an Avnet Azure Sphere Starter Kit with the MikroE microSD Click. From CP/M you can start **MBASIC (Microsoft Basic)**, and write and save apps to the virtual B: drive. For **C** and **Assembler** applications you can edit with the WordStar text editor and save files to the virtual B: drive.

In this module, you will:

* Understand Altair BASIC and CP/M, and how to use them.
* Learn how to program the Altair emulator using Altair BASIC.
* Learn about programming options and configurations for the Altair emulator.

## Prerequisites

* A computer with an x86-64-based processor running:
  * Windows 10 Anniversary Update or later.
  * Or, 64-bit Ubuntu 20.04 LTS or Ubuntu 18.04 LTS.
* An Azure Sphere developer board. Either:
  * An Avnet Azure Sphere Starter Kit Rev 1 or 2.
  * Or, a Seeed Studio Azure Sphere MT3620 Development Kit.
* A GitHub account.
* An Azure Account. Sign up for a free [Student Azure account](https://azure.microsoft.com/free/students?azure-portal=true), or free [Azure account](https://azure.microsoft.com/free?azure-portal=true).

In the next unit, you'll learn how to program the Altair emulator using Altair BASIC.
