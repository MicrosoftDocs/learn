When you develop real-time capable applications (RTApps), as a first step, you will have to install a cross-compiler. The compiler will compile the source code on the host machine and will generate a binary for your embedded processor. Along with that, you will need to set up hardware to receive output from the app that could be displayed to the user.

You'll use a USB-to-serial adapter to connect the UART on the real-time core to a USB port on your machine.

The components used in this unit are:

**Putty:** is a free and open-source terminal emulator, serial console and network file transfer application. Windows users will install it to display output messages from the app.

**Minicom:** is a text-based modem control and terminal emulator program for Unix-like operating systems. Linux users will install it to display output messages from the app.

**USB-to-serial adapter:** is used to connect the UART. It provides communication with the UART and your application.

**UART:** A universal asynchronous receiver-transmitter is a computer hardware device for asynchronous serial communication in which the data format and transmission speeds are configurable. 

**Jumper wires:** is used to connect the USB-to-serial adapter to the Azure Sphere kit.

The steps you will follow:

1. Install the terminal emulator for your development environment
2. Connect the USB-to-serial adapter to Azure Sphere
3. Connect the USB-to-serial adapter to your computer
4. Start your terminal emulator

When you deploy your image classification app to Azure Sphere, the app transmits the output message over a UART. These messages can be read in a terminal application on a computer using a USB-to-serial adapter.

> [!NOTE]
> By default, this unit uses the real-time core's dedicated UART. If your hardware doesn't expose this UART's TX pin, then the sample can be altered to use a different UART.
