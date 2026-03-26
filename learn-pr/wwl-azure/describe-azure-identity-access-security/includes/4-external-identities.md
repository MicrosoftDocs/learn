An external identity is a person, device, or service that exists outside your tenant. Microsoft Entra External ID includes the capabilities used to securely interact with users beyond your tenant boundary.

## Why external identities matter

Organizations often need to collaborate with partners, suppliers, vendors, and contractors. External identities let those users access approved resources by using their existing credentials, while your team still enforces access policies.

For example, a project team can invite a supplier's users into specific collaboration spaces without creating and managing separate local credentials for each guest.

External identities can sound similar to single sign-on, but they're used for cross-tenant and consumer access scenarios. External users can bring their own identities, whether those are work accounts, government-issued digital identities, or social identities such as Google or Facebook.

The external identity provider manages authentication, and you manage authorization to your applications with Microsoft Entra ID or Azure AD B2C.

:::image type="content" source="../media/external-identities-option-flow-map.png" alt-text="Diagram showing the three Microsoft Entra External ID capabilities: B2B Collaboration creates guest users in your directory, B2B Direct Connect uses mutual trust for Teams shared channels without directory presence, and External ID for Customers manages consumer access in a separate tenant.":::


## External ID capabilities

The following capabilities make up External Identities:

 -  **B2B collaboration** \- Collaborate with external users by letting them use their preferred identity to sign in to your Microsoft applications or other internal applications (SaaS apps, custom-developed apps, etc.). B2B collaboration users are represented in your directory, typically as guest users.
 -  **B2B direct connect** \- Establish a mutual, two-way trust with another Microsoft Entra tenant for seamless collaboration. B2B direct connect currently supports Teams shared channels, enabling external users to access your resources from within their home instances of Teams. B2B direct connect users aren't represented in your directory, but they're visible from within the Teams shared channel and can be monitored in Teams admin center reports.
 -  **Microsoft Entra External ID for customers (formerly Azure AD B2C)** \- Publish modern SaaS apps or custom-developed apps (excluding Microsoft apps) to consumers and customers, while using Entra External ID for identity and access management.

:::image type="content" source="../media/external-identities-option-capabilities-cards.png" alt-text="Comparison cards for the three External ID capabilities showing who uses each, how access works, directory presence, and best-fit scenarios.":::

Depending on your collaboration goals and the resources being shared, you can combine these capabilities.

## Manage guest access over time

With Microsoft Entra ID, you can enable collaboration across tenant boundaries by using B2B features. Guest users from other tenants can be invited by administrators or authorized users. This capability also applies to social identities such as Microsoft accounts.

You also can easily ensure that guest users have appropriate access. You can ask the guests themselves or a decision maker to participate in an access review and recertify (or attest) to the guests' access. The reviewers can give their input on each user's need for continued access, based on suggestions from Microsoft Entra ID. When an access review is finished, you can then make changes and remove access for guests who no longer need it.

