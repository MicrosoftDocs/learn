Azure offers several options for migrating data offline. For your migration planning for Tailwind Traders, we examine Azure Import/Export and Azure Data Box.

## Azure Import/Export service

The [Azure Import/Export](/azure/import-export/storage-import-export-service) service migrates large quantities of data between an on-premises location and an Azure storage account. By using the Import/Export service, you send and receive physical disks that contain your data between your on-premises location and an Azure datacenter. You ship data that's stored on your own disk drives. These disk drives can be Serial ATA (SATA) hard-disk drives (HDDs) or solid-state drives (SSDs).

### Things to know about the Import/Export service

To use the Azure Import/Export service, you create a job that specifies the data that you want to import or export. You then prepare the disks to use to transfer the data. For an import job, you write your data to these disks and ship them to an Azure datacenter. Microsoft uploads the data for you. For an export job, you prepare a set of blank disks and ship them to an Azure datacenter. Microsoft copies the data to these disks and ships them back to you.

Here are a few more points about working with the Import/Export service:

- You can use the Azure Import/Export service to export data from Azure Blob Storage only.
- You can't export data that's stored in Azure Files.
- To use the Import/Export service, BitLocker must be enabled on the Windows system.
- You need an active shipping carrier account like FedEx or DHL for shipping drives to an Azure datacenter.
- For exporting, you need a set of disks that you can send to an Azure datacenter. The datacenter uses these disks to copy the data from Azure Storage.

### Things to consider when using the Import/Export service
 
The Azure Import/Export service is ideal for uploading and downloading large amounts of data when the network backbone doesn't have sufficient capacity or reliability to support large-scale transfers. The Import/Export service can be helpful in other scenarios, including:

| Scenario | Description |
| --- | --- |
| _Migration_ | Use the Import/Export service to migrate large amounts of data from on-premises to Azure, as a one-time task. |
| _Backup_ | You can back up your data on-premises in Azure Storage with the Import/Export service. |
| _Recovery_ | With the Import/Export service, you can recover large amounts of data that you previously stored in Azure Storage. |
| _Distribution_ | The Import/Export service helps you distribute data from Azure Storage to customer sites. |

## Azure Data Box

[Azure Data Box](/azure/databox/) provides a quick, reliable, and inexpensive method for moving large volumes of data to Azure. By using Data Box, you can send terabytes of data into and out of Azure. The solution is based on a secure storage device that's shipped to your organization. Your Data Box can include various devices, such as disks, ruggedized server chassis, or mobile disks. 

Azure offers several products to fit different scenarios: [Data Box](/azure/databox/data-box-overview), [Data Box Disk](/azure/databox/data-box-disk-overview), and [Data Box Heavy](/azure/databox/data-box-heavy-overview). The configuration process is basically the same across all the products. 

After you receive your storage device, you can quickly set it up by using the local web-based management interface. If you're exporting data to Azure, copy the required data to the storage device, and then return it to Azure.

### Things to know about Azure Data Box

Azure Data Box includes the following components:

- **Data Box device**: A physical device that provides primary storage, manages communication with cloud storage, and helps to ensure the security and confidentiality of all data stored on the device. The Data Box device has a usable storage capacity of 80 TB.

- **Data Box service**: An extension of the Azure portal that lets you manage a Data Box device by using a web interface that you can access from different geographical locations. Use the Data Box service to perform daily administration of your Data Box device. The service tasks include how to create and manage orders, view, and manage alerts, and manage shares.

- **Data Box local web-based user interface**: A web-based UI that's used to configure the device so it can connect to the local network, and then register the device with the Data Box service. You can also use the local web UI to shut down and restart the Data Box device, view copy logs, and contact Microsoft Support to file a service request.

> [!NOTE]
> You define your encryption keys for the storage device. The entire process is tracked end-to-end by the Data Box service in the Azure portal. 

### Things to consider when using Azure Data Box

Data Box is ideally suited for transferring data sizes larger than 40 TBs. The service is especially useful in scenarios with limited internet connectivity. You could consider using Data Box in the following situations.

| Scenario | Description |
| --- | --- |
| _One time migration_ | Use Azure Data Box to migrate a large amount of on-premises data to Azure. Move a media library from offline tapes into Azure to create an online media library. Migrate your virtual machine farm, SQL server, and applications to Azure. Move historical data to Azure for in-depth analysis and reporting by using Azure HDInsight. |
| _Initial bulk transfer_ | You can perform an initial bulk transfer with Azure Data Box and follow it with incremental transfers over the network. Move large volumes of historical backup to Azure. After this data is added, you can continue to maintain the archive with incremental data transfers by network to Azure Storage. |
| _Periodic uploads_ | Use Azure Data Box to move large volumes of data that's generated periodically to Azure. Move data generated by sensors from customer connected IoT devices. |

## Compare Azure Import/Export and Azure Data Box

The following table provides a comparison of Azure Import/Export and Azure Data Box. Think about how you can implement these services to support your migration solution for Tailwind Traders.

| Compare | Azure Import/Export | Azure Data Box |
| --- | --- | --- |
| **Form factor** | Internal SATA HDDs or SDDs | Secure, tamper-proof, single hardware appliance |
| **Microsoft manages shipping logistics** | No | Yes |
| **Integrates with partner products** | No | Yes |
| **Custom appliance** | No | Yes |

> [!Tip]
> If you want to import or export more moderate volumes of data to and from Azure Blob Storage, consider using other tools like AzCopy or Azure Storage Explorer.