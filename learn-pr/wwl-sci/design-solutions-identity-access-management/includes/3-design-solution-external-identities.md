Microsoft Entra External ID refers to all the ways you can securely interact with users outside of your organization. If you want to collaborate with partners, distributors, suppliers, or vendors, you can share your resources and define how your internal users can access external organizations. If you're a developer creating consumer-facing apps, you can manage your customers' identity experiences.

With External Identities, external users can "bring their own identities." Whether they have a corporate or government-issued digital identity, or an unmanaged social identity like Google or Facebook, they can use their own credentials to sign in. The external user’s identity provider manages their identity, and you manage access to your apps with Microsoft Entra ID or Azure AD B2C to keep your resources protected.

The following capabilities make up External Identities:

-   **B2B collaboration** - Collaborate with external users by letting them use their preferred identity to sign in to your Microsoft applications or other enterprise applications (SaaS apps, custom-developed apps, etc.). B2B collaboration users are represented in your directory, typically as guest users.
    
-   **B2B direct connect** - Establish a mutual, two-way trust with another Microsoft Entra organization for seamless collaboration. B2B direct connect currently supports Teams shared channels, enabling external users to access your resources from within their home instances of Teams. B2B direct connect users aren't represented in your directory, but they're visible from within the Teams shared channel and can be monitored in Teams admin center reports.
    
-   **Azure AD B2C** - Publish modern SaaS apps or custom-developed apps (excluding Microsoft apps) to consumers and customers, while using Azure AD B2C for identity and access management.
    
-   **Microsoft Entra multi-tenant organization** - Collaborate with multiple tenants in a single Microsoft Entra organization via cross-tenant synchronization.

Depending on how you want to interact with external organizations and the types of resources you need to share, you can use a combination of these capabilities.

![External Identities overview diagram.](/azure/active-directory/external-identities/media/external-identities-overview/external-identities-b2b-overview.png)

<!--[](/azure/active-directory/external-identities/external-identities-overview#b2b-collaboration)-->

## B2B collaboration

With [B2B collaboration](/azure/active-directory/external-identities/what-is-b2b), you can invite anyone to sign in to your Microsoft Entra organization using their own credentials so they can access the apps and resources you want to share with them. Use B2B collaboration when you need to let external users access your Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications, especially when the partner doesn't use Microsoft Entra ID or it's impractical for administrators to set up a mutual connection through B2B direct connect. There are no credentials associated with B2B collaboration users. Instead, they authenticate with their home organization or identity provider, and then your organization checks the guest user’s eligibility for B2B collaboration.

There are various ways to add external users to your organization for B2B collaboration:

-   Invite users to B2B collaboration using their Microsoft Entra accounts, Microsoft accounts, or social identities that you enable, such as Google. An admin can use the Azure portal or PowerShell to invite users to B2B collaboration. The user signs into the shared resources using a simple redemption process with their work, school, or other email account.
    
-   Use self-service sign-up user flows to let external users sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity (like Google or Facebook). You can also collect information about the user during the sign-up process.
    
-   Use [Microsoft Entra entitlement management](/azure/active-directory/governance/entitlement-management-overview), an identity governance feature that lets you manage [identity and access for external users at scale](/azure/active-directory/governance/entitlement-management-external-users#how-access-works-for-external-users) by automating access request workflows, access assignments, reviews, and expiration.
    

A user object is created for the B2B collaboration user in the same directory as your employees. This user object can be managed like other user objects in your directory, added to groups, and so on. You can assign permissions to the user object (for authorization) while letting them use their existing credentials (for authentication).

You can use [cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-overview) to manage B2B collaboration with other Microsoft Entra organizations and across Microsoft Azure clouds. For B2B collaboration with non-Azure AD external users and organizations, use [external collaboration settings](/azure/active-directory/external-identities/external-collaboration-settings-configure).

<!--[](/azure/active-directory/external-identities/external-identities-overview#b2b-direct-connect)-->

## B2B direct connect

B2B direct connect is a new way to collaborate with other Microsoft Entra organizations. This feature currently works with Microsoft Teams shared channels. With B2B direct connect, you create two-way trust relationships with other Microsoft Entra organizations to allow users to seamlessly sign in to your shared resources and vice versa. B2B direct connect users aren't added as guests to your Microsoft Entra directory. When two organizations mutually enable B2B direct connect, users authenticate in their home organization and receive a token from the resource organization for access. Learn more about [B2B direct connect in Microsoft Entra ID](/azure/active-directory/external-identities/b2b-direct-connect-overview).

Currently, B2B direct connect enables the Teams Connect shared channels feature, which lets your users collaborate with external users from multiple organizations with a Teams shared channel for chat, calls, file-sharing, and app-sharing. Once you’ve set up B2B direct connect with an external organization, the following Teams shared channels capabilities become available:

-   Within Teams, a shared channel owner can search for allowed users from the external organization and add them to the shared channel.
    
-   External users can access the Teams shared channel without having to switch organizations or sign in with a different account. From within Teams, the external user can access files and apps through the Files tab. The user’s access is determined by the shared channel’s policies.
    

You use [cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-settings-b2b-collaboration) to manage trust relationships with other Microsoft Entra organizations and define inbound and outbound policies for B2B direct connect.

For details about the resources, files, and applications, that are available to the B2B direct connect user via the Teams shared channel, refer to [Chat, teams, channels, & apps in Microsoft Teams](/microsoftteams/deploy-chat-teams-channels-microsoft-teams-landing-page).

<!--[](/azure/active-directory/external-identities/external-identities-overview#azure-ad-b2c)-->

## Azure AD B2C

Azure AD B2C is a Customer Identity and Access Management (CIAM) solution that lets you build user journeys for consumer- and customer-facing apps. If you're a business or individual developer creating customer-facing apps, you can scale to millions of consumers, customers, or citizens by using Azure AD B2C. Developers can use Azure AD B2C as the full-featured CIAM system for their applications.

With Azure AD B2C, customers can sign in with an identity they've already established (like Facebook or Gmail). You can completely customize and control how customers sign up, sign in, and manage their profiles when using your applications.

Although Azure AD B2C is built on the same technology as Microsoft Entra ID, it's a separate service with some feature differences. For more information about how an Azure AD B2C tenant differs from a Microsoft Entra tenant, see [Supported Microsoft Entra features](/azure/active-directory-b2c/supported-azure-ad-features) in the [Azure AD B2C documentation](/azure/active-directory-b2c/).

<!--[](/azure/active-directory/external-identities/external-identities-overview#comparing-external-identities-feature-sets)-->

## Comparing External Identities feature sets

The following table gives a detailed comparison of the scenarios you can enable with Microsoft Entra External ID. In the B2B scenarios, an external user is anyone who isn't homed in your Microsoft Entra organization.

|   | B2B collaboration | B2B direct connect |  Azure AD B2C  |
| ---- | --- |  --- | --- |
| **Primary scenario**  | Collaborate with external users by letting them use their preferred identity to sign in to resources in your Microsoft Entra organization. Provides access to Microsoft applications or your own applications (SaaS apps, custom-developed apps, etc.). <br><br> *Example:* Invite an external user to sign in to your Microsoft apps or become a guest member in Teams. | Collaborate with users from other Microsoft Entra organizations by establishing a mutual connection. Currently can be used with Teams shared channels, which external users can access from within their home instances of Teams. <br><br> *Example:* Add an external user to a Teams shared channel, which provides a space to chat, call, and share content.  | Publish apps to consumers and customers using Azure AD B2C for identity experiences. Provides identity and access management for modern SaaS or custom-developed applications (not first-party Microsoft apps). |
| **Intended for**  | Collaborating with business partners from external organizations like suppliers, partners, vendors. These users may or may not have Microsoft Entra ID or managed IT.   |  Collaborating with business partners from external organizations that use Microsoft Entra ID, like suppliers, partners, vendors. | Customers of your product. These users are managed in a separate Microsoft Entra directory. |
| **User management**  | B2B collaboration users are managed in the same directory as employees but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on. Cross-tenant access settings can be used to determine which users have access to B2B collaboration.   |  No user object is created in your Microsoft Entra directory. Cross-tenant access settings determine which users have access to B2B collaboration. direct connect. Shared channel users can be managed in Teams, and users’ access is determined by the Teams shared channel’s policies.    | User objects are created for consumer users in your Azure AD B2C directory. They're managed separately from the organization's employee and partner directory (if any). |
| **Identity providers supported**  | External users can collaborate using work accounts, school accounts, any email address, SAML and WS-Fed based identity providers, and social identity providers like Gmail and Facebook. |  External users collaborate using Microsoft Entra ID work accounts or school accounts.   | Consumer users with local application accounts (any email address, user name, or phone number), Microsoft Entra ID, various supported social identities, and users with corporate and government-issued identities via SAML/WS-Fed-based identity provider federation. |
| **Single sign-on (SSO)**  | SSO to all Microsoft Entra connected apps is supported. For example, you can provide access to Microsoft 365 or on-premises apps, and to other SaaS apps such as Salesforce or Workday.  |  SSO to a Teams shared channel. | SSO to customer owned apps within the Azure AD B2C tenants is supported. SSO to Microsoft 365 or to other Microsoft SaaS apps isn't supported. |
| **Licensing and billing**  | Based on monthly active users (MAU), including B2B collaboration and Azure AD B2C users.  |  Based on monthly active users (MAU), including B2B collaboration, B2B direct connect, and Azure AD B2C users.   | Based on monthly active users (MAU), including B2B collaboration and Azure AD B2C users.  |
| **Security policy and compliance**        | Managed by the host/inviting organization (for example, with Conditional Access policies and cross-tenant access settings). |  Managed by the host/inviting organization (for example, with Conditional Access policies and cross-tenant access settings).   | Managed by the organization via Conditional Access and Identity Protection.         |
| **multifactor authentication (MFA)**   | If inbound trust settings to accept MFA claims from the user's home tenant are configured, and MFA policies have already been met in the user's home tenant, the external user can sign in. If MFA trust isn't enabled, the user is presented with an MFA challenge from the resource organization.  | If inbound trust settings to accept MFA claims from the user's home tenant are configured, and MFA policies have already been met in the user's home tenant, the external user can sign in. If MFA trust isn't enabled, and Conditional Access policies require MFA, the user is blocked from accessing resources. You *must* configure your inbound trust settings to accept MFA claims from the organization.  | Integrates directly with Microsoft Entra multifactor authentication.   |
| **Microsoft cloud settings**  | Supported.  | Not supported. | Not applicable.  |
| **Entitlement management**  | Supported.  | Not supported. | Not applicable. |
| **Line-of-business (LOB) apps**  | Supported.  | Not supported. Only B2B direct connect-enabled apps can be shared (currently, Teams Connect shared channels).  | Works with RESTful API.   |
| **Conditional Access**        | Managed by the host/inviting organization.|  Managed by the host/inviting organization.   |  Managed by the organization via Conditional Access and Identity Protection.        |
| **Branding**  | Host/inviting organization's brand is used.  | For sign-in screens, the user’s home organization brand is used. In the shared channel, the resource organization's brand is used. | Fully customizable branding per application or organization.   |

Based on your organization’s requirements you might use cross-tenant synchronization (preview) in multi-tenant organizations. For more information about this new feature, see the [multi-tenant organization documentation](/azure/active-directory/multi-tenant-organizations/) and the [feature comparison](/azure/active-directory/multi-tenant-organizations/overview#compare-multi-tenant-capabilities).
