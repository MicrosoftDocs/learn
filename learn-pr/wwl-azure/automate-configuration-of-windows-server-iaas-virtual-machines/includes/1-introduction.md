You can use Azure Automation to automate the configuration of Windows Server infrastructure as a service (IaaS) virtual machines (VMs) and determine if an IaaS VM has been reconfigured.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff are in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Microsoft Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

As part of this process, you need to understand whether you can automate the configuration of Windows Server IaaS VMs. You also must know whether you can use Azure to detect configuration drift for those VMs, and what steps you can take to remediate the configuration of those VMs.

By the end of this module, you'll be able to deploy Desired State Configuration (DSC) extensions, implement those extensions to remediate noncompliant servers, and use custom script extension.

## Learning objectives

After completing this module, you will be able to:

- Describe Azure automation.
- Implement Azure automation with DSC.
- Remediate noncompliant servers.
- Describe custom script extension.
- Configure a VM by using DSC extensions.

## Prerequisites

In order to get the best learning experience from this module, it's important that you have knowledge and experience of the following:

- Managing the Windows Server operating system and Windows Server workloads in on-premises scenarios, including Active Directory Domain Services (AD DS), Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services
- Common Windows Server management tools
- Core Microsoft compute, storage, networking, and virtualization technologies
- On-premises resiliency Windows Server-based compute and storage technologies
- Implementing and managing IaaS services in Microsoft Azure
- Microsoft Entra ID
- Security-related technologies such as firewalls, encryption, and multi-factor authentication
- Windows PowerShell scripting
- Automation and monitoring
