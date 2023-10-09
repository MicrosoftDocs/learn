The Azure Import/Export service is one of several options for transferring data in and out of Azure Storage. In the film-production company scenario, you want to make sure you've selected the correct solution for your requirements. In this unit, we explore in greater detail the question of when you should use the Azure Import/Export service and when another tool might be more suitable.

## Offline transfer of massive data

The Import/Export service is an offline solution. It's designed to handle more data than would be feasible to transmit over a network connection. Using the Import/Export service, you take responsibility for preparing and shipping the necessary hardware.

Microsoft provides an alternative solution in the form of the Azure Data Box family. The Data Box family uses Microsoft-supplied devices to transfer data from your on-premises location into Azure Storage. A Data Box device is a proprietary, tamper-proof network appliance. You can connect the device to your own internal network to move data to the device. You ship the device back to Microsoft, which then uploads data from the device into Azure Storage.

The Azure Data Box family is the recommended solution for handling very large import or export jobs when the organization is located in a region where Data Box is supported. It's an easier process than using the Import/Export service.

## Online transfer of massive data

The Import/Export service doesn't provide an online option. If you need an online method to transfer massive amounts of data, you can use Azure Stack Edge or Azure Data Box Gateway. Azure Stack Edge is a physical network appliance that you install on-premises. The device connects to your storage account in the cloud. Data Box Gateway is a virtual network appliance. Both of these products support data transfer from an on-premises location to Azure.

## Online transfer of smaller data volumes

If you're looking to import or export more moderate volumes of data to and from Azure Blob storage, consider using other tools like AzCopy or Azure Storage Explorer.

AzCopy is a simple but powerful command-line tool that lets you copy files to or from Azure Storage accounts. With AZCopy you can:

- Upload, download, and copy files to Azure Blob storage.
- Upload, download, and copy files to Azure Files.
- Copy files between storage accounts.
- Copy files between storage accounts from different regions.

You can use AzCopy to transfer data online across a network. To access AzCopy, you must provide the appropriate Azure credentials to access the storage account, or use an SAS (Shared Access Signature).

AzCopy is the ideal tool for copying small to moderate amounts of data as quickly as possible and with the least cost and effort. For large datasets, network bandwidth may limit the speed at which you can upload or download data to or from Azure Storage. You can create scripts that use AzCopy.

Azure Storage Explorer is a free tool that you can use to connect to Azure Storage and view data through a graphical user interface. You can upload and download data held in blobs, files, and tables. You can also examine queues and manipulate queued messages. Storage Explorer is an interactive tool. It isn't suitable for moving more than the smallest amounts of data, and it can't be easily scripted.

A version of Azure Storage Explorer is provided in the Azure portal.

You can also use Azure PowerShell and the Azure CLI to upload and download data. These interfaces are programmatic, allowing you to produce complex, scripted solutions that can incorporate transformations, mergers, and filtering as the data is transferred.

## Select the right tool for the job

The following table summarizes the considerations for choosing the most appropriate tool for a data-transfer operation:

| Dataset | Network bandwidth |Solution to use |
| ---- | ---- | ---- |
| Large dataset | Low-bandwidth network or direct connectivity to on-premises storage is limited by organization policies |  Azure Import/Export or Data Box for export; Data Box Disk or Data Box for import where it's supported; otherwise use Azure Import/Export.|
| Large dataset | High-bandwidth network: 1 gigabit per second (Gbps) - 100 Gbps | AZCopy for online transfers; or to import data, Azure Data Factory, Azure Stack Edge, or Azure Data Box Gateway. |
| Large dataset | Moderate-bandwidth network: 100 megabits per second (Mbps) - 1 Gbps | Azure Import/Export or Azure Data Box family where it's supported. |
| Small dataset: a few GBs to a few TBs | Low to moderate-bandwidth network: up to 1 Gbps | If transferring only a few files, use Azure Storage Explorer, Azure portal, AZCopy, or AZ CLI. |
