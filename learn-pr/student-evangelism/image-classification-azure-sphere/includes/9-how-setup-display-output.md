To display output from the image classification real-time capable application (RTApp), connect a terminal emulator on your development computer to the MT3620 real-time core's dedicated logging UART through a USB-to-serial adapter.

Before you set up the display output, make sure your development environment is ready for RTApp work. You need the Azure Sphere SDK, CMake, Ninja, the Azure Sphere and CMake Tools extensions for Visual Studio Code, and the GNU Arm Embedded Toolchain (`arm-none-eabi`) or an equivalent toolchain installed through vcpkg artifacts. Install the GNU Arm Embedded Toolchain before opening or building the RTApp project; follow the [Azure Sphere RTApp quickstart](/azure-sphere/install/qs-real-time-application?view=azure-sphere-integrated#install-the-gnu-arm-embedded-toolchain&preserve-view=true) for current installation options.

You use a 3.3 V logic USB-to-serial adapter to connect the logging UART on the real-time core to a USB port on your machine.

The components used in this unit are:

**Terminal emulator:** Windows users can use PuTTY or another serial terminal emulator. Linux users can use minicom, screen, picocom, or another terminal emulator that can open a serial port.

**USB-to-serial adapter:** Use an adapter that supports 3.3 V logic levels. For the dedicated RT-core logging UART, the adapter receives output from the board; it doesn't power the board or send data to the board.

**UART:** Each MT3620 real-time core has a dedicated TX-only UART intended for RTApp log output. The MT3620 reference board design exposes the TX pin so a terminal can display log messages from the application. This dedicated logging output doesn't require a `Uart` capability in `app_manifest.json`. If your hardware doesn't expose this UART and you choose to use an ISU UART instead, you must update the application manifest and code for the selected ISU UART.

**Jumper wires:** Use jumper wires to connect only GND and the adapter RX pin to the Azure Sphere kit's logging UART TX pin.

> [!IMPORTANT]
> Use 3.3 V logic. For this TX-only logging UART, connect only GND and adapter RX to board TX. Don't connect adapter VCC or adapter TX.

The steps you'll follow:

1. Install or verify the RTApp toolchain and a terminal emulator for your development environment.
1. Connect the USB-to-serial adapter to the Azure Sphere device's dedicated RT-core logging UART.
1. Connect the USB-to-serial adapter to your computer.
1. Identify the COM port or Linux `/dev/ttyUSBn` device used by the adapter.
1. Start your terminal emulator in serial mode with 115200-8-N-1 settings and no flow control.

When you deploy your image classification app to Azure Sphere, the RTApp transmits output messages over the dedicated logging UART. These messages can be read in a terminal application on a computer using the USB-to-serial adapter.

> [!NOTE]
> By default, this unit uses the real-time core's dedicated UART for log output only. If your hardware doesn't expose this UART's TX pin, the sample can be altered to use a different UART, but using an ISU UART requires corresponding manifest and code changes.
