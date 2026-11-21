Use Azure Automation for administrative procedures, Azure Machine Configuration for desired-state management, and Custom Script Extension for one-time setup of Windows Server infrastructure as a service (IaaS) virtual machines (VMs). Together, these capabilities help you configure VMs, detect configuration drift, and choose how to correct it.

## Scenario

Contoso is a medium-sized financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server, including virtualized workloads on Windows Server 2016 hosts. Contoso's IT team is migrating its servers to Windows Server 2025.

Contoso's IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Microsoft Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof-of-concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

As part of this process, you need to understand whether you can automate the configuration of Windows Server IaaS VMs. You also must know whether you can use Azure to detect configuration drift for those VMs, and what steps you can take to remediate the configuration of those VMs.

By the end of this module, you'll understand how to select an automation mechanism, explain the Machine Configuration deployment sequence, and distinguish one-time configuration from ongoing drift correction. The Machine Configuration walkthrough is conceptual, not a self-contained lab. You can study its sequence and expected results without running commands. Executing its package-dependent steps requires a separately obtained, maintained configuration package tested on the target VM.

## Learning objectives

After completing this module, you'll be able to:

- Describe Azure Automation runbooks and their execution environments.
- Explain the prerequisites and deployment sequence for configuring Windows Server VMs with Azure Machine Configuration.
- Interpret configuration compliance and distinguish monitored drift from automatic correction.
- Use Custom Script Extension for one-time VM configuration.

## Prerequisites

In order to get the best learning experience from this module, it's important that you have knowledge and experience of the following technologies:

- Managing the Windows Server operating system and Windows Server workloads in on-premises scenarios, including Active Directory Domain Services (AD DS), Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services
- Common Windows Server management tools
- Core Microsoft compute, storage, networking, and virtualization technologies
- On-premises resiliency Windows Server-based compute and storage technologies
- Implementing and managing IaaS services in Microsoft Azure
- Microsoft Entra ID
- Security-related technologies such as firewalls, encryption, and multifactor authentication
- Windows PowerShell scripting
- Desired State Configuration (DSC)
