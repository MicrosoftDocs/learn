In this unit, you'll learn how to program the Altair emulator using the front panel.

You have the following options to program with the front panel:
1. The virtual front panel.
1. The MikroE 8800 Retro Click.
1. The Altair front panel board.

The original Altair 8800 was programmed directly using the front panel. It was a painstaking, error-prone process to load and execute a program. Programming the Altair emulator using the front panel and Intel opcodes is a great way for you to understand how computers work.

The Altair 8800 had a series of LEDs and switches that you used to load apps and determine the state of the Altair.

![Image of the Altair 8800.](../media/altair-8800-smithsonian-museum.png)
[Altair 8800 image attribution - Smithsonian Museum](https://commons.wikimedia.org/wiki/File:Altair_8800,_Smithsonian_Museum.jpg)

## Overview

The Altair emulator supports several front panel configurations.

1. The virtual front panel, the advantage is that no extra hardware is required. The virtual front panel works with both the Avnet and Seeed Studio Azure Sphere developer kits.
2. If you have an Avnet Azure Sphere Starter Kit, then the MikroE 8800 Retro Click front panel is an option to simulate the front panel. The advantage is a more authentic experience programming the Altair. The LED panel also indicates the current state of the Altair and your application.
3. The Altair front panel is the most authentic experience, you'll need to build the panel, but it operates just like the original Altair. You can find the hardware design in the [MT3620 Azure Sphere Based Altair 8800 Hardware](https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.Hardware?azure-portal=true)) repo.

In the following exercise, you'll learn how to program the Altair emulator using the Altair front panel.
