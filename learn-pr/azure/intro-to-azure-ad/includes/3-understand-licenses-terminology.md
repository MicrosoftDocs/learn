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
| | |

## Default user permissions

Azure AD gives all of the users in your tenant a default set of permissions. Permissions dictate what a user can and can't do. The set of permissions granted by default depends on whether a particular user is a natural member user of the tenant (like an internal employee) or if they belong to an outside organization. The latter would be considered a guest, such as an external collaborating user. Guest users are invited to the tenant through a feature for Azure AD called Azure Active Directory B2B.

Member users can do many things that guest users can't. For example, member users manage their own profile details, like their phone number, profile photos, and more. Guest users typically have more restrictions. A guest user can, for instance, view their display photo but can't change it. The external healthcare professionals your company works with regularly, could be given guest user access. This way, they'd have more restricted permissions than a regular internal staff member, but they would still have enough permissions to get their work done.

### Member and guest default permissions compared

Here are some of the default permissions for member and guest type users:

|Area  |Member user permissions  |Guest user permissions  |
|---------|---------|---------|
|Users and contacts|Can view all profile details. Change own password, update own mobile phone number, and profile photos.|Only view profile name, email, sign-in name, photo, user principal name, and user type properties of other users and contacts; change own password.|
|Devices|Can read all properties of devices. Manage all properties of owned devices.|Can't read all properties of devices. Can't manage all properties of owned devices. Can delete owned devices.|
|Applications |Can register new applications.|Can't register new applications. Can delete owned applications.|
Policies|Read all properties of policies, manage all properties of owned policy.|No permissions.|
Subscriptions|Read all subscriptions, enable Service Plan Member.|No permissions.|
Roles and Scopes|Read all administrative roles and memberships, read all Roles and Scopes and membership of administrative units.|No permissions.|