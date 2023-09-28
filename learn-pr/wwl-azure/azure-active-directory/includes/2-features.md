**Azure Active Directory** (Azure AD) is a cloud-based identity and access management service. This service helps employees access external resources, such as Microsoft 365, the Azure portal, and thousands of other software-as-a-service (SaaS) applications. Azure Active Directory also helps them access internal resources like apps on your corporate intranet network, along with any cloud apps developed for your organization.

## :::image type="content" source="../media/azure-active-directory-features-2f5b251f.png" alt-text="Screenshot showing Azure Active Directory features implementation example."::: Who uses Azure AD?

Azure AD is intended for:

 -  IT admins: As an IT admin, use Azure AD to control access to your apps and your app resources based on your business requirements. For example, you can use Azure AD to require multi-factor authentication when accessing important organizational resources. You can also use Azure AD to automate user provisioning between your existing Windows Server AD and your cloud apps, including Microsoft 365. Finally, Azure AD gives you powerful tools to automatically help protect user identities and credentials and to meet your access governance requirements.
 -  App developers: As an app developer, you can use Azure AD as a standards-based approach for adding single sign-on (SSO) to your app, allowing it to work with a user's pre-existing credentials. Azure AD also provides APIs that can help you build personalized app experiences using existing organizational data.
 -  Microsoft 365, Office 365, Azure, or Dynamics Customer relationship management (CRM) Online subscribers: As a subscriber, you're already using Azure AD. Each Microsoft 365, Office 365, Azure, and Dynamics CRM Online tenant is automatically an Azure AD tenant. You can immediately start to manage access to your integrated cloud apps.

## What are the Azure AD licenses?

Microsoft Online business services, such as Microsoft 365 or Microsoft Azure, require Azure AD for sign-in activities and to help with identity protection. If you subscribe to any Microsoft Online business service, you automatically get Azure AD with access to all the free features.

To enhance your Azure AD implementation, you can also add paid capabilities by upgrading to Azure Active Directory Premium P1 or Premium P2 licenses. Azure AD paid licenses are built on top of your existing free directory. The licenses provide self-service, enhanced monitoring, security reporting, and secure access for your mobile users.

 -  **Azure Active Directory Free.** Provides user and group management, on-premises directory synchronization, basic reports, self-service password change for cloud users, and single sign-on across Azure, Microsoft 365, and many popular SaaS apps.
 -  **Azure Active Directory Premium P1.** In addition to the Free features, P1 lets your hybrid users access both on-premises and cloud resources. It also supports advanced administration, such as dynamic groups, self-service group management, Microsoft Identity Manager, and cloud write-back capabilities, which allow self-service password reset for your on-premises users.
 -  **Azure Active Directory Premium P2.** In addition to the Free and P1 features, P2 also offers Azure Active Directory Identity Protection to help provide risk-based Conditional Access to your apps and critical company data and Privileged Identity Management to help discover, restrict, and monitor administrators and their access to resources and to provide just-in-time access when needed.
 -  **"Pay as you go"** feature licenses. You also get additional feature licenses, such as Azure Active Directory Business-to-Customer (B2C). B2C can help you provide identity and access management solutions for your customer-facing apps.

## Which features work in Azure AD?

After you choose your Azure AD license, you'll get access to some or all of the following features:

|              **Category**              | **Description**                                                                                                                                                                                      |
|:--------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|         Application management         | Manage your cloud and on-premises apps using Application Proxy, single sign-on, the My Apps portal, and Software as a Service (SaaS) apps.                                                           |
|             Authentication             | Manage Azure Active Directory self-service password reset, Multi-Factor Authentication, custom banned password list, and smart lockout.                                                              |
| Azure Active Directory for developers  | Build apps that sign in all Microsoft identities, and get tokens to call Microsoft Graph, other Microsoft APIs, or custom APIs.                                                                      |
|       Business-to-Business (B2B)       | Manages your guest users and external partners while maintaining control over your own corporate data.                                                                                               |
|       Business-to-Customer (B2C)       | Customize and control how users sign up, sign in, and manage their profiles when using your apps.                                                                                                    |
|           Conditional Access           | Manage access to your cloud apps.                                                                                                                                                                    |
|           Device Management            | Manage how your cloud or on-premises devices access your corporate data.                                                                                                                             |
|            Domain services             | Join Azure virtual machines to a domain without using domain controllers.                                                                                                                            |
|            Enterprise users            | Manage license assignments, access to apps, and set up delegates using groups and administrator roles.                                                                                               |
|            Hybrid identity             | Use Azure Active Directory Connect and Connect Health to provide a single user identity for authentication and authorization to all resources, regardless of location (cloud or on-premises).        |
|          Identity governance           | Manage your organization's identity through employee, business partner, vendor, service, and app access controls. You can also perform access reviews.                                               |
|          Identity protection           | Detect potential vulnerabilities affecting your organization's identities, configure policies to respond to suspicious actions, and then take appropriate action to resolve them.                    |
| Managed identities for Azure resources | Provide your Azure services with an automatically managed identity in Azure AD that can authenticate any Azure AD-supported authentication service, including Key Vault.                             |
|  Privileged identity management (PIM)  | Manages, controls, and monitors access within your organization. This feature includes access to resources in Azure AD and Azure, and other Microsoft Online Services, like Microsoft 365 or Intune. |
|         Reports and monitoring         | Gain insights into the security and usage patterns in your environment.                                                                                                                              |
