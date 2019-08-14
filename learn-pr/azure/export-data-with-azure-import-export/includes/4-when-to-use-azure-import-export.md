The Azure Import/Export service is one of a number of options available for transferring data in and out of Azure storage. In the film production company scenario, you want to make sure that you've selected the correct solution for your requirements. In this unit, you'll look in more detail at when you should use the Azure Import/Export service, and when another tool might be more suitable.

## Offline transfer of massive data

The Import/Export service is an offline solution. It's designed handle more data than would be feasible to transmit over a network connection. Using the Import/Export service, you take responsibility for preparing and shipping the necessary hardware.

Microsoft provides an alternative solution in the form of Azure Data Box Family.  Data Box Family uses Microsoft-supplied devices to transfer data from your on-premises location into Azure storage. A Data Box device is a proprietary, tamper-proof network appliance. You connect the device to your own internal network to move data to the device. You ship the device back to Microsoft who uploads data from the device into Azure storage.

Azure Data Box family is the recommended solution for performing very large import jobs when the organization is within a region where Data Box is supported. It's an easier process than using the Import/Export service.

Azure Data Box family doesn't support offline export from Azure. For offline export of large amounts of data from Azure to an on-premises location, we recommend Azure Import/Export.

## Online transfer of massive data

The Import/Export service doesn't provide an online option. If you need an online solution to transfer massive amounts of data, you can use Data Box Edge or Data Box Gateway. Data Box Edge is a physical network appliance that you install on-premises. The device connects to your storage account in the cloud. Data Box Gateway is a virtual network appliance. Both of these products support data transfer from an on-premises location to Azure.

## Online transfer of smaller data

If you're looking to import or export more moderate volumes to and from Azure blob storage, consider using other tools like AzCopy or Storage Explorer.

AzCopy is a simple but powerful command-line tool that allows you to copy files to or from Azure storage accounts. With AZCopy you can:

- Upload, download, and copy files to Azure blob storage.
- Upload, download, and copy files to Azure files.
- Copy files between storage accounts.
- Copy files between storage accounts from different regions.

You use AzCopy to transfer data online across the network. To access AzCopy, you need to provide the appropriate Azure credentials to enable you to access the storage account, or use a SAS (Shared Access Signature).

AzCopy is the ideal tool to use to copy small to moderate amounts of data as quickly as possible, with the least amount of cost and effort. For large datasets, network bandwidth may limit the speed at which you can upload or download data to or from Azure storage. You can create scripts that use AzCopy.

Azure Storage Explorer is a free tool that you can use to connect to Azure storage and view data through a graphical user interface. You can upload and download data held in blobs, files, and tables. You can also examine queues and manipulate queued messages. Storage Explorer is an interactive tool. It isn't suited to moving more than the smallest amounts of data, and can't easily be scripted.

A version of Azure Storage Explorer is provided in the Azure portal.

You can also use Azure PowerShell and the Azure CLI to upload and download data. These interfaces are programmatic, enabling you to produce complex, scripted solutions that can incorporate transformations, mergers, and filter of data as it is transferred.

## Select the right tool for the job

The following tables summarize the considerations for selected which tool is most appropriate for a data transfer operation, given the size of the dataset and the network bandwidth available to you:

| Dataset | Network bandwidth |Solution to use |
| ---- | ---- | ---- |
| Large dataset | Low network bandwidth or direct connectivity to on-premises storage is limited by organization policies |  Azure Import/Export for export;  Data Box Disk or Data Box for import where supported, otherwise use Azure Import/Export|
| Large dataset | High network bandwidth 1 Gbps - 100 Gbps | AZCopy for online transfers, or to import data, Azure Data Factory, Azure Data Box Edge, or Azure Data Box Gateway |
| Large dataset | Moderate network bandwidth 100 Mbps - 1-Gbps | Azure Import/Export for export or Azure Data Box family for import where supported |
| Small dataset that are a few GBs to a few TBs | Low to moderate network bandwidth of up to 1 Gbps | If transferring only a few files, use Azure Storage Explorer, Azure portal, AZCopy, or AZ CLI |
