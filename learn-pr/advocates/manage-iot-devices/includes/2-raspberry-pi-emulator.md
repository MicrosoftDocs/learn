Raspberry Pi boards are popular IoT devices for education, for testing ideas, and even for building some worthwhile systems. Although the cost of a board isn't prohibitive, we can test the Raspberry Pi functionality before investing in actual hardware.

Microsoft has built an online [Raspberry Pi Azure IoT simulator](https://azure-samples.github.io/raspberry-pi-web-simulator?azure-portal=true). Users control the emulated hardware via code. The simulator shows a graphic of Raspberry Pi connected to a temperature, humidity, and pressure sensor, and a red LED. A breadboard allows circuits to be wired together. The displayed side panel enables users to enter Node.js code to control the LED, and to collect dummy data from the simulated sensor.

By default, the simulator operates a sample temperature-capture program, which is displayed via the command line. The same sample application can also be run on a real Pi device, because the simulator is designed to allow people to test code before transferring it to a real device.

[![Raspberry Pi simulator.](../media/iot-admin-raspberry-pi-simulator.png)](../media/iot-admin-raspberry-pi-simulator.png#lightbox)

The web simulator has three screen areas:

1. **Assembly area**. This area is where you can see your device status. By default, it shows a Pi device connecting with a BME280 sensor and an LED light.

1. **Coding area**. This area is an online code editor where you can make an app on Raspberry Pi by using Node.js. The default sample application helps collect sensor data from the BME280 sensor, and then sends it to your Azure IoT hub.

1. **Integrated console window**. This window is where you can see the output of your app. Within the console, there are three functions:
    - **Run** runs the sample code. When the sample is running, code is read-only.
    - **Stop** stops the sample code from running. You can select **Run** again to restart where you left off.
    - **Reset** resets the simulator to its starting state.

Now that you have an overview of the Raspberry Pi simulator, we'll explore the IoT hub in Azure where you'll create a new resource to capture data from the simulator.
