In cross-premises scenarios, Active Directory from on-premises can be extended to serve as the authentication mechanism through an Azure deployed domain controller (as well as potentially using the integrated DNS). It's important to distinguish between traditional Active Directory Servers and Microsoft Entra ID that provides only a subset of the traditional on-premises AD features. This subset includes Identity and Access Management but doesn't have the full AD schema or services that many third-party applications utilize. While Microsoft Entra ID is a requirement for provisioning resources in Azure, and it can synchronize users with customers' on-premises AD, the two are explicitly different and customers will likely continue to require full Active Directory servers deployed in Microsoft Azure.

From the authentication standpoint, the Active Directory domain controllers hosted in Azure Virtual Machines would typically constitute an extension of an on-premises Active Directory. To provide enough resiliency, you should place Azure Virtual Machines hosting domain controllers into the same availability set. By collocating domain controllers with SAP servers within the same Azure virtual network, you improve performance by localizing authentication traffic.

Hosting SAP workload scenarios in Azure also can create requirements of identity integration and single sign-on. This situation can occur when you use Microsoft Entra ID to connect different SAP components and SAP software-as-a-service (SaaS) or platform-as-a-service (PaaS) offers.

You can take advantage of Microsoft Entra ID to enable single-sign-on (SSO) to your S/4HANA Fiori Launchpad, SAP HANA, and SAP NetWeaver-based applications (SAP HANA also supports just-in-time user provisioning). Microsoft Entra ID can also be integrated with the SAP Cloud Platform (SCP) to provide single-sign-on to your SCP services that can also be run on Azure.

Control access to resources by using a centralized identity management system at all levels:

- Provide access to Azure resources through role-based access control (RBAC).
- Grant access to Azure Virtual Machines through LDAP, Microsoft Entra ID, Kerberos, or another system.
- Support access within the apps themselves through the services that SAP provides or that use OAuth 2.0 and Microsoft Entra ID.
