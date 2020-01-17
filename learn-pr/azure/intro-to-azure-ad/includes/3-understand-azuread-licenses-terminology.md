
Your company is always looking for the most experienced healthcare professionals and external contractors to work with. Research projects can become costly if not managed properly. Your company wants to improve its cost effectiveness. You've been asked to investigate how Azure Active Directory (Azure AD) is licensed. You've also been asked to provide a clear and concise outline of the key terminology your company will come across when using Azure AD.

Here, you'll explore how Azure AD is licensed, and which features fall under the different licenses. You'll see how to add or change licenses in Azure AD. And you'll learn the key terms you need to understand when using Azure AD.

## Azure Active Directory licenses

You can use different features of Azure AD, depending on the type of license you choose.

- **Azure Active Directory Free**. Here, you get user and group management capabilities, basic reports, on-premises Active Directory synchronization, self-service password reset for Azure AD users, single sign-on for Office 365, Azure services, and many third-party SaaS applications.

- **Azure Active Directory Premium P1**. Here, you get all the features from the free tier, but you can also let users access on-premises, and cloud-based services and resources. You can also use dynamic groups where users are added and removed automatically, based on your criteria, and self-service group management. This tier also supports on-premises identity management suites like Microsoft Identity Manager. Self-service password reset for on-premises based users is also supported.

- **Azure Active Directory Premium P2**. This tier has all the features of the previous two tiers, with an added feature called Active Directory Identity Protection. This feature helps you configure risk-based Conditional Access to protect applications from identity-based risks. You can also use Privileged Identity Management, which lets you monitor and put detailed restrictions on administrators.

- **Pay-as-you-go licenses for specific features**. Specific Azure AD features, like Azure AD Business-to-Customer (B2C) are accessed on a pay-as-you-go basis. Azure AD B2C lets you manage identity and access for customer users and the applications they use.

Choose the license type you want, based on your organization's needs.

View your active license plans in the Azure portal by selecting **Azure Active Directory > Licenses > All products**. Here, you can also buy or try new licenses.

![Licenses](../media/3-licenses.png)

You can select each license plan to see which users are included. Also, you can add or remove users for individual plans, and do the same for groups of users.

![License users](../media/3-licenses-users.png)

<!-- 1. **Understand Azure AD terminology**

   Get to grips with the terminology that underlies using Azure AD, including Iidentity, Azure tenant, custom domain, and so on.

   **Knowledge Check**
   1. What is meant by the term identity?
       A: Something that can get authenticated.  This can be a user, an application, other servers, or anything that needs to be identified.
   1. What is meant by the term Azure tenant?
       A: A dedicated and trusted instance of Azure AD that represents your organization.
   1. What is meant by the term Azure subscription?
       A: A subscription is the mechanism used to pay for Azure cloud services. -->

## Azure AD terminology

To use Azure AD effectively, there are some key Active Directory specific terms you'll need to understand when you come across them. 

Here's an explanation of some of those terms: 

|Terms|Description|
|---------|---------|
|Identity|Something that has to be identified and authenticated. Typically a user who has username and password credentials, but can also apply to applications or services.|
|Account|An account is an identity with associated data. An account can't exist without an identity.|
|Azure AD account|An identity created with Azure AD, or through services like Office 365. These identities are stored in Azure AD. For example, there might be accounts used daily by internal staff members at work.|
|Azure subscription| You need a subscription to use Azure and all of its services. For pay-as-you-go, set up an Azure subscription using your credit card. There are other types of subscriptions. For example, enterprise-level customers can use Azure Enterprise Agreement subscriptions. Each account can use many subscriptions.|
|Azure AD tenant|An instance of an Azure AD directory. This directory is a resource created for you automatically when you first sign up for Azure or other services like Office 365. A tenant, which represents an organization, holds your users, their groups, and applications.|
|Multi-tenant|When multiple tenants access the same applications and services in a shared environment. These tenants represent multiple organizations.|
|Azure AD directory|An Azure resource that's created for you automatically when you subscribe to Azure. You can create many Azure AD directories, and each represents a tenant.|
|Custom domain|When you create an Azure AD directory, it's automatically assigned a default domain like `<your-organization>.onmicrosoft.com` from Azure. But you can also configure your own custom domain names. Your users could then have accounts like `joesmith@contoso.com` instead of `joesmith@contoso.onmicrosoft.com`.|
|Owner role|This role lets you manage all resources in Azure, including the access levels users need for resources.  |
|Global administrator| When you create a tenant, you're automatically assigned this role for that tenant. The role gives you all the administrative capabilities for Azure AD. For example, you can reset passwords for all users and administrators.|
