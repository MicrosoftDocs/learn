In this exercise, you'll set up Visual Studio Code to monitor device-to-cloud messages that arrive at your IoT hub. Note: to view the device-to-cloud messages that your IoT hub receives, you need the [Azure IoT Hub Toolkit extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.azure-iot-toolkit) (formerly Azure IoT Toolkit extension).

1. In Visual Studio Code, select **IoT Hub Devices**.
2. Then select **Set IoT Hub Connection String** from the menu.
3. In the text box that opens at the top of the page, enter the iothubowner connection string for your IoT Hub. Your IoT Edge device should appear in the IoT Hub Devices list.
4. Select **Start Monitoring Built-in Event Endpoint**.
5. Observe the messages coming from tempSensor every five seconds. The message body contains a property called **anomaly**, which the machinelearningmodule provides with a true or false value.
6. The **AzureMLResponse** property contains the value "OK" if the model ran successfully.