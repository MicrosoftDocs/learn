In this unit, you use the Azure portal to create a storage account for a fictitious southern California surf report web app. The surf report site lets users upload photos and videos of local beach conditions. Viewers of the site use the content to help them choose the beach with the best surfing conditions. 

Your list of design and feature goals is:

- Video content must load quickly.
- The site must handle unexpected spikes in upload volume.
- Outdated content must be removed as surf conditions change so the site always shows current conditions.

You decide to buffer uploaded content in an Azure Queue for processing and then transfer it to an Azure Blob for persistent storage. You need a storage account that can hold both queues and blobs while delivering low-latency access to your content.

## Create a storage account using Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. On the resource menu, or from the **Home** page, select **Storage accounts**. The **Storage accounts** pane appears.

1. On the command bar, select **Create.** The **Create a storage account** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | ---- | ---- |
    | **Project details**| |
    | Subscription | Concierge Subscription |
    | Resource group | <rgn>[sandbox resource group name]</rgn> from the dropdown list. |
    | **Instance details**| |
    | Storage account name | Enter a unique name. This name is used to generate the public URL to access the data in the account. The name must be unique across all existing storage account names in Azure. Names must have 3 to 24 characters and can contain only lowercase letters and numbers. |
    | Region | Select a location near to you from the dropdown list. |
    | Performance | *Standard*. This option decides the type of disk storage used to hold the data in the Storage account. Standard uses traditional hard disks, and Premium uses solid-state drives (SSD) for faster access. |
    | Redundancy | Select *Locally redundant storage (LRS)* from the dropdown list. In our case, the images and videos quickly become out-of-date and are removed from the site. As a result, there's little value to paying extra for *Geo-redundant storage (GRS)*. If a catastrophic event results in data loss, you can restart the site with fresh content from your users. |

1. Select **Next : Advanced**. On the **Advanced** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Security** | 
    | Require secure transfer for REST API operations | *Check*. This setting controls whether **HTTP** can be used for the REST APIs that access data in the storage account. Setting this option to *enable* forces all clients to use **HTTPS**. Most of the time, you want to set secure transfer to *enable*; using HTTPS over the network is considered a best practice. |

    | Allow enabling anonymous access on individual containers | *Uncheck*. Blob containers, by default, don't permit anonymous access to their content. This setting allows authorized users to selectively enable anonymous access on specific containers. |
    | Enable blob public access | *Check*. We want to allow clients to read data in that container without authorizing the request. |

    | Enable storage account key access | *Check*. We want to allow clients to access data via SAS. |
    | Default to Azure Active Directory authorization in the Azure portal | *Uncheck*. Clients are public, not part of an Active Directory. |
    | Minimum TLS version | Select *Version 1.2* from dropdown list. TLS 1.2 is a secure version of TLS, and Azure Storage uses it on public HTTPS endpoints. TLS 1.1 and 1.0 are supported for backwards compatibility. See *Warning* at end of table. |
    | Permitted scope for copy operations | Accept default |
    | **Hierarchical Namespace** |
    | Enable hierarchical namespace | *Uncheck*. Data Lake hierarchical namespace is for big-data applications that aren't relevant to this module. |
    | **Access protocols** |
    | Enable hierarchical namespace | Accept default. Blob and Data Lake Gen2 endpoints are provisioned by default. |
    | **Blob storage** |
    | Allow cross-tenant replication | *Uncheck*. Active Directory isn't being used for this exercise. |
    | Access tier | *Hot*. This setting is only used for Blob storage. The *Hot* access tier is ideal for frequently accessed data; the *Cool* access tier is better for infrequently accessed data. This setting only sets the *default* value. When you create a Blob, you can set a different value for the data. In our case, we want the videos to load quickly, so we use the high-performance option for our blobs. |
    | **Azure Files**| |
    | Enable large file shares | *Uncheck*. Large file shares provide support up to a 100 TiB, however this type of storage account can't convert to a Geo-redundant storage offering, and upgrades are permanent. |

    > [!WARNING]
    > If *Enable large file shares* is selected, it will enforce additional restrictions, and Azure files service connections without encryption will fail, including scenarios using SMB 2.1 or 3.0 on Linux. Because Azure storage doesn't support SSL for custom domain names, this option cannot be used with a custom domain name.

1. Select **Next : Networking**. On the **Networking** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Network connectivity**|
    | Network access | *Enable public access from all networks*. We want to allow public Internet access. Our content is public facing, and we need to allow access from public clients. |
    | **Network routing**|
    | Routing preference | *Microsoft network routing*. We want to make use of the Microsoft global network that is optimized for low-latency path selection. |

1. Select **Next : Data protection**. On the **Data protection** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Recovery**|
    | Enable point-in-time restore for containers | *Uncheck*. Not necessary for this implementation. |
    | Enable soft delete for blobs | *Uncheck*. Soft delete lets you recover blob data in cases where blobs or blob snapshots are deleted accidentally or overwritten. |
    | Enable soft delete for containers | *Uncheck*. Soft delete lets you recover your containers that are deleted accidentally. |
    | Enable soft delete for file shares | *Uncheck*. File share soft delete lets you recover your accidentally deleted file share data more easily. |
    | **Tracking**|
    | Enable versioning for blobs | *Uncheck*. Not necessary for this implementation. |
    | Enable blob change feed | *Uncheck*. Not necessary for this implementation. |
    | **Access control**|
    | Enable version-level immutability support | *Uncheck*. Not necessary for this implementation. |

1. Select **Next : Encryption.** Accept the defaults.

1. Select **Next : Tags**. Here, you can associate key/value pairs with the account for your categorization to determine if a feature is available to selected Azure resources.

1. Select **Next : Review** to validate your options and to ensure all the required fields are selected. If there are issues, this tab identifies them so you can correct them.

1. When validation passes successfully, select **Create** to deploy the storage account.

1. When deployment is complete, which may take up to two minutes, select **Go to resource** to view **Essential** details about your new storage account.

You created a storage account with settings driven by your business requirements. For example, you might have selected a West US datacenter because your customers were primarily located in southern California. The typical flow for creating a storage account is: first analyze your data and goals, and then configure the storage account options to match.
