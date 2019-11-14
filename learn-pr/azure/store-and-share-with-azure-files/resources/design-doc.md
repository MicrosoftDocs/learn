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
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

1. **Introduction**

    A financial company is moving an application to Azure that generates reports and data exports for users and other systems to consume. These reports and data exports are currently stored on both NAS devices and Windows file shares, so they can easily be shared between systems. They would like to consolidate the storage for these files to a native cloud service, while still leveraging SMB to access the files.

1. **Plan your Azure Files deployment**

    - Choosing your data access method
        - Direct cloud access - mounted SMB share
        - Azure File Sync, checking compatibility and cloud tiering
    - Choosing your share performance
    - Choosing your redundancy option

    **Knowledge check**

1. **Deploy Azure Files using direct cloud access**

    

1. **Exercise - deploy Azure Files using direct cloud access**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Deploy Azure File Sync**

    - Evaluate whether it is compatible with your system using the Azure File Sync (Evaluation cmdlet)
    - 

1. **Exercise - deploy Azure File Sync**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**

    - Restate the scenario problem(s)
    - Show how you solved the scenario problem(s)
    - Describe the experience without the product
    - Describe the business impact

## Notes

Reference links: 
- [Tutorial: Extend Windows file servers with Azure File Sync](https://docs.microsoft.com/en-us/azure/storage/files/storage-sync-files-extend-servers)
- [Data access method](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-planning#data-access-method)