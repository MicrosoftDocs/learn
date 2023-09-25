
Today’s world is about collaboration, working with people both inside and outside of your organization. That means you'll sometimes need to provide access to your organization’s applications or data to external users.

Microsoft Entra ID External Identities refers to all the ways you can securely interact with users outside of your organization.

The following capabilities make up External Identities:

- B2B collaboration
- B2B direct connect
- Microsoft Entra External ID for customers (preview)
- Microsoft Entra ID multi-tenant organization

### B2B collaboration

B2B collaboration enables employees of an organization to collaborate with external users by letting them use their preferred identity to sign in to your Microsoft applications or other enterprise applications. B2B collaboration users are represented in your directory, typically as guest users.

There are no credentials associated with B2B collaboration users. Instead, they authenticate with their home organization or identity provider, and then your organization checks the guest user’s eligibility for B2B collaboration.

There are various ways to add external users to your organization for B2B collaboration:

- Invite users to B2B collaboration using their Microsoft Entra ID accounts, Microsoft accounts, or social identities that you enable. The user signs into the shared resources using a simple redemption process with their work, school, or other email account.
- Use self-service sign-up user flows to let external users sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity. You can also collect information about the user during the sign-up process.
- Use Microsoft Entra ID entitlement management, an identity governance feature that lets you manage identity and access for external users at scale by automating access request workflows, access assignments, reviews, and expiration.

A user object is created for the B2B collaboration user in the same directory as your employees. This user object can be managed like other user objects in your directory, added to groups, and so on. You can assign permissions to the user object (for authorization) while letting them use their existing credentials (for authentication).

You can manage B2B collaboration with other Microsoft Entra ID organizations and across Microsoft Azure clouds by using cross-tenant access settings that give you granular control over how external Microsoft Entra ID organizations collaborate with you (inbound access) and how your users collaborate with external Microsoft Entra ID organizations (outbound access). You can also use external collaboration settings to manage B2B collaboration with non-Microsoft Entra ID external users and organizations.

### B2B direct connect

B2B direct connect is a new way to collaborate with other Microsoft Entra ID organizations using Microsoft Teams shared channels. With B2B direct connect, you create two-way trust relationships with other Microsoft Entra ID organizations to allow users to seamlessly sign in to your shared resources and vice versa. B2B direct connect users aren't represented in your Microsoft Entra ID directory (they aren't added as guests), but they're visible from within the Teams shared channel and can be monitored in Teams admin center reports. When two organizations mutually enable B2B direct connect, users authenticate in their home organization and receive a token from the resource organization for access.

B2B direct connect enables the Teams Connect shared channels feature, which lets your users collaborate with external users from multiple organizations with a Teams shared channel for chat, calls, file-sharing, and app-sharing. Once you’ve set up B2B direct connect with an external organization, the following Teams shared channels capabilities become available:

- Within Teams, a shared channel owner can search for allowed users from the external organization and add them to the shared channel.
- External users can access the Teams shared channel without having to switch organizations or sign in with a different account. From within Teams, the external user can access files and apps through the Files tab. The user’s access is determined by the shared channel’s policies.
You use cross-tenant access settings to manage trust relationships with other Microsoft Entra ID organizations and define inbound and outbound policies for B2B direct connect.

### Microsoft Entra External ID for customers (Preview)

Microsoft Entra External ID for customers is Microsoft’s new customer identity and access management (CIAM) solution. This solution is intended for businesses that want to make applications available to their customers using the Microsoft Entra platform for identity and access.

With Microsoft Entra External ID for customers, you create a distinct tenant that follows the standard Microsoft Entra ID tenant model but is configured for customer scenarios.  Capabilities include:

- **Single sign-on (SSO) with social and enterprise identities**. Customers can choose a social, enterprise, or managed identity to sign in with a username and password, email, or one-time passcode.
- **Sign-up and sign-in pages to your apps**. Quickly add intuitive, user-friendly sign-up and sign-in experiences for your customer apps.
- **Add your company branding to the sign-up page**. Customize the look and feel of your sign-up and sign-in experiences. With a single identity, a customer can securely access all the applications you want them to use.
- **Provide self-service account management**. Customers can register for your online services by themselves, manage their profile, delete their account, enroll in a multifactor authentication (MFA) method, or reset their password with no admin or help desk assistance.

:::image type="content" source="../media/customized-screen.png" alt-text="Screen capture of a consumer sign-in screen that shows options for using a social identity account and is customized with an organization's branding.":::


### Multi-tenant organizations

A multi-tenant organization is an organization that has more than one instance of Microsoft Entra ID. There are various reasons for multi-tenancy, like using multiple clouds or having multiple geographical boundaries. Multi-tenant organizations use a one-way synchronization service in Microsoft Entra ID, called cross-tenant synchronization. Cross-tenant synchronization enables seamless collaboration for a multi-tenant organization. It improves user experience and ensures that users can access resources, without receiving an invitation email and having to accept a consent prompt in each tenant.
