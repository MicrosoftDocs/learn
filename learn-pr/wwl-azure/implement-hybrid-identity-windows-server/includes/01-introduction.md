In this module, learn how to configure a Microsoft Azure environment so that Windows Server infrastructure as a service (IaaS) workloads that require Active Directory are supported. Also learn how to integrate an on-premises AD DS environment into Azure.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2016 hosts. Contoso's IT staff are in the process of migrating Contoso servers to Windows Server 2025.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization.

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals. 

With more services available online and in the cloud, organizations like Contoso are finding that they need to define and manage cloud identities. Contoso can use cloud identities to authenticate and authorize their users when they try to access company resources.

Microsoft provides a cloud-based directory service in the Azure platform called *Microsoft Entra ID* (Microsoft Entra ID). Microsoft Entra ID is a multitenant, cloud-based directory, and identity management service. It provides identity and access services for resources that exist in the cloud. Microsoft Entra ID can also provide for single-sign on (SSO) access to cloud software as a service (SaaS) applications.

Contoso could also choose to use Microsoft Entra Domain Services. Microsoft Entra Domain Services provides managed domain services such as domain join, group policy, Lightweight Directory Access Protocol (LDAP), and Kerberos authentication or NTLM authentication that is fully compatible with Windows Server AD DS. Contoso could integrate Microsoft Entra Domain Services with their Microsoft Entra tenant. This makes it possible for users to sign in using their existing credentials. 

In this module, you learn how to select a Microsoft Entra integration model, and plan for integration. You'll also prepare and install AD DS synchronization. You learn how to implement SSO, and enable Microsoft Entra sign-in for an Azure virtual machine (VM). Finally, you learn to plan and implement Microsoft Entra Domain Services.  

## Learning objectives

After completing this module, you'll be able to:

- Select a Microsoft Entra integration model.
- Plan for Microsoft Entra integration.
- Prepare on-premises AD DS for directory synchronization.
- Install and configure directory synchronization using Microsoft Entra Connect.
- Implement Seamless SSO.
- Enable Microsoft Entra sign-in for an Azure Windows VM.
- Describe Microsoft Entra Domain Services.
- Implement and configure Microsoft Entra Domain Services.
- Manage Windows Server in a Microsoft Entra Domain Services instance.
- Join a Windows Server VM to a managed domain.

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
