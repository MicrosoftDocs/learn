Storage accounts let you create a group of data management rules and apply them all at once to the data stored in the account: blobs, files, tables, and queues. 

If you tried to achieve the same thing without storage accounts, the end product would be tedious and error-prone. For example, what are the chances that you could successfully apply the same rules to thousands of blobs?

Instead, you capture the rules in the settings for a storage account, and those rules are automatically applied to every data service in the account.

[!INCLUDE [](../../../includes/azure-sandbox-cleanup.md)]

> [!IMPORTANT]
> When you're working in your own subscription, to avoid unwanted usage charges, you must remove any resources that you create.

Use the following steps in the Azure portal to delete the resource group and all associated resources.

1. In the resource menu, select **Resource groups**.

1. Select the resource group you created.

1. In the command bar, select **Delete resource group**.

1. In the confirmation pane, you're prompted to type the resource group name; you can right-click and drag the title from the Resource group pane. 

1. When the expected name is a match, **Delete** is available. 
 
1. Select **Delete**. It may take several minutes to delete your resource group. Check **Notifications** in the Global Controls in the upper right corner of the Azure portal to ensure your operation completed. 
