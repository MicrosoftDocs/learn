In this unit, we'll create an IoT Hub.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox, using the button above. The sandbox creates free temporary resources.
1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **+ Create a resource**, from the top of the left-hand menu. In the **Search the Marketplace** search box, enter "IoT Hub".
1. Select **IoT Hub** from the search results, and click **Create**.
1. You'll be required to enter a **Subscription** from the selection offered to you. A sandbox subscription will be **Concierge Subscription**, so choose that. For **Resource Group**, enter <rgn>[sandbox resource group name]</rgn>. A resource group is like a folder, it's largely there to help you organize your resources.
1. The **Region** should be the geographical region closest to you, and finally enter a friendly name (say "CheeseCaveHub-&lt;your ID&gt;") for **IoT Hub Name**.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names.
1. Now, select **Review + create**, this option gives you a chance to verify your choices before clicking **Create**, and building the hub. Building your hub can take a few minutes.
1. When the IoT Hub is built, click **Go to resource** to go to the **Overview**** page for your hub. Or search for it in **All Resources**, if you happen to miss the completion message.
1. It's a good idea to bookmark the **Overview**** page of your IoT Hub.

Having created the hub, let's take a step back and go over some theory. You might find this knowledge valuable in understanding the security resources.