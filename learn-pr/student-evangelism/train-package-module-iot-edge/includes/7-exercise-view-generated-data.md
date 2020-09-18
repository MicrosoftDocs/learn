::: zone pivot="bash"

In this exercise, you'll view the messages using Azure CLI.

1. Open the command prompt on your IoT Edge device again, or if you are disconnected to your Edge device, use the SSH connection from Azure CLI to connect to the device. Confirm that the module deployed from the cloud is running on your IoT Edge device using the command **sudo iotedge list**.

2. View the messages being sent from the temperature sensor module using the command **sudo iotedge logs <module_name> -f**. Note that IoT Edge commands are case-sensitive when referring to module names.

3. Clean up resources.

::: zone-end

::: zone pivot="vscode"

In this exercise, you'll set up Visual Studio Code to monitor device-to-cloud messages that arrive at your IoT hub. Note: to view the device-to-cloud messages that your IoT Hub receives, you need the [Azure IoT Hub Toolkit extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.azure-iot-toolkit) (formerly Azure IoT Toolkit extension).

1. In Visual Studio Code, select **IoT Hub Devices**.
2. Then select **Set IoT Hub Connection String** from the menu.
3. In the text box that opens at the top of the page, enter the iothubowner connection string for your IoT Hub. Your IoT Edge device should appear in the IoT Hub Devices list.
4. Select **Start Monitoring Built-in Event Endpoint**.
5. Observe the messages coming from tempSensor every five seconds. The message body contains a property called **anomaly**, which the machinelearningmodule provides with a true or false value.
6. The **AzureMLResponse** property contains the value "OK" if the model ran successfully.
7. Clean up resources.

::: zone-end