# Title

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

Azure provides a variety of disk storage options for virtual machine workloads. Identify the features of capabilities of each type to ensure your application performs optimally.

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

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    An organization is beginning a lift and shift migration to the cloud where many of their systems will be running on Azure virtual machines. These systems have a variety of usage and performance profiles, and they are unsure of the type disk storage available to them and which ones they should use for each workload. They need to balance performance, features, and cost to identify the right disk for each system.

1. **Managed, unmanaged, and local disk storage**

    List the content that will enable the learner to *subtask*:

    - Managed disks
        - What they are
        - How they work
        - When you use them
    - Unmanaged disks
        - What they are
        - How they work
        - When you use them
    - Local host disk storage (temp disk and ephemeral preview)
        - What they are
        - How they work
        - When you use them

    **Knowledge check**

    - Question 1
    - Question 2

1. **Disk types for virtual machines**

   Azure Managed Disks are the new and recommended disk storage offering for use with Azure virtual machines for persistent storage of data. They are billed on the provisioned size.

    For each disk type, discuss:

    - What it is
    - Performance and price characteristics
    - When to choose it

    Disk Types

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

    **Knowledge check**

    - Question 1
    - Question 2

1. **Select a disk type for your workload**

    - Scenario 1
        - Walk through a workload description that would require Ultra SSD
        - Explain the decision to select Ultra SSD and why this was chosen
    - Scenario 2
        - Walk through a workload description that would require Premium SSD
        - Explain the decision to select Premium SSD and why this was chosen
    - Scenario 3
        - Walk through a workload description that would require Standard SSD
        - Explain the decision to select Premium SSD and why this was chosen
    - Scenario 4
        - Walk through a workload description that would require Standard HDD
        - Explain the decision to select Standard HDD and why this was chosen

    Include some scenarios that the learner has to evaluate to determine the best type of disk storage. They should be able to define the differences between the disk types and select the one that best fits the use case, based on size, price, performance, etc.

    Identify the use cases for each type of disk storage

    - Ultra SSD
        - Critical workloads require enterprise-grade backup and recovery in the Azure cloud. Ideal if say the backup can be stored on Ultra SSD and reused to provision databases, so database Cloning using Ultra SSD
        - When you need sub-millisecond latency and extremely scalable performance. For your most demanding, data-intensive workloads. Specifically designed for applications such as MongoDB, PostgreSQL,  benefit from low queue depths and for high IOPS workloads such as SQL Server, SAP/HANA, and Oracle DB.
    - Premium SSD
        - for high-performance database workloads and other applications that require good storage performance
    - Standard SSD
        - for cost-effective and consistent performance, also be used for backup and archiving applications
        - Web servers, lightly used enterprise applications and dev/test
    - Standard HDD
        - Backup, non-critical, infrequent access

    **Knowledge check**

    - Question about the decision in scenario 1
    - Question about the decision in scenario 2
    - Question about the decision in scenario 3
    - Question about the decision in scenario 4

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

If there's value to it, consider including an exercise to deploy a VM or two with a particular disk requirement. Definitely include some scenarios that the learner has to evaluate to determine the best type of disk storage. We don't need to demonstrate rote memorization, but they should be able to define the differences between the disk types and select the one that best fits the use case, based on size, price, performance, etc.

Doc on different disk types - https://docs.microsoft.com/azure/virtual-machines/windows/disks-types

Should include coverage of:

- Ultra SSD (preview, but worth covering)
- Premium SSD
- Standard SSD
- Standard HDD
- Temporary disk
- Ephemeral OS disks (preview, but worth covering)
- Managed and unmanaged disks
