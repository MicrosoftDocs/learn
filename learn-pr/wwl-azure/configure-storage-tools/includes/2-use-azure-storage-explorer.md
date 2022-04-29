Azure Storage Explorer is a standalone app that makes it easy to work with Azure Storage data on Windows, macOS, and Linux. With Storage Explorer, you can access multiple accounts and subscriptions and manage all your storage content.

:::image type="content" source="../media/storage-explorer-304e94f3.png" alt-text="Screenshot of the Storage Explorer. The navigation pane is expanded and a folder in the blob container is selected. The folder contains several documents.":::


To fully access resources after you sign in, Storage Explorer requires both management (Azure Resource Manager) and data layer permissions. This means that you need Azure Active Directory (Azure AD) permissions, which give you access to your storage account, the containers in the account, and the data in the containers.

## Connecting to storage

Storage Explorer is used to connect to different storage accounts.

 -  Connect to storage accounts associated with your Azure subscriptions.
 -  Connect to storage accounts and services that are shared from other Azure subscriptions.
 -  Connect to and manage local storage by using the Azure Storage Emulator.

:::image type="content" source="../media/connection-options-1df9c8f7.png" alt-text="Screenshot of the Azure Explorer Manage Accounts page.":::


In addition, you can work with storage accounts in global and national Azure:

 -  **Connect to an Azure subscription**. Manage storage resources that belong to your Azure subscription.
 -  **Work with local development storage**. Manage local storage by using the Azure Storage Emulator.
 -  **Attach to external storage**. Manage storage resources that belong to another Azure subscription or that are under national Azure clouds by using the storage account's name, key, and endpoints (shown below.)
 -  **Attach a storage account by using a SAS**. Manage storage resources that belong to another Azure subscription by using a shared access signature (SAS).
 -  **Attach a service by using a SAS**. Manage a specific storage service (blob container, queue, or table) that belongs to another Azure subscription by using a SAS.
 -  **Connect to an Azure Cosmos DB account by using a connection string**. Manage Cosmos DB account by using a connection string.

## Accessing external storage accounts

As mentioned previously, Storage Explorer lets you attach to external storage accounts so that storage accounts can be easily shared. To create the connection you will need the storage **Account name** and **Account key**. In the portal, the account key is called **key1**.

:::image type="content" source="../media/attach-name-key-13fe3ba3.png" alt-text="Screenshot of Storage Explorer. The wizard to connect to external storage is displayed, prompting for an account name, account key, and storage endpoint domain.":::


To use a name and key from a national cloud, use the **Storage endpoints domain** drop-down to select **Other** and then enter the custom storage endpoint domain.

> [!NOTE]
> Access keys provide access to the entire storage account. Store your access keys securely. We recommend regenerating your access keys regularly. You are provided two access keys so that you can maintain connections using one key while regenerating the other.

When you regenerate your access keys, you must update any Azure resources and applications that access this storage account to use the new keys. This action will not interrupt access to disks from your virtual machines.
