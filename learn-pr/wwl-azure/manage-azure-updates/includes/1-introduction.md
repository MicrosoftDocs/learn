In this module, you’ll learn how to ensure that on-premises Windows Server instances and Azure infrastructure as a service (IaaS) virtual machines (VMs) are up to date with software updates.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff are in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Microsoft Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

One of the most important tasks that Contoso has to do in securing a hybrid server environment is to ensure that server updates are timely. Applying updates quickly, especially security updates, helps you block attacks based on the vulnerabilities that the updates address. Contoso IT staff are eager to find out how to manage their updates for both on-premises and cloud-based servers. They realize this could be challenging because few tools can manage both environments. They do have the option to extend Microsoft Endpoint Configuration Manager to manage their Azure servers. However, the Contoso IT team wants you to test whether they could manage updates for both cloud-based and on-premises servers by using the Azure Update Management service.

This module will cover enrolling Azure VMs in Azure Update Management, and configuring Windows Server Update Services (WSUS) with Azure Update Management. It will also cover reviewing, managing, and deploying Azure updates.

By the end of this module you'll be able to enable Azure Update Management, deploy updates, review an update assessment, and manage updates for your Azure VMs.

## Learning objectives

After completing this module, you will be able to:

- Describe Azure updates.
- Enable Update Management.
- Deploy updates.
- Review an update assessment.
- Manage updates for your Azure VMs.

## Prerequisites

In order to get the best learning experience from this module, it's important that you have knowledge and experience of the following:

- Managing the Windows Server operating system (OS) and Windows Server workloads in an on-premises scenarios including Active Directory Domain Service (AD DS), Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services.
- Common Windows Server management tools.
- Core Microsoft compute, storage, networking, and virtualization technologies.
- On-premises resiliency Windows Server-based compute and storage technologies.
- Implementing and managing IaaS services in Microsoft Azure.
- Microsoft Entra ID.
- Security-related technologies (firewalls, encryption, multi-factor authentication).
- Windows PowerShell scripting.
- Automation and monitoring.
