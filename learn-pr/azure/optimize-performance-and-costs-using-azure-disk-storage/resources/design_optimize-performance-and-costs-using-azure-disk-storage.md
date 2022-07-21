Module title: Optimize performance and costs using Azure Disk Storage 

# Learner roles

·    Administrator

·    Developer

·    DevOps engineer

·    Data Engineer

·    Solution Architect

# Learner level

·    **Beginner:** Introductory and overview material that assumes little or no expertise with the topic and that details concepts, functions, features, and benefits of using Azure Disk Storage.

# Product(s) taught

·    Azure Disk Storage

# Prerequisites

To get the best learning experience from this module, you should have:

·    Basic knowledge of Azure Disk Storage.

·    Basic knowledge of Azure virtual machines (VMs).

·    Experience navigating the Azure portal.

# Module topic statement

Microsoft Azure Disk Storage offers a range of disk types and capabilities that enable you to optimize application performance and costs in specific scenarios.

# Subtasks in this module

·    Understand how disk performance works.

·    Identify Azure Disk Storage capabilities.

# Exercise

·    Exercise title: Change the disk performance tier

o  Create an Azure disk.

o  Change the disk’s performance tier.

# Module learning objectives

After completing this module, you should know more about:

·    The disk types available in Azure.

·    How disk performance works.

·    Performance-scaling options.

# Estimate module duration

41 minutes

# Module outline of units

## Summary of units

\1.   Introduction

\2.   Choose the right Azure Disk Storage option

\3.   Understanding disk performance characteristics

\4.   Optimize performance and costs using performance-scaling options

\5.   Exercise unit

\6.   Knowledge Check 

\7.   Summary

## Unit descriptions

### First unit: Introduction

**Type of unit:** Introduction unit

**Estimate unit duration:** 3 minutes

#### Module scenario

Most organizations have diverse requirements for their cloud-hosted data. Data often is of different types and sizes, and no single storage solution meets all requirements. Suppose you work for a medium-size financial services company. Your Chief Technology Officer (CTO) wants to migrate several applications, databases, and support files to the cloud. This will reduce the number of physical servers that your company maintains in their datacenter. As part of your migration strategy, you must determine a suitable approach for your cloud-based storage infrastructure.

A primary concern in a migration strategy is how to move enterprise applications that require high-performance storage, such as SAP HANA and many SQL databases. Some application workloads run periodic batch jobs. These demand higher performance for short periods, but otherwise experience baseline performance most of the time.

You’ve must evaluate Azure Disk Storage types and capabilities and propose a storage solution that optimizes performance and costs for applications that require high storage.

### Second unit: Choose the right Azure Disk Storage option

**Type of unit:** Learning content unit

**Estimate unit duration:** 8 minutes

##### Learning objective targeted

After completing this unit, you should know more about:

·    The disk types available in Azure.

##### Key content per learning objective

·    Describe the following disk types:

o  Ultra SSDs.

o  Premium SSDs.

o  Standard SSDs.

o  Standard hard disk drives.

·    Include performance specs for each disk type.

·    Highlight the pricing and provisioning models. 

·    Details how some SKUs have transaction costs, but no need to discuss exact pricing. 

·    Explain that the ultra-disk provisioning model is different.

### Third unit: Understanding disk performance characteristics 

**Type of unit:** Learning content unit

**Estimate unit duration:** 10 minutes

##### Learning objective targeted

After completing this unit, you should know more about:

·    Disk performance characteristics.

##### Key content per learning objective

·    Describe the relationship between I/O operations per second (IOPS), throughput, and latency.

·    Describe disk and virtual machine I/O capping.

·    Describe caching.

### Fourth unit: Optimize performance and costs using performance-scaling options 

**Type of unit:** Learning content unit

**Estimate unit duration:** 5 minutes

##### Learning objective targeted

After completing this unit, you should know more about:

·    Performance-scaling options.

##### Key content per learning objective

·    Understand different performance-scaling options, including how they work and the benefits they provide.

·    Understand when you would want to use a specific option (planned versus unplanned scenarios, short-term versus long-term duration, and similar).

·    Describe how disk bursting, performance tiers, and dynamic scaling on Ultra Disk Storage work.

·    Identify use-case scenarios and workloads for each option.

### Fifth unit: Exercise: Change the disk performance tier

**Type of unit:** Exercise unit

**Estimate unit duration:** 10 minutes

##### Learning objective(s) targeted

·    Describe how the different performance-scaling options work

##### Exercise steps

\1.   Create an Azure disk.

\2.   Change the disk’s performance tier.

### Sixth unit: Knowledge check

**Type of unit:** Knowledge check unit

**Estimate unit duration:** 3 minutes

### Seventh unit: Summary

**Type of unit:** Summary unit

**Estimate unit duration:** 2 minutes

##### Resolution of module problem

In this unit, you learned how Azure Disk Storage provides block storage that’s scalable, highly available, and easy to set up with limited administrative effort. You also learned about different disk types and capabilities that you can use to optimize performance and costs.

Selecting the appropriate disk type and right performance-scaling option can significantly impact your applications’ performance, availability, and running costs.

# Additional learning links

·    [What disk types are available in Azure?](/azure/virtual-machines/disks-types)

·    [Virtual machine and disk performance - Azure Virtual Machines | Microsoft Docs](/azure/virtual-machines/disks-performance)

·    [Managed disk bursting - Azure Virtual Machines | Microsoft Docs](/azure/virtual-machines/disk-bursting)

·    [Performance tiers for Azure managed disks - Azure Virtual Machines | Microsoft Docs](/azure/virtual-machines/disks-change-performance)

 
