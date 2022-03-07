Module title: Run clustered applications on Azure with shared disks

# Learner roles

- Administrator
- Developer
- DevOps engineer
- Data Engineer
- Security Engineer

# Learner level

- **Intermediate**: Material that assumes some knowledge of the topic, but which doesn’t require in-depth understanding of it. Material provides a detailed overview of a topic's subareas.

# Product(s) taught

- Microsoft Azure Disk Storage

# Prerequisites

To get the best learning experience from this module, you should have:

- Basic knowledge of Azure Disk Storage.
- Basic knowledge of Azure virtual machines (VMs).
- Experience using the Azure portal.

# Module topic statement

Providing high availability for clustered applications is an important requirement for most organizations. Microsoft Azure shared disks helps you do that by enabling you to run clustered or high-availability applications on Azure. 

# Subtasks in this module

- Identify use-case scenarios for Azure shared disks.
- Deploy clustered VMs by using Azure shared disks.

# Exercise

- Exercise – Deploy clustered VMs by using Azure shared disks:

   - Create Azure shared disks.
   - Create a proximity placement group.
   - Create two VMs.
   - Initialize Azure Shared Disks in the VMs.
   - Run SCSI persistent reservation (PR) commands against shared disks.

# Module learning objectives

After completing this module, you should know more about: 

- Azure shared disks.
- Using Azure shared disks with VMs.
- Benefits and limitations of Azure shared disks.

# Estimate module duration

43 minutes

# Module outline of units

## Summary of units

1.   Introduction 

2.   Define Azure shared disks

3.   Create and use Azure shared disks

4.   Identify benefits and limitations of Azure shared disks

5.   Exercise unit

6.   Knowledge Check 

7.   Summary 

## Unit descriptions

### First unit: Introduction

Type of unit: Introduction unit

Estimate unit duration: 3 minutes

#### Module scenario

Most organizations have diverse requirements for their cloud-hosted data. These might include storing data in a specific region or requiring separate billing for different data categories. 

Suppose that you work at a medium-size financial services company. Your company uses Azure services extensively, and your development team is creating architectures for new applications. Your Chief Technology Officer (CTO) wants to migrate several applications, databases, and support files to the cloud. This will reduce the number of physical servers your company maintains in your datacenter. As part of your migration strategy, you must decide the best approach for your cloud-based storage infrastructure.



Your CTO’s primary concern is the enterprise applications that’ll be harder to migrate. These include clustered databases, parallel file systems, and distributed applications  running in your on-premises SAN that require  shared block storage.

You must evaluate the functionality of Azure shared disks as a solution that’ll enable your organization to migrate clustered applications in Azure. 

### Second unit: Define Azure shared disks

Type of unit: Learning content unit

Estimate unit duration: 10 minutes

Learning objective targeted

After completing this unit, you should know more about:

- Azure shared disks.



Key content per learning objective

- Describe the features of Azure shared disks.

- Identify usage scenarios and workloads for Azure shared disks.

- Describe Windows and Linux clustering scenarios.

### Third unit: Create and use Azure shared disks  

Type of unit: Learning content unit

Estimate unit duration: 5 minutes

##### Learning objective targeted

After completing this unit, you should know more about:

- Using Azure shared disks with VMs.

##### Key content per learning objective

- Describe how to create an Azure shared disk.

- Describe how to use Azure shared disks with VMs.

### Fourth unit: Benefits and limitations of Azure shared disks

Type of unit: Learning content unit

Estimate unit duration: 5 minutes

##### Learning objective targeted

After completing this unit, you should know more about:

- The benefits and limitations of Azure shared disks.

##### Key content per learning objective

- Describe the advantages of using Azure shared disks:

   - Explain that zone redundant storage (currently in preview) is also available for shared disks.

- Describe current limitations of using Azure shared disks.

### Fifth unit: Exercise: Deploy clustered VMs by using Azure shared disks

Type of unit: Exercise unit

Estimate unit duration: 15 minutes

##### Learning objective targeted

After completing this unit, you should know more about:

- Using Azure shared disks with virtual machines.

##### Key content per learning objective

1.   Create Azure shared disks.

2.   Create a Proximity Group.

3.   Create two VMs.

4.   Initialize/Mount Azure shared disks in VMs.

5.   Run SCSI PR commands against shared disks.

### Sixth unit: Knowledge check

Type of unit: Knowledge check unit

Estimate unit duration: 3 minutes

### Seventh unit: Summary

Type of unit: Summary unit

Estimate unit duration: 2 minutes

##### Resolution of module problem

Your organization can use Azure shared disks to migrate existing clustered or distributed applications from your on-premises environment to the cloud. 

You’ll benefit from shared access to high performance block storage with Ultra Disk and Premium SSDs and consistent sub-ms latency of Ultra Disk Storage for your most demanding workloads. Shared disk simplifies your ability to run clusters on Azure  offering a  balance of price and performance.

In this module, you learned about Azure shared disks and their benefits. You also learned how to create Azure Shared Disks and use them to deploy clustered VMs.

### Additional learning links

- [Create an FCI with Azure shared disks - SQL Server on Azure VM | Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-azure-shared-disks-manually-configure?tabs=windows2012)

- [Cluster an SAP ASCS/SCS instance on a Windows failover cluster by using a cluster shared disk in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk)

- [Enabled shared disk](https://docs.microsoft.com/en-us/azure/virtual-machines/disks-shared-enable?tabs=azure-cli)

- [Share an Azure managed disk](https://docs.microsoft.com/en-us/azure/virtual-machines/disks-shared)

- [Managed Disks pricing](https://azure.microsoft.com/pricing/details/managed-disks/)
