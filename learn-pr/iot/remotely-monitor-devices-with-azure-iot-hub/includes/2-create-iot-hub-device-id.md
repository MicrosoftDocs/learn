In this unit, we will create an IoT Hub, add a single device to that hub, and record the connection strings we need for the coding sections of this module.

## Create a custom IoT Hub

1. Sign in to the [Azure portal](https://ms.portal.azure.com/#home).
1. Select **+ Create a resource**, from the top of the left-hand menu. In the **Search the Marketplace** search box, enter "IoT Hub".
1. Select **IoT Hub** from the search results, and click **Create**.
1. You will be required to enter a **Subscription** from the selection offered to you. Then enter a **Resource Group**. A resource group is similar to a folder, it is largely there to help you organize your resources. Select an existing resource group you have, or enter a new one. The **Region** should be the geographical region closest to you, and finally enter a friendly name (say "CheeseCaveHub-&lt;your ID&gt;") for **IoT Hub Name**.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names.
1. Select **Next: Size and scale** to view the capabilities of your hub, noting all the services we need are enabled. Open up **Advanced Settings** to see the number of partitions. However, leave all entries at their default settings.

    > [!NOTE]
    > A single _partition_ has a maximum number of concurrent readers processing data. In our cheese cave scenario, we only have one reader (the back-end service app), so could get away with one partition. However, if high telemetry throughput is an issue, increasing the number of partitions, and number of concurrent connected readers, will aid in increasing efficiency.

1. Now, select **Review + create**, this option gives you a chance to verify your choices before clicking **Create**, and building the hub. Building your hub can take a few minutes.
1. It is a good idea to bookmark the home page of your IoT Hub.

## Create an IoT Hub device identity

Now we need to create a single device, the sensor monitoring the cheese cave. If it is not already opened in the Azure portal, open your [Azure IoT Hub](https://apps.azureiothub.com/?azure-portal=true).

1. Locate and select the **IoT devices** entry in the left-hand menu.
1. Click **+ New**.
1. In the **Create a device** screen that follows, enter a **Device ID**, such as "CheeseCaveID". Ensure **Auto-generate keys** is enabled, as is **Connect this device to an IoT Hub**, and click **Save**.

    ![Screenshot showing the creation of an IoT Hub device identity](../media/cheesecave-device-create.png)

1. You should now see your device in the list of devices for the IoT Hub. Click on the device name. Copy your **Device ID**, and the **Primary Connection String** to a text file (using Notepad, or similar text editor).

    > [!IMPORTANT]
    > The connection string you have just copied is the _device_ connection string. There are many other connection strings , including the _service_ connection string, that we also will need. Add a note to your text file that this is the device connection string.

1. In the left-hand menu for your IoT Hub, select **Shared access policies**.
1. Click the **iothubowner** entry under **Policy**, then, on the right-hand side, copy the **Connection string-primary key** and paste it into your text file. Again, add a note, this text is the service connection string.
1. Save off the text file, with a name such as "Cave connections.txt", for reference in the next unit.

You have now completed the preparatory work for this module, the next steps are all coding and testing. Before we advance though, a quick knowledge check!
