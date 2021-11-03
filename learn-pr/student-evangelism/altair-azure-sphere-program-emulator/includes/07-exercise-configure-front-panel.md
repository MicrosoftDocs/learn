In this exercise, you'll use the virtual front panel, the MikroE 8800 Retro Click, and Altair front panel board to program the Altair emulator.

## Virtual front panel

To access the Virtual Front panel, you must be connected to the Altair emulator via the web terminal.

1. From the web terminal, press **ctrl+M** to enter the CPU Monitor.
1. You can enter binary strings to represent the switches on a real Altair front panel. For example, if you entered *0000000011110000* followed by Enter, then you're setting 12 switches off and 4 switches on.
1. You can enter Altair control commands as follows:
    * **e** = EXAMINE
    * **en** = EXAMINE NEXT
    * **d** = DEPOSIT
    * **dn** = DEPOSIT
    * **s** = SINGLE STEP
1. If you wanted to load the three byte [Intel 8080 Jmp](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true) at address 0x0100 then you would:
    1. Type **100000000** (0x0100) followed by Enter.
    1. Type **e** for EXAMINE, followed by Enter to set the CPU current instruction pointer to address 0x0100.
    1. Type **11000011** (The Intel 8080 opcode for Jmp) followed by Enter.
    1. Type **d** followed by Enter to DEPOSIT the instruction at address 0x0000.
    1. Type **0** followed by Enter to set the **low** order address for the Jump instruction.
    1. Type **dn** followed by Enter to DEPOSIT NEXT to increment the CPU instruction pointer to the next address location and deposit the high-order byte of the Jmp instruction.
    1. Type **dn** followed by Enter to DEPOSIT NEXT to increment the CPU instruction pointer to the next address location and deposit the **high** order byte of the Jmp instruction.

1. To execute the instructions you entered you would:
    1. Type **100000000** (0x0100) followed by Enter
    1. Type **e"" followed by Enter to set the CPU instruction pointer to address 0x0100.
    1. Type **s** followed by Enter to SINGLE STEP the CPU.
    1. Type **s** followed by Enter to SINGLE STEP the CPU and you will see the CPU address will now be s0x0000 after executing the jump to address 0x0000.

        ```text
        Single step: Address bus: 00000000 00000000 (0x0000), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
        ```

1. To exit CPU Monitor mode press **ctrl+M**
1. Note, you are directly setting memory addresses and you will likely overwrite something important and crash the Altair emulator, if this happens then just reset the Azure Sphere, and experiment again.

## Avnet Click Front Panel with the MikroE 8800 Retro Click

The MikroE 8800 Retro Click has two modes of operation, command mode, and input mode. The modes are selected by pressing **Button B** on the Avnet Azure Sphere starter kit. When you change modes the MikroE 8800 Retro 8x8 LED panel will briefly display **C** or **I**.

### Command Mode

In **Command Mode**, the buttons take on the role of the command switches on the Altair. In this mode you have access to CPU STOP, CPU RUN, SINGLE STEP, EXAMINE, EXAMINE NEXT, DEPOSIT, and DEPOSIT NEXT.

:::image type="content" source="../media/altair-retro-click-panel-command-mode.png" alt-text="Photo that shows buttons for command mode." border="false":::

### Input Mode

In **Input Mode**, the buttons take on the role of the 16 address/data switches on the Altair. Using the 16 buttons on the ALtair 8800 Retro Click you can set the bit values to be loaded onto the data bus or address bus.

:::image type="content" source="../media/altair-retro-click-panel-input-mode.png" alt-text="Screenshot that shows input mode." border="false":::

### CPU RUN STOP Status LEDs

The top row of LEDs are the Altair status indicators. In **CPU STOP** mode, the middle row of LEDs displays the 8 bits on the Data Bus, the bottom two rows display the 16 bits set on the Address Bus. In **CPU RUN** mode, the Data and Address bus LEDs are sampled every 20 milliseconds and are an indicator of activity.

### Loading an Intel 8080 opcode by using the Click front panel

Taking the same example as the virtual front panel. We are going to load the 3 byte [Intel 8080 Jmp](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true) at address 0x0100.

Follow along:

1. Press **STOP CPU**.
1. Press **Button B** on the Avnet Stater kit to switch to **Input** mode.
1. Press button **8** to set address 0x0100.
1. Press **Button B** on the Avnet Stater kit to switch to **Command** mode.
1. Press **EXAMINE** to set the CPU instruction pointer.
1. Press **Button B** on the Avnet Stater kit to switch to **Input** mode.
1. Press button **8** to turn off the address just entered.
1. Press buttons **7**, **6**, **1**, and **0** to set the Intel 8080 Jmp instruction
1. Press **Button B** on the Avnet Stater kit to switch to **Command** mode.
1. Press **DEPOSIT** to deposit the first byte of the Jmp instruction at address 0x0100.
1. Press **Button B** on the Avnet Stater kit to switch to **Input** mode.
1. Press buttons **7**, **6**, **1**, and **0** to turn off the switches set in the previous step
1. Press **Button B** on the Avnet Stater kit to switch to **Command** mode.
1. Press **DEPOSIT NEXT** to deposit zero into the **low** order jump address
1. Press **DEPOSIT NEXT** again to deposit zero into the **high** order jump address

Set the CPU Instruction pointer to 0x0100

1. Press **Button B** on the Avnet Stater kit to switch to **Input** mode.
1. Press button **8** to set address 0x0100.
1. Press **Button B** on the Avnet Stater kit to switch to **Command** mode.

Execute the instruction

1. Press **SINGLE STEP**
1. Press **SINGLE STEP** again and note the address on the address bus will change to zero. All of the address bus LEDs will be turned off.

1. Press **CPU START** to start the CPU running again.

> [!NOTE]
> You can observe the instruction being executed in the web terminal as well.
> ```text
>     Examine: Address bus: 00000001 00000000 (0x0100), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
> Single step: Address bus: 00000001 00000000 (0x0100), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
> Single step: Address bus: 00000000 00000000 (0x0000), Data bus 11000011 (0xc3), JMP adr          (3 byte instruction)
> ```

## Altair front panel

The Altair front panel board can be used with the Avnet Starter Kit and the Seeed Studio Reference Design Board.

:::image type="content" source="../media/altair-front-panel.png" alt-text="Photo that shows the Altair front panel." border="false":::

### Loading an Intel 8080 opcode using the Altair front panel

Using the same example as the virtual front panel. We are going to load the 3 byte [Intel 8080 Jmp](https://github.com/AzureSphereCloudEnabledAltair8800/Altair8800.manuals/blob/master/8080asm.pdf?azure-portal=true) at address 0x0100.

Follow along:

1. Flick the **STOP** switch.
1. Turn on address/data bus switch **8** by moving to the up position to set address 0x0100. Ensure all other switches are down in the off position.
1. Flick the **EXAMINE** switch to set the CPU instruction pointer.
1. Set address/data bus switch 8 to the off position.
1. Set address/data bus switches 7, 6, 1 and 0 on (moved to the up position). These switch settings are the Intel 8080 jmp instruction.
1. Flick the **DEPOSIT** switch.
1. Turn off all address/data bus switches.
1. Flick the **DEPOSIT NEXT** switch to load zero into the **low** order jump address
1. Flick the **DEPOSIT NEXT** switch again to load zero into the **high** order jump address

Set the CPU Instruction pointer to 0x0100

1. Turn on address/data bus switch **8** by moving to the up position to set address 0x0100. Ensure all other switches are down in the off position.
1. Flick the **EXAMINE** switch to set the CPU instruction pointer.

Execute the instruction

1. Flick the **SINGLE STEP** switch.
1. Flick **SINGLE STEP** again and note the address on the address bus will change to zero. All of the address bus LEDS will be turned off.
