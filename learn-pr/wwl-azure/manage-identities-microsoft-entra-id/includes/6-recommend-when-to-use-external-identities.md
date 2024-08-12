B2B collaboration is a feature within Microsoft Entra External ID that lets you invite guest users to collaborate with your organization. With B2B collaboration, you can securely share your company's applications and services with external users, while maintaining control over your own corporate data. Work safely and securely with external partners, large or small, even if they don't have Microsoft Entra ID or an IT department.

:::image type="content" source="../media/business-to-business-collaboration-916353ba.png" alt-text="Diagram showing how Microsoft Entra External ID that lets you invite guest users to collaborate with your organization.":::


A simple invitation and redemption process lets partners use their own credentials to access your company's resources. You can also enable self-service sign-up user flows to let external users sign up for apps or resources themselves. Once the external user has redeemed their invitation or completed sign-up, they're represented in your directory as a user object. The user type for these B2B collaboration users is typically set to "guest" and their user principal name contains the \#EXT\# identifier.

Developers can use Microsoft Entra business-to-business APIs to customize the invitation process or write applications like self-service sign-up portals. For licensing and pricing information related to guest users, refer to [Microsoft Entra External ID pricing](https://azure.microsoft.com/pricing/details/active-directory/external-identities/).

**Collaborate with any partner using their identities**

With Microsoft Entra B2B, the partner uses their own identity management solution, so there's no external administrative overhead for your organization. Guest users sign in to your apps and services with their own work, school, or social identities.

 -  The partner uses their own identities and credentials, whether or not they have a Microsoft Entra account.<br>
 -  You don't need to manage external accounts or passwords.
 -  You don't need to sync accounts or manage account lifecycles.

Manage collaboration with other organizations and clouds

B2B collaboration is enabled by default, but comprehensive admin settings let you control your inbound and outbound B2B collaboration with external partners and organizations:

 -  For B2B collaboration with other Microsoft Entra organizations, use cross-tenant access settings. Manage inbound and outbound B2B collaboration, and scope access to specific users, groups, and applications. Set a default configuration that applies to all external organizations, and then create individual, organization-specific settings as needed. Using cross-tenant access settings, you can also trust multi-factor (MFA) and device claims (compliant claims and Microsoft Entra hybrid joined claims) from other Microsoft Entra organizations.<br>
 -  Use external collaboration settings to define who can invite external users, allow or block B2B specific domains, and set restrictions on guest user access to your directory.<br>
 -  Use Microsoft cloud settings to establish mutual B2B collaboration between the Microsoft Azure global cloud and Microsoft Azure Government or Microsoft Azure operated by 21Vianet.

## Easily invite guest users from the Azure portal

As an administrator, you can easily add guest users to your organization in the Azure portal.

 -  [Create a new guest user](/entra/external-id/b2b-quickstart-add-guest-users-portal) in Microsoft Entra ID, similar to how you'd add a new user.
 -  Assign guest users to apps or groups.
 -  [Send an invitation email](/entra/external-id/invitation-email-elements) that contains a redemption link, or send a direct link to an app you want to share.

:::image type="content" source="../media/invite-external-user-1b53c66b.png" alt-text="Screenshot showing the Microsoft Entra admin center for inviting an external user.":::


 -  Guest users follow a few simple redemption steps to sign in.

:::image type="content" source="../media/review-permissions-f0a7a68d.png" alt-text="Screenshot showing the review permissions template that is used to invite guest users.":::


## Allow self-service sign-up

With a self-service sign-up user flow, you can create a sign-up experience for external users who want to access your apps. As part of the sign-up flow, you can provide options for different social or enterprise identity providers, and collect information about the user. Learn about [self-service sign-up and how to set it up](/entra/external-id/self-service-sign-up-overview).

You can also use API connectors to integrate your self-service sign-up user flows with external cloud systems. You can connect with custom approval workflows, perform identity verification, and validate user-provided information.

:::image type="content" source="../media/sign-up-and-sign-in-page-422a2552.png" alt-text="Screenshot showing the external identities sign up page.":::


## Use policies to securely share your apps and services

You can use authentication and authorization policies to protect your corporate content. Conditional Access policies, such as multifactor authentication, can be enforced:

 -  At the tenant level.<br>
 -  At the application level.
 -  For specific guest users to protect corporate apps and data.

:::image type="content" source="../media/getting-started-28cfa399.png" alt-text="Screenshot showing the getting started page for using authentication and authorization policies to protect your corporate content.":::


## Let application and group owners manage their own guest users

You can delegate guest user management to application owners so that they can add guest users directly to any application they want to share, whether it's a Microsoft application or not.

 -  Administrators set up self-service app and group management.
 -  Non-administrators use their [Access Panel](https://myapps.microsoft.com/) to add guest users to applications or groups.

:::image type="content" source="../media/self-service-application-portal-26f89656.png" alt-text="Screenshot showing how application and group owners manage their own guest users.":::


## Customize the onboarding experience for B2B guest users

Bring your external partners on board in ways customized to your organization's needs.

 -  Use [Microsoft Entra entitlement management](/entra/id-governance/entitlement-management-overview) to configure policies that [manage access for external users](/entra/id-governance/entitlement-management-external-users#how-access-works-for-external-users).
 -  Use the [B2B collaboration invitation APIs](/graph/api/resources/invitation) to customize your onboarding experiences.

## Integrate with Identity providers

Microsoft Entra External ID supports external identity providers like Facebook, Microsoft accounts, Google, or enterprise identity providers. You can set up federation with identity providers. This way your external users can sign in with their existing social or enterprise accounts instead of creating a new account just for your application. Learn more about [identity providers for External ID](/entra/external-id/identity-providers).

:::image type="content" source="../media/integrate-with-identity-providers-49ba1fd1.png" alt-text="Screenshot showing the external identities configuration and settings page in the Azure dashboard.":::
<br>

## Integrate with SharePoint and OneDrive

You can [enable integration with SharePoint and OneDrive](/sharepoint/sharepoint-azureb2b-integration) to share files, folders, list items, document libraries, and sites with people outside your organization, while using Azure B2B for authentication and management. The users you share resources with are typically guest users in your directory, and permissions and groups work the same for these guests as they do for internal users. When enabling integration with SharePoint and OneDrive, you also enable the [email one-time passcode](/entra/external-id/one-time-passcode) feature in Microsoft Entra B2B to serve as a fallback authentication method.

:::image type="content" source="../media/email-one-time-passcode-for-guests-d5d36965.png" alt-text="Screenshot showing how to configure an identity provider email with a one-time passcode.":::
<br>
