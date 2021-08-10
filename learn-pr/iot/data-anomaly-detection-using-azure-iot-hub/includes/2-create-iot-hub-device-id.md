In this unit, we first create an IoT Hub, and then add a single device to that hub. To complete the unit, we record the connection strings needed for the coding part of this module.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox by selecting the button at the start of this exercise. The sandbox creates a free temporary resource.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Using this link will ensure you're using the sandbox.

1. Select **Create a resource**. In the **Search the Marketplace** search box, enter *IoT Hub*, and then press <kbd>Enter</kbd>.

1. Select **IoT Hub** from the search results, and then select **Create**. The **IoT hub** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value  |
    |---------|---------|
    | **Project details** |
    | Subscription  | Concierge Subscription  |
    | Resource group  |  <rgn>[sandbox resource group name]</rgn> |
    | Region | Select a geographical region closest to you |
    | IoT hub name | Enter a unique friendly name (for example, "VibrationSensorHub-&lt;your ID&gt;") |

    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names. Hub names must also be unique, as they form part of the Azure URL.

1. Select the **Management** tab to view the **Scale tier and unit** capabilities of your hub, noting all the services we need are enabled.

1. At the bottom of the **Management** tab, expand **Advanced settings**, and under **Scale**, note the number of partitions. Leave all entries at their default settings.

1. Select **Review + create**. This option gives you a chance to verify your choices.

1. If you are satisfied with your selections, select **Create** to build the hub. Building your hub can take a few minutes.

1. After your deployment successfully completes, select **Go to resource**. Your temporary IoT Hub pane appears. If you miss this alert, you can search for your resource from your home page.

    It's a best practice to bookmark the home page of your IoT Hub.

## Create an IoT Hub device identity

Now, we need to create a single device identity - the sensor monitoring the conveyor belt vibration.

1. On your IoT Hub pane, in the left menu pane, under **Explorers**, select **IoT devices**.

1. In the top menu bar, select **New**. The **Create a device** pane appears.

1. In the **Device ID** field, enter an ID, such as *VibrationSensorID*. Ensure **Auto-generate keys** is checked, and **Connect this device to an IoT Hub** is enabled.

1. Select **Save**.

    [![Screenshot showing the creation of an IoT Hub device identity.](../media/vibrations-device-create.png)](../media/vibrations-device-create.png#lightbox)

1. Your device should now appear in the list of devices for the IoT Hub. Select the device name.

1. Copy your **Device ID**, and the **Primary Connection String** to a text file (using Notepad, or similar text editor).

    > [!IMPORTANT]
    > The connection string you've just copied is the _device_ connection string. There are many other connection strings. Add a note to your text file that this is the device connection string.

1. Save the text file with a name, such as *Vibration connections.txt*, for reference in the next units.

The next step is to code the delivery of telemetry messages.
