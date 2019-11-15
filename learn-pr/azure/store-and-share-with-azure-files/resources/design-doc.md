# Title

Store and share files in your application with Azure Files

## Role(s)

- Solution Architect
- Administrator

## Level

- Beginner

## Product(s)

- Azure Files

## Prerequisites

- Knowledge of Windows Server file shares

## Summary

Azure Files provides a cloud-based file share for storing and sharing files to applications. Whether it's an application hosted in Azure App Service, an Azure VM, or an on-premises app, Azure Files can store and share file access between one or more applications and systems in a secure and failure resilient manner.

## Learning objectives

1. Identify the features and use cases for Azure Files
1. Configure Azure Files for use on a server
1. Identify how to secure Azure Files deployments

## Chunk your content into subtasks

Identify the subtasks of *Store and share files in your application with Azure Files*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Explore File Share options | TODO | KC | 1 | Yes |
| Moving data into Azure Files | TODO | Exercise | 1,2 | No, 1 |
| Create Storage account and Azure Files | TODO | Exercise | 2 | Yes |
| Securing access over SMB | TODO | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    A financial company is moving an application to Azure that generates reports and data exports for users and other systems to consume. These reports and data exports are currently stored on both NAS devices and Windows file shares, so they can easily be shared between systems. They would like to consolidate the storage for these files to a native cloud service, while still leveraging SMB to access the files.

1. **Plan your Azure Files deployment**

    - What is Azure Files?
        - Replace internal file shares and NAS devices
        - Simplify cloud development
        - Fully managed
        - Resiliency
    - Choosing your data access method
        - Is SMB and a REST API the only access you need? (Direct access is ok, Azure File Sync if you need FTPS, NFS etc)
        - Where does your workload run? (Do you have on premises with poor internet connectivity, Azure File Sync, or is it running on Azure?)
        - How much granularity do you need in your ACL? (Most granular supported by Azure File Sync)
        - In our scenario Direct Access (Azure Files mapped over SMB) is the best option and will be used in the exercise
    - Choosing your redundancy option
        - What kind of storage account do you need?
        - LRS, ZRS, GRS, RA-GRS, GZRS, or RA-GZRS
    - Choosing your data migration solution
        - AzCopy
        - Azure Storage Explorer
        - Azure portal
        - Azure Data Box
        - In our scenario small files, low volumes will transfer with AzCopy in the exercise

    **Knowledge check**

    1. Use a scenario and ask which is the best way to access Direct or through Azure File Sync.
    1. Use a scenario and ask what level of redundancy is the best option.
    1. Use a scenario and ask which is the best data transfer solution.

1. **Create Azure Files account and connect over SMB**

    - Creating a storage account using Azure CLI
        - What are the parameters?
        - Which options should we use for our scenario
    - Create a file share
    - Create an SMB share
        - Can't use Kerberos authentication, use the storage account key
        - Persist credentials with cmdkey

1. **Exercise - create Azure Files account and connect over SMB**

    1. Create a Windows 2019 Data Center VM
    1. Create storage account
    1. Create file share
    1. Connect to VM, create mapped drive over SMB

1. **Secure access to files stored on Azure Files**

    - Secure access from on-premises
        - Open port 445
        - Remove SMB 1.0
        - Limit access with firewall to public IP address ranges
    - Enable Secure transfer required
    - Enable Azure AD DS authentication
        - Discuss exceptions

1. **Exercise - secure access to files stored on Azure Files**

    1. Enable secure transfer required
    1. Add firewall rules to block IP address
    1. Test trying to access, update rules
    1. Use AzCopy to export local files (git clone) to file share
    1. Change a file, create a snapshot on the portal
    1. View the snapshot on the VM

1. **Summary**

    - Restate the scenario problem(s)
    - Show how you solved the scenario problem(s)
    - Describe the experience without the product
    - Describe the business impact

## Notes

Reference links: 
- [Tutorial: Extend Windows file servers with Azure File Sync](https://docs.microsoft.com/en-us/azure/storage/files/storage-sync-files-extend-servers)
- [Data access method](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-planning#data-access-method)
- [Quickstart: Create and manage Azure Files share with Windows virtual machines](https://docs.microsoft.com/en-gb/azure/storage/files/storage-files-quick-create-use-windows#create-a-share-snapshot)