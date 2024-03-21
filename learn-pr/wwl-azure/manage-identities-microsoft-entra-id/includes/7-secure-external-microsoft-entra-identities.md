Microsoft Entra External ID refers to all the ways you can securely interact with users outside of your organization. If you want to collaborate with partners, distributors, suppliers, or vendors, you can share your resources and define how your internal users can access external organizations. If you're a developer creating consumer-facing apps, you can manage your customers' identity experiences.

With External ID, external users can "bring their own identities." Whether they have a corporate or government-issued digital identity, or an unmanaged social identity like Google or Facebook, they can use their own credentials to sign in. The external user’s identity provider manages their identity, and you manage access to your apps with Microsoft Entra ID or Microsoft Entra B2C to keep your resources protected.

The following capabilities make up External Identities:

 -  B2B collaboration - Collaborate with external users by letting them use their preferred identity to sign in to your Microsoft applications or other enterprise applications (SaaS apps, custom-developed apps, etc.). B2B collaboration users are represented in your directory, typically as guest users.
 -  B2B direct connect - Establish a mutual, two-way trust with another Microsoft Entra organization for seamless collaboration. B2B direct connect currently supports Teams shared channels, enabling external users to access your resources from within their home instances of Teams. B2B direct connect users aren't represented in your directory, but they're visible from within the Teams shared channel and can be monitored in Teams admin center reports.
 -  Microsoft Entra B2C - Publish modern SaaS apps or custom-developed apps (excluding Microsoft apps) to consumers and customers, while using Microsoft Entra B2C for identity and access management.
 -  Microsoft Entra multitenant organization - Collaborate with multiple tenants in a single Microsoft Entra organization via cross-tenant synchronization.

Depending on how you want to interact with external organizations and the types of resources you need to share, you can use a combination of these capabilities. :::image type="content" source="../media/secure-external-identities-compliance-c4fd3af7.png" alt-text="Screenshot of table showing when to use external identities.":::


## B2B collaboration

With B2B collaboration, you can invite anyone to sign in to your Microsoft Entra organization using their own credentials so they can access the apps and resources you want to share with them. Use B2B collaboration when you need to let external users access your Office 365 apps, software-as-a-service (SaaS) apps, and line-of-business applications, especially when the partner doesn't use Microsoft Entra ID or it's impractical for administrators to set up a mutual connection through B2B direct connect. There are no credentials associated with B2B collaboration users. Instead, they authenticate with their home organization or identity provider, and then your organization checks the guest user’s eligibility for B2B collaboration.

There are various ways to add external users to your organization for B2B collaboration:

 -  Invite users to B2B collaboration using their Microsoft Entra accounts, Microsoft accounts, or social identities that you enable, such as Google. An admin can use the Azure portal or PowerShell to invite users to B2B collaboration. The user signs into the shared resources using a simple redemption process with their work, school, or other email account.
 -  Use self-service sign-up user flows to let external users sign up for applications themselves. The experience can be customized to allow sign-up with a work, school, or social identity (like Google or Facebook). You can also collect information about the user during the sign-up process.
 -  Use Microsoft Entra entitlement management, an identity governance feature that lets you manage identity and access for external users at scale by automating access request workflows, access assignments, reviews, and expiration.<br>

A user object is created for the B2B collaboration user in the same directory as your employees. This user object can be managed like other user objects in your directory, added to groups, and so on. You can assign permissions to the user object (for authorization) while letting them use their existing credentials (for authentication).<br>

You can use cross-tenant access settings to manage B2B collaboration with other Microsoft Entra organizations and across Microsoft Azure clouds. For B2B collaboration with non-Microsoft Entra External ID users and organizations, use external collaboration settings.<br>

## **B2B direct connect**<br>

B2B direct connect is a new way to collaborate with other Microsoft Entra organizations. This feature currently works with Microsoft Teams shared channels. With B2B direct connect, you create two-way trust relationships with other Microsoft Entra organizations to allow users to seamlessly sign in to your shared resources and vice versa. B2B direct connect users aren't added as guests to your Microsoft Entra directory. When two organizations mutually enable B2B direct connect, users authenticate in their home organization and receive a token from the resource organization for access. Learn more about B2B direct connect in Microsoft Entra External ID.

Currently, B2B direct connect enables the Teams Connect shared channels feature, which lets your users collaborate with external users from multiple organizations with a Teams shared channel for chat, calls, file-sharing, and app-sharing. Once you’ve set up B2B direct connect with an external organization, the following Teams shared channels capabilities become available:<br>

 -  Within Teams, a shared channel owner can search for allowed users from the external organization and add them to the shared channel.<br>
 -  External users can access the Teams shared channel without having to switch organizations or sign in with a different account. From within Teams, the external user can access files and apps through the Files tab. The user’s access is determined by the shared channel’s policies.<br>

You use cross-tenant access settings to manage trust relationships with other Microsoft Entra organizations and define inbound and outbound policies for B2B direct connect.

## Microsoft Entra B2C

Microsoft Entra B2C is a Customer Identity and Access Management (CIAM) solution that lets you build user journeys for consumer- and customer-facing apps. If you're a business or individual developer creating customer-facing apps, you can scale to millions of consumers, customers, or citizens by using Microsoft Entra B2C. Developers can use Microsoft Entra B2C as the full-featured CIAM system for their applications.

With Microsoft Entra B2C, customers can sign in with an identity they've already established (like Social Networks or Public Cloud Platforms). You can completely customize and control how customers sign up, sign in, and manage their profiles when using your applications.<br>

Although Microsoft Entra B2C is built on the same technology as Microsoft Entra External ID, it's a separate service with some feature differences.
