# Integrate Azure Arc and Azure Stack HCI

## Learner roles

- Administrator
- Security engineer
- Solution architect
- Student
- Technology manager

## Learner level

- **Beginner**: Introductory and overview material that assumes little or no expertise with the topic. Its covers topic concepts, functions, features, and benefits.

## Products taught

- Azure Stack HCI
- Azure Arc
- Azure Resource Manager

## Prerequisites

To get the best learning experience from this module, you should have knowledge of:

- Windows Server Hyper-V
- Windows Server-based software-defined storage
- Windows Server-based software-defined networking
- Architecture and operating principles of Azure Stack HCI
- Azure Resource Manager

## Module summary description

This module introduces you to integration between Azure Arc and Azure Stack HCI, including its common use cases, implementation process, core capabilities, and their management.

## Subtasks in this module

- What is Azure Arc?
- Leverage Azure Arc to deploy Azure Stack HCI virtual machines (VMs).
- Leverage Azure Arc to provide centralized monitoring of Azure Stack HCI clusters.

## Lab exercise

None

## Module learning objectives

- Describe use cases and capabilities of integrating Azure Arc and Azure Stack HCI-based workloads.
- Describe Azure Resource Manager-based capabilities available to Azure Stack HCI workloads.
- Describe cloud-based monitoring of Azure Stack HCI and its workloads.

## Estimated module duration

30 minutes

## Module outline of units
<!--LM: The other modules include a numbered list of the unit headings here. Please consider adding this here and removing the next heading "number of units per module" and the number 5.-->
### Number of units per module

5

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 minutes

### Module scenario

Contoso, Ltd. is a midsize financial services company with its headquarters in London, England. It currently operates almost entirely on-premises. Much of its compute environment runs on the Windows Server platform, which includes virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, Contoso IT migrated some of its applications to Azure infrastructure as a service (IaaS) and platform as a service (PaaS) as part of datacenter consolidation and modernization initiatives. However, a number of highly regulated workloads must remain in the on-premises datacenters.

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first workload is a group of Microsoft SQL Server instances hosting transactional databases for the Contoso’s loan origination department. The second workload is a set of containerized securities research department apps running on a third-party Kubernetes cluster.

Contoso’s Chief Information Officer (CIO) will need to invest in additional hardware to implement these workloads. Before they invest, they want to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. They also want to make sure that the new implementation will provide a consistent management strategy that leverages existing IT skills and aligns with the way workloads running in Azure are administered.
<!--LM: I replaced "methodology" with "strategy". Please revert if it doesn't work here.-->
Given the hybrid nature of Contoso's environment, the CIO wants to explore emerging technologies that promise to bridge the gap between on-premises and cloud services. As Contoso's IT Engineering team leader, you've been asked to explore and evaluate how Contoso's capabilities can help streamline the provisioning, configuration, and maintenance of two workloads that must remain in its datacenter. With Azure Arc in public preview, you will need to determine the optimal approach that will satisfy technical and business requirements.

## Second unit: Characteristics and capabilities of Azure Arc

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 minutes

**Demonstration video:** Conceptual video illustrating Azure Stack HCI integration with Azure Resource Manager that leverages Azure Arc

### Key content per learning objective

Describe use cases and capabilities of integrating Azure Arc and Azure Stack HCI-based workloads. Topics include:

- Describe Azure Arc and its components.
- Describe integration of Azure Arc and Azure Stack HCI.
- Describe use cases of Azure Arc enabled Azure Stack HCI clusters.
- Describe capabilities of Azure Arc enabled Azure Stack HCI clusters.

## Third unit: Leverage Azure Arc to manage Azure Stack HCI-based virtualized workloads

**Type of unit:** Learning content unit

**Estimated unit duration:** 7 minutes

### Key content per learning objective

Describe Azure Resource Manager-based capabilities available to Azure Stack HCI workloads. Topics include:

- Leverage Azure Arc to deploy Azure Stack HCI VMs.
- Leverage Azure Arc to manage Azure Stack HCI VMs.

## Fourth unit: Leverage Azure Arc to monitor Azure Stack HCI clusters and their virtualized workloads

**Type of unit:** Learning content unit

**Estimated unit duration**: 7 minutes

### Key content per learning objective

Describe cloud-based monitoring of Azure Stack HCI and its workloads. Topics include:

- Describe cloud-based monitoring of Azure Stack HCI cluster.
- Describe cloud-based monitoring of Azure Stack HCI workloads.

## Fifth unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 minutes

### Resolution of module problem

Azure Arc allowed Contoso to optimize a hybrid management model and retain their critical, highly regulated workloads in on-premises datacenters.
