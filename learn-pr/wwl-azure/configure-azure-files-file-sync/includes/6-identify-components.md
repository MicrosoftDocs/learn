[Azure Storage Explorer](/azure/storage/storage-explorer/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows) is a standalone application that makes it easy to work with Azure Storage data on Windows, macOS, and Linux. With Azure Storage Explorer, you can access multiple accounts and subscriptions, and manage all your Storage content.

:::image type="content" source="../media/storage-explorer.png" alt-text="Screenshot of Azure Storage Explorer that shows the Emulator storage account open, which has a folder and several documents. The access tier information is visible." border="false":::

### Things to know about Azure Storage Explorer

Azure Storage Explorer has the following characteristics.

- Azure Storage Explorer requires both management (Azure Resource Manager) and data layer permissions to allow full access to your resources. You need Azure Active Directory (Azure AD) permissions to access your storage account, the containers in your account, and the data in the containers.

- Azure Storage Explorer lets you connect to different storage accounts.
   - Connect to storage accounts associated with your Azure subscriptions.
   - Connect to storage accounts and services that are shared from other Azure subscriptions.
   - Connect to and manage local storage by using the Azure Storage Emulator.

   :::image type="content" source="../media/connection-options-1df9c8f7.png" alt-text="Screenshot of the Azure Explorer Manage Accounts page.":::

### Things to consider when using Azure Storage Explorer

Azure Storage Explorer supports many scenarios for working with storage accounts in global and national Azure. As you review these options, think about which scenarios apply to your Azure Storage implementation.

| Scenario | Description |
| --- | --- |
| **Connect to an Azure subscription** | Manage storage resources that belong to your Azure subscription. |
| **Work with local development storage** | Manage local storage by using the Azure Storage Emulator. |
| **Attach to external storage** | Manage storage resources that belong to another Azure subscription or that are under national Azure clouds by using the storage account name, key, and endpoints. This scenario is described in more detail in the next section. |
| **Attach a storage account with a SAS** | Manage storage resources that belong to another Azure subscription by using a shared access signature (SAS). |
| **Attach a service with a SAS** | Manage a specific Azure Storage service (blob container, queue, or table) that belongs to another Azure subscription by using a SAS. |

## Attach to external storage account

Azure Storage Explorer lets you attach to external storage accounts so storage accounts can be easily shared.

To create the connection, you need the external storage **Account name** and **Account key**. In the Azure portal, the account key is called **key1**.

:::image type="content" source="../media/attach-name-key-13fe3ba3.png" alt-text="Screenshot of the Azure Storage Explorer wizard to connect to an external storage account.":::

To use a storage account name and key from a national Azure cloud, use the **Storage endpoints domain** drop-down menu to select **Other**, and then enter the custom storage account endpoint domain.

### Access keys

Access keys provide access to the entire storage account. You're provided two access keys so you can maintain connections by using one key while regenerating the other.

> [!Important]
> Store your access keys securely. We recommend regenerating your access keys regularly. 

When you regenerate your access keys, you must update any Azure resources and applications that access this storage account to use the new keys. This action doesn't interrupt access to disks from your virtual machines.