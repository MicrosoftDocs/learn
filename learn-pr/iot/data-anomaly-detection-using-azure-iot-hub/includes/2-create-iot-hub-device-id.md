In this unit, we first create an IoT Hub, and then add a single device to that hub. To complete the unit, we record the connection strings needed for the coding part of this module.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox, using the button above. The sandbox creates a free temporary resource.
1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Using this link will ensure you're using the sandbox.
1. Select **+ Create a resource**, from the top of the left-hand menu. In the **Search the Marketplace** search box, enter "IoT Hub".
1. Select **IoT Hub** from the search results, and select **Create**.
1. For **Subscription** for the sandbox, select **Concierge Subscription**. For **Resource Group**, select <rgn>[sandbox resource group name]</rgn>.
1. The **Region** should be the geographical region closest to you.
1. Enter a unique friendly name (for example, "VibrationSensorHub-&lt;your ID&gt;") for **IoT Hub Name**.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names. Hub names must also be unique, as they form part of the Azure URL.
1. Select **Next: Size and scale** to view the capabilities of your hub, noting all the services we need are enabled. Open **Advanced Settings** to see the number of partitions. Leave all entries at their default settings.
1. Select **Review + create**. This option gives you a chance to verify your choices before selecting **Create**, and building the hub. Building your hub can take a few minutes.
1. Select **Go to resource**, when this option is available, to go to the home page for your temporary hub. If you miss this alert, you can search for your resource from your home page.
1. It's a good idea to bookmark the home page of your IoT Hub.

## Create an IoT Hub device identity

Now we need to create a single device identity, the sensor monitoring the conveyor belt vibration.

1. With the home page of your hub open, locate and select the **IoT devices** entry in the left-hand menu.
1. Select **+ New**.
1. In the **Create a device** screen that follows, enter a **Device ID**, such as "VibrationSensorID". Ensure **Auto-generate keys** is enabled, as is **Connect this device to an IoT Hub**, and select **Save**.

    [![Screenshot showing the creation of an IoT Hub device identity](../media/vibrations-device-create.png)](../media/vibrations-device-create.png#lightbox)

1. You should now see your device in the list of devices for the IoT Hub. Select the device name. Copy your **Device ID**, and the **Primary Connection String** to a text file (using Notepad, or similar text editor).

    > [!IMPORTANT]
    > The connection string you've just copied is the _device_ connection string. There are many other connection strings. Add a note to your text file that this is the device connection string.

1. Save off the text file, with a name such as "Vibration connections.txt", for reference in the next units.

The next step is to code the sending of telemetry messages.
