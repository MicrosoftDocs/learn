Using the manufacturing company example, as project lead, your first step is to review the available options. You'll then start to plan your company's storage tier strategy.

In this unit, you'll review Azure Storage tiers, and look at typical use cases. You'll also look at how these tiers can be used to help manage data stored in Azure blobs.

## Azure Storage

Azure Storage is Microsoft's managed service that provides highly available and redundant storage. There are several types of Azure Storage:

- **Azure Blobs**. Typically used to upload and manage images, documents, and general data.
- **Azure Files**. Let you create file shares using Server Message Block (SMB) 3.0, so systems can access files through a uniform naming convention (UNC) path.
- **Azure Data Lake**. Lets you store large complex data for tasks such as big data analysis.

This module is all about optimizing Azure Blob storage.

## Azure Blobs

Blobs are used to store large amounts of unstructured data such as text or binary data as separate files. Blobs are organized into containers, and there's no limit to the number of containers you can create in a storage account. Each container can hold an unlimited number of blobs and a blob must reside inside a container. 

Containers do not support subdirectories, but you can create a logical structure by adding **/** to filenames. For example, you save a file called **Report.txt** in the top level of a container as **/Sales/Report.txt**. To any service accessing the file, it would appear that the file is saved in a subdirectory called **Sales**.

## Blob Storage Access Tiers

Azure Storage provides several storage tiers. Each of these tiers has different pricing, where the best performing tier incurs the greatest cost. By configuring these tiers, you can optimize the balance between data access speed and costs.

There are currently four Blob storage tiers:

- **Premium**. This tier is ideal for sensitive applications with high throughput such as online transactions and suited for workloads where an application performs many small transactions at a low latency level. The premium tier is only available for BlobStorage accounts.
- **Hot**. This is the default tier and is used for data that is frequently accessed. It is more expensive to store data here, compared to the Cool and Archive tiers, but cheaper to access. Hot supports a 99.9% availability SLA. You can set the Hot tier at the account level, and at the object level.
- **Cool**. This tier is used for storing less frequently accessed data, such as archived files, backups, and raw or unprocessed data. Cool is designed for data that is likely to be stored for at least 30 days. Cool storage costs less than Hot storage per GB. How much it costs depends on the region. Cool supports a 99.9% availability SLA. You can set the Cool tier at the account level, and at the object level.
- **Archive**. This is the most cost-effective option for storing data but is typically more expensive for data retrieval than Hot and Cool tiers. Archive is designed for data that is likely to be stored for at least 180 days, and for systems or scenarios where retrieval latency can be tolerated. You can only set Archive access tier at the blob level.

Only the Cool and Hot access tiers can be set at the account level.

You can use Hot, Cool, and Archive tiers with General Purpose V2 storage accounts.

You can switch between access tiers at any time, when and if, your usage patterns change. The change between tiers is immediate, except when you wish to move data out of Archive. Archive data is offline, with only metadata available for online query. To access Archive data, the blob must first be **rehydrated**.

## Blob Rehydration

Blob rehydration is the process of retrieving data back from archive and moving it from offline to online storage. Data can be rehydrated back into Hot or Cool tiers. You can start the process by  changing the blob tier from Archive to either Hot or Cool. The process can take up to 15 hours.

## Pricing

The cost of storage varies depending on the storage tier being used:

- The cost of storing data **decreases** as you move off Hot or Premium tiers with Archive being the cheapest.
- The cost of retrieving data **increases** the further down the cooling tier you are; for example, the cost of retrieving data from Cool is higher compared to the cost of retrieving data from Hot. Retrieval from Archive is the most expensive.
- Changing storage tiers also incurs a cost.

## Azure Blob Storage Lifecycle Management

Blob Storage lifecycle management is a Preview feature that lets you use policies and rules to automatically move data between tiers. Using policies helps you control your storage performance and costs.

With Lifecycle management you can:

- Transition blobs to cool or archive tiers
- Delete blobs

You can create rules to:

- Move blobs to cool tier after X days
- Move blobs to archive tier after X days
- Delete blobs after X days
