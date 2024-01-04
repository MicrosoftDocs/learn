You can use Azure Arc to apply Azure Policy guest configuration to on-premises Windows Server instances.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of Contoso’s compute infrastructure consists of on-premises Windows Servers. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso’s IT staff is in the process of migrating to Windows Server 2022.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof-of-concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals.

It's become increasingly obvious that Contoso will continue to operate an on-premises environment for some time after they begin migrating workloads to Azure infrastructure as a service (IaaS) virtual machines (VMs). Consequently, the ability to apply Azure policies to on-premises Windows Server workloads will be important. In addition, administrators will need to review on-premises Windows Server instances in the Azure console.

In this module, you will learn how to describe Azure Arc, implement Azure Arc with on-premises server instances, deploy Azure policies with Azure Arc, and use role-based access control (RBAC) to restrict access to Log Analytics data.

## Learning objectives

After completing this module, you will be able to:

 -  Describe Azure Arc.
 -  Explain how to onboard on-premises Windows Server instances in Azure Arc.
 -  Connect hybrid machines to Azure from the Azure portal.
 -  Use Azure Arc to manage devices.
 -  Restrict access using RBAC.

## Prerequisites

In order to get the best learning experience from this module, it's important that you have knowledge and experience of the following:

 -  Managing Windows Server operating systems and Windows Server workloads in on-premises scenarios, including AD DS, Domain Name System (DNS), the Distributed File System (DFS), Microsoft Hyper-V, and file and storage services.
 -  Common Windows Server management tools.
 -  Core Microsoft compute, storage, networking, and virtualization technologies.
 -  On-premises resiliency Windows Server-based compute and storage technologies.
 -  Implementing and managing IaaS services in Azure.
 -  Microsoft Entra ID.
 -  Security-related technologies (firewalls, encryption, multi-factor authentication).
 -  Windows PowerShell scripting.
 -  Automation and monitoring.
