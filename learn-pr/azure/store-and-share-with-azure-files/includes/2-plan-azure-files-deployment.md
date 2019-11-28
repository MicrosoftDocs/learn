Moving a company's shared files into the clouds based Azure Files requires analysis of the options and a plan for the implementation. There is one important decision that you need to make to begin with. How are you going to access and update files? You can replace your existing SMB file shares with their equivalent in Azure Files. The other option is to set up Azure File Sync. Using Azure File Sync gives you more flexibility on how files are secured and accessed.

The finance company has given you guideance on what their requirements are. Their main concern is that they want to reduce the impact on existing applications, systems, and users. They'd like a drop in replacement for their existing Server Message Block (SMB) protocol shares. There intention is that there will be zero code changes required to support the moved data.

In this unit, you'll explore the features offered by Azure Files, and understand the different ways you can access your files. A company's data needs to be resilient to failures, so you'll investigate the different redundancy options, and choose the right one for the finance company. Finally, knowing how you will use Azure Files, you'll need to create a plan on how you'll migrate your existing files.

## What is Azure Files?

![Diagram of how Azure Files are structured. Starting with a storage account, through file storage, shares, directories, and files.](../media/2-overview.png)

Before exploring what Azure Files is, you need to understand that storage of file shares are one of the types of storage that can be contained in an Azure Storage Account. Later in this unit you'll see how storage accounts provide options for the resilience of stored files.

Azure Files can be used to supplement, or replace, a company's existing on-premises NAS devices and file server. Examples of how Azure Files can help an organization are:

  - Developers can store apps and configuration files in a file share and connect new VMs to the shared files. Reducing the speed to get new machines to be productive.
  - Cloud based apps can efficiently write log files using the File REST API to the shared storage. The developers can then map to the shared folder and run their local debugging tools on the data.
  - File shares on Azure don't need a company to buy and deploy expensive redundant hardware.
  - Creation and editing of file shares can be automated with PowerShell and Azure CLI increasing the productivity a company's operations.
  - All of the inherent resilience of the Azure platform is inherited by your file share, making files globally redundant. You also gain options to use the integrated snapshots, and have automatic backups with Recovery Services vaults.
  - All data is encrypted in transit over HTTPS and is stored encrypted when at rest.
  - The shares are cross platform and can be connected to from Windows, Linux, or macOS.

### Choose your data access method

![Flowchart on how to decide which data access method](../media/2-data-access-method.png)

There are two built-in methods of data access supported by Azure Files. One is direct access via a mounted drive in your operating system. The other is to use an on-premises, or in Azure, Windows Server and install Azure File Sync to synchronize the files between your local shares and Azure Files.

The most common scenario that means you should consider using Azure File Sync, is your applications and systems are running locally on on-premises Windows machines. A factor that will increase the need to run Azure File Sync is if the office has a slow internet connection.

The best use of direct cloud access is where the apps are running on Azure, and all locations that need access to the data have good internet connectivity.

As the finance company is moving it's main apps into Azure, and they want to reduce the number of changes they have to make in their business, direct access is the best choice for them.

### Choose your file redundancy option

|         |LRS      |ZRS      |GRS / GZRS     |
|---------|---------|---------|---------|
|Data can be easily recreated and costs are a priority    |    ✔     |         |         |
|Data must be stored in a single known location     |    ✔    |         |         |
|Premium performance is required |    ✔    |     ✔*    |         |
|Data needs to be highly available and redundancy is a priority     |         |    ✔     |    ✔     |
|99.999999999% (11 nines) durability     |    ✔     |         |         |
|99.9999999999% (12 nines) durability     |         |    ✔     |         |
|99.99999999999999% (16 nines) durability     |         |         |    ✔    |

 *Premium File Storage accounts with ZRS are only supported in a smaller subset of regions.

As Azure Files are stored in a storage account, you can therefore choose between standard and premium performance storage accounts.

- Standard performance: Double digit ms latency, 10,000 IOPS, 300MBps bandwidth
- Premium performance: Single digit ms latency, 100,000 IOPS, 5GBps bandwidth

Standard performance uses HDD to store the data, therefore the costs are cheaper and performance is lower. Premium performance is backed by SSD arrays and therefore have a higher cost. Currently premium accounts can only use FileStorage accounts with ZRS storage in a limited number of regions.

You need to balance the availability and performance requirements to decide on the account and redundancy options. The finance company is more concerned with the security of their data than performance, and therefore they want the most redundancy possible. This makes the best choice a standard GZRS storage account.

### Choose your data migration solution

The finance company has existing systems, data, and file shares. This data needs to be migrated into Azure Files and therefore there's another decision you need to make. Because you can connect over SMB you have lots of options from writing your own custom utility to using Microsoft solutions. The following is a list of common utilities that already exist, making them quick to use if they are your choice.


|Utility  | Description  |
|---------|---------|
|AzCopy     | Command line tool offering the best performance, especially for low volume small files.  |
|Azure Storage Explorer     | Graphical tool         |
|Azure portal     |         |
|Azure File Sync     | Can be used to do the initial data transfer, and then uninstalled once the data is transferred.  |
|Azure Data Box     |         |


        - AzCopy
        - Azure Storage Explorer
        - Azure portal
        - Azure Data Box
        - In our scenario small files, low volumes will transfer with AzCopy in the exercise