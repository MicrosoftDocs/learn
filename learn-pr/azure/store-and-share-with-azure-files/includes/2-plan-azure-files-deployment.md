Moving a company's shared files into the cloud-based Azure Files requires an analysis of the options and a plan for the implementation. There's an important decision to make. How are you going to access and update the files? You could choose to replace your existing Server Message Block (SMB) file shares with their equivalent in Azure Files. The other option is to set up an instance of Azure File Sync. If you choose to use Azure File Sync, there's more flexibility on how files are secured and accessed.

The finance company has given you guidance on their requirements. The main concern is that they want to reduce the impact on existing applications, systems, and users. The company wants to use a drop-in replacement for their existing SMB protocol shares. They intend that there won't be any code changes required to support the moved data.

In this unit, you'll explore the features offered by Azure Files and understand the different ways you can access your files. A company's data needs to be resilient to failures. You'll investigate the different redundancy options and choose the right one for the finance company. Finally, knowing the Azure Files features to use, you'll create a plan to migrate the existing files.

## What is Azure Files?

![Diagram of how Azure files are structured. Starting with a storage account, through file storage, shares, directories, and files](../media/2-overview.svg)

Before we explore Azure Files, you need to understand that storage of file shares is one type of data that can be contained in an Azure Storage account. Later in this unit, you'll see how storage accounts provide options for the resilience of stored files.

You can think of Azure Files as a standard file share, hosted on Azure, that you can access with the industry standard SMB protocol. You can mount or connect to an Azure file share at the same time on all the main operating systems.

Azure Files can be used to add to or replace a company's existing on-premises NAS devices or file servers. Some reasons why your organization will want to use Azure Files are:

- Developers can store apps and configuration files in a file share and connect new VMs to the shared files. This action reduces the time to get new machines into production.
- Cloud-based apps can efficiently write log files by using the File REST API to the shared storage. Developers can then map to the shared folder and run their local debugging tools on the shared data.
- With file shares on Azure, a company doesn't need to buy and deploy expensive redundant hardware and manage software updates.
- You can automate the creation and editing of file shares by using PowerShell or Azure CLI commands. Automation leads to an increase in the productivity of a company's operations.
- All of the resilience of the Azure platform is inherited by your file share, which makes files globally redundant. You also gain options to use the integrated snapshots feature and set up automatic backups by using Recovery Services vaults.
- All the data is encrypted in transit by using HTTPS and is stored encrypted when at rest.
- The shares are cross-platform, and you can connect to them from Windows, Linux, or macOS.

Moving a company's existing file shares into Azure Files gives them the flexibility to move their data and processing, or just data, into the cloud. They can then benefit from its scalability, security, and reduced costs compared to running and maintaining the required resources on-premises.

### Choose your data access method

There are two built-in methods of data access supported by Azure Files. One method is direct access via a mounted drive in your operating system. The other method is to use a Windows server (either on-premises or in Azure) and install Azure File Sync to synchronize the files between local shares and Azure Files.

The most common scenario that might lead you to consider using Azure File Sync is to run your applications or compute resources locally on on-premises Windows machines. If the office also has a slow internet connection, it increases the need to run Azure File Sync for performance reasons.

The primary use of direct cloud access is where the apps are running on Azure and all locations that need access to the data have a fast internet connection.

Because the finance company is moving its main apps to Azure and they want to reduce the number of changes they have to make in their offices, direct access is the best choice for them.

### Choose your file redundancy option

Because Azure Files stores files in a storage account, you can choose between standard or premium performance storage accounts:

- **Standard performance**: Double-digit ms latency, 10,000 IOPS, 300-MBps bandwidth
- **Premium performance**: Single-digit ms latency, 100,000 IOPS, 5-GBps bandwidth

Standard performance accounts use HDD to store data. With HDD, the costs are lower but so is the performance. SSD arrays back the premium storage account's performance, which comes with higher costs. Currently, premium accounts can only use file storage accounts with ZRS storage in a limited number of regions.

You need to balance the availability and performance requirements to decide on the account and redundancy options. The finance company is more concerned with the security of their data than performance, and they want the most resilience possible. As a result, the best choice is a standard GRS storage account. When GZRS leaves preview and becomes generally available, it will be the best option for them. This table compares the different characteristics of each storage option.

|         |LRS      |ZRS      |GRS/GZRS     |
|---------|---------|---------|---------|
|You can easily re-create data, and cost is a priority.    |    ✔     |         |         |
|Data must be stored in a single known location.     |    ✔    |         |         |
|Premium performance is required. |    ✔    |     ✔*    |         |
|Data needs to be highly available, and redundancy is a priority.     |         |    ✔     |    ✔     |
|99.999999999% (11 nines) durability.     |    ✔     |         |         |
|99.9999999999% (12 nines) durability.     |         |    ✔     |         |
|99.99999999999999% (16 nines) durability.     |         |         |    ✔    |

 *Premium file storage accounts with ZRS are only supported in a smaller subset of regions.


### Choose your data migration solution

The finance company has existing systems, data, and file shares. You need to migrate this data into Azure Files, so you have another decision to make. Because you can connect over SMB or use the REST APIs, you have many options. For example, you can write a custom utility or use Microsoft solutions. The table lists the most common utilities.

![Most common utilities](../media/2-azure-data-transfer-options.svg)

|Utility  | Description  |
|---------|---------|
|AzCopy     | Command-line tool that offers the best performance, especially for a low volume of small files.  |
|Robocopy   | Command-line tool shipped with Windows and Windows Server. AzCopy is written to be Azure aware and performs better. |
|Azure Storage Explorer     | Graphical file management utility that runs on Windows, Linux, and macOS.         |
|Azure portal     | Use the portal to import files and folders. |
|Azure File Sync     | Can be used to do the initial data transfer, and then uninstalled after the data is transferred.  |
|Azure Data Box     | If you have up to 35 TB of data and you need it imported in less than a week.  |

The finance company's files are small, and they have around 100-Mbps bandwidth on their network. Their operations team doesn't want to install software on any of the machines and wants the transfers to be as fast as possible.

Knowing these requirements and constraints, you propose that AzCopy is the best tool for their needs.
