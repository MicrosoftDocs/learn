Raspberry Pi boards are popular IoT devices for eduction, for testing ideas, and even for buiding some worthwhile systems. While the cost of this board is not prohibitive, we can test out the Raspberry Pi functionality before investing in actual hardware.

Microsoft has built an online [Raspberry Pi Azure IoT Simulator](https://azure-samples.github.io/raspberry-pi-web-simulator?azure-portal=true), allowing users to control the emulated hardware via code. The emulator portrays a graphic of a Raspberry Pi connected to a temperature, humidity, and pressure sensor, and a red LED. There is a breadboard allowing circuits to be wired together. The displayed side panel
allows users to enter Node.js code to control the LED, and collect dummy data from the simulated sensor.

## Raspberry Pi Azure IoT Online Simulator

By default, the simulator operates a sample temperature capture program which is displayed via the command line. The same sample application can also be run on a real Pi as the simulator is designed to allow people to test code before transferring it to a real device.

![Raspberry Pi Simulator](../media/RaspberryPiSimulator.png)

There are three areas in the web simulator:

1. **Assembly Area**. This is where you can see your device status. By default, this is a Pi connecting with a BME280 sensor and an LED light. This configuration isn't customizable at this time.

1. **Coding Area**. An online code editor for you to make an app on Raspberry Pi with Node.js. The
    default sample application helps to collect sensor data from the BME280 sensor and sends it to your Azure IoT Hub.

1. **Integrated console window**. This is where you can see the output of your app. Within the console there are three functions:
    - `Run` - Runs the sample code. When the sample is running, code is read-only.
    - `Stop` - Stops the sample code running.
    - `Reset` - Resets the code.

Now that you have an overview of the Raspberry Pi simulator, we'll explore the IoT Hub in Azure where you will create a new resource to capture data from the simulator.

