You can migrate an on-premises file server to Azure and ensure that important file shares are replicated throughout your organization without requiring Distributed File System (DFS).

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2016 hosts. Contoso's IT staff are in the process of migrating Contoso's servers to Windows Server 2025.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services can help modernize the current operational model through automation and virtualization. 

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals. 

One of the first things that IT staff at Contoso plan to migrate is file sharing. Currently, many file servers are distributed across the organization. In addition, Contoso is using DFS to consolidate shared folders across the enterprise, and to synchronize content to branch offices by using DFS-Replication (DFSR). It's important that you investigate options for moving this shared content to Azure.

In this module, you learn to deploy Azure File Sync, to migrate from DFS, and to use Storage Migration Services to migrate file servers to Azure. By the end of this module, you are able to effectively migrate file sharing to Azure for Contoso.
 

## Learning objectives

After completing this module, you'll be able to:

- Describe Azure file services
- Configure Azure file services
- Configure connectivity to Azure file services
- Describe Azure File Sync
- Implement Azure File Sync
- Deploy Azure File Sync
- Manage cloud tiering
- Migrate from DFSR to Azure File Sync

## Prerequisites

To get the best learning experience from this module, it's important that you have knowledge and experience in the following areas:

- Managing the Windows Server operating system and Windows Server workloads in on-premises scenarios, including Active Directory Domain Services (AD DS), Domain Name System (DNS), DFS, Microsoft Hyper-V, and file and storage services
- Common Windows Server management tools
- Core Microsoft compute, storage, networking, and virtualization technologies
- Implementing and managing infrastructure as a service (IaaS) services in Azure
- Microsoft Entra ID (formerly Azure AD)
- Security-related technologies (firewalls, encryption, multifactor authentication)
- Windows PowerShell scripting
- Automation and monitoring
