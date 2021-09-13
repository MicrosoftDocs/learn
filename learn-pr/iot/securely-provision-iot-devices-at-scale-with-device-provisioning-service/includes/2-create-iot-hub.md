In this unit, we'll create an IoT Hub.

## Create a custom IoT Hub

1. Make sure you've activated the sandbox, selecting **Activate sandbox** above. The sandbox creates free temporary resources.

1. Using this link, sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, enter *IoT Hub*.
1. Select **IoT Hub** from the search results, and click **Create**. The **IoT hub** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown list, select <rgn>[sandbox resource group name]</rgn>. A resource group is like a folder, it's largely there to help you organize your resources. |
    | **Instance details** |
    | IoT hub name | Enter a friendly name (for example, *CheeseCaveHub-XXX*, where XXX represents any ID you'll remember like your initials). |
    | Region | Choose a location close to you. |

    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names.

1. Select **Review + create**. This option gives you a chance to verify your choices.

1. After validation passes, select **Create**. Building your hub can take a few minutes.

1. When the IoT Hub deployment completes, select **Go to resource**. The **Overview** page for your hub appears. Alternatively, you can search for it in **All Resources** if you happen to miss the completion message.

1. It's a good idea to bookmark the **Overview** page of your IoT Hub.

Having created the hub, let's take a step back and go over some theory. You might find this knowledge valuable in understanding the security resources.