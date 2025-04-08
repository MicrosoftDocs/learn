Microsoft Entra External Identities is a feature that makes it possible for you to allow people outside your organization to access your apps and resources. Your partners, distributors, suppliers, vendors, and other guest users can "bring their own identities." Whether they have a corporate or government-issued digital identity, or an unmanaged social identity like Google or Facebook, they can use their own credentials to sign in. The external user’s identity provider manages their identity, and you manage access to your apps with Microsoft Entra ID to keep your resources protected.

## Invitation redemption flow

:::image type="content" source="../media/business-to-business-invitation-redemption.png" alt-text="Diagram of the redemption of an external invitation to join Microsoft Entra tenant as a guest."::: 

1.  Microsoft Entra ID performs user-based discovery to determine if the user already exists in a managed Microsoft Entra tenant. (Unmanaged Microsoft Entra accounts can no longer be used for redemption.) If the user’s User Principal Name (UPN) matches both an existing Microsoft Entra account and a personal MSA, the user is prompted to choose which account they want to redeem with.
2.  If an admin has enabled SAML/WS-Fed IdP federation, Microsoft Entra ID checks if the user’s domain suffix matches the domain of a configured SAML/WS-Fed identity provider and redirects the user to the pre-configured identity provider.
3.  If an admin has enabled Google federation, Microsoft Entra ID checks if the user’s domain suffix is gmail.com, or googlemail.com and redirects the user to Google.
4.  The redemption process checks if the user has an existing personal MSA. If the user already has an existing MSA, they'll sign in with their existing MSA.
5.  Once the user’s home directory is identified, the user is sent to the corresponding identity provider to sign in.
6.  If no home directory is found and the email one-time passcode feature is enabled for guests, a passcode is sent to the user through the invited email. The user retrieves and enters this passcode in the Microsoft Entra sign-in page.
7.  If no home directory is found and email one-time passcode for guests is disabled, the user is prompted to create a consumer MSA with the invited email. We support creating an MSA with work emails in domains that aren't verified in Microsoft Entra ID.
8.  The user, after authenticating to the right identity provider, is redirected to Microsoft Entra ID to complete the consent experience.

## External identities scenarios<br>

Microsoft Entra External Identities focus less on a user's relationship to your organization and more on how the user wants to sign in to your apps and resources. Within this framework, Microsoft Entra ID supports various scenarios.

A B2B collaboration scenario allows you to invite external users into your own tenant as "guest" users that you can assign permissions to (for authorization) while letting them use their existing credentials (for authentication). Users sign in to the shared resources using a simple invitation and redemption process with their work, school, or other email account. You can also use Microsoft Entra entitlement management to configure policies that manage access for external users. And now with the availability of self-service sign up user flows, you can allow external users to sign up for applications themselves. The experience can be customized to allow sign up with a work, school, or social identity (such as Google or Facebook). You can also collect information about the user during the sign up process.

The following list identifies an example B2B collaboration scenario and details some of the capabilities it provides:

- Primary scenario - Collaboration using Microsoft applications (Microsoft 365, Teams, and so on) or your own applications (SaaS apps, custom-developed apps, and so on).
- Intended for - Collaborating with business partners from external organizations like suppliers, partners, vendors. Users appear as guest users in your directory.
- Identity providers supported - External users can collaborate using work accounts, school accounts, any email address, SAML and WS-Fed based identity providers, Gmail, and Facebook.
- External user management - External users are managed in the same directory as employees, but are typically annotated as guest users. Guest users can be managed the same way as employees, added to the same groups, and so on.
- Single sign-on (SSO) - SSO to all Microsoft Entra-connected apps is supported. For example, you can provide access to Microsoft 365 or on-premises apps, and to other SaaS apps such as Salesforce or Workday.
- Security policy and compliance - Managed by the host/inviting organization (for example, with Conditional Access policies).
- Branding - Host/inviting organization's brand is used.

## Manage external collaboration settings in Microsoft Entra ID<br>

This unit describes how to enable Microsoft Entra B2B collaboration. Then, we explore the ability to designate who can invite guests and determine the permissions that guests have.

By default, all users and guests in your directory can invite guests even if they're not assigned to an admin role. External collaboration settings let you turn guest invitations on or off for different types of users in your organization. You can also delegate invitations to individual users by assigning roles that allow them to invite guests.

Microsoft Entra ID allows you to restrict what external guest users can see in your Microsoft Entra directory. By default, guest users are granted a limited permission level. The guests are blocked from listing users, groups, or other directory resources, but the guests can see membership of non-hidden groups. Admins can change the guest permissions setting allowing you to restrict guest access even further, so that guests can only view their own profile information. For details, see [Restrict guest access permissions](/entra/identity/users/users-restrict-guest-permissions).

## Configure business-to-business external collaboration settings

With Microsoft Entra B2B (Business to Business) collaboration, a tenant admin can set the following invitation policies:

- Turn off invitations (no external users can be invited)
- Only admins and users in the Guest Inviter role can invite (only admins and users in the Guest Inviter role can invite)
- Admins, the Guest Inviter role, and members can invite (same as above setting, but invited members can also invite external users)
- All users, including guests, can invite (as the name implies, all users in the tenant can invite external users)

By default, all users, including guests, can invite guest users.
