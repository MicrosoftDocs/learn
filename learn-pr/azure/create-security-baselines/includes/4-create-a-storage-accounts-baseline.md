An Azure storage account provides a unique namespace to store and access your Azure Storage data objects.

## Azure Storage account recommendations

Here are the recommendations for setting up Azure Storage accounts. Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps with your own subscription using your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Require security-enhanced transfers - Level 1

Another step you should take to ensure the security of your Azure Storage data is to encrypt the data between the client and Azure Storage. The first recommendation is to always use the HTTPS protocol, which ensures secure communication over the public Internet. You can enforce the use of HTTPS when calling the REST APIs to access objects in storage accounts by enabling *secure transfer required* for the storage account. Connections using HTTP will be refused after you enable this control.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Storage accounts*. The **Storage accounts** pane displays.

1. Select an existing account.

1. In the middle menu pane, under **Settings**, select **Configuration**. The **Configuration** pane displays for your storage account.

1. Set **Secure transfer required** to **Enabled**.

   :::image type="content" source="../media/4-create-a-storage-accounts-baseline/azure-storage-account-secure-transfer-setting.png" alt-text="Screenshot that shows the secure transfer storage setting in the Azure portal.":::

### Enable binary large object (blob) encryption - Level 1

Azure Blob Storage is Microsoft's object storage solution for the cloud. Blob Storage is optimized for storing massive amounts of unstructured data. Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data. Storage service encryption protects your data at rest. Azure Storage encrypts your data as it's written in its datacenters, and automatically decrypts it for you as you access it.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Storage accounts*. The **Storage accounts** pane displays.

1. Select an existing account.

1. In the middle menu pane, under **Security + networking**, select **Encryption**. The **Encryption** pane for your storage account displays.

1. Azure Storage encryption is enabled for all new and existing storage accounts and can't be disabled.

    :::image type="content" source="../media/4-storage-encryption.png" alt-text="Secure storage encryption setting.":::

### Periodically regenerate access keys - Level 1

When you create a storage account, Azure generates two 512-bit storage access keys. These keys are used for authentication when the storage account is accessed. Rotating these keys periodically ensures that any inadvertent access or exposure to these keys could be undermined.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Storage accounts*. The **Storage accounts** pane displays.

1. Select an existing account.

1. In the middle menu pane, select **Activity log** for each storage account. The **Activity log** for your storage account displays.

1. Under the **Timespan** dropdown, select **Custom**, and then select **Start Time** and **End Time** so it creates a 90 day range.

1. Select **Apply**.

    :::image type="content" source="../media/4-storage-timespan.png" alt-text="Storage timespan setting.":::

1. If you aren't using Azure Key Vault with key rotation, to regenerate storage access keys for a specific storage account, run the following command:

    ```http
    POST https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/regenerateKey?api-version=2019-04-01
    ```

### Require Shared Access Signature (SAS) tokens to expire within an hour - Level 1

A shared access signature (SAS) is a URI that grants restricted access rights to Azure Storage resources. You can provide an SAS to clients who shouldn't be trusted with your storage account key, but who you want to delegate access to certain storage account resources. By distributing an SAS URI to these clients, you can grant them access to a resource for a specified period of time, with a specified set of permissions.

> [!NOTE]
> Currently, verification of a SAS token expiry times can't be accomplished. Until Microsoft makes token expiry time as a setting rather than a token creation parameter, this recommendation would require a manual verification.

### Require SAS tokens to be shared only via HTTPS - Level 1

SAS tokens should be allowed only over HTTPS protocol.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Storage accounts*. The **Storage accounts** pane displays.

1. Select an existing account.

1. In the middle menu pane, under **Security + networking**, select **Shared Access signature** for each storage account. The **Shared Access signature** pane for your storage account displays.

1. Under **Start and expiry date/time**, set the **Start** and **End** dates/times.

1. Under **Allowed protocols**, select **HTTPS only**.

Both SAS features follow.

:::image type="content" source="../media/4-storage-SAS.png" alt-text="SAS in storage setting.":::

### Enable Azure Files encryption - Level 1

Azure Disk Encryption is used to encrypt the OS and data disks in IaaS VMs. Client-side Encryption and SSE are both used to encrypt data in Azure Storage.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Storage accounts*. The **Storage accounts** pane displays.

1. Select an existing account.

1. In the middle menu pane, under **Security + networking**, select **Encryption**. The **Encryption** pane for your storage account displays.

1. Azure Storage encryption is enabled for all new and existing storage accounts and can't be disabled.

    :::image type="content" source="../media/4-storage-encryption.png" alt-text="Storage encryption.":::

### Require only private access to blob containers - Level 1

You can enable anonymous, public read access to a container and its blobs in Azure Blob Storage. By doing so, you can grant read-only access to these resources without sharing your account key, and without requiring a SAS. By default, a container and any blobs within it might be accessed only by a user that has been given appropriate permissions. To grant anonymous users read access to a container and its blobs, you can set the container public access level. **When you grant public access to a container, anonymous users can read blobs within a publicly accessible container without authorizing the request**.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Storage accounts*. The **Storage accounts** pane displays.

1. In the middle menu pane, under **Data storage**, select **Containers**. The **Containers** pane for your storage account displays.

1. Ensure that **Public access level** is set to **Private**.

    :::image type="content" source="../media/4-create-a-storage-accounts-baseline/azure-storage-account-container-private-access-setting.png" alt-text="Screenshot that shows a storage container with public access level set to private."::: 

    > [!TIP]
    > Remember to select **Save** if you make changes to any of the settings.
