The first step toward using Spark Structured Streaming is setting up Azure Event Hubs in your Azure subscription.

## Create an Event Hubs namespace

1. In the Azure portal, select **+ Create a resource**. Enter **event hubs** into the **Search the Marketplace** box, select **Event Hubs** from the results, and then select **Create**.

    ![Screenshot of the Azure portal with selections for creating an event hub](../media/create-event-hubs.PNG)

1. In the **Create Namespace** blade, enter the following information:

   - **Name**: Enter a unique name, such as **databricksdemoeventhubs**. Uniqueness will be indicated by a green check mark.
   - **Pricing tier**: Select **Basic**.
   - **Subscription**: Select the subscription group you're using for this module.
   - **Resource group**: Choose your module resource group.
   - **Location**: Select the location you're using for this module.
   
   Select **Create**.

   ![Screenshot of the "Create Namespace" blade](../media/create-event-hubs-namespace.PNG)

## Create an event hub

1. After your Event Hubs namespace is provisioned, browse to it and add a new event hub by selecting the **+ Event Hub** button on the toolbar.
 
   ![Screenshot of an Event Hubs namespace with the button for adding an event hub highlighted](../media/add-event-hub.PNG)

1. On the **Create Event Hub** blade, enter:

   - **Name**: Enter **databricks-demo-eventhub**.
   - **Partition Count**: Enter **2**.
    
   Select **Create**.

   ![Screenshot of the "Create Event Hub" blade](../media/create-new-event-hubs.PNG)

## Create a shared access policy

1. From the left menu in your Event Hubs namespace, select **Event Hubs**, and then select **databricks-demo-eventhubs** from the list.

   ![Screenshot of "Event Hubs" under "Entities"](../media/select-event-hubs-entity.PNG)

1. On the blade for your event hub, select **Shared access policies** under **Settings** in the left menu.

   ![Location of the shared access policy](../media/shared-access-policy-location.PNG)

1. Select the **Add** button on the toolbar.

   !["Add" button for shared access policy](../media/shared-access-policy-add-button.PNG)

1. On the **Add SAS Policy** blade, enter the following information:

   - **Policy name**: Enter **both**.
   - **Manage**: Leave unselected.
   - **Send**: Select this box.
   - **Listen**: Select this box.
    
   Select **Create**.

   ![Screenshot of the "Add SAS policy" blade](../media/add-sas-policy.PNG)

## Capture the connection string's primary key for the shared access policy

1. After you create your shared access policy, select it from the list of shared access policies. Then copy the connection string's primary key by selecting the copy button.

   ![Selected shared access policy with information about connection string and primary key](../media/capture-sas-policy.PNG)

1. Save the copied primary key to Notepad.exe or another text editor for later reference.