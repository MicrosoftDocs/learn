One easy way to use Azure Event Grid is to include it in a logic app.

Suppose you've chosen to use Event Grid to alert your administrators when a virtual machine is reconfigured. 

Here, you'll set up a virtual machine and create a logic app with an Event Grid trigger that responds to the events produced by the virtual machine.

## Create a virtual machine

Let's start by creating a new virtual machine in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account that you used to activate the sandbox.

1. Select **+ Create a resource**.

1. Select **Compute** > **Virtual Machine**.

1. The **Create a virtual machine** page appears. Fill in the fields with the following values.

    | Field | Value |
    | --- | --- |
    | On the **Basics** tab > **Project details** |
    | **Subscription** | Concierge subscription |
    | **Resource group**   | <rgn>[sandbox resource group]</rgn> |
    | **Instance details** |
    | **Virtual machine name** | vm1 |
    | **Region** | Select a region near you |
    | **Availability options** | No infrastructure redundancy required |
    | **Image** | Windows Server 2019 Datacenter - Gen1 |
    | **Azure Spot instance** | No checkmark |
    | **Size** | Standard DS1 v2 |
    | **Administrator account** |
    | **Authentication type** | Password |
    | **Username** | vmadmin |
    | **Password** | Enter a complex password |
    | **Inbound port rules** |
    | **Public inbound ports** | None |

1. Select **Review and create**, and then select **Create**.

## Create a logic app

The next step is to create the logic app that will run when a virtual machine change is detected. Let's create a blank logic app.

1. From the **Home** page, select **+ Create a resource**.

1. Select **Integration**, search for and select **Logic App**, and then select **Create**.

1. The **Create a logic app** page appears. Fill in the fields with the following values.

    | Field | Value |
    | --- | --- |
    | On the **Basics** tab > **Project details** |
    | **Subscription** | Concierge subscription |
    | **Resource group** | From the dropdown, select **<rgn>[sandbox resource group]</rgn>** |
    | **Instance details** |
    | **Logic app name** | Enter a name |
    | **Region** | Select a region near you |
    | **Enable log analytics** | Off |

1. Select **Review + create**, and then select **Create**.

## Add an Event Grid trigger to the logic app

After your logic app is created, you add triggers for Event Grid events.

1. After your deployment successfully completes, select **Go to resource**.

1. Select the logic app that you created in the previous step.

1. Under **Templates**, select **Blank Logic App**.

    ![Template for a blank logic app](../media/3-choose-logic-app-template.png)

1. Within the designer, in search box, enter **Event Grid** as your filter. From the list of triggers, select **When a resource event occurs**.

    ![Selections for adding an Event Grid trigger](../media/3-logic-app-event-grid-trigger.png)

1. When you're prompted, sign in to the **Microsoft Learn Sandbox** organization by using your Azure account credentials.

1. Enter these values to subscribe your logic app to publisher events.

    | Field | Value |
    | --- | --- |
    | **Subscription** | Concierge Subscription |
    | **Resource Type** | `Microsoft.Resources.ResourceGroups` |
    | **Resource Name** | <rgn>[sandbox resource group]</rgn> |
    | **Event Type Item - 1** | `Microsoft.Resources.ResourceActionSuccess` |
    | **Event Type Item - 2** | `Microsoft.Resources.ResourceDeleteSuccess` |
    | **Event Type Item - 3** | `Microsoft.Resources.ResourceWriteSuccess` |
    | | |

    ![Trigger details](../media/3-logic-app-event-grid-trigger-details.png)

1. From the top menu bar, select **Save**.

    ![Save button](../media/3-logic-app-event-grid-save.png)

Your logic app is now ready and set up to be a subscriber to the events from Azure Event Grid.
