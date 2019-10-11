You've successfully evaluated the target server and found it suitable. Now you'll prepare your Azure environment to deploy Azure File Sync and investigate what steps are required.

In this unit, you'll see the components and services that Azure File Sync relies on.

To support Azure File Sync, there are a number of resources that you need to create in your **Azure** subscription. Create these resources in the following order:

## 1. Storage account

The storage account is used to store the file share. In Azure, a storage account is where all Azure storage data objects are stored like blobs, files, queues, and disks. There are some limitations to the kind of storage account that can be used. Select StorageV2, with a Hot access tier.

## 2. File share

The file share is the cloud version of a normal on-premises file share and will store all files and folders. You control the size of the file share by specifying a quota size. The quota can be increased if needed in the future.

## 3. Storage Sync Service

The Storage Sync Service is responsible for establishing trust between your companies server and Azure. The service is where you connect together the file share in Azure and your file directory on your server.

## 4. Sync group

The Sync group must contain one cloud endpoint that represents an Azure file share, and one or more server endpoints that map to a path on a registered Windows file server. The sync group manages the process with metadata stored in a hidden folder: **.SystemShareInformation**. Don't delete this folder.