# Integrate Azure Arc and Azure Stack HCI

## Learner roles

- administrator

- security engineer
- solution architect
- student
- technology manager

## Learner level

- **Beginner**: Introductory and overview material that assumes little or no expertise with topic and covers topic concepts, functions, features, benefits.

## Product(s) taught

- Azure Stack HCI
- Azure Arc
- Azure Resource Manager

## Prerequisites

In order to get the best learning experience from this module, you should have knowledge of the following:

- Windows Sever Hyper-V
- Windows Server-based software defined storage
- Windows Server-based software defined networking
- Architecture and operating principles of Azure Stack HCI
- Azure Resource Manager

## Module summary description

This module introduces you to integration between Azure Arc and Azure Stack HCI, including its common use cases, implementation process, core capabilities, and their management.

## Subtasks in this module

What main subtasks would be addressed in this module? 

- What is Azure Arc?
- How can you leverage Azure Arc to deploy Azure Stack HCI VMs?
- How can you leverage Azure Arc to provide centralized monitoring of Azure Stack HCI clusters?

## Lab exercise

None

## Module learning objectives

- Describe use cases and capabilities of integrating Azure Arc and Azure Stack HCI-based workloads
- Describe Azure Resource Manager-based capabilities available to Azure Stack HCI workloads
- Describe cloud-based monitoring of Azure Stack HCI and its workloads

## Estimated module duration

30 minutes

## Module outline of units

### Number of units per module

5

## 1st unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 mins

### Module scenario

Contoso is a medium-size financial services company with its headquarters in London, England. It’s currently operating almost entirely on-premises, with a large portion of its compute environment running on the Windows Server platform, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.
In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, a number of highly regulated workloads have to remain in the on-premises datacenters. 
Two of these workloads present a particular challenge due to their performance and resiliency requirements. The first of them is a group of Microsoft SQL Server instances hosting transactional databases for the Contoso’s loan origination department. The second workload is a set of containerized securities research department apps running on a third-party Kubernetes cluster. 
Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before making the investment, he wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. He also wants to make sure that the new implementation will help ensure a consistent management methodology, which not only leverages existing IT skills but also aligns with the way workloads running in Azure are administered. 
Given the hybrid nature of Contoso's environment, the CIO wants to explore emerging technologies that promise to bridge the gap between on-premises and cloud services. With Azure Arc in public preview, you, as the lead of the IT Engineering team, were tasked with exploring and evaluating how its capabilities can help streamline provisioning, configuration, and maintenance of two workloads which must remain in the Contoso' datacenter. You need to determine the optimal approach that will satisfy technical and business requirements. 

## 2nd unit: What are characteristics and capabilities Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

**Demo video:** Conceptual video illustrating Azure Stack HCI integration with Azure Resource Manager that leverages Azure Arc

### Key content per learning objective

Describe use cases and capabilities of integrating Azure Arc and Azure Stack HCI-based workloads

- Describe Azure Arc and its components
- Describe integration of Azure Arc and Azure Stack HCI
- Describe use cases of Azure Arc-enabled Azure Stack HCI clusters
- Describe capabilities of Azure Arc-enabled Azure Stack HCI clusters

## 3rd unit: How can you leverage Azure Arc to manage Azure Stack HCI-based virtualized workloads?

**Type of unit:** Learning content unit

**Estimated unit duration:** 7 mins

### Key content per learning objective

Describe Azure Resource Manager-based capabilities available to Azure Stack HCI workloads

- Leverage Azure Arc for deployment of Azure Stack HCI VMs 
- Leverage Azure Arc for management of Azure Stack HCI VMs 

## 4th unit: How can you leverage Azure Arc to monitor Azure Stack HCI clusters and their virtualized workloads?

**Type of unit:** Learning content unit

**Estimated unit duration: 7 mins

### Learning objective(s) targeted

Describe cloud-based monitoring of Azure Stack HCI and its workloads

- Describe cloud-based monitoring of Azure Stack HCI cluster
- Describe cloud-based monitoring of Azure Stack HCI workloads

## 5th unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 mins

### Resolution of module problem

Azure Arc will allow Contoso to optimize a hybrid management model while retaining their critical, highly regulated workloads in on-premises datacenters.
