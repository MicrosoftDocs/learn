In this unit, you'll use the Azure portal to create a storage account that is appropriate for a fictitious southern California surf report web app.

The surf report site lets users upload photos and videos of local beach conditions. Viewers will use the content to help them choose the beach with the best surfing conditions. Your list of design and feature goals is:

- Video content must load quickly.
- The site must handle unexpected spikes in upload volume.
- Outdated content must be removed as surf conditions change so the site always shows current conditions.

To fulfill these requirements, you decide to buffer uploaded content in an Azure Queue for processing, and then transfer it to an Azure Blob for persistent storage. You need a storage account that can hold both queues and blobs while delivering low-latency access to your content.

## Create a storage account using Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu, or from the **Home** page, select **Create a resource**.

1. In the left menu pane, select **Storage**, and then search for and select **Storage account**. The **Storage account** pane appears.


1. On the **Basics** tab, enter the following values for each setting.

1. Select **Create**. The **Create storage account** pane appears. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | ---- | ---- |
    | **Project details**| |
    | Subscription | Concierge Subscription |
    | Resource group | ("<rgn>[sandbox resource group name]</rgn>") from the dropdown. |
    | **Instance details**| |
    | Storage account name | The name will be used to generate the public URL used to access the data in the account. The name must be unique across all existing storage account names in Azure. Names must be 3 to 24 characters long and can contain only lowercase letters and numbers. |
    | Location | Select a location near to you in the dropdown from the dropdown. |
    | Performance | Standard. This option decides the type of disk storage used to hold the data in the Storage account. Standard uses traditional hard disks, and Premium uses solid-state drives (SSD) for faster access. |
    | Account kind | StorageV2 (general purpose v2) |
    | Redundancy | Locally redundant storage (LRS). In our case, the images and videos quickly become out-of-date and are removed from the site. As a result, there's little value to paying extra for global redundancy. If a catastrophic event results in data loss, you can restart the site with fresh content from your users. |

    [!INCLUDE [Sandbox Regions](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Next : Networking**. Enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Network connectivity**| |
    | Connectivity method | *Public endpoint (all networks)*.  We want to allow public Internet access. Our content is public facing, and we need to allow access from public clients. |
    | **Network routing**| |
    | Routing preference | *Microsoft network routing (default)*. We want to make use of the Microsoft global network that is optimized for low-latency path selection. |

1. Select **Next : Data protection**. Enter the following value for the setting.

    | Setting | Value |
    |---|---|
    | **Recovery**| |
    | Turn on soft delete for blobs | *Disabled*. Soft delete lets you recover your blob data in many cases where blobs or blob snapshots are deleted accidentally or overwritten. |
    | Turn on soft delete for file shares | *Disabled*. File share soft delete lets you recover your blob data more easily at the folder level. |

1. Select **Next : Advanced**. Enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Security**| |
    | Secure transfer required | *Enabled*. This setting controls whether **HTTP** can be used for the REST APIs used to access data in the storage account. Setting this option to *enable* forces all clients to use SSL (**HTTPS**). Most of the time, you'll want to set this to *enable* as using HTTPS over the network is considered a best practice. |
    | Minimum TLS version | *Version 1.2* from dropdown. TLS 1.2 is the most secure version of TLS and is used by Azure Storage on public HTTPS endpoints. TLS 1.1 and 1.0 is supported for backwards compatibility. See *Warning* at end of table. |
    | **Blob storage**| |
    | Allow Blob public access | *Enabled*. We'll allow clients to read data in that container without authorizing the request. |
    | Blob access tier (default) | *Hot*. This setting is only used for Blob storage. The *Hot Access Tier* is ideal for frequently accessed data; the *Cool Access Tier* is better for infrequently accessed data. This setting only sets the _default_ value. When you create a Blob, you can set a different value for the data. In our case, we want the videos to load quickly, so we'll use the high-performance option for our blobs. |
    | **Data Lake Storage Gen 2**| |
    | Hierarchical namespace | *Disabled*. This is for big-data applications that aren't relevant to this module. |
    | **Azure Files**| |
    | Large file shares | *Disabled*. Large file shares provide support up to a 100 TiB, however this type of storage account can't convert to a Geo-redundant storage offering, and upgrades are permanent. |

    > [!WARNING]
    > If this option is enabled, it will enforce some additional restrictions. Azure files service connections without encryption will fail, including scenarios using SMB 2.1 or 3.0 on Linux. Because Azure storage doesn't support SSL for custom domain names, this option cannot be used with a custom domain name.

1. Select **Next : Tags**. Here, you associate key/value pairs to the account for your categorization and determine if a feature is available to any Azure resource.

1. Select **Review + create** to review the settings. This will do a quick validation of your options to make sure all the required fields are selected. If there are issues, they'll be reported here.

1. After validation passes, select **Create** to provision the storage account.

   It may take two minutes to deploy the account.

1. After validation succeeds, select **Go to resource** to view your newly-created storage account.

You created a storage account with settings driven by your business requirements. For example, you might have selected a West US datacenter because your customers were primarily located in southern California. This is a typical flow: first analyze your data and goals, and then configure the storage account options to match.
