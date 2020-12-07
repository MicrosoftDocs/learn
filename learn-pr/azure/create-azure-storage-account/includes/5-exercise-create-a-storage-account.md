In this unit, you'll use the Azure portal to create a storage account that is appropriate for a fictitious southern California surf report web app.

The surf report site lets users upload photos and videos of local beach conditions. Viewers will use the content to help them choose the beach with the best surfing conditions. Your list of design and feature goals is:

- Video content must load quickly.
- The site must handle unexpected spikes in upload volume.
- Outdated content must be removed as surf conditions change so the site always shows current conditions.

To fulfill these requirements, you decide to buffer uploaded content in an Azure Queue for processing and then transfer it to an Azure Blob for persistent storage. You need a storage account that can hold both queues and blobs while delivering low-latency access to your content.

## Use the Azure portal to create a storage account

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the selection panel that appears, select **Storage**.

1. On the right side of that pane, select **Storage account**.

    :::image type="content" source="../media/5-portal-storage-select.png" border="true" alt-text="Screenshot of the Azure portal showing the Create a resource pane with the Storage category and Storage account option highlighted.":::

### Configure the basic options

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

Under **PROJECT DETAILS**:

1. Select the _Concierge Subscription_ from the **Subscription** drop-down list.

1. Select the existing Resource Group ("**<rgn>[sandbox resource group name]</rgn>**") from the drop-down list.

    > [!NOTE]
    > This free Resource Group has been provided by Microsoft as part of the learning experience. When you create an account for a real application, you'll want to create a new Resource Group in your subscription to hold all the resources for the app.

Under **INSTANCE DETAILS**:

1. Enter a **Storage account name**. The name will be used to generate the public URL used to access the data in the account. The name must be unique across all existing storage account names in Azure. Names must be 3 to 24 characters long and can contain only lowercase letters and numbers.

1. Select a **Location** near to you from the list above.

1. Select _Standard_ for the **Performance** option. This option decides the type of disk storage used to hold the data in the Storage account. Standard uses traditional hard disks, and Premium uses solid-state drives (SSD) for faster access.

1. Select _StorageV2 (general purpose v2)_ for the **Account kind**. This option provides access to the latest features and pricing. In particular, Blob storage accounts have more options available with this account type. You need a mix of blobs and a queue, so the _Blob storage_ option won't work. For this application, there would be no benefit to choosing a _Storage (general purpose v1)_ account, since that would limit the features you could access and would be unlikely to reduce the cost of your expected workload.

1. Select _Locally redundant storage (LRS)_ for the **Replication** option. Data in Azure storage accounts are always replicated to ensure high availability - this option lets you choose how far away the replication occurs to match your durability requirements. In our case, the images and videos quickly become out-of-date and are removed from the site. As a result, there's little value to paying extra for global redundancy. If a catastrophic event results in data loss, you can restart the site with fresh content from your users.

The following screenshot shows the completed settings for the **Basics** tab. The resource group, subscription, and name will have different values.

:::image type="content" source="../media/5-create-storage-account-basics.png" border="true" alt-text="Screenshot of a Create a storage account pane with the Basics tab selected.":::

### Configure the networking options

1. Select the **Networking** tab at the top of the screen.

1. Set the **Connectivity method** option to *Public endpoint (all networks)*. We want to allow public Internet access. Our content is public facing and you need to allow access from public clients.

1. Set the **Routing preference** option to *Microsoft network routing (default)*. We want to make use of the Microsoft global network that is optimized for low-latency path selection.

:::image type="content" source="../media/5-create-storage-account-network.png" border="true" alt-text="Screenshot of a Create a storage account pane with the Networking tab selected.":::

### Configure the Data Protection options

Boxes checked are enabled, boxes that are not checked are disabled. 

1. Leave the **soft delete for blobs** option set to _Disabled_. Soft delete lets you recover your blob data in many cases where blobs or blob snapshots are deleted accidentally or overwritten.

1. Leave the **soft delete for file shares** option set to _Disabled_. File share soft delete lets you recover your blob data more easily at the folder level.

:::image type="content" source="../media/5-create-storage-account-data-protection.png" border="true" alt-text="Screenshot of a Create a storage account pane with the Advanced tab selected.":::

### Configure the advanced options

1. Set **Secure transfer required** to *Enabled*. The **Secure transfer required** setting controls whether **HTTP** can be used for the REST APIs used to access data in the Storage account. Setting this option to _Enabled_ will force all clients to use SSL (**HTTPS**). Most of the time you'll want to set this to _Enabled_ as using HTTPS over the network is considered a best practice.

1. Set **Minimum TLS version** to *Version 1.2*. TLS 1.2 is the most secure version of TLS and is used by Azure Storage on public HTTPS endpoints. TLS 1.1 and 1.0 is supported for backwards compatibility.

    > [!WARNING]
    > If this option is enabled, it will enforce some additional restrictions. Azure files service connections without encryption will fail, including scenarios using SMB 2.1 or 3.0 on Linux. Because Azure storage doesn't support SSL for custom domain names, this option cannot be used with a custom domain name.

1. Set **Allow Blob public access** to *Enabled*. We'll allow clients to read data in that container without authorizing the request.

1. Set the **Access tier** to _Hot_. This setting is only used for Blob storage. The **Hot Access Tier** is ideal for frequently accessed data, and the **Cool Access Tier** is better for infrequently accessed data. This setting only sets the _default_ value - when you create a Blob, you can set a different value for the data. In our case, we want the videos to load quickly, so you'll use the high-performance option for your blobs.

1. Leave the **Data Lake Storage Gen2** option as _Disabled_. This is for big-data applications that aren't relevant to this module.

1. Leave the **Large file shares** option set to _Disabled_. Large file shares provide support up to a 100 TiB, however this type of storage account can't convert to a Geo-redundant storage offering, and upgrades are permanent.


The following screenshot shows the completed settings for the **Advanced** tab.

:::image type="content" source="../media/5-create-storage-account-advanced.png" border="true" alt-text="Screenshot of a Create a storage account pane with the Advanced tab selected.":::

### Create

1. You can explore the **Tags** settings if you like. This lets you associate key/value pairs to the account for your categorization and is a feature available to any Azure resource.

1. Click **Review + create** to review the settings. This will do a quick validation of your options to make sure all the required fields are selected. If there are issues, they'll be reported here. Once you've reviewed the settings, click **Create** to provision the storage account.

It will take a few minutes to deploy the account.

### Verify

1. Select the **Storage accounts** link in the left sidebar.

1. Locate the new storage account in the list to verify that creation succeeded.

You created a storage account with settings driven by your business requirements. For example, you might have selected a West US datacenter because your customers were primarily located in southern California. This is a typical flow: first analyze your data and goals, and then configure the storage account options to match.
