**Azure Active Directory** (Azure AD) is Microsoft’s multi-tenant cloud-based directory and identity management service. For IT admins, Azure AD is an affordable, easy-to-use solution that gives employees and business partners single sign-on (SSO) access to thousands of cloud SaaS applications like Office365, Salesforce, Dropbox, and Concur.

For application developers, Azure AD lets you focus on building your application by making it fast and simple to integrate, with a world-class identity management solution used by millions of organizations around the world.

:::image type="content" source="../media/az500-azure-active-directory-c22f0a71.png" alt-text="Cloud and on-premises environments are connected to Azure AD." lightbox="../media/az500-azure-active-directory-c22f0a71.png":::

## Identity management capabilities and integration

Azure AD also includes a full suite of identity management capabilities, including multifactor authentication, device registration, self-service password management, self-service group management, privileged account management, role-based access control, application usage monitoring, rich auditing and security monitoring, and alerting. These capabilities can help secure cloud-based applications, streamline IT processes, cut costs, and help assure corporate compliance goals are met.

Additionally, Azure AD can be integrated with an existing instance of Windows Server Active Directory, so organizations can use their existing on-premises identity management investments to manage access to cloud-based SaaS applications.

## Azure AD editions

Azure AD comes in four editions—**Free**, **Microsoft 365 Apps**, **Premium P1**, and **Premium P2**. The Free edition is included with an Azure subscription. The Premium editions are available through a Microsoft Enterprise Agreement, the Open Volume License Program, and the Cloud Solution Providers program. Azure and Microsoft 365 subscribers can also buy Azure Active Directory Premium P1 and P2 online.

| Feature                                                     | Free  | Microsoft 365 apps | Premium P1 | Premium P2 |
|:--------------------------------------------------------------- |:---------:|:----------------------:|:--------------:|:--------------:|
| Directory Objects                                               |  500,000  |       Unlimited        |   Unlimited    |   Unlimited    |
| Single Sign-On                                                  | Unlimited |       Unlimited        |   Unlimited    |   Unlimited    |
| Core Identity and Access Management                             |     X     |           X            |       X        |       X        |
| Business to Business Collaboration                              |     X     |           X            |       X        |       X        |
| Identity & Access Management for Microsoft 365 apps |           |           X            |       X        |       X        |
| Premium Features                                                |           |                        |       X        |       X        |
| Hybrid Identities                                               |           |                        |       X        |       X        |
| Advanced Group Access Management                                |           |                        |       X        |       X        |
| Conditional Access                                              |           |                        |       X        |       X        |
| Identity Protection                                             |           |                        |                |       X        |
| Identity Governance                                             |           |                        |                |       X        |

-  **Azure Active Directory Free** \- Provides user and group management, on-premises directory synchronization, basic reports, and SSO across Azure, Microsoft 365, and many popular SaaS apps.
-  **Azure Active Directory Microsoft 365 Apps** \- This edition is included with O365. In addition to the Free features, this edition provides Identity & Access Management for Microsoft 365 apps, including branding, multifactor authentication, group access management, and self-service password reset for cloud users.
-  **Azure Active Directory Premium P1** \- In addition to the Free features, P1 also lets your hybrid users access both on-premises and cloud resources. It also supports advanced administration, such as dynamic groups, self-service group management, Microsoft Identity Manager (an on-premises identity and access management suite) and cloud write-back, which allows self-service password reset for your on-premises users.
-  **Azure Active Directory Premium P2** \- In addition to the Free and P1 features, P2 also offers Azure Active Directory Identity Protection to help provide risk-based Conditional Access to your apps and critical company data. It provides Privileged Identity Management to help you discover, restrict, and monitor administrators and their access to resources, and to provide just-in-time access when needed.

The [Azure Active Directory Pricing](https://azure.microsoft.com/pricing/details/active-directory) page has detailed information about what is included in each of the editions. Based on the feature list, which Azure AD edition might help your organization meet its business and information security goals?

> [!NOTE]
> If you're a customer of Microsoft 365, Azure, or Dynamics CRM Online, you might not realize that you already use Azure AD. Each tenant in Microsoft 365, Azure, and Dynamics CRM is also an Azure AD tenant. You can use your tenant to manage access to thousands of other cloud applications that can integrate with Azure AD.

> [!IMPORTANT]
> The [Azure Active Directory Admin Center](https://aad.portal.azure.com/) also is available.
