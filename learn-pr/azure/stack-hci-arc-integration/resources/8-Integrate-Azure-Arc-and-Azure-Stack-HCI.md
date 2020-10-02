# Integrate Azure Arc and Azure Stack HCI

## Learner roles

- administrator
- database administrator
- devOps engineer
- security engineer
- solution architect
- technology manager

## Learner level

- **Intermediate**: Material that assumes some knowledge but little in-depth understanding of the topic. Provides a detailed overview of a topic's sub-areas.

## Product(s) taught

- Azure Stack HCI
- Azure Arc
- Kubernetes
- Azure SQL Managed Instance
- Azure Policy

## Prerequisites

In order to get the best learning experience from this module, you should have knowledge of the following:

- Windows Sever Hyper-V
- Windows Server-based software defined storage
- Windows Server-based software defined networking
- Architecture and operating principles of Azure Stack HCI
- Containerization and its concepts
- Architecture and concepts of Kubernetes
- Basic management of Kubernetes clusters
- Azure Resource Manager
- Azure virtual machine (VM) extensions
- Azure Policy
- Azure Monitor
- Log Analytics
- Azure CLI
- Azure Active Directory
- Azure SQL Managed Instance
- Core DevOps principles

## Module summary description

This module introduces you to integration between Azure Arc and Azure Stack HCI, including its common use cases, implementation process, core capabilities, and their management.

## Subtasks in this module

What main subtasks would be addressed in this module? 

- What are capabilities and use cases of integration between Azure Arc and Azure Stack HCI
- What are the benefits of integrating Azure Stack HCI-hosted Kubernetes clusters with Azure Arc
- How to integrate Azure Stack HCI-hosted Kubernetes clusters with Azure Arc
- What are the benefits of integrating Azure Stack HCI-hosted VMs with Azure Arc
- How to integrate Azure Stack HCI-hosted VMs with Azure Arc
- What are the benefits of implementing Azure Arc enabled data services in Azure Stack HCI
- How to implement Azure Arc enabled data services in Azure Stack HCI

## Lab exercise

None

## Module learning objectives

- Describe capabilities, use cases, and benefits of integrating Azure Arc and Azure Stack HCI-based workloads
- Implement integration of Azure Stack HCI-hosted VMs and Azure Arc
- Implement integration of Azure Stack HCI-hosted Kubernetes clusters and Azure Arc
- Implement Azure Arc enabled data services in Azure Stack HCI

## Estimated module duration

50 minutes

## Module outline of units

### Number of units per module

9

## 1st unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 mins

### Module scenario

Contoso is a medium-size financial services company with its headquarters in London, England. It’s currently operating almost entirely on-premises, with a large portion of its compute environment running on the Windows Server platform, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.
In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, a number of highly regulated workloads have to remain in the on-premises datacenters. 
Two of these workloads present a particular challenge due to their performance and resiliency requirements. The first of them is a group of Microsoft SQL Server instances hosting transactional databases for the Contoso’s loan origination department. The second workload is a set of containerized securities research department apps running on a third-party Kubernetes cluster. 
Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before making the investment, he wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. He also wants to make sure that the new implementation will help ensure a consistent management methodology, which not only leverages existing IT skills but also aligns with the way workloads running in Azure are administered. 
Given the hybrid nature of Contoso's environment, the CIO wants to explore emerging technologies that promise to bridge the gap between on-premises and cloud services. With Azure Arc in public preview, you, as the lead of the IT Engineering team, were tasked with exploring and evaluating how its capabilities can help streamline provisioning, configuration, and maintenance of two workloads which must remain in the Contoso' datacenter. You need to determine the optimal approach that will satisfy technical and business 
requirements. 


## 2nd unit: What are basic capabilities and use cases of integration between Azure Arc and Azure Stack HCI?

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

**Demo video:** Integrate Azure Stack HCI with Azure Arc

### Key content per learning objective

Describe basic capabilities and use cases of integration between Azure Arc and Azure Stack HCI

- Azure Arc enabled servers
- Azure Arc enabled Kubernetes
- Azure Arc enabled data services


## 3rd unit: What are the benefits of integrating Azure Stack HCI-hosted VMs and Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 mins

### Key content per learning objective

Describe benefits of integrating Azure Stack HCI-hosted VMs with Azure Arc

- VM extensions
- Azure Policy
- Azure Monitor for VMs
- Log Analytics resource-context log access


## 4th unit: How to implement integration of Azure Stack HCI-hosted VMs and Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration: 3 mins

### Learning objective(s) targeted

Implement integration of Azure Stack HCI-hosted VMs with Azure Arc

- Connect Azure Stack VMs with Azure Arc


## 5th unit: What are the benefits of integrating Azure Stack HCI-hosted Kubernetes clusters and Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration: 10 mins

### Learning objective(s) targeted

Apply configuration of Azure Arc enabled Kubernetes clusters by using GitOps

- Apply configuration of Azure Arc enabled Kubernetes clusters by using GitOps
- Enforce and audit configuration of Azure Arc enabled Kubernetes clusters by using Azure Policy
- Deploy containerized applications to Azure Arc enabled Kubernetes clusters by using GitOps
- Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor.


## 6th unit: How to implement integration of Azure Stack HCI-hosted Kubernetes clusters and Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration: 3 mins

### Learning objective(s) targeted

Implement integration of Azure Stack HCI-hosted Kubernetes clusters with Azure Arc

- Connect Kubernetes clusters to Azure Arc
- Connect Kubernetes clusters to Azure Arc by using a service principal


## 7th unit: What are the benefits of implementing Azure Arc enabled data services in Azure Stack HCI?

**Type of unit:** Learning content unit

**Estimated unit duration: 7 mins

### Learning objective(s) targeted

Describe benefits of implementing Azure Arc enabled data services in Azure Stack HCI

- Azure SQL Managed Instance
- Azure Database for PostgresSQL Hyperscale


## 8th unit: How to implement Azure Arc enabled data services in Azure Stack HCI?

**Type of unit:** Learning content unit

**Estimated unit duration: 3 mins

### Learning objective(s) targeted

Implement Azure Arc enabled data services in Azure Stack HCI


## 9th unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 mins

### Resolution of module problem

Azure Arc will allow Contoso to optimize a hybrid management model while retaining their critical, highly regulated workloads in on-premises datacenters.
