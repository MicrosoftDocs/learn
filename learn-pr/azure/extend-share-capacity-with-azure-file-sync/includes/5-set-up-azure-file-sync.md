You successfully evaluate the target server and found it suitable. Now, prepare your Azure environment to deploy Azure File Sync and investigate what steps are required.

In this unit, you learn about the components and services that Azure File Sync relies on.

To support Azure File Sync, there are many resources that you need to create in your Azure subscription. Create these resources in the following order:

## 1. Storage account

The storage account is used to store the file share. In Azure, a storage account is where you store all Azure Storage data objects, like blobs, files, queues, and disks. There are some limits on the kind of storage account that you can use to store file shares. There are also multiple access tiers that you can select from based on your workload. When using Azure File Sync, we recommend selecting standard access tiers (transaction optimized, hot, cool). Select **StorageV2** with a transaction optimized access tier.

## 2. File share

The file share is the cloud version of a normal on-premises file share. It stores all files and folders. You can control the size of the file share by specifying a quota size. You can change the quota later if you need to.

## 3. Storage Sync Service

The Storage Sync Service establishes trust between your company's server and Azure. This service is where you connect the file share in Azure with the file share on your server.

## 4. Sync group

The sync group must contain one cloud endpoint that represents an Azure file share and one or more server endpoints that map to a path on a registered Windows file server. The sync group manages the process by using metadata stored in a hidden folder: *.SystemShareInformation*. Don't delete this folder.
