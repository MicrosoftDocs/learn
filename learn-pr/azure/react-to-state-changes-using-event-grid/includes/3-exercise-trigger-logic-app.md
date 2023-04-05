One easy way to use Azure Event Grid is to include it in a logic app.

Suppose you've chosen to use Event Grid to alert your administrators when a virtual machine is reconfigured.

Here, you'll set up a virtual machine and create a logic app with an Event Grid trigger that responds to the events produced by the virtual machine.

## Create a virtual machine

Let's start by creating a new virtual machine in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account that you used to activate the sandbox.

1. In resource menu or on the home page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** pane, enter **Virtual machine** in global search. In the search results, select **Virtual machine** published by Microsoft for Azure, and then select **Create**.

1. On the **Basics** tab, enter the following values for each setting:

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Concierge subscription |
    | Resource group  | From the dropdown list, select **<rgn>[sandbox resource group]</rgn>** |
    | **Instance details** |
    | Virtual machine name | vm1 |
    | Region | Choose from the free *sandbox regions* listed after this table. |
    | Availability options | No infrastructure redundancy required |
    | Security type | Standard |
    | Image | Windows Server 2019 Datacenter - x64 Gen2 |
    | Azure Spot instance | No checkmark |
    | Size | Standard DS1 v2 |
    | **Administrator account** |
    | Username | vmadmin |
    | Password | Enter a complex password |
    | **Inbound port rules** |
    | Public inbound ports | None |

    [!INCLUDE[Sandbox regions](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review and create**. Once validation passes, select **Create**.

    Wait for deployment to complete, and then select **Go to resource**. The **Overview** pane for **vm1** *Virtual machine* appears.

## Create a logic app

Let's create a logic app that will run whenever a virtual machine change is detected. First, we'll create a blank logic app.

1. In the resource menu, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Integration**, and then in the results list, select **Logic App**. The **Create Logic App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project Details** |
    | Subscription | Concierge subscription |
    | Resource group | From the dropdown list, select **<rgn>[sandbox resource group]</rgn>** |
    | **Instance Details** |
    | Type | Consumption |
    | Logic app name | Enter a name |
    | Region | Choose from the free *sandbox regions* listed after this table. |
    | Enable log analytics | No |

    [!INCLUDE[Sandbox regions](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**, then select **Create**.

1. Wait for deployment to complete, then select **Go to resource**. The **Logic Apps Designer** pane appears.

## Add an Event Grid trigger to the logic app

1. In the **Logic Apps Designer** pane, scroll down to **Templates** section, then select **Blank Logic App**.  The **Logic Apps Designer** pane appears.

    :::image type="content" source="../media/3-choose-logic-app-template.png" alt-text="Template for a blank logic app.":::

1. In the *Search connectors and triggers* search box, enter *event grid* as your filter. From the list of triggers, select **When a resource event occurs**.

    :::image type="content" source="../media/3-logic-app-event-grid-trigger.png" alt-text="Selections for adding an Event Grid trigger.":::

1. When prompted, sign in to the **Microsoft Learn Sandbox** organization using your Azure account credentials.

1. The **When a resource event occurs** dialog box appears. Select the following values for each setting to subscribe your logic app to publisher events:

    | Setting | Value |
    | --- | --- |
    | **Subscription** | Concierge Subscription |
    | **Resource Type** | `Microsoft.Resources.ResourceGroups` |
    | **Resource Name** | <rgn>[sandbox resource group]</rgn> |
    | **Event Type Item - 1** | `Microsoft.Resources.ResourceActionSuccess`, then select **Add new item** |
    | **Event Type Item - 2** | `Microsoft.Resources.ResourceDeleteSuccess`, then select **Add new item** |
    | **Event Type Item - 3** | `Microsoft.Resources.ResourceWriteSuccess` |
    | | |

    :::image type="content" source="../media/3-logic-app-event-grid-trigger-details.png" alt-text="Trigger details.":::

1. On the command bar, select **Save**.

    :::image type="content" source="../media/3-logic-app-event-grid-save.png" alt-text="Save menu button.":::

Your logic app is now ready and set up to be a subscriber to the events from the Azure Event Grid.
