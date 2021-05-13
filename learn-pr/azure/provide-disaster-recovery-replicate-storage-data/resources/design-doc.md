# Module design

## Title

Provide disaster recovery by replicating storage data across regions and failing over to secondary endpoint


## Role(s)

- Administrator

## Level

Beginner

## Product(s)

- Azure Storage 

## Prerequisites

- Basic knowledge of Azure Storage accounts and blob storage

## Summary

Evaluate and choose a redundancy option for Azure Storage. Create a storage account and blob container to demonstrate replication. Change the redundancy from ZRS to GZRS so data replicates across regions. Initiate storage account failover to the secondary region.

## Learning objectives

1. Identify redundancy options for Azure Storage
1. Configure Azure storage replication
1. Initiate storage account failover

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| 1. Review different replication strategies | you want to explore other redundancy options | Exercise | 1 | No 2,3 |
| 2. Review use cases for each | you want to explore other redundancy options | Exercise | 1 | No 1,3 |
| 3. Switch between replication strategies | you want to explore other redundancy options | Exercise | 2 | No 1, 2 |
| 4. Understand how to manual trigger a failover | practice a storage failover | Exercise | 3 | Yes |


## Outline the units

1. **Introduction**

  You're an administrator for a music streaming service.  Your organization uses Azure Blob Storage to store ~2 petabytes of audio file data. You're using zone-redundant storage (ZRS) to replicate the data across multiple availability zones in a single region. Uptime is obviously important to you and your users. If your audio files aren't available, you may lose subscribers to another service. You have a plan in place to recover from a zone failure. But you want to explore other redundancy options which protect from region-wide outage and practice a storage failover.

1. **Improve data redundancy of data in Blob Storage**

  - Review the different redundancy options
    - LRS, ZRS, GRS/RA-GRS, GZRS/RA-GZRS
    - List paired groups, and what regions GZRS/RA-GZRS is available in
  - Review scenarios for each option
    - Number of data copies
    - Use case
  - Switching replication strategies
    - ZRS to GZRS with portal, CLI (`az storage account update -sku Standard_GZRS`) , or PowerShell (`Set-AzStorageAccount -SkuName "Standard_GZRS"`)
    - Manually copy data to the new strategy for LRS, GRS, or RA-GRS
    - Live migration, request to Azure Support

1. **Exercise - Improve data redundancy of data in Blob Storage**

    1. Create storage account pick ZRS
    1. Create Blob container
    1. Use script to create Blob data
    1. Upload data
    1. View data
    1. Change the replication mode on the Azure storage account (to GZRS) with the portal
    1. View the replication status of your storage account

1. **Test data redundancy of data in Blob Storage**

  - Prerequisites
    - Register for the preview with Azure CLI
  - Process
    - Understand potential data loss, using the Last Sync Time (using CLI and PowerShell)
    - Fail over to LRS storage in secondary region, it then becomes primary (using CLI, PowerShell, and portal)
    - Re-enable GRS to create a new secondary region (using CLI, PowerShell, and portal)
  - How to track outages
  - Microsoft-managed failover

1. **Exercise - Test data redundancy of data in Blob Storage**

    1. Create GRS storage account with CLI
    1. Create Blob container, copy data from ZRS with CLI
    1. Check Last Sync Time
    1. On the portal, select Prepare for failover (preview)
    1. On completion, change the storage account from LRS to GRS.
    1. Check data - check Last Sync Time.

1. **Summary**

  - Restate the scenario
  - Show how GZRS solves the problems in the scenario
  - Describe the experience without GZRS
  - Describe te business impact of using GZRS

## Notes

- Learn: Redundancy options 
  - What are they
  - When to use what
  - How they're configured
  - See module/reuse content in: [Make your application storage highly available with read-access geo-redundant storage](https://docs.microsoft.com/learn/modules/ha-application-storage-with-grs/)
  - Cover new options (currently in preview): GZRS and RA-GZRS 
- Exercise: Set up storage account and change replication mode
  - Create storage account pick ZRS
  - Create Blob container
  - Use script to create Blob data
  - Upload data
  - View data
  - Change the replication mode on the Azure storage account (to GZRS)
  - View the replication status of your storage account
- Learn: Understand the storage account fail over process
  - Process 
  - Most likely customers will want to fail over programmatically. So we should cover how to do that in CLI or  PowerShell.
  - Check last sync time via CLI, PowerShell, and portal
  - How to track outages
- Exercise: Initiate an account failover
  - Check last sync time (to determine amount of data loss)
  - Fail over: For steps, see [Initiate a storage account failover (preview)](https://docs.microsoft.com/en-us/azure/storage/common/storage-initiate-account-failover)
  - Most likely customers will want to failover programmatically. But portal has more info, so thinking we should do exercise in portal.
  - Verify it failed over. Check the data.

## Resources

- [Make your application storage highly available with read-access geo-redundant storage](https://docs.microsoft.com/learn/modules/ha-application-storage-with-grs/)
- [Azure Storage redundancy](https://docs.microsoft.com/azure/storage/common/storage-redundancy)  
- [Build highly available Azure Storage applications with geo-zone-redundant storage (GZRS)](https://docs.microsoft.com/azure/storage/common/storage-redundancy-gzrs?toc=%2fazure%2fstorage%2fblobs%2ftoc.json)
- [Disaster recovery and storage account failover (preview) in Azure Storage](https://docs.microsoft.com/azure/storage/common/storage-disaster-recovery-guidance?toc=%2fazure%2fstorage%2fblobs%2ftoc.json)  
- [Initiate a storage account failover (preview)](https://docs.microsoft.com/azure/storage/common/storage-initiate-account-failover#azure-portal)
- [Create a storage account](https://docs.microsoft.com/azure/storage/common/storage-quickstart-create-account?tabs=azure-portal)
- [Quickstart: Upload, download, and list blobs with the Azure portal](https://docs.microsoft.com/azure/storage/blobs/storage-quickstart-blobs-portal)


## IMPORTANT

Sandbox is going to need to have this feature manual failover pre-approved:

```powershell
Register-AzProviderFeature -FeatureName CustomerControlledFailover -ProviderNamespace Microsoft.Storage
```