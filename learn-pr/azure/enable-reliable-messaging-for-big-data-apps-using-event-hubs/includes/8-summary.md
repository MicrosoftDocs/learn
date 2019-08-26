Azure Event Hubs provides big data applications the capability to process large volume of data. It also has the ability to scale out during exceptionally high-demand periods as and when required. Azure Event Hubs decouple the sending and receiving messages to manage the data processing. This helps eliminate the risk of overwhelming consumer application and data loss due to any unplanned interruptions.

In this module, you've seen how to deploy Azure Event Hubs as part of an event processing solution. 
You learned how to:

- Use the Azure CLI commands to create an Event Hubs namespace and an event hub in that namespace. 
- Configure sender and receiver applications to send and receive messages through the event hub.
- Use the Azure portal to view your event hub status and performance.

## Clean up resources

In this module you created resources using your Azure subscription. You want to clean up these resources so that you will not continue to be charged for them.

1. In Azure, select **Resource groups** on the left.

1. Find the **learn-big-data-messaging-rg** resource group, or whatever resource group name you used,  and select it.

1. In the **Overview** tab of the resource group, select **Delete resource group**.

1. This opens a new dialog box. Type the name of the resource group  again and select **Delete**. This will delete all of the resources we created in this module.
1. 