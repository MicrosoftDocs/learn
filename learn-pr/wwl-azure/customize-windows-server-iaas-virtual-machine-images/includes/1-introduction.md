
You can use Azure Image Builder and generalized Windows Server images to create and manage virtual machines (VMs) that you can deploy to your Microsoft Azure subscription.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff are in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

IT operations staff have begun the process of creating VMs in Azure, of which they need many. As the lead system engineer, you have been asked to find ways to accelerate the process. You decide to investigate whether Azure Image Builder and preconfigured images might help.

This module covers creating a generalized image, creating a managed image from the generalized image, and then creating a VM from the managed image. It also discusses how to implement Azure Image Builder. Finally, it covers how to use Azure Image Builder templates to create preconfigured images.

By the end of this module, you'll be able to create new VMs from generalized images and use Azure Image Builder templates to create and manage images in Azure.

## Learning objectives

After completing this module, you'll be able to:

- Create a generalized image.
- Create a new VM from a generalized image.
- Create a managed image of a generalized VM in Azure.
- Create a VM from a managed image.
- Describe Azure Image Builder.
- Use Azure Image Builder to create a Windows image.

## Prerequisites

In order to get the best learning experience from this module, it's important that you have knowledge and experience of:

- Managing Windows Server operating system and Windows Server workloads in on-premises scenarios, including Active Directory Domain Services (AD DS), Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services.
- Common Windows Server management tools.
- Core Microsoft compute, storage, networking, and virtualization technologies.
- On-premises resiliency Windows Server-based compute and storage technologies.
- Implementing and managing infrastructure as a service (IaaS) services in Azure.
- Microsoft Entra ID.
- Security-related technologies (firewalls, encryption, multi-factor authentication).
- Windows PowerShell scripting.
- Automation and monitoring.
