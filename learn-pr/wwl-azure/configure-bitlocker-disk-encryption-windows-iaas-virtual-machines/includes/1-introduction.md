In this module, you’ll learn how to configure Azure Disk Encryption for Windows infrastructure as a service (IaaS) virtual machines (VMs). You'll also learn how to back up and recover encrypted data.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff are in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

The IT security team at Contoso wants to know how they can ensure that the virtual hard disks (VHDs) of Windows Server IaaS VMs are encrypted. Encryption must meet corporate security standards. They also need to ensure that they can recover an encrypted VHD of a Windows Server IaaS VM; for example, if the VM suffers data corruption and needs to be restored.

This module will cover Azure Disk Encryption and its requirements, and configuring Azure Key Vault to support Azure Disk Encryption. It also covers encrypting Azure IaaS VM hard disks, and backing up and recovering encrypted data when necessary.

By the end of this module, you'll be able to configure Azure Disk Encryption for Windows IaaS VMs and back up and recover encrypted data.

## Learning objectives

After completing this module, you'll be able to:

- Describe Azure Disk Encryption.
- Configure Key Vault to support Azure Disk Encryption.
- Explain how to encrypt Azure IaaS VM hard disks.
- Back up and recover encrypted data from IaaS VM hard disks.

## Prerequisites

In order to get the best learning experience from this module, you should have knowledge and experience of:

- Managing Windows Server operating system and Windows Server workloads in on-premises scenarios, including Active Directory Domain Services (AD DS), Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services
- Common Windows Server management tools
- Core Microsoft compute, storage, networking, and virtualization technologies
- On-premises resiliency Windows Server-based compute and storage technologies
- Implementing and managing IaaS services in Microsoft Azure
- Microsoft Entra ID
- Security-related technologies (firewalls, encryption, multi-factor authentication)
- Windows PowerShell scripting
- Automation and monitoring
