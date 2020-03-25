Capturing of weather data is an important task as weather can effect everything
from traffic patterns to how heating, ventilation, and air conditioning (HVAC) systems in retail stores are operated. In this
exercise, you will be interacting with the online Raspberry Pi simulator you learned about in the previous unit to capture
simulated weather data and via the Azure IoT Hub.

While this exercise is being conducted in a simulated environment, the application running on the simulated device can be transferred to a real device in the future.

## Create an IoT hub

Azure IoT Hub provides the features and an extensibility model that enable device and back-end developers to build robust device management solutions. Devices range from constrained sensors and single purpose microcontrollers, to powerful gateways that route communications for groups of devices. In addition, the use cases and requirements for IoT operators vary significantly across industries. Despite this variation, device management with IoT Hub provides the capabilities, patterns, and code libraries to cater to a diverse set of devices and end users.

In order to start collecting the data from the Raspberry Pi simulator, you need to first create an IoT hub.

1. Right-click [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), and select **Open in new window**.

1. Choose **Create a resource** in the upper left-hand corner of the Azure portal, then search for **IoT Hub**.

    ![Screenshot of Azure portal menu bar](../media/iot-admin-create-resource.png)

1. Create an IoT Hub resource.

     ![Screenshot of Azure portal menu bar](../media/iot-admin-create-hub.png)

1. In the **IoT hub** pane, enter the following information for your IoT hub:

   - **Subscription**: Use the sandbox subscription for this example.
   - **Resource group**: Use the sandbox resource group.
   - **Name**: Create a unique name for your IoT hub, something like "PiHub-your-id", replacing "your-id" with something appropriate. If the name you enter is available, a green check mark appears.
   - **Region**: Select the closest region to your location.

    > [!IMPORTANT]
    > The IoT hub will be publicly discoverable as a DNS endpoint, so make sure to avoid any sensitive information while naming it.

     ![Screenshot showing the IoT Hub creation fields](../media/iot-admin-name-hub.png)

1. Select **Review + create**.

1. Review your IoT hub information, then click **Create**. Your IoT hub might take a few minutes to deploy. 

1. Click **Go to resource**, when the deployment is complete.

## Register a device

A device must be registered with your IoT hub before the device can connect.

1. In your IoT hub navigation menu, open **IoT devices**, then click **Add** to register a device in your IoT hub.

    ![Screenshot showing how to add a device to your IoT hub](../media/iot-admin-create-device.png)

1. Enter a **Device ID** for the new device. Choose a meaningful ID to represent your device, something like "PiHubDevice-your-id", again replacing "your-id" with something appropriate. Device IDs are case sensitive.

    > [!IMPORTANT]
    > The device ID may be visible in the logs collected for customer support and troubleshooting, so make sure to avoid any sensitive information while naming it.

1. Click **Save**.

1. After the device is created, open the device from the list in the **IoT devices** pane.

    ![Screenshot showing the new device for your IoT hub](../media/iot-admin-device-id.png)

1. Copy the **Primary Connection String** to a text file, to use in the next section. The icon to the far right of the string copies the key to the clipboard for you.

   ![Get the device connection string](../media/iot-admin-device-key.png)

## Send simulated telemetry

1. Right-click [Raspberry Pi Azure IoT Simulator](https://azure-samples.github.io/raspberry-pi-web-simulator?azure-portal=true), and select **Open in new window**.

1. Replace the placeholder in line 15 with the Azure IoT hub device connection string from your text file.

    ![Screenshot showing where to replace the device connection string](../media/Line15.png)

1. Click the `Run` button, or type `npm start` in the console window, to run the application.

   ![Screenshot showing the Pi simulator run button](../media/iot-admin-device-run.png)

1. You should see output similar to the following, showing the sensor data and messages sent to your IoT hub.

   ![Screenshot showing the Pi simulator console output](../media/iot-admin-device-telemetry.png)

## Read the telemetry from your hub

So what's happening? IoT hub is receiving the device-to-cloud messages sent from the simulated device. In order to see that, let's take a quick look at how Azure IoT Hub is processing the incoming data.

1. In your IoT Hub, under **Monitoring**, select **Metrics**.

1. For **METRIC** locate  **Telemetry messages sent** - it is near the end of the list of available metrics. Select **Sum**, for **AGGREGATION**.

1. Change the time range to **Last 30 minutes**, in the box top-right. Give it a few minutes as you wait for the data to come into the picture.

   ![Screenshot showing the Pi simulator run button](../media/iot-admin-device-metrics.png)

