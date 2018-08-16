## Module Summary

In this module, you have seen how to deploy Azure Event Hubs as part of an event processing solution. You have learned how to use Azure CLI commands to create an Event Hub namespace and Event Hub in that namespace. You have learned how to configure sender and receiver applications, to send and receive messages through the Event Hub. You have also seen how to use the Azure Portal to view Event Hub status and performance.

You looked at the example of a bank payment processing service, which demands a high level of resilience, as potentially millions of data events are sent from credit card readers to card verification applications. Banks cannot afford for any card checks to be missed because processing applications have become swamped by data. You also looked at the example of of a vehicle tracking application, where regular interruptions to data publishing are inevitable, when vehicles move out of cellular range.

It is exactly these kind of situations that Azure Event Hubs are designed for; by decoupling the sending and receiving of messages, large data streams cannot overwhelm the data receivers, and interruptions to event streams do not lead to any data loss. 

## Clean Up The Azure Subscription

The resources you have used for your Event Hub testing will incur costs against your subscription. When you have finished with the Event Hub, remember to remove these resources in order to avoid unnecessary charges. Because you create the hub, namespace, and storage in the same resource group, the easiest way to clean up your Azure subscription is to remove the resource group which will remove all its contents. Run the following command to remove the resource group, namespace, storage account, and all related resources. Replace `myResourceGroup` with the name of the resource group you created:

```azurecli
az group delete --resource-group myResourceGroup
```

When you are asked to confirm the delete, answer **Yes**.

The command may take several minutes to complete as resources are deleted.
