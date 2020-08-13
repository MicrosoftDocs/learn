Azure Active Directory (Azure AD) is a Microsoft cloud-based identity and access management service.

Active Directory Domain Services (Active Directory) provides the ability to manage on-premises infrastructure components and systems by using a single identity per user. In contrast, think of Azure AD as the next evolution of identity and access management solutions for the cloud.

Tailwind Traders uses Active Directory to secure their on-premises environments. How can they integrate their existing Active Directory instance with Azure AD to create a consistent access model across their organization?

In this part, you'll learn more about how Azure AD works and how Azure AD works with single sign-on (SSO).

Let's start with a brief overview of SSO.

## What's single sign-on (SSO)?

Single sign-on enables a user to sign in one time and use that credential to access multiple resources and applications.

The more identities a user has to manage, the greater the risk of a credential-related security incident. More identities mean more passwords to remember and periodically change. Password policies can vary among applications and, as complexity requirements increase, it becomes increasingly difficult for users to remember them.

Consider the process of managing all those identities. Additional strain is placed on help desks as they deal with account lockouts and password reset requests. If a user leaves an organization, tracking down all those identities and ensuring they are disabled can be challenging. If an identity is overlooked, this could allow access when it should have been eliminated.

With SSO, you need to remember only one ID and one password. Access across applications is granted to a single identity that's tied to the user, which simplifies the security model. As users change roles or leave an organization, access is tied to a single identity, which greatly reduces the effort needed to change or disable accounts. Using SSO for accounts makes it easier for users to manage their identities and increases your security capabilities.

## What kinds of resources can Azure AD help secure?

Azure AD helps users access both external and internal resources.

**External resources** might include Microsoft Office 365, the Azure portal, and thousands of other software as a service (SaaS) applications.

**Internal resources** might include apps on your corporate network and intranet, along with any cloud applications developed within your organization.

## What services does Azure AD provide?

Azure AD provides services such as:

* **Authentication**

    This includes verifying identity to access applications and resources, and providing functionality such as self-service password reset, multi-factor authentication (MFA), a custom banned password list, and smart lockout services.
* **Single sign-on (SSO)**

    As mentioned earlier, SSO enables you to remember only one ID and one password to access multiple applications. A single identity is tied to a user, which simplifies the security model. As users change roles or leave an organization, access modifications are tied to that identity, which greatly reduces the effort needed to change or disable accounts.
* **Application management**

    You can manage your cloud and on-premises apps by using Azure AD Application Proxy, single sign-on, the My apps portal (also referred to as *Access panel*), and SaaS apps.
* **Device management**

    Manage how your cloud or on-premises devices access your corporate data.

## Who is Azure AD for?

Azure AD is for:

* **IT administrators**

    Administrators can use Azure AD to control access to apps and resources based on their business requirements.
* **App developers**

    Developers can use Azure AD to provide a standards-based approach for adding functionality to applications that they build, such as adding SSO functionality to an app or enabling an app to work with a user's existing credentials.
* **Online service subscribers**

    Microsoft 365, Microsoft Office 365, Azure, and  Microsoft Dynamics CRM Online subscribers are already using Azure AD.

    A _tenant_ is a representation of an organization. A tenant is typically separated from other tenants and has its own identity.

    Each Microsoft 365, Office 365, Azure, and Dynamics CRM Online tenant is automatically an Azure AD tenant.

## How does SSO work with Azure AD?

By using Azure AD for single sign-on, you also have the ability to combine multiple data sources into an intelligent security graph. This security graph provides threat analysis and real-time identity protection to all accounts in Azure AD, including accounts that are synchronized from your on-premises Active Directory. By using a single identity provider, you have centralized the security controls, reporting, alerting, and administration of your identity infrastructure.

As Tailwind Traders integrates its existing Active Directory instance with Azure AD, they create a consistent access model across their organization. Doing so greatly simplifies their ability to sign into applications such as email and Office 365 without having to re-authenticate each time.
