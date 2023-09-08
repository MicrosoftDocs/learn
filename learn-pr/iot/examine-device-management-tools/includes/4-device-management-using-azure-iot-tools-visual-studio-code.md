The Azure IoT Hub extension for Visual Studio Code provides an interactive menu-based system that can be used to perform many IoT device management tasks. The interface is run outside of the Azure portal.

Suppose you work as a field technician for an oil and gas company. You need to test some IoT devices by monitoring IoT Hub-to-device messages in real-time. Your company doesn't allow you to use its Azure portal account. This account is limited to a select group of administrators. So you use Visual Studio Code and the Azure IoT extension to run a menu-based command to monitor the IoT Hub-to-device messages.

Here, you'll learn about some of the Visual Studio Code and Azure IoT Hub extension capabilities that you can use to manage IoT devices.

:::row:::
  :::column:::
    **Management option**
  :::column-end:::
  :::column:::
    **Task**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Invoke direct method
  :::column-end:::
  :::column:::
    Tell a device to perform an action, such as starting or stopping the process of sending messages, or rebooting the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Read device twin
  :::column-end:::
  :::column:::
    Get the reported state of a device. For example, the device reports the LED is blinking now.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Update device twin
  :::column-end:::
  :::column:::
    Put a device into certain states, such as setting an LED to green or setting the telemetry send interval to 30 minutes.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud-to-device messages
  :::column-end:::
  :::column:::
    Send notifications to a device. For example, "It's likely to rain today. Don't forget to bring an umbrella."
  :::column-end:::
:::row-end:::

## Access your IoT hub and devices

When using the Azure IoT Hub extension for Visual Studio Code, the first step is to access to your IoT Hub through your Azure subscription.

1. In the Explorer view of Visual Studio Code, expand the **Azure IoT Hub** section in the side bar.

2. Select the ellipsis (…) button of the **Azure IoT Hub** section to display the action menu, and then select **Select IoT Hub** from the action menu.

3. If you're not signed into Azure, a pop-up notification is shown in the bottom right corner to let you sign in to Azure. Select **Sign In** and follow the instructions to sign into Azure.

4. Select your Azure subscription from the **Select Subscription** dropdown list.

5. Select your IoT hub from the **Select IoT Hub** dropdown list.

6. The devices for your IoT hub are retrieved from IoT Hub and shown under the **Devices** node in the **Azure IoT Hub** section of the side bar.

After a few seconds, the Visual Studio Code Explorer pane is updated to show a Devices section under Azure IoT Hub. The Devices section then displays a list of the devices connected to the IoT Hub that you selected.

## Access device management commands

You can access the device management commands by right-clicking a device in the Explorer pane, and then selecting a command from the context menu.

> [!NOTE]
> The commands listed as follows are an introductory sampling and not meant to be a complete reference.

### Invoke a direct method

To invoke a direct method on a device:

1. In the Visual Studio Code Explorer pane, right-click the device that you're interested in.
2. On the context menu for your device, select **Invoke Direct Method**.
3. Enter the method name in the input box, and then the associated payload value. The results are shown in OUTPUT &gt; Azure IoT Hub extension view. If the direct method that you specify doesn't exist on the device, you then see message similar to this: Failed to invoke Direct Method: Not found.

### Read a device twin

To read the contents of a device twin document (JSON file):

1. In the Visual Studio Code Explorer pane, right-click the device that you're interested in.
2. On the context menu for your device, click **Edit Device Twin**. An azure-iot-device-twin.json file is opened in Visual Studio Code showing the contents of the device twin document.

### Update a device twin

After opening a device twin document, you can update desired properties as follows:

1. Make some edits to the properties.desired field. You can also make changes to tags. Tags can be used to support of device management tasks that act on a group of devices that have the same tag value setting.
2. Right-click anywhere within the azure-iot-device-twin.json document. This opens the Visual Studio Code context menu for the open document.
3. On the context menu, to save the changes to the device twin, select **Update Device Twin**.

### Send cloud-to-device messages

To send a message from your IoT hub to your device, follow these steps:

1. In the Visual Studio Code Explorer pane, right-click the device that you are interested in.
2. On the context menu for your device, select **Send C2D Message to Device**.
3. Enter the message in input box. Results are shown in OUTPUT &gt; Azure IoT Hub extension view.
