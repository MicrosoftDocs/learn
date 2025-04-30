Your company always looks for the most experienced healthcare professionals and external contractors with whom to work. Research projects can become costly if they're not managed properly. Your company wants to improve its cost effectiveness. The company asks you to investigate how Microsoft Entra ID is licensed. They also want you to provide a clear and concise outline of the critical terminology they might come across in Microsoft Entra ID.

In this unit, you explore how Microsoft Entra ID is licensed and which features fall under the different licenses. You see how to add or change licenses in Microsoft Entra ID, and you learn the key terms you need to understand when you use Microsoft Entra ID.

<a name='azure-ad-licenses'></a>

## Microsoft Entra ID licenses

You can use different features of Microsoft Entra ID, depending on the type of license you choose:

- **Microsoft Entra ID Free**: You can manage users and groups, and you get necessary reports, on-premises Active Directory synchronization, and self-service password reset for Microsoft Entra users. You also get single sign-on for Microsoft 365, Azure services, and many non-Microsoft SaaS applications.

- **Pay-as-you-go licenses for specific features**: You can access specific Microsoft Entra features, like Azure AD B2C, on a pay-as-you-go basis. Azure AD B2C lets you manage identity and access for consumer users and the applications they use.

- **Office 365 Apps**: You get all the free tier features, but you can also have custom sign-in and sign out pages, self-service password reset for cloud users, and device write-back.

- **Microsoft Entra ID P1**: You get all the features from the free tier, but you can also let users access on-premises and cloud-based services and resources. You can use self-service group management or dynamic groups, where users are added and removed automatically based on your criteria. This tier supports on-premises identity-management suites like Microsoft Identity Manager. Self-service password reset is also supported for users who are based on-premises.

- **Microsoft Entra ID P2**: You get all the features of the previous two tiers, along with Microsoft Entra ID Protection. This feature helps you configure risk-based Conditional Access to protect applications from identity risks. You can also use privileged identity management, which lets you monitor and put detailed restrictions on Administrators.

- **Microsoft Entra ID Governance**: An advanced set of identity governance capabilities available for Microsoft Entra ID P1 and P2 customers. Microsoft Entra ID Governance is available as six products, Microsoft Entra ID Governance, Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2, Entra ID Governance Frontline Worker, Microsoft Entra ID Governance Step up for Microsoft Entra ID F2, Microsoft Entra ID Governance for Government, and Microsoft Entra ID Governance Add-on for Microsoft Entra ID P2 for Government. These six products differ only in their prerequisites. They contain both the entitlement management, privileged identity management, and access reviews capabilities that were in Microsoft Entra ID P2, plus additional advanced identity governance capabilities.

- **Microsoft Entra Suite**: A complete cloud-based solution for workforce access, available for Microsoft Entra ID P1 and P2 customers. Microsoft Entra Suite brings together Microsoft Entra Private Access, Microsoft Entra Internet Access, Microsoft Entra ID Governance, Microsoft Entra ID Protection, and Microsoft Entra Verified ID. The Microsoft Entra ID Governance portion provides the same identity governance capabilities as the Microsoft Entra ID Governance product. The difference is that they have different prerequisites.

Choose the license type you want based on your organization's needs.

View your active license plans in the Microsoft Entra admin center by selecting **Licenses** > **All products**. Here, you can also buy or try new licenses. Visit the M365 Admin Center to add or remove users or groups of users and see which users are included.

![Microsoft Entra ID licenses.](../media/3-licenses.png)

Select a license plan to see which users are included. In the plan, you can add or remove users or groups of users.

<a name='azure-ad-terminology'></a>

## Microsoft Entra terminology

To use Microsoft Entra ID effectively, you need to understand some key Active Directory terms.

Here's an explanation of some of those terms:

|Term|Description|
|---------|---------|
|Identity|Something that has to be identified and authenticated. An identity is typically a user with a username and password credentials, but the term can also apply to applications or services.|
|Account|An identity and its associated data. An account can't exist without an identity.|
|Microsoft Entra account|An identity created in Microsoft Entra ID, or in services like Microsoft 365. These identities are stored in Microsoft Entra ID. For example, internal staff members might use Microsoft Entra accounts daily at work.|
|Azure subscription| Your level of access to use Azure and its services. For pay-as-you-go access, use your credit card to set up an Azure subscription. There are several types of subscriptions. For example, enterprise-level customers can use Azure Enterprise Agreement subscriptions. Each account can use many subscriptions.|
|Microsoft Entra tenant|An instance of a Microsoft Entra ID. This tenant is automatically created for you when you first sign up for Azure or other services like Microsoft 365. A tenant (which represents an organization) holds your users, user groups, and applications.|
|Multitenant|Access by multiple tenants to the same applications and services in a shared environment. These tenants represent multiple organizations.|
|Microsoft Entra directory|An Azure resource created for you automatically when you subscribe to Azure. You can create many Microsoft Entra directories. Each of these directories represents a tenant.|
|Custom domain|A domain you customize for your Microsoft Entra directory. When you create a Microsoft Entra directory, Azure automatically assigns it a default domain like `<your-organization>.onmicrosoft.com`. However, you can customize domain names. Your users could then have accounts like `user@contoso.com` instead of `user@contoso.onmicrosoft.com`.|
|Owner role|The role you use to manage all Azure resources, including the access levels users need for resources.  |
|Global Administrator| The role that gives you access to all Administrative capabilities in Microsoft Entra ID. When you create a tenant, you automatically have this role for the tenant. This role allows you to reset passwords for all users and Administrators, for example.|
| | |

## Default user permissions

Microsoft Entra ID gives all of the users in your tenant a default set of permissions. Permissions dictate what a user can and can't do. The set of permissions granted by default depends on whether a user is a natural member of the tenant (as an internal employee) or a member of an outside organization. The latter is considered a guest. An example of a guest would be a vendor that is performing work for you, but isn't an official employee of the organization. Guest users are invited to the tenant through a Microsoft Entra feature called Microsoft Entra B2B.

Member users can do many things guest users can't. For example, member users manage their own profile details, like their phone number and profile photos. Guest users typically have more restrictions. For instance, guest users can view their display photos but can't change them. You could make use of this restriction by granting guest-user access to the external healthcare professionals your company works with regularly. This way, they'd have more restricted permissions than a regular internal staff member, but they'd still have enough permissions to do their work.

### Comparison of member and guest default permissions

Here are some of the default permissions for member users and guest users:

|Area  |Member user permissions  |Guest-user permissions  |
|---------|---------|---------|
|Users and contacts|Can view all profile details. Can change own password, mobile phone number, and profile photos.|Can view the profile name, email, sign-in name, photo, and user principal name. Can view the user type properties of other users and contacts. Can change own password.|
|Devices|Can read all properties of devices. Can manage all properties of owned devices.|Can't read all properties of devices. Can't manage all properties of owned devices. Can delete owned devices.|
|Applications |Can register new applications.|Can't register new applications. Can delete owned applications.|
|Policies|Can read all properties of policies and manage all properties of owned policies.|No permissions.|
|Subscriptions|Can read all subscriptions and enable service plan members.|No permissions.|
|Roles and scopes|Can read all Administrative roles and memberships. Can read all roles and scopes and membership of Administrative units.|No permissions.|
