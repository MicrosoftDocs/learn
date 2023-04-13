Azure AD External Identities is a feature that makes it possible for you to allow people outside your organization to access your apps and resources. They access with a sign-in using whatever identity they prefer. Your partners, distributors, suppliers, vendors, and other guest users can "bring their own identities." Whether they have a corporate or government-issued digital identity, or an unmanaged social identity like Google or Facebook, they can use their own credentials to sign in. The external user’s identity provider manages their identity, and you manage access to your apps with Azure AD to keep your resources protected.<br>

:::image type="content" source="../media/external-user-state-diagram-aac1f75a.png" alt-text="Diagram of the different ways an external user account can be generated and verified, when invited to your Azure A D.":::


Depending on the inviting organization's needs, an Azure AD B2B collaboration user can be in one of the following account states:

| **State** | **Definition**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| State 1   | Homed in an external instance of Azure AD and represented as a guest user in the inviting organization. In this case, the B2B user signs in by using an Azure AD account that belongs to the invited tenant. If the partner organization doesn't use Azure AD, the guest user in Azure AD is still created. The requirements are that they redeem their invitation and Azure AD verifies their email address. This arrangement is also called a just-in-time (JIT) tenancy or a "viral" tenancy. |
| State 2   | Homed in a Microsoft or other account and represented as a guest user in the host organization. In this case, the guest user signs in with a Microsoft account or a social account. The invited user's identity is created as a Microsoft account in the inviting organization’s directory during offer redemption.                                                                                                                                                                              |
| State 3   | Homed in the host organization's on-premises Active Directory and synced with the host organization's Azure AD. You can use Azure AD Connect to sync the partner accounts to the cloud as Azure AD B2B users with UserType = Guest.                                                                                                                                                                                                                                                              |
| State 4   | Homed in the host organization's Azure AD with UserType = Guest and credentials that the host organization manages.                                                                                                                                                                                                                                                                                                                                                                              |

## External identities scenarios

Azure AD External Identities focus less on a user's relationship to your organization and more on how the user wants to sign in to your apps and resources. Within this framework, Azure AD supports various scenarios.

A B2B collaboration scenario allows you to invite external users into your own tenant as "guest" users that you can assign permissions to (for authorization) while letting them use their existing credentials (for authentication). Users sign in to the shared resources using a simple invitation and redemption process with their work, school, or other email account. You can also use Azure AD entitlement management to configure policies that manage access for external users. And now with the availability of self-service sign-up user flows (preview), you can allow external users to sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity (such as Google or Facebook). You can also collect information about the user during the sign-up process.

The following list identifies an example B2B collaboration scenario and details some of the capabilities it provides:

 -  **Primary scenario** \- Collaboration using Microsoft applications (Microsoft 365, Teams, and so on) or your own applications (SaaS apps, custom-developed apps, and so on).
 -  **Intended for** \- Collaborating with business partners from external organizations like suppliers, partners, vendors. Users appear as guest users in your directory. These users may or may not have managed IT.
 -  **Identity providers supported** \- External users can collaborate using work accounts, school accounts, any email address, SAML and WS-Fed based identity providers, Gmail, and Facebook.
 -  **External user management** \- External users are managed in the same directory as employees, but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on.
 -  **Single sign-on (SSO)** \- SSO to all Azure AD-connected apps is supported. For example, you can provide access to Microsoft 365 or on-premises apps, and to other SaaS apps such as Salesforce or Workday.
 -  **Security policy and compliance** \- Managed by the host/inviting organization (for example, with Conditional Access policies).
 -  **Branding** \- Host/inviting organization's brand is used.

## Manage external collaboration settings in Azure Active Directory

This unit describes how to enable Azure Active Directory (Azure AD) B2B collaboration. Then, we explore the ability to designate who can invite guests, and determine the permissions that guests have.

By default, all users and guests in your directory can invite guests even if they're not assigned to an admin role. External collaboration settings let you turn guest invitations on or off for different types of users in your organization. You can also delegate invitations to individual users by assigning roles that allow them to invite guests.

Azure AD allows you to restrict what external guest users can see in your Azure AD directory. By default, guest users are granted a limited permission level. The guests are blocked from listing users, groups, or other directory resources. But, the guests can see membership of non-hidden groups. A new preview setting lets you restrict guest access even further, so that guests can only view their own profile information. For details, see [Restrict guest access permissions](/azure/active-directory/enterprise-users/users-restrict-guest-permissions).

## Configure business-to-business external collaboration settings

With Azure AD B2B (Business to Business) collaboration, a tenant admin can set the following invitation policies:

 -  Turn off invitations (no external users can be invited)
 -  Only admins and users in the Guest Inviter role can invite (only admins and users in the Guest Inviter role can invite)
 -  Admins, the Guest Inviter role, and members can invite (same as above setting, but invited members can also invite external users)
 -  All users, including guests, can invite (as the name implies, all users in the tenant can invite external users)

By default, all users, including guests, can invite guest users.
