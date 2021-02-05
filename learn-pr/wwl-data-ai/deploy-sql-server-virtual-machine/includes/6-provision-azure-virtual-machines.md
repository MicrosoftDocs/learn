The Azure ecosystem offers several different methods in which to provision a new SQL Server instance on an Azure virtual machine. Each method provides different capabilities, such as the ability to have a repeatable process (via scripting languages like PowerShell) or a method to accomplish the goal without needing an understanding of programming constructs, via the Azure portal.

## Azure Marketplace

The Azure Marketplace is essentially a centralized location that provides the ability to create Azure resources based on a predesigned template. For example, you can quickly create a SQL Server 2019 instance on Windows Server 2019 with a couple of clicks of the mouse along with some basic information, such as the virtual machine name as well as some SQL Server configuration information. Once provided, Azure Resource Manager will initiate the creation of the virtual machine and within minutes it will be up and running.

The blade for SQL Server 2019 on Windows Server 2019 in the Azure Marketplace is shown below. This blade gives you the option of pre-set configurations that support OLTP or Data Warehouse workloads and allow you to specify storage, patching, and backup options.

:::image type="content" source="../media/module-22-plan-implement-final-06.png" alt-text="Azure portal SQL Server VM Creation":::

The disadvantage of using the portal to create Azure resources is that it is not an easily repeatable process. However, it is easy to get started with the portal, and a new administrator can quickly get up and running by using the portal.

## Storage considerations

SQL Server requires good storage performance to deliver robust application performance, whether it be an on-premises instance or installed in an Azure VM. Azure provides a wide variety of storage solutions to meet the needs of your workload. While Azure offers various types of storage (blob, file, queue, table) in most cases SQL Server workloads will use Azure managed disks. The exceptions are that a Failover Cluster Instance can be built on file storage and backups will use blob storage. Azure-managed disks act as a block-level storage device that is presented to your Azure VM. Managed disks offer a number of benefits including 99.999% availability, scalable deployment (you can have up to 50,000 VM disks per subscription per region), and integration with availability sets and zones to offer higher levels of resiliency in case of failure.

Azure-managed disks all offer two types of encryption. Azure Server-side encryption is provided by the storage service and acts as encryption-at-rest provided by the storage service. Azure Disk Encryption uses BitLocker on Windows, and DM-Crypt on Linux to provide OS and Data disk encryption inside of the VM. Both technologies integrate with Azure Key Vault and allow you to bring your own encryption key.

Each VM will have at least two disks associated with it: the operating system disk and the temporary disk.

Operating System disk – Each virtual machine will require an operating system disk that contains the boot volume. This disk would be the C: drive in the case of a Windows platform virtual machine, or /dev/sda1 on Linux. The operating system will be automatically installed on the operating system disk.

Temporary disk – Each virtual machine will include one disk used for temporary storage. This storage is intended to be used for data that does not need to be durable, such as page files or swap files. Because the disk is temporary, you should not use it for storing any critical information like database or transaction log files as they will be lost during maintenance or a reboot of the virtual machine. This drive will be mounted as D:\ on Windows, and /dev/sdb1 on Linux.

Additionally, you can and should add additional data disks to your Azure VMs running SQL Server.

Data disks – The term data disk is used in the Azure portal, but in practice these are just additional managed disks added to a VM. These disks can be pooled to increase the available IOPs and storage capacity, using Storage Spaces on Windows or Logical Volume Management on Linux.

Furthermore, each disk can be one of several types:

- **Standard HDD** was the original storage offering on Azure and offers cost-effective storage for non-I/O intensive workloads. A common use case for standard disks is for SQL Server backups.

- **Standard SSD** is a solid-state drive and will have similar latency and IOPS to the standard HDD drives at sizes up to 4 TB; however, this type offers significant performance gains at larger volumes. Standard SSDs do offer guaranteed performance levels where the Standard HDD disks do not.

- **Premium SSD** is the most commonly used type of disk for SQL Server workloads. They are available in all regions and support a wide variety of VM types. Premium disks strike a good balance between price and performance.

- **Ultra SSD** provides the lowest latency (submillisecond) and the highest potential IOPs. Ultra SSD allows you to configure IOPs, storage volume, and bandwidth independently for more granular cost control.

The best practices for SQL Server on Azure recommend using Premium Disks pooled for increased IOPs and storage capacity. Data files should be stored in their own pool with read-caching on the Azure disks. Transaction log files will not benefit from this caching, so those files should go into their own pool without caching. TempDB can optionally go into its own pool, or using the VM’s temporary disk, which offers low latency since it is physically attached to the physical server where the VMs are running. Properly configured Premium SSD will see latency in single digit milliseconds. For mission critical workloads that require latency lower than that, you should consider Ultra SSD.

## Deploying via PowerShell/CLI

PowerShell is an object-orienting programming language that can be used to quickly and efficiently create a virtual machine (as well as other resources) within the Azure ecosystem. Using PowerShell gives you granular control over various aspects of the virtual machine such as size, name, IP address, and even storage.

:::image type="content" source="../media/module-22-plan-implement-final-07.png" alt-text="PowerShell sample to create a Resource Group and an Azure VM":::

The image above shows a PowerShell script that defines parameters and creates an Azure resource group and a virtual machine with a predefined virtual network.

Azure Command Line Interface (CLI) is another method of using scripting to create Azure resources, including virtual machines. Its simplistic nature allows you to accomplish the same goal as with PowerShell in fewer lines of actual code.

:::image type="content" source="../media/module-22-plan-implement-final-08.png" alt-text="Azure CLI to Create a Resource Group and a VM":::

As the image shows, the CLI is less verbose in terms of the amount of code required to create new resources.

## Deploying using Azure Resource Manager templates

Azure Resource Manager Templates have the benefit of being able to deploy a full set of resources in one single declarative template. This includes the ability to build dependencies into the templates, as well as using parameters to change specific values at deployment time. Once you have a template, there are several ways with which you can deploy it including an Azure DevOps pipeline, or through the custom deployments blade in the Azure portal. You can use the Azure portal to export a Resource Manager template to JSON for future deployment.

:::image type="content" source="../media/module-22-plan-implement-final-09.png" alt-text="Example Azure Resource Manager Template":::

The image above is an example of an Azure Resource Manager template that can be used to deploy a group of Azure resources repeatedly. Templates can be deployed directly from the Azure portal, or via scripting languages that reference the templates like PowerShell, the Azure CLI, or through DevOps workflows like Azure DevOps.

```powershell
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"

$location = Read-Host -Prompt "Enter the location (i.e. centralus)"


New-AzResourceGroup -Name $resourceGroupName -Location $location

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `

 -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json


az deployment group create --resource-group myresourcegroup `

--TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-sql-logical-server/azuredeploy.json"

```

The image above highlights the PowerShell and Azure CLI code to deploy an Azure Resource Group and prompts the user for the resource group name and the target Azure region.
