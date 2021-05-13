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

- Basic concepts of cloud technologies
- Basic characteristics of services available in Azure
- Basic concepts of virtualization and containerization
- Basic architecture and operating principles of Azure Stack HCI
- The purpose and core capabilities of Azure Resource Manager

## Module summary description

This module introduces you to integration between Azure Arc and Azure Stack HCI, including its common use cases, core capabilities, and their management.

## Subtasks in this module

What main subtasks would be addressed in this module? 

- What is Azure Arc?
- How can you leverage Azure Arc to manage Azure Stack HCI VMs?
- How can you leverage Azure Arc to provide centralized monitoring of Azure Stack HCI clusters?

## Lab exercise

None

## Module learning objectives

- Describe Azure Arc, its components, and use cases.
- Describe the principles of integration of Azure Arc and Azure Stack HCI virtualized workloads.
- Describe the benefits of Azure Arc enabled Azure Stack HCI clusters

## Estimated module duration

30 minutes

## Module outline of units

### Number of units per module

5

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 mins

### Module scenario

Contoso is a medium-size financial services company with its headquarters in London, England, and offices all around the world. It’s currently operating almost entirely on-premises, with a large portion of its compute environment running on the Windows Server platform, including virtualized workloads on Windows Server 2012 R2 and Microsoft Hyper-V hosts in Windows Server 2016. Its internal IT staff is well versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.
In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, many highly regulated workloads have to remain in the on-premises datacenters. 

Two types of these workloads present a particular challenge due to their performance and resiliency requirements. The first of them consists of Microsoft SQL Server instances hosting transactional databases for each of the Contoso’s regional loan origination departments. The second type of workload is a set of containerized apps serving securities research department apps running on third-party Kubernetes clusters in each of the region with a local securities exchange.

Contoso’s Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before making the investment, they want to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. They also want to make sure that the new implementation will help ensure a consistent management methodology, which not only leverages existing IT skills but also aligns with the way workloads running in Azure are administered. 

Given the hybrid nature of Contoso's environment, the CIO wants to explore technologies that promise to bridge the gap between the administrative model of on-premises and cloud services. As the lead of the IT Engineering team, you were tasked with exploring and evaluating hybrid capabilities of Azure Stack HCI and Azure Arc to determine whether they can help streamline management and maintenance of the two workloads types that must remain in the Contoso' datacenter. 


## Second unit: What are characteristics, capabilities, and use cases of Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

### Key content per learning objective

Describe Azure Arc, its components, and use cases.

- Describe Azure Arc and its components.
- Describe the benefits and use cases of Azure Arc.
- Describe the capabilities of Azure Arc-enabled Azure Stack HCI clusters.

## Third unit: How can you leverage Azure Arc to manage Azure Stack HCI-based virtualized workloads?

**Type of unit:** Learning content unit

**Estimated unit duration:** 7 mins

### Key content per learning objective

Describe the principles of integration of Azure Arc and Azure Stack HCI virtualized workloads.

- Leverage Azure Arc for configuration of Azure Stack HCI VMs 
- Leverage Azure Arc for management of Azure Stack HCI VMs 

## Fourth unit: How can you leverage Azure Arc to monitor Azure Stack HCI clusters at scale?

**Type of unit:** Learning content unit

**Estimated unit duration: 7 mins

### Learning objective(s) targeted

Describe cloud-based management of Azure Stack HCI clusters.

- Describe the Azure portal-based management of Azure Stack HCI clusters.
- Describe cloud-based monitoring of Azure Stack HCI workloads.

## Fifth unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 mins

### Resolution of module problem

Azure Arc will allow Contoso to optimize a hybrid management model while retaining their critical, highly regulated workloads in on-premises datacenters.