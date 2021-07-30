One easy way to use Azure Event Grid is to include it in a logic app.

Suppose you've chosen to use Event Grid to alert your administrators when a virtual machine is reconfigured. 

Here, you'll set up a virtual machine and create a logic app with an Event Grid trigger that responds to the events produced by the virtual machine.

## Create a virtual machine

Let's start by creating a new virtual machine in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account that you used to activate the sandbox.

1. On the home page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Compute**, and in the *Popular offers* list, select **Create**  under **Virtual machine**. The **Create a virtual machine** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Concierge subscription |
    | Resource group  | From the dropdown list, select **<rgn>[sandbox resource group]</rgn>** |
    | **Instance details** |
    | Virtual machine name | vm1 |
    | Region | Select a region near you |
    | Availability options | No infrastructure redundancy required |
    | Image | Windows Server 2019 Datacenter - Gen1 |
    | Azure Spot instance | No checkmark |
    | Size | Standard DS1 v2 |
    | **Administrator account** |
    | Username | vmadmin |
    | Password | Enter a complex password |
    | **Inbound port rules** |
    | Public inbound ports | None |

1. Select **Review and create**, and after validation passes, select **Create**.

    Wait for deployment to complete, and then select **Go to resource**. The virtual machine **Overview** pane for vm1 appears.

## Create a logic app

The next step is to create the logic app that will run when a virtual machine change is detected. Let's create a blank logic app.

1. In the top left, select **Home** to open **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Integration**, select **Logic App (Consumption)** from the Popular Offers in Marketplace. The **Logic App (Consumption)** pane appears.

1. Select **Create**. The **Create a logic app** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Concierge subscription |
    | Resource group | From the dropdown list, select **<rgn>[sandbox resource group]</rgn>** |
    | **Instance details** |
    | Logic app name | Enter a name |
    | Region | Select a region near you |
    | Associate with integration service environment | No checkmark |
    | Enable log analytics | No checkmark |

1. Select **Review + create**, and after validation passes, select **Create**.

## Add an Event Grid trigger to the logic app

1. Wait for deployment to complete, and then select **Go to resource**. The **Logic Apps Designer** pane appears.

1. Scroll down, and under **Templates**, select **Blank Logic App**.

    :::image type="content" source="../media/3-choose-logic-app-template.png" alt-text="Template for a blank logic app."::: 

1. Within the designer, in the search box, enter **event grid** as your filter. From the list of triggers, select **When a resource event occurs**.

    :::image type="content" source="../media/3-logic-app-event-grid-trigger.png" alt-text="Selections for adding an Event Grid trigger.":::

1. When prompted, sign in to the **Microsoft Learn Sandbox** organization using your Azure account credentials.

1. On the Apps Designer in **When a resource event occurs** select the following values from the dropdown lists to subscribe your logic app to publisher events:

    | Field | Value |
    | --- | --- |
    | **Subscription** | Concierge Subscription |
    | **Resource Type** | `Microsoft.Resources.ResourceGroups` |
    | **Resource Name** | <rgn>[sandbox resource group]</rgn> |
    | **Event Type Item - 1** | `Microsoft.Resources.ResourceActionSuccess`, and then select **Add new item** |
    | **Event Type Item - 2** | `Microsoft.Resources.ResourceDeleteSuccess`, and then select **Add new item** |
    | **Event Type Item - 3** | `Microsoft.Resources.ResourceWriteSuccess` |
    | | |

    :::image type="content" source="../media/3-logic-app-event-grid-trigger-details.png" alt-text="Trigger details.":::

1. On **Logic Apps Designer** menu bar, select **Save**.

    :::image type="content" source="../media/3-logic-app-event-grid-save.png" alt-text="Save menu button.":::

Your logic app is now ready and set up to be a subscriber to the events from the Azure Event Grid.
