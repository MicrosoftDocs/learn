The first step towards using Spark Structured Streaming is setting up your Azure Event Hubs in your Azure subscription.

## Create Event Hubs namespace

1. In the Azure portal, select + Create a resource, enter "event hubs" into the Search the Marketplace box, select Event Hubs from the results, and then select Create.

    ![Screenshot of Azure Portal with + Create a resource highlighted in the navigation pane, "event hubs" entered into the Search the Marketplace box, and Event Hubs highlighted in the results.](../media/create-event-hubs.PNG)

1. In the Create Namespace Event Hubs blade, enter the following:

   - _Name_: Enter a unique name, such as **databricksdemoeventhubs**. Uniqueness will be indicated by a green check mark.
   - _Pricing tier_: Select **Basic**.
   - _Subscription_: Select the subscription group you are using for this module.
   - _Resource group_: Choose your module resource group.
   - _Location_: Select the location you are using for this module.
   - Select **Create**.

   ![Screenshot of Create Event Hubs namespace page](../media/create-event-hubs-namespace.PNG)

## Create Event Hubs

1. Once your Event Hubs Namespace is provisioned, navigate to your new Event Hubs Namespace and add a new Event Hub by selecting the + Event Hub button on the toolbar.
 
   ![Screenshot of Event Hubs namespace with add Event Hub button highlighted](../media/add-event-hub.PNG)

1. On the Create Event Hub blade, enter:

   - _Name_: Enter **databricks-demo-eventhub**.
   - _Partition count_: Enter 2.
   - Select **Create**.

   ![Screenshot of create Event Hubs page](../media/create-new-event-hubs.PNG)

## Create Shared Access Policy

1. From the left-hand menu in your Event Hubs Namespace, select **Event Hubs**, and then select **databricks-demo-eventhubs** from the list.

   ![Screenshot of create Event Hubs entity](../media/select-event-hubs-entity.PNG)

1. On the blade for your Event Hub, select **Shared access policies** under Settings in the left-hand menu.

   ![Screenshot of share access policy location](../media/shared-access-policy-location.PNG)

1. Select the + **Add** button on the toolbar.

   ![Screenshot of share access policy add button](../media/shared-access-policy-add-button.PNG)

1. On the Add SAS Policy blade, enter the following:

   - _Policy name_: Enter both.
   - _Manage_: Leave unchecked.
   - _Send_: Check this box.
   - _Listen_: Check this box.
   - Select **Create**.

   ![Screenshot of add share access policy page](../media/add-sas-policy.PNG)

## Capture the SAS Policy connection string-primary key

1. After creating your Shared access policy, select it from the list of Shared access policies, and then copy the Connection string-primary key by selecting the copy button.

   ![Screenshot of capture share access policy page](../media/capture-sas-policy.PNG)

1. Save the copied connection string-primary key to Notepad.exe or another text editor for later reference.