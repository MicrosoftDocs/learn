In this module, you’ll learn how to configure a Microsoft Azure environment so that Windows Server infrastructure as a service (IaaS) workloads that require Active Directory are supported. You’ll also learn how to integrate an on-premises AD DS environment into Azure.

## Scenario

Contoso is a medium-size financial services company in London with a branch office in New York. Most of its compute environment runs on-premises on Windows Server. This includes virtualized workloads on Windows Server 2012 R2 hosts. Contoso IT staff are in the process of migrating Contoso servers to Windows Server 2019.

Contoso’s IT director realizes that Contoso has an outdated operational model with limited automation and reliance on dated technology. The Contoso IT Engineering team has started exploring Azure capabilities. They want to determine whether Azure services might assist with modernizing the current operational model through automation and virtualization. 

As part of the initial design, the Contoso IT team asked you, their lead system engineer and server administrator, to set up a proof of concept environment. This environment must verify whether Azure services can help to modernize the IT infrastructure and meet business goals. 

With more services available online and in the cloud, organizations like Contoso are finding that they need to define and manage cloud identities.Contoso can use cloud identities to authenticate and authorize their users when they try to access company resources.

Microsoft provides a cloud-based directory service in the Azure platform called *Azure Active Directory* (Azure AD). Azure AD is a multitenant, cloud-based directory and identity management service. It provides identity and access services for resources that exist in the cloud. Azure AD can also provide for single-sign on (SSO) access to thousands of cloud software as a service (SaaS) applications.

Contoso could also choose to use Azure Active Directory Domain Services (Azure AD DS). Azure AD DS provides managed domain services such as domain join, group policy, Lightweight Directory Access Protocol (LDAP), and Kerberos authentication or NTLM authentication that is fully compatible with Windows Server AD DS. Contoso could integrate Azure AD DS with their Azure AD tenant. This makes it possible for users to sign in using their existing credentials. 

In this module, you'll learn how to select an Azure AD integration model, and plan for integration. You'll also prepare and install AD DS synchronization. You will learn how to implement SSO, and enable Azure AD login for an Azure virtual machine (VM). Finally, you'll learn to plan and implement Azure AD DS.  

## Learning objectives

After completing this module, you will be able to:

- Select an Azure AD integration model.
- Plan for Azure AD integration.
- Prepare on-premises AD DS for directory synchronization.
- Install and configure directory synchronization using Azure AD Connect.
- Implement Seamless SSO.
- Enable Azure AD login for an Azure Windows VM.
- Describe Azure AD DS.
- Implement and configure Azure AD DS.
- Manage Windows Server 2019 in an Azure AD DS instance.
- Join a Windows Server VM to a managed domain.


## Prerequisites

To get the best learning experience from this module, it's important that you have knowledge and experience of the following areas:

- Managing Windows Server operating system and Windows Server workloads in on-premises scenarios, including AD DS, DNS, Distributed File System (DFS), Microsoft Hyper-V, and file and storage services.
- Common Windows Server management tools.
- Core Microsoft compute, storage, networking, and virtualization technologies.
- Implementing and managing IaaS services in Microsoft Azure.
- Azure Active Directory (Azure AD).
- Security-related technologies (firewalls, encryption, multi-factor authentication).
- Windows PowerShell scripting.
- Automation and monitoring.