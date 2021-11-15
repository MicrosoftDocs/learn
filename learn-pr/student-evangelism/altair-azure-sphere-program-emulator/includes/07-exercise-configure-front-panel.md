In this exercise, you'll use the virtual front panel, the MikroE 8800 Retro Click, and Altair front panel board to program the Altair emulator.

## Virtual front panel

To access the virtual front panel, you must be connected to the Altair emulator via the web terminal.

> [!NOTE]
> In the following procedure, you're directly setting memory addresses. You'll likely overwrite something important and crash the Altair emulator. If this happens, reset Azure Sphere and experiment again.

1. From the web terminal, select **Ctrl+M** to enter the CPU monitor.
1. You can enter binary strings to represent the switches on a real Altair front panel. For example, if you type **0000000011110000** and then select the **Enter** key, you set 12 switches off and 4 switches on.

   The following steps use these Altair control commands:
    * **e** = EXAMINE
    * **en** = EXAMINE NEXT
    * **d** = DEPOSIT
    * **dn** = DEPOSIT NEXT
    * **s** = SINGLE STEP
1. If you want to load the 3-byte [Intel 8080 Jmp](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true) at address 0x0100, use the following commands (type them and then select **Enter**):
    1. Enter **100000000** (0x0100).
    1. Enter **e** to set the CPU current instruction pointer to address 0x0100.
    1. Enter **11000011**, the Intel 8080 opcode for Jmp.
    1. Enter **d** to deposit the instruction at address 0x0000.
    1. Enter **0** to set the **low** order address for the Jmp instruction.
    1. Enter **dn** to increment the CPU instruction pointer to the next address location and deposit the high-order byte of the Jmp instruction.
    1. Enter **dn** again to increment the CPU instruction pointer to the next address location and deposit the high-order byte of the Jmp instruction.

1. To execute the instructions that you entered:
    1. Enter **100000000** (0x0100).
    1. Enter **e** to set the CPU instruction pointer to address 0x0100.
    1. Enter **s** to SINGLE STEP the CPU.
    1. Enter **s** again to SINGLE STEP the CPU. The CPU address is now s0x0000 after execution of the jump to address 0x0000.

        ```text
        Single step: Address bus: 00000000 00000000 (0x0000), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
        ```

1. To exit the CPU monitor, select **Ctrl+M**.

## Avnet Click Front Panel with the MikroE 8800 Retro Click

The MikroE 8800 Retro Click has two modes of operation: command mode and input mode. You select the modes by pressing **Button B** on the Avnet Azure Sphere starter kit. When you change modes, the MikroE 8800 Retro 8x8 LED panel briefly displays **C** or **I**.

### Command mode

In command mode, the buttons take on the role of the command switches on the Altair. In this mode, you have access to CPU STOP, CPU RUN, SINGLE STEP, EXAMINE, EXAMINE NEXT, DEPOSIT, and DEPOSIT NEXT.

:::image type="content" source="../media/altair-retro-click-panel-command-mode.png" alt-text="Diagram that shows buttons for command mode." border="false":::

### Input mode

In input mode, the buttons take on the role of the 16 address/data switches on the Altair. By using the 16 buttons on the Altair 8800 Retro Click, you can set the bit values to be loaded onto the data bus or address bus.

:::image type="content" source="../media/altair-retro-click-panel-input-mode.png" alt-text="Diagram that shows buttons for input mode." border="false":::

### Status LEDs for CPU STOP and CPU RUN

The top row of LEDs consists of the Altair status indicators. In CPU STOP mode, the middle row of LEDs displays the 8 bits on the data bus. The bottom two rows display the 16 bits on the address bus. In CPU RUN mode, the LEDs for the data bus and address bus are sampled every 20 milliseconds and are an indicator of activity.

### Loading an Intel 8080 opcode by using the Click front panel

Using the same example as the virtual front panel, follow these steps to load the 3-byte [Intel 8080 Jmp](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true) at address 0x0100:

1. Press **CPU STOP**.
1. Press **Button B** on the Avnet Starter Kit to switch to input mode.
1. Press button **8** to set address 0x0100.
1. Press **Button B** on the Avnet Starter Kit to switch to command mode.
1. Press **EXAMINE** to set the CPU instruction pointer.
1. Press **Button B** on the Avnet Starter Kit to switch to input mode.
1. Press button **8** to turn off the address just entered.
1. Press buttons **7**, **6**, **1**, and **0** to set the Intel 8080 Jmp instruction.
1. Press **Button B** on the Avnet Starter Kit to switch to command mode.
1. Press **DEPOSIT** to deposit the first byte of the Jmp instruction at address 0x0100.
1. Press **Button B** on the Avnet Starter Kit to switch to input mode.
1. Press buttons **7**, **6**, **1**, and **0** to turn off the switches set in the previous step.
1. Press **Button B** on the Avnet Starter Kit to switch to command mode.
1. Press **DEPOSIT NEXT** to deposit zero into the low-order jump address.
1. Press **DEPOSIT NEXT** again to deposit zero into the high-order jump address.

Set the CPU Instruction pointer to 0x0100:

1. Press **Button B** on the Avnet Starter Kit to switch to input mode.
1. Press button **8** to set address 0x0100.
1. Press **Button B** on the Avnet Starter Kit to switch to command mode.

Execute the instruction:

1. Press **SINGLE STEP**.
1. Press **SINGLE STEP** again. The address on the address bus changes to zero. All of the address bus LEDs are now turned off.

1. Press **CPU START** to start the CPU running again.

> [!NOTE]
> You can also observe the instruction being executed in the web terminal:
> ```text
>     Examine: Address bus: 00000001 00000000 (0x0100), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
> Single step: Address bus: 00000001 00000000 (0x0100), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
> Single step: Address bus: 00000000 00000000 (0x0000), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
> ```

## Altair front panel

The Altair front panel board can be used with the Avnet Starter Kit and the Seeed Studio Reference Design Board.

:::image type="content" source="../media/altair-front-panel.jpg" alt-text="Photo that shows the Altair front panel." border="false":::

### Loading an Intel 8080 opcode by using the Altair front panel

Using the same example as the virtual front panel, follow these steps to load the 3-byte [Intel 8080 Jmp](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true) at address 0x0100:

1. Flick the **STOP** switch.
1. Turn on address/data bus switch **8** by moving it to the up position to set address 0x0100. Ensure that all other switches are down in the off position.
1. Flick the **EXAMINE** switch to set the CPU instruction pointer.
1. Set address/data bus switch **8** to the off position.
1. Set address/data bus switches **7**, **6**, **1**, and **0** to the on position. These switch settings are the Intel 8080 Jmp instruction.
1. Flick the **DEPOSIT** switch.
1. Turn off all address/data bus switches.
1. Flick the **DEPOSIT NEXT** switch to load zero into the low-order jump address.
1. Flick the **DEPOSIT NEXT** switch again to load zero into the high-order jump address.

Set the CPU Instruction pointer to 0x0100:

1. Turn on address/data bus switch **8** by moving it to the up position to set address 0x0100. Ensure that all other switches are down in the off position.
1. Flick the **EXAMINE** switch to set the CPU instruction pointer.

Execute the instruction:

1. Flick the **SINGLE STEP** switch.
1. Flick **SINGLE STEP** again. The address on the address bus changes to zero. All of the address bus LEDs are now turned off.
