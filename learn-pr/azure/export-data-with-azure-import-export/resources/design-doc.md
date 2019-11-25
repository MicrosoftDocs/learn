# Module design

## Title

Export large amounts of data from Azure by using Azure Import/Export

## Role(s)

Administrator

## Level

Beginner

## Product(s)

- Azure Import/Export
- Azure Storage
- Azure Blobs

## Prerequisites

Familiarity with Azure Storage and Azure Blobs

## Summary

Evaluate Azure Import/Export to copy data from Azure Blob storage to an on-premises server. Create an export job in your Azure storage account. Get the BitLocker keys to unlock the drives that you receive.

## Learning objectives

1. Decide whether to use Azure Import/Export
1. Identify the steps to export data from Azure

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe Azure Import/Export | Explains what the service is | Knowledge Check | 1 | Yes |
| Describe how to import/export data with Azure Import/Export | Explains how to import/export data | Knowledge check | 2 | Yes |
| Describe when to use Azure Import/Export | Describes scenarios for using Azure Import/Export | Knowledge check | 1 | Yes |

## Outline the units

1. **Introduction**

    You're an administrator for a film production company that has 200 TBs of film footage archived in Azure Blob storage. Your company is planning to re-release the film with some new footage that's in the archive. You've been asked to get a copy of the film footage so the producers can work on the film locally.

1. **What is Azure Import/Export?**

    - Describe the Azure Import / Export service
       - What can the service be used for?  
         - Uploading large amounts of data from on-premise to Azure blobs
         - Exporting data out of Azure Blobs
         - Importing data into Azure files.
  
    - Summarize the purpose of the WAImportExport tool (details in Unit 2)

    - Discuss security considerations when importing or exporting data
        - How to ensure that the data will not be compromised? Summarize encryption options (AES-128 bitlocker encryption by default, but can be upgraded to AES 256. See [Does Azure Import/Export suppoer AES-256 encryption](https://docs.microsoft.com/azure/storage/common/storage-import-export-service-faq?toc=%2fazure%2fstorage%2fblobs%2ftoc.json#does-azure-importexport-support-aes-256-encryption))

1. **How Azure Import/Export works**

   - Describe the steps required to import or export data to/from Azure Blob storage
       - Add a diagram to help explain the process
       - What are the prerequisites for being able to import data or export data from Blob storage
       - What Azure services are required to be in place for this function to work

   - List the requirements for the Import/Export System
        - What software or features does the import/export service require or support for the process to work
  
   - What is an import/export job
        - Why do you need the import/export job?
        - What will the import/export job look at when dealing with data migration?

   - Using the WAImportExport tool
        - What is this tool used for?  
        - Where can it be obtained from?
        - Bitlocker considerations:
            - Explain how to provide Bitlocker keys with an export job
            - Explain how to obtain the Bitlocker keys to unlock drives received as part of an import job

1. **When to use Azure Import/Export**

   - Describe the general use cases for the import and export service (Data migration to the cloud, content distribution, backup/recovery)

   - Contrast with other tools, such as AzCopy and Azure Data Box family.
      - Is this the best tool for a company to use to export large amounts of data out of Azure blobs to use locally on-premise?
        - Summarize factors to consider, such as network bandwidth, connectivity (online vs offline) frequency of jobs, amounts of data (see [Choose an Azure solution for data transfer](https://docs.microsoft.com/azure/storage/common/storage-choose-data-transfer-solution?toc=%2fazure%2fstorage%2fblobs%2ftoc.json)).
        - Briefy compare scenarios for using Import/Export to Data Box family (see [Comparison of key capabilities](https://docs.microsoft.com/azure/storage/common/storage-solution-large-dataset-low-network?toc=%2fazure%2fstorage%2fblobs%2ftoc.json#comparison-of-key-capabilities))

        > [!NOTE]
        > Azure Data Box family is the recommended solution for performing very large import jobs when the organization is within a region where Data Box is supported. It's an easier process. Azure Data Box family doesn't support export from Azure.

   - Limitations of Azure Import/Export
2. **Knowledge check**

    - What is the Azure Import/Export service?
    - What are the Import/Export system requirements?
    - When should you use Azure Import/Export rather than AzCopy (or vice versa)?
    - When should you use Azure Import/Export rather than Azure DataBox family?

3. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

   - Learned about Azure Import/Export Service
   - Learned what the Import/Export service can be used for
   - Learned how to create jobs to import or export data

## Notes

- This module won't be able to use the Sandbox. So assessment would be with the knowledge checks. 
- Module should also mention, as part of introduction of Azure Import/Export service, that you can import to Azure as well. But Azure Data Box family is the recommended solution for import where the organization is within a region where Data Box is supported. It's an easier process. Data Box doesn't support export from Azure.
- Process to export could use an illustration. There's an existing one in the docs, but it needs a refresh.

## Resources

- [What is Azure Import/Export service?](https://docs.microsoft.com/azure/storage/common/storage-import-export-service)
- [Azure Import/Export requirements](https://docs.microsoft.com/azure/storage/common/storage-import-export-requirements)
- [Use the Azure Import/Export service to import data to Azure Blob Storage](https://docs.microsoft.com/azure/storage/common/storage-import-export-data-to-blobs?)
- [Choose an Azure solution for data transfer](https://docs.microsoft.com/azure/storage/common/storage-choose-data-transfer-solution?toc=%2fazure%2fstorage%2fblobs%2ftoc.json)
- [Scenarios: Data transfer for large datasets with moderate to high network bandwidth](https://docs.microsoft.com/azure/storage/common/storage-solution-large-dataset-moderate-high-network)
- [Pricing](https://azure.microsoft.com/en-ca/pricing/details/storage-import-export/)
- Related service: [What is Azure Data Box?](https://docs.microsoft.com/azure/databox/data-box-overview)