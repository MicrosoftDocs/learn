# Title

Protect your virtual machines with Azure Backup

## Role(s)

- Solution Architect
- Administrator

## Level

- Beginner

## Product(s)

- Azure Backup

## Prerequisites

- Basic knowledge of Azure virtual machines
- Basic knowledge of virtual machine disk storage

## Summary

Use Azure Backup to protect the data for on-premises servers, virtual machines, virtualized workloads, SQL server, Azure Files and more.

## Learning objectives

1. Identify the scenarios for which Azure Backup provides backup and restore capabilities
2. Backup and restore an Azure virtual machine

## Chunk your content into subtasks

Identify the subtasks of *Protect your virtual machines with Azure Backup*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify the different Azure Backup types  | Know the supported use cases for Azure Backup | Knowledge Check | 1 | Yes |
| Identify the different Azure Restore types | Know the supported types of Restore available | Knowledge Check | 1 | Yes |
| Backup a Virtual Machine within Azure | Demonstrates ability to Backup a VM | Exercise | 2 | Yes |
| Restore a Virtual Machine within Azure | Demonstrates ability to Restore a VM | Exercise | 2 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    An organization has several critical virtual machine workloads running on Azure. They need to be able to recover these virtual machines in the event of data loss or corruption. They would like to use the built-in capabilities of Azure Backup to protect these VMs.

1. **Azure Backup features and scenarios**

    List the content that will enable the learner to Identify the different Azure Backup types:

    - Azure Backup Types & Scenarios
        - Why use Azure Backup - List key benefits...
            - Offload On-Premises Backups
            - Backup Azure VM's in the easiest way
            - Scalabilty
        - List differences between Azure Backup and Azure Site Recovery, ASR is Disaster Recovery (Primary to Secondary replication), Backup is granular from file level up
            - ASR is for Disaster Recovery - usually Primary Site to Secondary Site Replication
            - Azure Backup is a granular level backup and restore method from the File level upwards
        - What Types of VM can be backed up
            - On Premises VM (Microsoft Azure Backup Recovery Service (M.A.R.S) Agent - Files/Folders & System State)
            - On Premises VM (Backup to DPM, anything protected by DPM/MAPS, Files/Folders/Shares/Volumes/App data)
            - Azure VM's (Azure Backup Agent - Backup entire VM)
            - Azure VM's (Microsoft Azure Recovery Services Agent (MARS) - Files/Folders & System State)
            - Azure VM's (Backup to DPM, anything protected by DPM - Files/Folders/Shares/Volumes\App data)

    Knowledge check

    What types of questions will test *Azure Backup Types and Scenarios*?

    - If you wanted to back up a whole VM within Azure, what would be the best Agent to use?
    - You have an On-Premise server at your local office that you wish to back up to Azure, what Agent would be used?
    - The Azure Backup Agent was used to backup a VM within Azure but a file level restore cannot take place, why is this?

1. **Backing up an Azure virtual machine**

    - Information about Backup Agents used and when to use them 
        - Backup whole VM - Azure Backup Agent
        - Backup specific Files/Folders - MARS Agent
        - Backup On-Premises Windows Machines - MARS Agent
        - Backup On-Premises Linux Machines - DPM or Microsoft Azure Backup Server (M.A.B.S) Agent
        - Backup On Premises Apps - DPM or MABS Agent
        - Most granular and flexible Backup and Recovery settings - MABS or DPM

1. **Exercise - Backing up an Azure virtual machine**

    List the steps which apply the learning content from previous unit:

    Question: Should the exercises should focus on a Windows VM or Linux? Or use pivot?

    Answer: Both if possible

    1. Ensure the Azure Backup Agent is running with your Virtual Machine, (Images from the Azure Marketplace have it as standard but Custom VM's will need it installed)
    1. Sign in to the Azure Portal and search for and select 'Virtual Machines'
    1. From the list Select the VM you wish to backup and from the VM Menu, click 'Backup'
    1. In the Recovery Services Vault, select an existing Vault, or Create a new Vault, specifying its name.
    1. Choose the Backup policy settings you require, Frequency, Retention Range, or leave the DefaultPolicy selected which is a Daily Backup at 16:00hrs, and a Retention Range of 30 day(s)
    1. Next, select 'Enable Backup' which associates the new or existing policy with your VM
    1. After the Job completes the Backup settings for the VM can be accessed from the VM menu by selecting the 'Backup' page.

1. **Restore Azure virtual machine data**

    List the content that will enable the learner to Identify the different Azure Restore types:

    - Azure restore Types & Scenarios
        - List the types of Restore available
            - Full Disk restore
            - Creation of a new VM from the restore point
            - Replace and existing disk
        - Cover example Scenarios you could use each option for
            - Full Disk
            - Creation of new VM
            - Replace an existing Disk (only if the machine is still in existence)

    Knowledge check

    What types of questions will test *Identify the different Azure restore types*?

    - Which Restore option would be best suited if you wanted to create new VM from an existing Restore Point?
    - You wish to replace the existing disk on a VM but get an error when you attempt this, why could this be? (Colleague has deleted the VM)

1. **Exercise - Restore Azure virtual machine data**

    List the steps which apply the learning content from previous unit:

    1. Ensure you have the correct Role Based Permission to complete the VM Restore Operation
    1. In the Recovery Services Vault associated with the VM you wish to restore, select 'Backup Items' - Azure Virtual Machine
    1. Select the VM you wish to restore, the VM Dashboard will contain recovery points from the last 30 days, this period can be altered by using the filter to sort by Dates and Time Ranges etc
    1. In the 'Restore Configuration' Window select the preferred restore option, that being either 'Create New' or 'Replace Existing'
    1. To Create New - Select a Virtual Machine name, select the 'Resource Group' it should be a member of, its Virtual Network and finally its Storage Location, the select 'Restore' to trigger the restore operation
    1. To Replace Existing - Rather than performing the above step, in the 'Restore Configuration' selection screen, select 'Replace Existing' , then select 'Replace disk(s), select the 'Staging Location' which is where Snapshots of the managed disks should be saved, the finally select 'Restore'

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
      - Identified the different types of Azure Backup and what options each one offers
      - Outlined scenarios when each may be used (File level restore required, backing up an On-Premise VM etc)
      - Identified the different types of Restore that could be performed once a successful backup was taken
      - Exercises to demonstrate the process of performing a VM Backup and then a subsequent VM/Disk and/or File Restore

## Notes

Details the features of Azure Backup to backup and restore Azure virtual machines. Discussion of the types of resources that can also be protected with backup (SQL, Azure Files, etc.). Exercise will protect and recover a VM with backup and restore.

Supporting documentation:

[Azure Backup architecture](https://docs.microsoft.com/azure/backup/backup-architecture?azure-portal=true)

[Restore Azure VMs in portal](https://docs.microsoft.com/azure/backup/backup-azure-arm-restore-vms?azure-portal=true)