


Azure AD is a Microsoft-managed, cloud-based, identity and access management solution. It provides secure access for organizations and individuals to various cloud-resident services, including Azure, Office 365, Microsoft Dynamics CRM Online, and Microsoft Intune. It can also be used to facilitate seamless authentication to on-premises applications.

Azure AD offers multitenancy and scalability:

- **Multitenancy**. Azure AD is multitenant by design, ensuring isolation between its individual directory instances. The term tenant in this context typically represents an individual, company, or organization that signed up for a subscription to a Microsoft cloud-based service such as Office 365, Windows Intune, or Microsoft Azure, each of which uses Azure AD. However, from a technical standpoint, the term tenant represents an individual Azure AD instance. As an Azure customer, you can create multiple Azure AD tenants. This is useful if you want to test Azure AD functionality in one without affecting the others. Each Azure AD tenant serves as a security boundary and a container for Azure AD objects such as users, groups, and applications.
- **Scalability**. Azure AD is the world’s largest multitenant directory, hosting over a million directory services instances, with billions of authentication requests per week.

Microsoft Online business services, such as Office 365 or Microsoft Azure, require Azure AD for sign in and to help with identity protection. If you subscribe to any Microsoft Online business service, you automatically get Azure AD with access to all the free features.

To enhance your Azure AD implementation, you can also add paid capabilities by upgrading to Azure Active Directory Basic, Premium P1, or Premium P2 licenses. Azure AD paid licenses are built on top of your existing free directory, providing self-service, enhanced monitoring, security reporting, and secure access for your mobile users.

- **Azure Active Directory Free**. Provides user and group management, on-premises directory synchronization, basic reports, and single sign-on across Azure, Office 365, and many popular SaaS apps.
- **Azure Active Directory Basic**. In addition to the Free features, Basic also provides cloud-centric app access, group-based access management, self-service password reset for cloud apps, and Azure AD Application Proxy, which lets you publish on-premises web apps using Azure AD.
- **Azure Active Directory Premium P1**. In addition to the Free and Basic features, P1 also lets your hybrid users access both on-premises and cloud resources. It also supports advanced administration, such as dynamic groups, self-service group management, Microsoft Identity Manager (an on-premises identity and access management suite), and cloud write-back capabilities, which allow self-service password reset for your on-premises users.
- **Azure Active Directory Premium P2**. In addition to the Free, Basic, and P1 features, P2 also offers Azure Active Directory Identity Protection to help provide risk-based Conditional Access to your apps and critical company data; and Privileged Identity Management (PIM) to help discover, restrict, and monitor administrators and their access to resources and to provide just-in-time access when needed.

Each Azure subscription is associated with one, and only one, Azure AD tenant. Besides providing authentication, this association also facilitates authorization, allowing you to grant permissions to resources in the Azure subscription (via Role Based Access Control) to users, groups, and service principals that exist in that particular Azure AD tenant. Note that individual Azure AD tenant can be associated with multiple Azure subscriptions. This allows you to use the same users, groups, and service principals to access and manage resources across multiple Azure subscriptions.

Many applications built on different platforms such as .NET, Java, Node.js, and PHP can use industry-standard protocols such as Security Assertion Markup Language (SAML) 2.0, Web Services Federation (WS-Federation), and OpenID Connect to integrate with the identity management provided by Azure AD. With the support of Open Authorization (OAuth 2.0), developers can develop mobile and web service applications that leverage Azure AD for cloud authentication and access management. They can also take advantage of the support for Azure AD across several PaaS services, such as Azure Web Apps or Azure SQL Database.

Organizations that use AD DS can synchronize users and groups from their Active Directory domains with Azure AD to enable an SSO experience for their users accessing both on-premises and cloud-based applications.

> [!NOTE]
> To learn more about the functionality that implements Azure AD authentication for Linux VMs, see [Log in to a Linux virtual machine in Azure by using Azure AD and OpenSSH](/azure/active-directory/devices/howto-vm-sign-in-azure-ad-linux).
