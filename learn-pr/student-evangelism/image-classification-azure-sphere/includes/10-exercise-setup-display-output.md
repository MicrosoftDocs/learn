You'll use a USB-to-serial adapter to connect the MT3620 real-time core's dedicated logging UART to a USB port on your machine and set up your terminal emulator to display output from the RTApp.

## RT core toolchain and terminal prerequisites

Before you open or build the RTApp project, verify that your development environment includes the Azure Sphere SDK, CMake, Ninja, the Azure Sphere and CMake Tools extensions for Visual Studio Code, and the GNU Arm Embedded Toolchain (`arm-none-eabi`) or an equivalent toolchain installed through vcpkg artifacts.

Install the GNU Arm Embedded Toolchain by following the [Azure Sphere RTApp quickstart](/azure-sphere/install/qs-real-time-application?view=azure-sphere-integrated#install-the-gnu-arm-embedded-toolchain&preserve-view=true). The quickstart links to current Arm GNU Toolchain downloads and describes the vcpkg artifacts option. By default, Visual Studio Code searches for the installed toolchain. If you encounter build problems related to toolchain discovery, set **Azure Sphere: Arm Gnu Path** to the actual GNU Arm toolchain installation directory. Don't set it to an Azure Sphere SDK sysroot directory.

Install a serial terminal emulator:

- On Windows, install [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), Tera Term, or another serial terminal emulator.
- On Ubuntu Linux, install a terminal emulator such as minicom or screen. For example:

  ```bash
  sudo apt update
  sudo apt install minicom screen
  ```

## Connect the USB-to-serial adapter

To set up the hardware to display output from an RTApp, follow these steps. You'll need to refer to the documentation from your hardware manufacturer to determine the pin locations. If you're using hardware that follows the MT3620 reference board design (RDB), like the MT3620 Dev Kit from Seeed Studio, then looking at [the RDB interface headers](/azure-sphere/hardware/mt3620-user-guide?view=azure-sphere-integrated#interface-headers&preserve-view=true) may help you to determine the pin locations.

> [!IMPORTANT]
> Use a USB-to-serial adapter set for 3.3 V logic. For the dedicated RT-core logging UART, connect only GND and adapter RX to board TX. Do not connect adapter VCC or adapter TX.

> [!NOTE]
> Each MT3620 real-time core has a dedicated TX-only UART intended for log output. This dedicated UART doesn't require a `Uart` capability in `app_manifest.json`. If your hardware doesn't expose the dedicated logging UART and you choose to use an ISU UART instead, update `app_manifest.json` with the selected `Uart` capability and update the application code to use that ISU UART.

1. If your USB-to-serial adapter has a voltage selector, set it to 3.3 V logic.
1. Connect GND on the USB-to-serial adapter to GND on your dev kit. On MT3620 RDB hardware, GND is header 3, pin 2.
1. Connect RX on the USB-to-serial adapter to IOM4-0 TX on your dev kit. On MT3620 RDB hardware, IOM4-0 TX is header 3, pin 6.
1. Leave adapter VCC and adapter TX disconnected.
1. Attach the USB-to-serial adapter to your computer.
1. Make sure that the Azure Sphere device is connected to your computer.

## Identify the serial port

- On Windows, determine which COM port the adapter uses. If you're using the FTDI Friend adapter, start **Device Manager**, select **View** > **Devices by container**, and look for **FT232R USB UART** or another USB UART device. Note the assigned COM port, such as `COM5`.
- On Linux, plug in the USB-to-serial adapter and run:

  ```bash
  dmesg | grep ttyUSB
  ```

  If your Linux distribution restricts access to `dmesg`, run `sudo dmesg | grep ttyUSB`. The adapter usually appears as `/dev/ttyUSBn`, where `n` is the port number. If several USB serial devices are listed, use the one most recently reported as attached.

  Access to `/dev/ttyUSBn` may require membership in the `dialout` group or elevated privileges. To add your user to the `dialout` group on Ubuntu, run the following command, then sign out and sign back in:

  ```bash
  sudo usermod -a -G dialout $USER
  ```

  Alternatively, run the terminal emulator with `sudo`.

## Open the terminal session

Open a serial session to the adapter's COM port or `/dev/ttyUSBn` device with these settings:

- Serial mode or connection type: **Serial**
- Speed or baud rate: **115200**
- Data bits: **8**
- Parity: **None**
- Stop bits: **1**
- Flow control: **None**; disable both hardware and software flow control

For PuTTY on Windows:

1. Start **PuTTY**.
1. In **Session**, set **Connection type** to **Serial**.
1. Set **Serial line** to the adapter COM port, such as `COM5`.
1. Set **Speed** to `115200`.
1. In **Connection** > **Serial**, set **Data bits** to `8`, **Stop bits** to `1`, **Parity** to **None**, and **Flow control** to **None**.
1. Select **Open**.

For minicom on Linux, replace `/dev/ttyUSBn` with your adapter device:

```bash
minicom -D /dev/ttyUSBn -b 115200 -8
```

If needed, press **Ctrl+A**, then **O**, open **Serial port setup**, and verify that the speed is `115200 8N1`, **Hardware Flow Control** is **No**, and **Software Flow Control** is **No**.

For screen on Linux, replace `/dev/ttyUSBn` with your adapter device:

```bash
screen /dev/ttyUSBn 115200
```

The default screen serial settings are acceptable for this 115200-8-N-1 session. If your environment has changed the port settings, reset them before starting screen:

```bash
stty -F /dev/ttyUSBn 115200 cs8 -cstopb -parenb -ixon -ixoff -crtscts
screen /dev/ttyUSBn 115200
```
