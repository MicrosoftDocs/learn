In this unit, we create an IoT Hub.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox, using the button above. The sandbox creates a free temporary resource.
1. Right Click on [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and select **Open in a new window**. Using this link will ensure you're using the sandbox.
1. Select **+ Create a resource**, from the top of the left-hand menu. In the **Search the Marketplace** search box, enter "IoT Hub".
1. Select **IoT Hub** from the search results, and click **Create**.
1. You'll be required to enter a **Subscription** from the selection offered to you. A sandbox subscription will be **Concierge Subscription**, so choose that. For **Resource Group**, select <rgn>[sandbox resource group name]</rgn>.
1. The **Region** should be the geographical region closest to you.
1. Enter a unique friendly name (say "cheesecavesmanager-&lt;your ID&gt;") for **IoT Hub Name**.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names. Hub names must also be unique, as they form part of the Azure URL.
1. Select **Next: Size and scale** to view the capabilities of your hub, noting all the services we need are enabled. Open up **Advanced Settings** to see the number of partitions. You can leave all entries at their default settings. Or, for peace of mind, you can change **Pricing and scale tier** to **F1: Free tier**, although you'll not be charged if you leave the tier at **S1: Standard tier**, as sandbox resources are free.
1. Now, select **Review + create**, this option gives you a chance to verify your choices before clicking **Create**, and building the hub. Building your hub can take a few minutes.
1. Click **Go to resource**, when this option is available, to go to the home page for your temporary hub. If you miss this alert, you can search for your resource from your home page.
1. It's a good idea to bookmark the home page of your IoT Hub.

You now have an IoT Hub. In the following unit, we will create the Logic Apps that will send an email and configure the integration with event grid.
