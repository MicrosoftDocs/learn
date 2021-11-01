In this unit, you'll interact with the online Raspberry Pi simulator that you learned about in the previous unit.

Although this exercise is being conducted in a simulated environment, the app running on the simulated device is similar to the code that would be running on a real device. In the IoT world, device simulation is a valuable step in building a production-grade solution.

## Create an IoT hub

To start collecting data from the Raspberry Pi simulator, you need to first create an IoT hub.

1. Right-click [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), and select **Open in new window**.

1. Choose **Create a resource** in the upper-left corner of the Azure portal, and then search for **IoT Hub**.

   [![Screenshot of the Azure portal menu bar.](../media/iot-admin-create-resource.png)](../media/iot-admin-create-resource.png#lightbox)

1. Create an IoT hub resource.

   [![Screenshot of the selection for creating an IoT hub resource.](../media/iot-admin-create-hub.png)](../media/iot-admin-create-hub.png#lightbox)

1. In the **IoT hub** pane, enter the following information for your IoT hub:

   - **Subscription**: Use **Concierge Subscription** for this example. This entry is the sandbox subscription.
   - **Resource group**: Use the sandbox resource group.
   - **IoT hub name**: Create a unique name for your IoT hub. For example, use something like **PiHub-your-id**, but replace "your-id" with something appropriate. If the name that you enter is available, a green check mark appears.
   - **Region**: Select the closest region to your location.

    > [!IMPORTANT]
    > The IoT hub will be publicly discoverable as a DNS endpoint, so don't use any sensitive information while naming it.

   [![Screenshot showing the IoT Hub creation fields.](../media/iot-admin-name-hub.png)](../media/iot-admin-name-hub.png#lightbox)

1. Select **Review + create**.

1. Review your IoT hub information, and then select **Create**. Your IoT hub might take a few minutes to deploy. 

1. Select **Go to resource** when the deployment is complete.

## Register a device

A device must be registered with your IoT hub before the device can connect.

1. On your IoT hub's left menu, select **IoT devices**, and then select **+ New**.

   [![Screenshot showing how to add a device to your IoT hub.](../media/iot-admin-create-device.png)](../media/iot-admin-create-device.png#lightbox)

1. For **Device ID**, enter an ID for the new device. Choose something meaningful, like **PiHubDevice-your-id**. (Again, replace "your-id" with something appropriate.) Device IDs are case-sensitive.

   > [!IMPORTANT]
   > The device ID might be visible in the logs collected for customer support and troubleshooting, so don't use any sensitive information while naming it.

1. Select **Save**.

1. Open the device from the list in the **IoT devices** pane.

   [![Screenshot showing the new device for your IoT hub.](../media/iot-admin-device-id.png)](../media/iot-admin-device-id.png#lightbox)

1. Copy the **Primary Connection String** information to a text file, to use in the next section. The icon to the right of the string copies the key to the clipboard for you.

   [![Get the device connection string.](../media/iot-admin-device-key.png)](../media/iot-admin-device-key.png#lightbox)

## Send simulated telemetry

1. Right-click [Raspberry Pi Azure IoT Simulator](https://azure-samples.github.io/raspberry-pi-web-simulator?azure-portal=true), and select **Open in new window**.

1. Replace the placeholder in line 15 with the connection string (for the Azure IoT hub device) from your text file.

   [![Screenshot showing where to replace the device connection string.](../media/iot-admin-line-15.png)](../media/iot-admin-line-15.png#lightbox)

1. Select **Run**, or enter `npm start` in the console window, to run the application.

   [![Screenshot showing the Pi simulator Run button.](../media/iot-admin-device-run.png)](../media/iot-admin-device-run.png#lightbox)

1. You should see output similar to the following. It shows the sensor data and messages sent to your IoT hub.

   [![Screenshot showing the Pi simulator console output.](../media/iot-admin-device-telemetry.png)](../media/iot-admin-device-telemetry.png#lightbox)

1. Make sure you don't miss the LED flash each time a message is sent!

   [![Screenshot showing the Pi simulator LED flash.](../media/iot-admin-led-flash.png)](../media/iot-admin-led-flash.png#lightbox)

## Read the telemetry from your hub

IoT hub is receiving the device-to-cloud messages sent from the simulated device. To see that, let's take a quick look at how Azure IoT Hub is processing the incoming data.

1. In your IoT hub, under **Monitoring**, select **Metrics**.

1. For **Metric**, find **Telemetry messages sent**. It's near the end of the list of available metrics. Select **Sum** for **Aggregation**.

1. Change the time range to **Last 30 minutes**. Wait a few minutes for the data to enter the picture.

   [![Graph with the time range changed to 30 minutes.](../media/iot-admin-device-metrics.png)](../media/iot-admin-device-metrics.png#lightbox)

1. The shape of the graph will depend on the volume of messages arriving, and the sequence of **Run**, **Stop**, and **Reset** commands that you use. Feel free to stop and restart the sending of telemetry. Notice how the graph changes, and when it changes, because there's some latency.

### Next steps

Let's look at some of the most useful menu entries for your job as hub administrator.
