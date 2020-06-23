You'll use a USB-to-serial adapter to connect the UART on the real-time core to a USB port on your machine and set up your hardware to display output.

### RT core toolchain

The Visual Studio extension for Azure Sphere includes the compiler that is required for the ARM Cortex-M4 processors on the real-time capable cores. 

When you are using Visual Studio Code or you are developing from the CLI, you must install this compiler yourself. You can find the GNU embedded toolchain for ARM that includes the compiler on the [Arm developer website](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads).

In this module, you're developing an application using Visual Studio Code. Follow the instructions in the website to install GNU embedded toolchain.

After installation, configure Visual Studio Code with the path to the GNU Arm Embedded Toolchain:

1. In the **File** menu select **Preferences > Settings > Extensions > AzureSphere**.
2. Under **Azure Sphere: Arm Gnu Path**, update the path to the GNU Arm Embedded Toolchain install directory. By default, the toolchains are installed in /opt/azurespheresdk/Sysroots/*sysroot-version*/tools.

To set up the hardware to display output from an RTApp, follow these steps. You'll need to refer to the documentation from your hardware manufacturer to determine the pin locations. If you're using hardware that follows the MT3620 reference board design (RDB) hardware, like the MT3620 Dev Kit from Seeed Studios, then looking at [the RDB interface headers](https://docs.microsoft.com/azure-sphere/hardware/mt3620-user-guide#interface-headers) may help you to determine the pin locations.

> Note: If you're not using MT3620 RDB hardware, update the [app_manifest.json file](https://docs.microsoft.com/azure-sphere/app-development/app-manifest) and the sample code to specify the correct UART, for example ISU1.

1. Install a terminal emulator like [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).
2. Connect GND on the USB-to-serial adapter to GND on your dev kit. On MT3620 RDB hardware, GND is Header 3, pin 2.
3. Connect RX on the USB-to-serial adapter to IOM4-0 TX on your dev kit. On MT3620 RDB hardware, IOM4-0 TX is Header 3, pin 6.
4. Attach the USB-to-serial adapter to your PC.
5. Make sure that Azure Sphere device is connected to your PC.
6. Determine which COM port the adapter uses on the PC. If you're using the FTDI Friend adapter, start **Device Manager**, select **View** > **Devices by container**, and look for FT232R USB UART.
7. On the PC, start a **terminal emulator** and then open a 115200-8-N-1 terminal to the COM port used by the adapter.
