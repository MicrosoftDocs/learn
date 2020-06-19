In this unit, we create an Azure IoT Hub instance.

## Create a custom IoT hub

1. Make sure you've activated the sandbox, by using the button above. The sandbox creates a free temporary resource.
1. Right-click the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and select **Open in a new window**. Using this link will ensure you're using the sandbox.
1. Select **+ Create a resource** from the menu on the left. In the **Search the Marketplace** box, enter **IoT Hub**.
1. Select **IoT Hub** from the search results, and select **Create**.
1. For **Subscription**, enter a subscription from the selection offered to you. A sandbox subscription will be **Concierge Subscription**, so choose that. For **Resource Group**, select <rgn>[sandbox resource group name]</rgn>.
1. For **Region**, enter the geographical region closest to you.
1. For **IoT Hub Name**, enter a unique friendly name (for example, **cheesecavesmanager-&lt;your ID&gt;**).
    >[!IMPORTANT]
    >When you're entering a name, remember that hub names are publicly discoverable. Hub names must also be unique, because they form part of the Azure URL.
1. Select **Next: Size and scale** to view the capabilities of your hub. Note that all the services we need are enabled. 

    Open **Advanced Settings** to see the number of partitions. You can leave all entries at their default settings. Or, for peace of mind, you can change **Pricing and scale tier** to **F1: Free tier**. But you won't be charged if you leave the tier at **S1: Standard tier**, because sandbox resources are free.
1. Select **Review + create**. This option gives you a chance to verify your choices before selecting **Create** and building the hub. Building your hub can take a few minutes.
1. Select **Go to resource**, when this option is available, to go to the home page for your temporary hub. If you miss this alert, you can search for your resource from your home page.
1. It's a good idea to bookmark the home page of your IoT hub.

You now have an IoT hub. In the following unit, we'll create the logic apps that will send an email and configure the integration with Azure Event Grid.
