# Module title: Plan and deploy Azure Stack HCI

## Learner roles

- administrator
- security engineer
- solution architect
- technology manager

## Learner level

- **Intermediate**: Material that assumes some knowledge but little in-depth understanding of the topic. Provides a detailed overview of a topic's subareas.

## Product(s) taught

- Azure Stack HCI

## Prerequisites

In order to get the best learning experience from this module, you should have the basic knowledge of the following:

- Azure
- Windows Server Hyper-V
- Windows Server software-defined storage 
- Windows Server software-defined networking

## Module summary description

In this module, you'll learn how to plan for and deploy Azure Stack HCI. This will include identifying suitable workloads, determining the optimal configuration to host these workloads, stepping through the deployment process, validating post-deployment operational status, and evaluating Azure integration options.

## Module learning objectives

- Plan for Azure Stack HCI.
- Deploy Azure Stack HCI.
- Validate deployment of Azure Stack HCI.
- Integrate Azure Stack HCI with Azure.

## Estimated module duration

45 minutes

## Module outline of units

### Number of units per module

7

## First unit: Introduction

The Introduction unit is required for all modules.

**Type of unit:** Introduction unit

**Estimated unit duration:** 4 mins

### Module scenario

Contoso, Ltd. is a medium-size financial-services company with its headquarters in New York and a research facility in Dallas. It’s currently operating almost entirely on-premises, with the majority of its compute environment running on either Windows Server operating system or one of several Linux distributions. Its internal IT staff is well-versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure IaaS and platform as a service (PaaS) services. However, a number of highly regulated workloads have to remain in the on-premises datacenters. 
Two of these workloads present a particular challenge due to their performance and resiliency requirements. The first of them is a group of heavily utilized Microsoft SQL Server instances hosting transactional databases for the Contoso's loan origination department. The second workload is an isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso's securities research department, which is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Contoso's Chief Information Officer (CIO) realizes that implementing these workloads will require additional investment in hardware. Before making the investment, they want to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter consolidation initiative. They also want to make sure that it helps ensure a consistent management approach that leverages existing IT skills, and if possible, integrates with some of the cloud services that Contoso is already benefiting from, such as Azure Monitor. It's also critical that the new solution provides multiple levels of high availability and resiliency thereby protecting them from localized failures, and facilitate disaster recovery to another on-premises location.

IT management has started its search for solutions that would satisfy these requirements. Your role, as the lead system engineer, is to assist with the search and implement a proof-of-concept environment that would help identify the most viable candidate.

## Second unit: What are the use cases of Azure Stack HCI?

**Type of unit:** Learning content unit

**Estimated unit duration:** 12 mins

### Key content per learning objective

Plan for Azure Stack HCI

- Identify Azure Stack HCI use cases
- Identify Azure Stack HCI provisioning model
- Identify Azure Stack HCI billing model

## Third unit: Plan for Azure Stack HCI workloads

**Type of unit:** Learning content unit

**Estimated unit duration:** 14 mins

### Key content per learning objective

- Identify hardware for Azure Stack HCI workloads
- Identify Azure Stack HCI compute considerations 
- Identify Azure Stack HCI storage considerations 
- Identify Azure Stack HCI network considerations

## Fourth unit: Deploy Azure Stack HCI

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

### Key content per learning objective

Deploy Azure Stack HCI

- Describe the prerequisites for deploying Azure Stack HCI
- Describe the deployment process of Azure Stack HCI

## Fifth unit: Deploy Azure Stack HCI

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

### Key content per learning objective

Validate deployment of Azure Stack HCI

- Describe the process of validating deployment of Azure Stack HCI

## Sixth unit: Integrate Azure Stack HCI with Azure

**Type of unit:** Learning content unit

**Estimated unit duration:** 12 mins

### Key content per learning objective

Integrate Azure Stack HCI with Azure

- Describe the primary integration options
- Describe integration with Azure management services
- Describe integration with Azure security services
- Describe integration with Azure governance and compliance services
- Describe integration with Azure business continuity services

## Seventh unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 mins

### Resolution of module problem

Using what you have learned, you determined that Azure Stack HCI would serve as the most suitable solution for Contoso. Contoso identified resource requirements for its workloads by reviewing performance utilization of the existing SQL Server deployments and estimating projected number and type of VDI users. That served as the basis for selecting properly sized hardware from the Azure Stack HCI Catalog. To validate the deployment, Contoso ran the functional and performance tests, leveraging Windows Admin Center and synthetic workloads generated by VM Fleet. To further optimize its deployment, Contoso integrated Azure Stack HCI clusters and their workloads with a number of cloud-based services that Contoso already implemented in its Azure subscriptions. In addition, Contoso is considering implementing a new disaster recovery solution based on Azure Site Recovery.