Azure supports many authentication and authorization scenarios, including support for a range of identity providers. However, for SAP deployments there are 3 of primary relevance:

* **Active Directory Domain Services (AD DS)**

* **Azure Active Directory (Azure AD)**

* **Azure Active Directory Domain Services (Azure AD DS)**

## Active Directory Domain Services (AD DS)
AD DS offers a wide range of business-related and technological benefits. It serves as an identity and access management solution for on-premises, independently managed, isolated environments. 

The authentication mechanisms of AD DS rely largely on having domain-member computers permanently joined to the domain. The communication with domain controllers involves protocols such as:

- Lightweight Directory Access Protocol (LDAP) for directory services lookups
- Kerberos for authentication
- Server Message Block (SMB) for Group Policy–based interaction with AD DS domain controllers

None of these protocols are suitable for Internet environments. 

If you want to provide equivalent functionality in Azure, you can deploy AD DS domain controllers as Azure VMs. Some of the more common reasons for placing domain controllers in Azure include:

* Providing authentication to AD DS–dependent applications and services within the Azure environment.

* Extending the scope of the on-premises AD DS to one or more Azure regions, for disaster recovery.

* Implementing more AD DS domain controllers in Azure to enhance the resiliency of the directory synchronization with Azure AD and Azure AD-federated deployments.

There are 3 main scenarios that involve AD DS and Azure VMs:

* **AD DS deployed to Azure VMs without cross-premises connectivity**. This deployment results in the creation of a new forest, with all domain controllers residing in Azure. Use this approach if you plan to host Azure-resident workloads on Azure VMs, that rely on Kerberos authentication or Group Policy but have no on-premises dependencies.

* **Existing on-premises AD DS deployment with cross-premises connectivity to an Azure virtual network, where the Azure VMs reside**. This scenario uses an existing on-premises Active Directory environment to provide authentication for Azure VM-resident workloads. When considering this design, you should consider the latency associated with cross-premises network traffic.

* **Existing on-premises AD DS deployment with cross-premises connectivity to an Azure virtual network, hosting more domain controllers on Azure VMs**. The primary goal of this scenario is to optimize workload performance by localizing authentication traffic. 

When planning the deployment of AD DS domain controllers to Azure VMs, you should consider the following:

* **Cross-premises connectivity**. If you intend to extend your existing AD DS environment to Azure, connectivity between your on-premises environment and the Azure virtual network is a key design element. It's required to set up either a site-to-site virtual private network (VPN) or Microsoft Azure ExpressRoute. 

* **Active Directory topology**. In cross-premises scenarios, you should configure AD DS sites to reflect your cross-premises network infrastructure. This topology will allow you to localize the authentication traffic and control the replication traffic between on-premises and Azure VM-based domain controllers. Intra-site replication assumes high bandwidth and permanently available connections. By contrast, inter-site replication allows for scheduling and throttling replication traffic. Also, a proper site design ensures that domain controllers in a given site handle authentication requests originating from that site. 

* **Read-only domain controllers (RODCs)**. Some customers are wary about deploying writeable domain controllers to Azure VMs, because of security concerns. One way to mitigate this concern is to deploy RODCs instead. RODCs and writeable domain controllers provide similar user experiences. However, RODCs lower the volume of egress traffic and the corresponding charges. This approach is a good option if an Azure-resident workload doesn't require frequent write access to AD DS. 

* **Global catalog placement**. Whatever your domain topology, you should configure all your Azure VM-based domain controllers as global catalog servers. This arrangement prevents global catalog lookups from traversing cross-premises network links, which would negatively affect performance.

## Integrating Linux with AD DS

There are several ways to integrate Linux VMs with Active Directory. There are 3 main options based on built-in or freely available components:

* **LDAP Authentication / Authorization**

* **Kerberos 5 Authentication / LDAP Authorization**

* **Winbind Authentication / Authorization**

LDAP Authentication and Authorization use the compliance of Active Directory with LDAP standards. Applications that implement NSS (Name Service Switch) and PAM (Pluggable Authentication Module), can use LDAP modules to communicate with the LDAP endpoint of Active Directory. With LDAP Authentication, users can't change their password from the Linux client. You should implement a password change process that conforms to your password expiration policy. You can do this either by providing users an alternative method to change their password, or by having an automated password refresh mechanism.

With Kerberos Authentication, NSS still uses LDAP, and works the same as with LDAP Authentication. However, PAM uses the pam_krb5 module to authenticate against the Kerberos Key Distribution Center (KDC) implemented in Active Directory. This configuration is popular, because it works with out-of-the-box components in a secure way, and provides password change capabilities.

Winbind is a more complex solution, requiring a Winbind daemon to run on the Linux systems. Winbind provides more advanced technical capabilities, such as support for RPC and NTLM. It doesn't require any specific components (such as Services for UNIX) to be installed on authenticating AD DS domain controllers. Winbind is part of the Samba interoperability suite, which also provides file sharing capabilities using the SMB protocol. If you plan to use SMB, using Winbind is a logical choice.

## Azure Active Directory (Azure AD)
Azure AD is a Microsoft-managed, cloud-based, identity, and access management solution. Azure AD provides organizations and individuals secure access to a variety of cloud-resident services, including Azure, Microsoft 365, Microsoft Dynamics CRM Online, and Microsoft Intune. It can also be used to provide seamless authentication to on-premises applications. 

Azure AD offers multitenancy and scalability:

* **Multitenancy**. Azure AD is multitenant by design, ensuring isolation between its individual directory instances. The term *tenant* in this context typically represents an individual, company, or organization that signed up for a subscription to a Microsoft cloud-based service. For example, this could be Microsoft 365, Windows Intune, or Microsoft Azure, each of which uses Azure AD. However, from a technical standpoint, the term tenant represents an individual Azure AD instance. As an Azure customer, you can create multiple Azure AD tenants. Creating multiple Azure AD tenants is useful if you want to test Azure AD functionality in one without affecting the others. Each Azure AD tenant serves as a security boundary, and as a container for Azure AD objects such as users, groups, and applications.

* **Scalability**. Azure AD is the world’s largest multitenant directory. It hosts over a million directory services instances, with billions of authentication requests per week.

Microsoft Online business services, such as Microsoft 365 or Microsoft Azure, require Azure AD for sign-in and to help with identity protection. If you subscribe to any Microsoft Online business service, you automatically get Azure AD with access to all the free features.

To enhance your Azure AD implementation, you can also add paid capabilities by upgrading to Azure Active Directory Basic, Premium P1, or Premium P2 licenses. Azure AD paid licenses are built on top of your existing free directory. They provide self-service, enhanced monitoring, security reporting, and secure access for your mobile users.

* **Azure Active Directory Free**. Provides user and group management, on-premises directory synchronization, basic reports, and single sign-on across Azure, Microsoft 365, and many popular SaaS apps.

* **Azure Active Directory Basic**. In addition to the Free features, Basic also provides cloud-centric app access, group-based access management, self-service password reset for cloud apps, and Azure AD Application Proxy. This lets you publish on-premises web apps using Azure AD.

* **Azure Active Directory Premium P1**. In addition to the Free and Basic features, P1 also lets your hybrid users access both on-premises and cloud resources. It also supports advanced administration, such as:

    * Dynamic groups.
    
    * Self-service group management.
    
    * Microsoft Identity Manager (an on-premises identity and access management suite).
    
    * Cloud write-back capabilities (which allow self-service password reset for your on-premises users).

* **Azure Active Directory Premium P2**. In addition to the Free, Basic, and P1 features, P2 also offers:

    * Azure Active Directory Identity Protection to help provide risk-based Conditional Access to your apps and critical company data.
    
    * Privileged Identity Management (PIM) to help discover, restrict, and monitor administrators and their access to resources, and to provide just-in-time access when needed.

Each Azure subscription is associated with one, and only one, Azure AD tenant. Besides providing authentication, this association also makes authorization easier. It allows you to grant permissions to resources in the Azure subscription to users, groups, and service principals that exist in that particular Azure AD tenant, via Role-Based Access Control. You can associate the same Azure AD tenant with multiple Azure subscriptions. You can then use the same users, groups, and service principals to access and manage resources across multiple Azure subscriptions.

Many applications built on different platforms such as .NET, Java, Node.js, and PHP can use industry standard protocols to integrate with the identity management Azure AD provides. These protocols include Security Assertion Markup Language (SAML) 2.0, Web Services Federation (WS-Federation), and OpenID Connect. With the support of Open Authorization (OAuth 2.0), developers can develop mobile and web service applications that use Azure AD for cloud authentication and access management. They can also take advantage of the support for Azure AD across several PaaS services, such as Azure Web apps or Azure SQL Database. 

Azure AD is available in 3 editions: Free, Basic, and Premium (P1 and P2). 

Organizations that use AD DS can synchronize users and groups from their Active Directory domains with Azure AD. This allows them to enable an SSO experience for their users when they access both on-premises and cloud-based applications.



## Azure Active Directory Domain Services (Azure AD DS)
What if you need to deploy AD DS–dependent workloads in Azure, but you want to minimize the overhead associated with deploying and managing Active Directory domain controllers hosted on Azure VMs? You should consider implementing Azure AD DS instead. Azure AD DS is a Microsoft-managed AD DS service. It provides the standard Active Directory features such as Group Policy, domain join, and also support for protocols such as Kerberos, NTLM, and LDAP. 

The service consists of two Active Directory domain controllers in a new, single-domain forest. When you provision the service, the Azure platform automatically deploys these two domain controllers to an Azure virtual network that you choose. Also, the managed AD DS automatically synchronizes its users and groups from the Azure AD tenant associated with the Azure subscription hosting the virtual network. Effectively, the Azure AD DS domain will contain the same users and groups as its Azure AD counterpart. This provides the following capabilities:

* You can join Azure VMs to the managed AD DS domain if they reside on the same virtual network or another virtual network connected to it.

* Azure AD users can use their existing credentials to sign in to these Azure VMs.

If you have an on-premises AD DS domain that synchronizes with the same Azure AD tenant, your on-premises AD DS users can sign in to the Azure AD DS domain with their existing credentials. 

However, in this scenario the on-premises Active Directory domain is separate from the Active Directory domain that Azure AD DS implements. The two Active Directory domains have different domain names and separate sets of user, group, and computer objects. However, the user and group objects within the scope of Azure AD Connect synchronization have matching attributes.

Azure AD DS offers support for the same set of protocols as on-premises AD DS. With Azure AD DS, you can migrate applications that depend on AD DS to Azure VMs. You do not have to deploy and maintain extra domain controllers or establish connectivity with the on-premises infrastructure. 

There are some important differences between AD DS and Azure AD DS. For example, Azure AD DS doesn't allow you to create trust relationships or extend the schema. Depending on their origin, user and group objects might have to be managed on-premises or in the corresponding Azure AD tenant. Support for Group Policy is limited, with only two previously created Group Policy Objects—one containing computer settings and another containing user settings. Also, while it's possible to perform LDAP binds and LDAP reads against Azure AD DS, there is no support for LDAP writes.