When you develop real-time capable applications (RTApps), as a first step, you will have to install a cross compiler. The compiler will compile the source code on the host machine and will generate binary for your embedded processor. Along with that you will need to set up hardware to receive output from the app that could be displayed to the user.

You'll use a USB-to-serial adapter to connect the UART on the real-time core to a USB port on your machine.

The components used in this unit are:

**Putty:** is a free and open-source terminal emulator, serial console and network file transfer application. Windows users will install it to display output message from the app.

**Minicom:** is a text-based modem control and terminal emulator program for Unix-like operating systems. Linux users will install it to display output message from the app.

**USB-to-serial adapter:** is used to connect the UART. It provides communication with UART and your application.

**UART:** A universal asynchronous receiver-transmitter is a computer hardware device for asynchronous serial communication in which the data format and transmission speeds are configurable. 

**Jumper wires:** is used to connect USB-to-serial adapter to Azure Sphere kit.

The steps you will follow:

1. Install terminal emulator for your development environment
2. Connect USB-to-serial adapter to Azure Sphere
3. Connect USB-to-serial adapter to your computer
4. Start your terminal emulator

When you deploy your image classification app to Azure Sphere, the app transmits the output message over a UART. These messages can be read in terminal application on a computer using a USB-to-serial adapter. 
Note: By default, it uses the real-time core's dedicated UART, but if your hardware doesn't expose this UART's TX pin, then the sample can be altered to use a different UART.

