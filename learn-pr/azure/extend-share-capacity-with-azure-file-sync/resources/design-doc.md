# Module design

## Title

Extend your on-premises file share capacity by using Azure File Sync

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure Files
- Azure File Sync

## Prerequisites

- Familiarity with Azure Files
- Basic knowledge of Windows Server file shares

## Summary

Evaluate requirements for Azure File Sync. Deploy the Storage Sync Service to replicate files from your Windows Server to the Azure file share. Test and troubleshoot file sync between the file shares.

## Learning objectives

1. Evaluate your servers compatibility with Azure File Sync
1. Deploy Azure File Sync
1. Test and troubleshoot file sync

## Chunk your content into subtasks

Identify the subtasks of *Extend your on-premises file share capacity by using Azure File Sync*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Azure File Sync? | Investigate how to extend your file share capacity  | Knowledge Check | 1 | Yes |
| Evaluate server compatibility | Investigate how to extend your file share capacity  | Exercise | 1 | Yes |
| Create file share in Azure | Extending your file share capacity using Azure | Exercise | 2 | No, Included with deploy storage sync subtask |
| Deploy storage sync | Extending your file share capacity using Azure | Exercise | 2 | No, Included with create file share in Azure subtask |
| Prepare the server | Extending your file share capacity using Azure | Exercise | 2 | Yes |
| Test the sync | Testing your file share using Azure | Knowledge Check | 3 | No, Included with the troubleshooting subtask |
| Troubleshoot the sync | Troubleshooting your file share capability | Knowledge Check | 3 | No, Included with the Test the sync subtask |

## Outline the units

1. **Introduction**

    You work as an administrator for an architecture firm that stores computer-aided design (CAD) files locally on a Windows Server file share. These CAD files are extremely large so your on-premises file share is nearly at capacity. Your organization needs quick access to the CAD files that are used most frequently. You can tolerate some network latency for the files that are used less frequently. You've been asked to investigate how you can extend your file share capacity by using Azure.

1. **What is Azure File Sync**

    - Overview of Azure File Sync
    - What is Azure File Sync
    - How does Azure File Sync work
    - Terminology used

    **Knowledge check**

    - How often is the cloud endpoint change detection job fired?
    - What is the Azure File Sync Agent?

1. **Check the readiness of your Windows Server for Azure File Sync**

    Prerequisites for Windows Server
    - Which Windows Server can run Azure File Sync
    - Which file systems are supported by Azure File Sync
    - Other considerations for using Azure File Sync

    Evaluating Windows Server compatibility
    - Using PowerShell to download the evaluation tools
    - Using the evaluation tools to assess viability of the Windows Server

1. **Exercise - Assess the readiness of Windows Server**

    1. From the server you wish to add to Azure File Sync (or Azure VM), log in
    1. Open a PowerShell terminal window
    1. Install PackageManagement and PowerShellGet
    1. Install the preview modules
    1. Invoke the evaluation tool to check system requirements
    1. Invoke the evaluation tool to check datasets
    1. Assess the results from the evaluation tool

1. **Set up Azure File Sync on Azure portal**

    Use Azure portal to define resources needed for Azure File Sync

    - Create a storage account on Azure
    - Configure the file share resource in Azure
    - Create and configure the sync storage resource in Azure
    - Deploy file sync storage on Azure
    - Create an Azure sync group on Azure

1. **Exercise - Create File Sync resources on Azure**

    1. Log in to your own Azure portal
    1. Create a storage account
    1. Create a file share resource
    1. Create and deploy a file sync resource
    1. Create an Azure sync group

1. **Set up Azure File Sync on Windows Server**

    Preparing your Windows Server
    - Setting Server Security
    - Assign Azure virtual data disk

    Installation of Azure PowerShell and Azure File Sync on Windows Server
    - Upgrade to Azure PowerShell and modules
    - Installing Azure File Sync Agent

    Registering Windows Server with Azure storage sync service

    Creating server endpoints in Azure portal

1. **Exercise - Configure File Sync tools on Windows Server**

    1. Return to your Windows Server or Azure VM
    1. Temporarily disable IE Enhanced Security Configuration
    1. Add any virtual disc(s) created in Azure
    1. Using PowerShell download the Azure PowerShell Module on to your Windows Server
    1. Deploy the Azure File Sync service on your Windows Server
    1. Download and install the Azure File Sync Agent onto your Windows Server
    1. Register your Windows Server with Azure File Sync service
    1. Create a sync group in Azure portal
    1. Assign the server end points in Azure
    1. Re-enable IE Enhanced Security Configuration

1. **Test and Troubleshoot Azure File Sync**

    Testing the Azure File Sync
    - Connecting to the Azure file Share
    - File transfers from Azure to Windows Server

    Troubleshooting Azure File Sync
    - Monitor the sync health in the Storage Sync Service
    - View event logs on a Windows Server
    - An overview of some of the more common File Sync concerns

1. **Exercise - troubleshoot Azure File Sync**

    1. CURL a folder that contains some files onto the Windows Server
    1. In the folder there is a file with unsupported characters in the name
    1. The file sync will have errors, use FileSyncErrorsReport.ps1 to identify the file
    1. Rename removing the invalid characters in the filename
    1. See the file sync successfully on Azure

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - You learned what Azure File Sync is and how to use it
    - You learned how to assess if your server is ready and compatible to by synchronized with Azure
    - You gained hands-on experience of configuring Azure to support Windows Servers using Azure File Sync
    - You setup and configured Azure File Sync on a Windows Server
    - You gained an understanding of how to troubleshoot Azure File Sync

## Notes

- Use an Azure virtual machine with Windows Server installed as the stand-in for an on-premises file share.
- What's in the subtask section is a rough draft. Please edit as needed for module design.
- There's a related module in the works for Azure Files: Store and share files in your application with Azure Files.
- PM mentioned that Storage Sync Service should be capitalized though that's not in the Cloud Style Guide (yet).

## Resources
Related links for Azure File Sync:
- https://learn.microsoft.com/azure/storage/files/storage-sync-files-planning
- https://learn.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide?tabs=azure-portal
- https://learn.microsoft.com/azure/storage/files/storage-sync-files-extend-servers
- https://learn.microsoft.com/azure/storage/files/storage-sync-files-troubleshoot

NOTES from design phase
- If we are going to provide a sandbox for the user to run this, it will need to have the following permissions: Create a VM, Create file storage, Create Azure File Sync
- In the original proposal, the testing and the troubleshooting were separate subtasks. However, after reviewing the material it felt they would be better combined.
- In the original proposal, the completion of testing and troubleshooting were an exercise. Troubleshooting is a tricky one to set up for an exercise as it requires a repeatable issue to be generated and fixed.  So I have changed it to a knowledge check. <- PS: I think there is a good exercise here, so changed.

## Sandbox requirements

Microsoft.Storage/storageAccounts
Microsoft.StorageSync/storageSyncServices
Microsoft.Compute/disks
Microsoft.Compute/virtualMachines
Microsoft.Network/networkInterfaces
Microsoft.Network/networkSecurityGroups
Microsoft.Network/publicIPAddresses
Microsoft.Network/virtualNetworks
Microsoft.Storage/storageAccounts
