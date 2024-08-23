In this module, you learn how to extend an existing Active Directory environment into Microsoft Azure. You place infrastructure as a service (IaaS) virtual machines (VMs) configured as domain controllers into an Azure virtual network (VNet) subnet.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff is in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization. 

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals. 

With more services available online and in the cloud, organizations are finding that they also need to define and manage cloud identities. Contoso can use cloud identities to authenticate and authorize their users when they try to access company resources.

IT staff at Contoso is considering deploying domain controllers on Windows Server VMs in Azure IaaS as a means to extend authentication and identity from on-premises and into the cloud. You must determine if this is the ideal solution. Keep in mind that Contoso could also implement Microsoft Entra ID or Microsoft Entra Domain Services.

In this module, you learn how to select an identity services option by using AD DS in Azure. You'll deploy and configure AD DS domain controllers in Azure. You'll also learn how to install a replica domain controller in Azure, and how to deploy a new AD DS forest on an Azure VNet.

## Learning objectives

After completing this module, you'll be able to:

- Select an option to implement directory and identity services by using AD DS in Azure.
- Deploy and configure AD DS domain controllers in Azure VMs.
- Install a replica AD DS domain controller in an Azure VM.
- Install a new AD DS forest on an Azure VNet.

## Prerequisites

To get the best learning experience from this module, it's important that you have knowledge and experience of the following areas:

- Managing Windows Server operating system and Windows Server workloads in on-premises scenarios, including AD DS, DNS, Distributed File System (DFS), Microsoft Hyper-V, and file and storage services.
- Common Windows Server management tools.
- Core Microsoft compute, storage, networking, and virtualization technologies.
- Implementing and managing IaaS services in Microsoft Azure.
- Microsoft Entra ID.
- Security-related technologies (firewalls, encryption, multifactor authentication).
- Windows PowerShell scripting.
- Automation and monitoring.
