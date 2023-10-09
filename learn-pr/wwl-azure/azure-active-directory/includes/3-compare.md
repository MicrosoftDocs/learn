To provide applications, services, or devices access to a central identity, there are three common ways to use Active Directory-based services in Azure. This choice in identity solutions gives you the flexibility to use the most appropriate directory for your organization's needs.

For example, if you mostly manage cloud-only users that run mobile devices, it may not make sense to build and run your own Active Directory Domain Services (AD DS) identity solution. Instead, you could use Azure Active Directory.

:::image type="content" source="../media/active-directory-domain-connect-services-7f606454.png" alt-text="Screenshot showing Azure Active Directory Domain Services customer use case.":::


Although the **three Active Directory-based identity solutions** share a common name and technology, they're designed to provide services that meet different customer demands. At a high level, these identity solutions and feature sets are:

1.  **Azure Active Directory (Azure AD) - Cloud-based** identity and mobile device management that provides user account and authentication services for resources such as Microsoft 365, the Azure portal, or SaaS applications.
     -  Azure AD can be synchronized with an on-premises AD DS environment to provide a single identity to users that works natively in the cloud.
2.  **Active Directory Domain Services (AD DS)** \- **Enterprise-ready lightweight directory access protocol (LDAP) server** that provides key features such as identity and authentication, computer object management, group policy, and trusts.
     -  AD DS is a central component in many organizations with an on-premises IT environment and provides core user account authentication and computer management features.
3.  **Azure Active Directory Domain Services (Azure AD DS)** \- **Provides managed domain services** with a subset of fully compatible traditional AD DS features such as domain join, group policy, LDAP, and Kerberos / New Technology LAN Manager (NTLM) authentication.
     -  Azure AD DS integrates with Azure AD, which can synchronize with an on-premises AD DS environment. This ability extends central identity use cases to traditional web applications that run in Azure as part of a lift-and-shift strategy.

## 
