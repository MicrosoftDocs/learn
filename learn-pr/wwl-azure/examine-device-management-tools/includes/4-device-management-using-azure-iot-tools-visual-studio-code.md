Azure IoT Tools extension for Visual Studio Code includes the ability to perform device management tasks.

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
    Invoke Direct Method.
  :::column-end:::
  :::column:::
    Tell a device to perform an action, such as starting or stopping the process of sending messages, or rebooting the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Read Device Twin.
  :::column-end:::
  :::column:::
    Get the reported state of a device. For example, the device reports the LED is blinking now.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Update Device Twin.
  :::column-end:::
  :::column:::
    Put a device into certain states, such as setting an LED to green or setting the telemetry send interval to 30 minutes.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud-to-device messages.
  :::column-end:::
  :::column:::
    Send notifications to a device. For example, "It is likely to rain today. Don't forget to bring an umbrella."
  :::column-end:::
:::row-end:::


The Azure IoT Tools extension provides other capabilities for working with devices in addition to these device management capabilities.

## Access your IoT hub and devices

When using the Azure IoT Tools extension for VS Code, the first step is to access to your IoT Hub through your Azure subscription.

1.  In the bottom-left corner of the VS Code window, select **Azure IoT Hub**. When the Azure IoT Tools extension for VS Code is installed, the Azure IoT Hub section is added to the VS Code Explorer pane.
2.  To the right of Azure IoT Hub, select the ellipsis (...). The ellipsis (...) provides access to the More Options context menu.
3.  On the content menu, select **Select IoT Hub**.
4.  A pop-up will be displayed on screen to let you sign in to Azure. After you sign in, your Azure Subscription list will be shown.
5.  Select the Azure Subscription that you will be using.
6.  Select the IoT Hub that you will be using.

After a few seconds, the VS Code Explorer pane will be updated to show a Devices section under Azure IoT Hub. The Devices section will display a list of the devices connected to the IoT Hub that you selected.

## Access device management commands

You can access the device management commands by right-clicking a device in the Explorer pane, and then selecting a command from the context menu.

### Invoke a direct method

To invoke a direct method on a device:

1.  In the VS Code Explorer pane, right-click the device that you are interested in.
2.  On the context menu for your device, select **Invoke Direct Method**.
3.  Enter the method name in the input box, and then the associated payload value. The results will be shown in OUTPUT &gt; Azure IoT Hub Toolkit view. If the direct method that you specify does exist on the device, you will see message similar to the following: Failed to invoke Direct Method: Not found.

### Read a device twin

To read the contents of a device twin document (json file):

1.  In the VS Code Explorer pane, right-click the device that you are interested in.
2.  On the context menu for your device, click **Edit Device Twin**. An azure-iot-device-twin.json file will be opened in VS Code showing the contents of the device twin document.

### Update a device twin

After opening a device twin document, you can update desired properties as follows:

1.  Make some edits to the properties.desired field. You can also make changes to tags. Tags can be used to support of device management tasks that act on a group of devices that have the same tag value setting.
2.  Right-click anywhere within the azure-iot-device-twin.json document. This will open the VS Code context menu for the open document.
3.  On the context menu, to save the changes to the device twin, select **Update Device Twin**.

### Send cloud-to-device messages

To send a message from your IoT hub to your device, follow these steps:

1.  In the VS Code Explorer pane, right-click the device that you are interested in.
2.  On the context menu for your device, select **Send C2D Message to Device**.
3.  Enter the message in input box. Results will be shown in OUTPUT &gt; Azure IoT Hub Toolkit view.
