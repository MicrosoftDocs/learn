## Title

Choose the right disk storage for your virtual machine workload

## Role(s)

- Solution Architect
- Administrator

## Level

- Beginner

## Product(s)

- Azure virtual machines
- Azure disk storage

## Prerequisites

- Basic knowledge of Azure disk storage
- Basic knowledge of Azure virtual machines and virtual machine types  

## Summary

*Add the summary [(Guidance)](id-guidance-introductory-summaries.md)*

## Learning objectives

1. Identify the types of disk storage available to virtual machines
1. Identify the capabilities of different disk storage
1. Identify the use cases for each type of disk storage

## Chunk your content into subtasks

Identify the subtasks of *Choose the right disk storage for your virtual machine workload*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify the types of disk storage available to virtual machines | organization unsure of the type disk storage available | Knowledge check | 1 | Yes |
| Identify the capabilities of different disk storage |  organization to identify the right disk for each system | Knowledge check | 2 | Yes |
| Identify the use cases for each type of disk storage | They need to balance performance, features, and cost to identify the right disk for each system | Knowledge check | 3 | Yes |
| Deploy a VM with a particular type of disk | Systems will be running on Azure virtual machines | Exercise | Not an objective, but suggested in the notes. | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    An organization is beginning a lift and shift migration to the cloud where many of their systems will be running on Azure virtual machines. These systems have a variety of usage and performance profiles, and they are unsure of the type disk storage available to them and which ones they should use for each workload. They need to balance performance, features, and cost to identify the right disk for each system.

1. **Identify the types of disk storage available to virtual machines**

    List the content that will enable the learner to *subtask*:

    - Managed and unmanaged disks ( are virtual hard disks (VHD)). You can think of it like a physical disk in an on-premises server but, virtualized
      - Benefits
      - Encryption
      - Disk roles
      - Managed disk snapshots
      - Disk allocation and performance

    Azure managed disks currently offers four disk types, three of which are generally available (GA) and one that is currently in preview. These four disk types each have their own appropriate target customer scenarios

    - Ultra SSD (preview) - fastest disk (160000 IOPS)
    - Premium SSD - Premium Storage tier only supports storage for virtual machines that require low latency and intensive I/O operations
        - Disk size - In order to use Premium Storage disks, you must choose a virtual machine series that supports this kind of storage
    - Standard SSD
        - Azure standard SSDs are a cost-effective storage option optimized for workloads that need consistent performance at lower IOPS levels
    - Standard HDD
        - Azure standard HDDs deliver reliable, low-cost disk support for VMs running latency-insensitive workloads

    - Unmanaged disks, Microsoft Azure unmanaged disk is a Microsoft-managed cloud service that provides storage that is highly available, secure, durable, scalable, and redundant. Unmanaged disk consists of three data services: Blob storage, File storage, and Queue storage

    Major differences between Managed and Unmanaged:
       - Both have selection of Premium or Standard options for types of disks
       - Unmanaged have account limits, admin overheads when multiple storage accounts
       - Managed adv - seamless upgrades, ability to separate storage units

    Also in preview - Ephemeral OS disks are created on the local host storage and not persisted to the remote Azure Storage

    **Knowledge check**

    - What are the different disk types?
    - What is Azure Storage accounts or unmanaged disks?

1. **Identify the capabilities of different disk storage**

   Azure Managed Disks are the new and recommended disk storage offering for use with Azure virtual machines for persistent storage of data. They are billed on the provisioned size.

   (Maybe better to be represented as a table)

    - Ultra SSD (preview)
        - Disk capacity
            - performance with lower latency
        - Disk size, Disk IOPS
        - IOPS/Throughput per disk
        - Managed disk size/Costs
    - Premium SSD
        - Disk size - In order to use Premium Storage disks, you must choose a virtual machine series that supports this kind of storage
        - IOPS/Throughput per disk
        - Managed disk size/Costs
    - Standard SSD
        - Disk size
        - IOPS/Throughput per disk
        - Managed disk size
    - Standard HDD - Managed Disks can also be used for backup and archiving applications
        - Azure standard HDDs deliver reliable, low-cost disk support for VMs running latency-insensitive workloads
        
        - Disk size
        
   - IOPS/Throughput per disk
     
        - Managed disk size/Costs
        
          
          

1. **Identify the use cases for each type of disk storage**

    Include some scenarios that the learner has to evaluate to determine the best type of disk storage. They should be able to define the differences between the disk types and select the one that best fits the use case, based on size, price, performance, etc.

    Identify the use cases for each type of disk storage

    Ultra SSD

    - Critical workloads require enterprise-grade backup and recovery in the Azure cloud. Ideal if say the backup can be stored on Ultra SSD and reused to provision databases, so database Cloning using Ultra SSD
    - When you need sub-millisecond latency and extremely scalable performance. For your most demanding, data-intensive workloads. Specifically designed for applications such as MongoDB, PostgreSQL,  benefit from low queue depths and for high IOPS workloads such as SQL Server, SAP/HANA, and Oracle DB.
    
    Premium SSD

     - for high-performance database workloads and other applications that require good storage performance

    Standard SSD

    - for cost-effective and consistent performance, also be used for backup and archiving applications
    - Web servers, lightly used enterprise applications and dev/test
    
    Standard HDD

       - Backup, non-critical, infrequent access

    

    **Knowledge check**

    - What would be an appropriate disk for a given scenario A?
    - What would be an appropriate disk for a given scenario B?
    
1. **Exercise - Deploy a VM with a particular disk requirement**

    In this exercise, we'll deploy a VM with a particular disk requirement and adjust the performance

    

    1. Launch cloud shell, using sandbox
    1. Run the following CLI command to create an ultra enabled VM

    ```azurecli
          az vm create
        -n $vmname -g --resource-group <rgn>[sandbox resource group name]</rgn>
        --image Win2016Datacenter 
        --ultra-ssd-enabled
        --zone $zone
        --authentication-type password
        --admin-password $password
        --admin-username $user
        --attach-data-disks $diskname
        --size Standard_D4s_v3
        --location <location>
    ```

    1. Create an ultra SSD by running the following using CLI

    ```azurecli
         location <location>
        rgname="ultraRG"
        diskname="ssd1"
        vmname="ultravm1"
        zone=123
    
        #create an Ultra SSD disk
        az disk create
        -n $diskname
        -g $rgname
        --size-gb 4
        --location <location>
        --zone $zone
        --sku UltraSSD_LRS
        --disk-iops-read-write 1000
        --disk-mbps-read-write 50
    ```

    1. Adjust the performance of an ultra SSD

     ```azurecli
        az disk update
        --resource-group <rgn>[sandbox resource group name]</rgn>
        --name $diskName
        --set diskIopsReadWrite=80000
        --set diskMbpsReadWrite=800
     ```

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

If there's value to it, consider including an exercise to deploy a VM or two with a particular disk requirement. Definitely include some scenarios that the learner has to evaluate to determine the best type of disk storage. We don't need to demonstrate rote memorization, but they should be able to define the differences between the disk types and select the one that best fits the use case, based on size, price, performance, etc.

Doc on different disk types - https://docs.microsoft.com/en-us/azure/virtual-machines/windows/disks-types

Should include coverage of:

- Ultra SSD (preview, but worth covering)
- Premium SSD
- Standard SSD
- Standard HDD
- Temporary disk
- Ephemeral OS disks (preview, but worth covering)
- Managed and unmanaged disks
