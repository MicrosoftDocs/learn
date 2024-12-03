
With Microsoft Azure Virtual Machine Scale Sets, you can scale up, scale down, and resize Windows Server virtual machines (VMs). With Azure Site Recovery, you can make VMs highly available should their primary datacenter become unavailable.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff are in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

Contoso's customer-facing website uses a VM running Microsoft Internet Information Services (IIS) and manages large workloads. Because the site's demand is unpredictable, the IT Engineering team would like to ensure that their Windows Server IaaS VMs are able to dynamically adjust to increases and decreases in workloads. Also, as part of a business continuity and disaster recovery (BCDR) plan, the IT team also needs to ensure that this site and other VMs remain available in the event that an Azure datacenter fails.

In this module, you'll learn how to implement scaling for virtual machine scale sets and load-balanced VMs. You'll also learn how to implement Azure Site Recovery. By the end of this module, you'll be able to help Contoso dynamically adjust to increases and decreases in workloads while ensuring business continuity.

## Learning objectives

After completing this module, you will be able to:

- Describe virtual machine scale sets.
- Implement scaling.
- Implement load-balancing VMs.
- Implement Azure Site Recovery.

## Prerequisites

In order to get the best learning experience from this module, it's important that you have knowledge and experience of the following:

- Managing the Windows Server operating system (OS) and Windows Server workloads in on-premises scenarios, including Active Directory Domain Services (AD DS), Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services
- Common Windows Server management tools
- Core Microsoft compute, storage, networking, and virtualization technologies
- On-premises resiliency Windows Server-based compute and storage technologies
- Implementing and managing IaaS services in Azure
- Microsoft Entra ID
- Security-related technologies (firewalls, encryption, multi-factor authentication)
- Windows PowerShell scripting
- Automation and monitoring
