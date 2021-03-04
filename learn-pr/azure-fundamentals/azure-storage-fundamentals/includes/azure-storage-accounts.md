The Chief Technology Officer (CTO) for your company, Tailwind Traders, has tasked your team with migrating all of your files to the cloud. Your team has chosen [Azure Storage](https://azure.microsoft.com/product-categories/storage?azure-portal=true), which is a service that you can use to store files, messages, tables, and other types of information. Clients such as websites, mobile apps, desktop applications, and many other types of custom solutions can read data from and write data to Azure Storage. Azure Storage is also used by infrastructure as a service virtual machines, and platform as a service cloud services.

The following video introduces the different services that available with Azure Storage.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MAbS]

To begin using Azure Storage, you first create an Azure Storage account to store your data objects. You can create an Azure Storage account by using the Azure portal, PowerShell, or the Azure CLI.

[![Screenshot of creating a storage account.](../media/create-storage-account.png)](../media/create-storage-account-expanded.png#lightbox)

Your storage account will contain all of your Azure Storage data objects, such as blobs, files, and disks.

> [!NOTE]
> 
> Azure VMs use Azure Disk Storage to store virtual disks. However, you can't use Azure Disk Storage to store a disk outside of a virtual machine.

![Diagram of hierarchy of a storage account.](../media/account-container-blob.png)

A storage account provides a unique namespace for your Azure Storage data, that's accessible from anywhere in the world over HTTP or HTTPS. Data in this account is secure, highly available, durable, and massively scalable.

For more information, see [Create a storage account](https://docs.microsoft.com/azure/storage/common/storage-account-create?azure-portal=true).
