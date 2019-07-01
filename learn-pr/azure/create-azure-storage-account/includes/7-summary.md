Storage accounts let you create a group of data management rules and apply them all at once to the data stored in the account: blobs, files, tables, and queues. 

If you tried to achieve the same thing without storage accounts, the end product would be tedious and error-prone. For example, what are the chances that you could successfully apply the same rules to thousands of blobs?

Instead, you capture the rules in the settings for a storage account, and those rules are automatically applied to every data service in the account.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

When you're working in your own subscription, you can use the following steps in the Azure portal to delete the resource group and all associated resources.

1. Select the **Resource groups** link in the left sidebar.

1. Locate the resource group you created in the list.

1. Right-click on the resource group entry and select **Delete resource group** from the context menu. You can also click the "..." menu element on the right side of the entry to get to the same context menu.

1. Type the resource group name into the confirmation field.

1. Click the **Delete** button. This may take several minutes.
