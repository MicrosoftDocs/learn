# Module title: Introduction to Azure Stack

## Learner roles

- administrator
- AI edge engineer
- business owner
- data engineer
- database administrator
- devOps engineer
- privacy manager
- security engineer
- solution architect
- student
- technology manager

## Learner level

- **Beginner**: Introductory and overview material that assumes little or no expertise with topic and covers topic concepts, functions, features, benefits.

## Product(s) taught

- Azure Stack HCI
- Azure Stack Hub
- Azure Stack Edge

## Prerequisites

In order to get the best learning experience from this module, you should have the basic knowledge of:

- Azure
- Window Server software-defined storage
- Windows Server software-defined networking
- IoT technologies

## Module summary description

This module introduces you to the Azure Stack portfolio and describes basic architecture, core capabilities, and primary use cases of its products. You'll also learn about differences and similarities between Azure Stack HCI, Azure Stack Hub, Azure Stack Edge, and Azure.

## Module learning objectives

- Describe the Azure Stack portfolio
- Describe basic architecture, core capabilities, and primary use cases of Azure Stack Hub
- Describe basic architecture, core capabilities, and primary use cases of Azure Stack HCI
- Describe basic architecture, core capabilities, and primary use cases of Azure Stack Edge

## Estimated module duration

45 minutes

## Module outline of units

### Number of units per module

7

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 mins

### Module scenario

Contoso, Ltd. is a medium-size financial-services company with its headquarters in New York and a research facility in Dallas. It’s currently operating almost entirely on-premises, with the majority of its compute environment running on either Windows Server operating system or one of several Linux distributions. Its internal IT staff is well versed in Microsoft technologies, including its virtualization and software-defined datacenter offerings.

In recent months, as part of datacenter consolidation and modernization initiatives, Contoso IT migrated some of its applications to a range of Azure infrastructure as a service (IaaS) and platform as a service (PaaS) services. However, several highly regulated workloads will have to remain in the New York's on-premises datacenter.

Two of these workloads present a particular challenge because of their performance and resiliency requirements. The first workload is a two-tier Online Transaction Processing (OLTP) application of the Contoso’s loan-origination department. The application's PHP-based front-end tier runs on a pair of clustered Linux Ubuntu 18.04 servers, while its back-end tier consists of MySQL databases. The second workload is a yet-to-be implemented, isolated Virtual Desktop Infrastructure (VDI) farm for users in Contoso’s investment banking department, which is supposed to replace an aging Windows Server 2012 R2–based Remote Desktop Services (RDS) deployment.

Another workload that remains on-premises but presents operational challenges is a research application that uses Machine Learning to process and analyze customer data and uploads it to Azure storage for long-term archival. The current process relies on legacy code to scrub data to minimize the potential for exposing personal data, but unfortunately its accuracy and efficiency does not meet regulatory requirements. 

Contoso’s Chief Information Officer (CIO) realizes that modernizing these workloads will require additional hardware investment, but before they commit the necessary funding she wants to verify that the extra expense will help the IT organization deliver a modern technological solution and accelerate the datacenter-consolidation initiative. They also want to ensure that the new implementation will not only promote a consistent management approach that leverages existing IT skills, but also, whenever possible, promote transition to the managed services model. That approach should include integration with the cloud services from which Contoso is already benefiting, such as Azure Monitor. It’s also critical that the new solution provides multiple levels of availability and resiliency, protecting from localized failures and facilitating disaster recovery.

IT management has started its search for a solution that would satisfy these requirements. Your role, as the lead system engineer, is to assist with identifying the most viable candidate. To choose the optimal Microsoft-provided platform for your workloads, you need to understand the options available to you, their capabilities, and the corresponding intended usage scenarios. With increasing integration, the differences between public clouds, private clouds, and traditional on-premises operational models are less pronounced, which makes your task more challenging.


## Second unit: What is Azure Stack?

**Type of unit:** Learning content unit

**Estimated unit duration:** 4 mins

### Key content per learning objective

Describe the Azure Stack portfolio

- Describe the hybrid cloud model
- Describe hybrid characteristics of Azure Stack
- Describe basic characteristics of Azure Stack products

## Third unit: What is Azure Stack Hub?

**Type of unit:** Learning content unit

**Estimated unit duration:** 8 mins

### Key content per learning objective

Describe Azure Stack Hub

- Describe the basic architecture of Azure Stack Hub
- Describe the core capabilities of Azure Stack Hub
- Describe the primary use cases of Azure Stack Hub

## Fourth unit: What is Azure Stack HCI?

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

### Key content per learning objective

Describe Azure Stack HCI

- Describe the basic architecture of Azure Stack HCI
- Describe the core capabilities of Azure Stack HCI
- Describe the primary use cases of Azure Stack HCI

## Fifth unit: What is Azure Stack Edge?

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

### Key content per learning objective

Describe Azure Stack Edge

- Describe the basic architecture of Azure Stack Edge
- Describe the core capabilities of Azure Stack Edge
- Describe the primary use cases of Azure Stack Edge

## Sixth unit: Compare Azure Stack portfolio products

**Type of unit:** Learning content unit

**Estimated unit duration:** 10 mins

### Key content per learning objective

Describe the Azure Stack portfolio

- Compare Azure Stack Hub, Azure Stack HCI, and Azure Stack Edge

## Seventh unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 mins

### Resolution of module problem

Given the characteristics of Contoso's on-premises workloads, you determined that Azure Stack HCI would be the most suitable platform for the VDI farm, that Azure Stack Hub would help modernize the two-tier OLTP application of the Contoso’s loan-origination department, and that Azure Stack Edge would serve as the optimal replacement for the research application relying on Machine Learning to analyze customer data and upload the results to Azure Storage. In each of these cases, Contoso will benefit from the integration of Azure Stack with a range of Azure cloud services.
