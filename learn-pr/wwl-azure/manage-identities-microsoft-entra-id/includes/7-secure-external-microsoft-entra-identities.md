Microsoft Entra External ID combines powerful solutions for working with people outside of your organization. With External ID capabilities, you can allow external identities to securely access your apps and resources. Whether you’re working with external partners, consumers, or business customers, users can bring their own identities. These identities can range from corporate or government-issued accounts to social identity providers like Google or Facebook.

:::image type="content" source="../media/external-identities-overview-aa4d9d2e.png" alt-text="Diagram showing an example of Microsoft Entra External ID capabilities.":::


These scenarios fall within the scope of Microsoft Entra External ID:

 -  If you’re an organization or a developer creating consumer apps, use External ID to quickly add authentication and customer identity and access management (CIAM) to your application. Register your app, create customized sign-in experiences, and manage your app users in a Microsoft Entra tenant in an *external* configuration. This tenant is separate from your employees and organizational resources.
 -  If you want to enable your employees to collaborate with business partners and guests, use External ID for B2B collaboration. Allow secure access to your enterprise apps through invitation or self-service sign-up. Determine the level of access guests have to the Microsoft Entra tenant that contains your employees and organizational resources, which is a tenant in a *workforce* configuration.

Microsoft Entra External ID is a flexible solution for both consumer-oriented app developers needing authentication and CIAM, and businesses seeking secure B2B collaboration.

## Secure your apps for consumers and business customers

Organizations and developers can use [External ID in an external tenant](/entra/external-id/customers/overview-customers-ciam) as their CIAM solution when publishing their apps to consumers and business customers. You can create a separate Microsoft Entra tenant in an *external* configuration, which allows you to manage your apps and user accounts separately from your workforce. Within this tenant, you can easily configure custom-branded sign-up experiences and user management features:

 -  Set up self-service registration flows that define the series of sign-up steps customers follow and the sign-in methods they can use, such as email and password, one-time passcodes, or social accounts from Google or Facebook.
 -  Create a custom look and feel for users signing in to your apps by configuring Company branding settings for your tenant. With these settings, you can add your own background images, colors, company logos, and text to customize the sign-in experiences across your apps.
 -  Collect information from customers during sign-up by selecting from a series of built-in user attributes or adding your own custom attributes.
 -  Analyze user activity and engagement data to uncover valuable insights that can aid strategic decisions and drive business growth.

With External ID, customers can sign in with an identity they already have. You can customize and control how customers sign up and sign in when using your applications. Because these CIAM capabilities are built into External ID, you also benefit from Microsoft Entra platform features like enhanced security, compliance, and scalability.

For details, see [Overview of Microsoft Entra External ID in external tenants](/entra/external-id/customers/overview-customers-ciam).

## Collaborate with business guests

[External ID B2B collaboration](/entra/external-id/what-is-b2b) allows your workforce to collaborate with external business partners. You can invite anyone to sign in to your Microsoft Entra organization using their own credentials so they can access the apps and resources you want to share with them. Use B2B collaboration when you need to let business guests access your Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications. There are no credentials associated with business guests. Instead, they authenticate with their home organization or identity provider, and then your organization checks the user’s eligibility for guest collaboration.

There are various ways to add business guests to your organization for collaboration:

 -  Invite users to collaborate using their Microsoft Entra accounts, Microsoft accounts, or social identities that you enable, such as Google. An admin can use the Microsoft Entra admin center or PowerShell to invite users to collaborate. The user signs into the shared resources using a simple redemption process with their work, school, or other email account.
 -  Use self-service sign-up user flows to let guests sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity (like Google or Facebook). You can also collect information about the user during the sign-up process.
 -  Use [Microsoft Entra entitlement management](/entra/id-governance/entitlement-management-overview), an identity governance feature that lets you manage [identity and access for external users at scale](/entra/id-governance/entitlement-management-external-users#how-access-works-for-external-users) by automating access request workflows, access assignments, reviews, and expiration.

A user object is created for the business guest in the same directory as your employees. This user object can be managed like other user objects in your directory, added to groups, and so on. You can assign permissions to the user object (for authorization) while letting them use their existing credentials (for authentication).

You can use [cross-tenant access settings](/entra/external-id/cross-tenant-access-overview) to manage collaboration with other Microsoft Entra organizations and across Microsoft Azure clouds. For collaboration with non-Azure AD external users and organizations, use [external collaboration settings](/entra/external-id/external-collaboration-settings-configure).

## What are "workforce" and "external" tenants?

A *tenant* is a dedicated and trusted instance of Microsoft Entra ID that contains an organization's resources, including registered apps and a directory of users. There are two ways to configure a tenant, depending on how the organization intends to use the tenant and the resources they want to manage:

 -  A workforce tenant configuration is a standard Microsoft Entra tenant that contains your employees, internal business apps, and other organizational resources. In a workforce tenant, your internal users can collaborate with external business partners and guests using B2B collaboration.
 -  An external tenant configuration is used exclusively for apps you want to publish to consumers or business customers. This distinct tenant follows the standard Microsoft Entra tenant model, but is configured for consumer scenarios. It contains your app registrations and a directory of consumer or customer accounts.

For details, see [Workforce and external tenant configurations in Microsoft Entra External ID](/entra/external-id/tenant-configurations).

## Comparing External ID feature sets

The following table compares the scenarios you can enable with External ID.

| **Identity**             | **External ID in workforce tenants**                                                                                                                                                                                                                                                                                                                                                                   | **External ID in external tenants**                                                                                                                                                                                                                                                                                                                                                |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Primary scenario         | Allow your workforce to collaborate with business guests. Let guests use their preferred identities to sign in to resources in your Microsoft Entra organization. Provides access to Microsoft applications or your own applications (SaaS apps, custom-developed apps, etc.).<br><br>*Example:* Invite a guest to sign in to your Microsoft apps or become a guest member in Teams.                   | Publish apps to external consumers and business customers using External ID for identity experiences. Provides identity and access management for modern SaaS or custom-developed applications (not first-party Microsoft apps).<br><br>*Example:* Create a customized sign-in experience for users of your consumer mobile app and monitor app usage.                             |
| Intended for             | Collaborating with business partners from external organizations like suppliers, partners, vendors. These users might or might not have Microsoft Entra ID or managed IT.                                                                                                                                                                                                                              | Consumers and business customers of your app. These users are managed in a Microsoft Entra tenant that is configured for external apps and users.                                                                                                                                                                                                                                  |
| User management          | B2B collaboration users are managed in the same workforce tenant as employees but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on. [Cross-tenant access settings](/entra/external-id/cross-tenant-access-overview) can be used to determine which users have access to B2B collaboration. | App users are managed in an external tenant that you create for consumers of your application. Users in an external tenant have different [default permissions](/entra/external-id/customers/reference-user-permissions) than users in a workforce tenant. They're managed in the external tenant, separate from the organization's employee directory. |
| Single sign-on (SSO)     | SSO to all Microsoft Entra connected apps is supported. For example, you can provide access to Microsoft 365 or on-premises apps, and to other SaaS apps such as Salesforce or Workday.                                                                                                                                                                                                                | SSO to apps registered in the external tenant is supported. SSO to Microsoft 365 or to other Microsoft SaaS apps isn't supported.                                                                                                                                                                                                                                                  |
| Company branding         | The default state for the authentication experience is a Microsoft look and feel. Administrators can customize the guest sign-in experience with their company branding.                                                                                                                                                                                                                               | The default branding for the external tenant is neutral and doesn't include any existing Microsoft branding. Administrators can customize the branding for the organization or per application. [Learn more](/entra/external-id/customers/concept-branding-customers).                                                                                  |
| Microsoft cloud settings | [Supported.](/entra/external-id/cross-cloud-settings)                                                                                                                                                                                                                                                                                                                       | Not applicable.                                                                                                                                                                                                                                                                                                                                                                    |
| Entitlement management   | [Supported.](/entra/id-governance/entitlement-management-overview)                                                                                                                                                                                                                                                                                                          | Not applicable.                                                                                                                                                                                                                                                                                                                                                                    |

## Related technologies

There are several Microsoft Entra technologies that are related to collaboration with external users and organizations. As you design your External ID collaboration model, consider these other features.

## B2B direct connect

B2B direct connect lets you create two-way trust relationships with other Microsoft Entra organizations to enable the Teams Connect shared channels feature. This feature allows users to seamlessly sign in to Teams shared channels for chat, calls, file-sharing, and app-sharing. When two organizations mutually enable B2B direct connect, users authenticate in their home organization and receive a token from the resource organization for access. Unlike B2B collaboration, B2B direct connect users aren't added as guests to your workforce directory. Learn more about [B2B direct connect in Microsoft Entra External ID](/entra/external-id/b2b-direct-connect-overview).

Once you set up B2B direct connect with an external organization, the following Teams shared channels capabilities become available:

 -  A shared channel owner can search within Teams for allowed users from the external organization and add them to the shared channel.
 -  External users can access the Teams shared channel without having to switch organizations or sign in with a different account. From within Teams, the external user can access files and apps through the Files tab. The shared channel’s policies determine the user’s access.

You use [cross-tenant access settings](/entra/external-id/cross-tenant-access-settings-b2b-collaboration) to manage trust relationships with other Microsoft Entra organizations and define inbound and outbound policies for B2B direct connect.

For details about the resources, files, and applications that are available to the B2B direct connect user via the Teams shared channel refer to [Chat, teams, channels, & apps in Microsoft Teams](/microsoftteams/deploy-chat-teams-channels-microsoft-teams-landing-page).

Licensing and billing are based on monthly active users (MAU). Learn more about [External ID pricing](https://azure.microsoft.com/pricing/details/active-directory/external-identities/) and [billing setup for B2B](/entra/external-id/external-identities-pricing).

## Azure Active Directory B2C

Azure Active Directory B2C (Azure AD B2C) is Microsoft's legacy solution for customer identity and access management. Azure AD B2C includes a separate consumer-based directory that you manage in the Azure portal through the Azure AD B2C service. Each Azure AD B2C tenant is separate and distinct from other Microsoft Entra ID and Azure AD B2C tenants. The Azure AD B2C portal experience is similar to Microsoft Entra ID, but there are key differences, such as the ability to customize your user journeys using the Identity Experience Framework.

For more information about how an Azure AD B2C tenant differs from a Microsoft Entra tenant, see [Supported Microsoft Entra features in Azure AD B2C](/azure/active-directory-b2c/supported-azure-ad-features). For details about configuring and managing Azure AD B2C, see the [Azure AD B2C documentation](/azure/active-directory-b2c/).

## Microsoft Entra entitlement management for business guest sign-up

As an inviting organization, you might not know ahead of time who the individual external collaborators are who need access to your resources. You need a way for users from partner companies to sign themselves up with policies that you control. To enable users from other organizations to request access, you can use [Microsoft Entra entitlement management](/entra/id-governance/entitlement-management-overview) to configure policies that [manage access for external users](/entra/id-governance/entitlement-management-external-users#how-access-works-for-external-users). Upon approval, these users will be provisioned with guest accounts and assigned to groups, apps, and SharePoint Online sites.

## Microsoft Entra Microsoft Graph API for B2B collaboration

Microsoft Graph APIs are available for creating and managing External ID features.

 -  Cross-tenant access settings API: The [Microsoft Graph cross-tenant access API](/graph/api/resources/crosstenantaccesspolicy-overview?view=graph-rest-beta&preserve-view=true) lets you programmatically create the same B2B collaboration and B2B direct connect policies that are configurable in the Azure portal. Using the API, you can set up policies for inbound and outbound collaboration. For example, you can allow or block features for everyone by default and limit access to specific organizations, groups, users, and applications. The API also allows you to accept MFA and device claims (compliant claims and Microsoft Entra hybrid joined claims) from other Microsoft Entra organizations.
 -  B2B collaboration invitation manager: The [Microsoft Graph invitation manager API](/graph/api/resources/invitation) is available for building your own onboarding experiences for business guests. You can use the [create invitation API](/graph/api/invitation-post?tabs=http) to automatically send a customized invitation email directly to the B2B user, for example. Or your app can use the inviteRedeemUrl returned in the creation response to craft your own invitation (through your communication mechanism of choice) to the invited user.

## Conditional Access

Organizations can enforce Conditional Access policies for external B2B collaboration and B2B direct connect users in the same way that they're enabled for full-time employees and members of the organization. For Microsoft Entra cross-tenant scenarios, if your Conditional Access policies require MFA or device compliance, you can now trust MFA and device compliance claims from an external user's home organization. When trust settings are enabled, during authentication, Microsoft Entra ID checks a user's credentials for an MFA claim or a device ID to determine if the policies were already met. If so, the external user is granted seamless sign-on to your shared resource. Otherwise, an MFA or device challenge is initiated in the user's home tenant. Learn more about the [authentication flow and Conditional Access for external users](/entra/external-id/authentication-conditional-access).

## Multitenant applications

A multitenant organization is an organization that has more than one instance of Microsoft Entra ID. There are various reasons for [multi-tenancy](/entra/identity/multi-tenant-organizations/overview#what-is-a-multi-tenant-organization). For example, your organization might span multiple clouds or geographical boundaries.

Multitenant organizations use a one-way synchronization service in Microsoft Entra ID, called [cross-tenant synchronization](/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview). Cross-tenant synchronization enables seamless collaboration for a multitenant organization. It improves user experience and ensures that users can access resources, without receiving an invitation email and having to accept a consent prompt in each tenant.

Cross-tenant synchronization settings are configured under the Organization-specific access settings. To learn more about multitenant organizations and cross-tenant synchronization see the [multitenant organizations documentation](/entra/identity/multi-tenant-organizations/) and the [feature comparison](/entra/identity/multi-tenant-organizations/overview#compare-multi-tenant-capabilities).
