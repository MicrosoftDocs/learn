Organizations frequently collaborate with external partners, customers, and other parties who don't have accounts in the organization's directory. As a security architect, you design solutions that enable secure external access while maintaining governance and control over organizational resources. Microsoft Entra External ID is the primary solution for working with people outside your organization.

## Design considerations for external identities

Your external identity design depends on several key factors that determine the appropriate solution approach:

| Factor | Design Impact |
|--------|---------------|
| **Relationship type** | Partners and vendors typically require B2B collaboration in your workforce tenant. Consumer apps need a separate external tenant for customer identity and access management (CIAM). |
| **Identity ownership** | External users should bring their own identities whenever possible, reducing your administrative overhead and eliminating password management for external accounts. |
| **Tenant configuration** | Workforce tenants host employees and B2B guests together. External tenants isolate customer identities separately from your organizational resources. |
| **Scale and performance** | B2B collaboration suits thousands of partners. External tenants scale to millions of customers with enhanced performance characteristics. |
| **Branding requirements** | B2B collaboration uses your organization's Microsoft branding by default. External tenants support fully customized, neutral branding per application. |
| **Application access** | B2B guests can access Microsoft 365 and enterprise apps. External tenant users access only apps registered in that tenant—not Microsoft 365 or other Microsoft SaaS apps. |

## Microsoft Entra External ID

Microsoft Entra External ID combines powerful solutions for working with people outside your organization. Users can bring their own identities, ranging from corporate or government-issued accounts to social identity providers like Google or Facebook.

External ID addresses two primary scenarios through different tenant configurations:

| Scenario | Tenant Type | Primary Use Case |
|----------|-------------|------------------|
| **B2B collaboration** | Workforce tenant | Partners, vendors, and contractors accessing your organization's Microsoft 365 apps, SharePoint, Teams, and line-of-business applications |
| **Customer identity (CIAM)** | External tenant | Consumers and business customers accessing your custom applications with branded sign-in experiences |

:::image type="content" source="../media/external-id-tenant-configurations.png" lightbox="../media/external-id-tenant-configurations.png" alt-text="Diagram showing a representation of the two external ID scenarios and the corresponding tenant type. Collaboration with business guests uses a workforce tenant configuration. External facing apps use an external tenant configuration.":::

### B2B collaboration in workforce tenants

B2B collaboration enables your workforce to work securely with external business partners. You invite guests to sign in to your Microsoft Entra organization using their own credentials, granting them access to the apps and resources you choose to share.

With B2B collaboration, the partner uses their own identity management solution. You don't manage external accounts, sync accounts, or handle password resets. Guest users authenticate with their home organization or identity provider, while your organization controls resource access through policies. This means B2B guests are subject to your Conditional Access policies, MFA requirements, terms of use, and other security controls—just like your internal users.

:::image type="content" source="../media/b2b-collaboration-overview.png" lightbox="../media/b2b-collaboration-overview.png" alt-text="Diagram showing a representation of B2B collaboration.":::

#### Authentication with B2B collaboration

When you invite a guest user, they redeem the invitation using their existing credentials. Microsoft Entra ID creates a user object in your directory representing the guest. This object has a user type of "guest" and a user principal name containing the #EXT# identifier.

Guest users can authenticate using:

- **Microsoft Entra ID** from their home organization
- **Microsoft accounts** (personal accounts)
- **Email one-time passcode** - enabled by default for all tenants as a fallback method
- **Social identity providers** - Google, Facebook, and others you configure
- **SAML/WS-Fed federation** - direct federation with external identity providers

#### Cross-tenant access settings

Cross-tenant access settings provide granular control over B2B collaboration with other Microsoft Entra organizations. These settings determine both the level of inbound access that external users have to your resources and the outbound access your users have to external organizations.

**Inbound access settings** control whether users from external Microsoft Entra organizations can access resources in your organization. You can apply these settings to everyone or specify individual users, groups, and applications.

**Outbound access settings** control whether your users can access resources in an external organization. Like inbound settings, you can scope these to specific users, groups, and applications.

**Trust settings** determine whether your Conditional Access policies trust claims from external organizations:

- **MFA claims** - Accept multifactor authentication completed in the user's home tenant
- **Compliant device claims** - Trust device compliance status from partner organizations
- **Microsoft Entra hybrid joined device claims** - Accept hybrid join status from external tenants

When trust settings are enabled, users who already satisfied these requirements in their home tenant don't face redundant authentication prompts. This creates a seamless collaboration experience while maintaining security.

**Automatic redemption** suppresses the consent prompt when both organizations enable this setting. Users don't receive invitation emails or consent prompts—they simply access resources after authenticating with their home organization.

#### B2B direct connect

B2B direct connect creates two-way trust relationships with other Microsoft Entra organizations for Teams shared channels. Unlike B2B collaboration, B2B direct connect users aren't added as guests to your directory. They authenticate in their home organization and receive a token from your organization for access.

Both organizations must mutually enable B2B direct connect through cross-tenant access settings. This feature enables:

- Shared channel owners can search for and add users from external organizations
- External users access Teams shared channels without switching organizations or signing in with different accounts
- Files and apps are accessible through the shared channel's Files tab

## Customer identity in external tenants

When building applications for consumers or business customers, Microsoft Entra External ID in an external tenant provides customer identity and access management (CIAM) capabilities. This configuration isolates customer identities from your workforce directory.

:::image type="content" source="../media/customer-identity-access-management.png" lightbox="../media/customer-identity-access-management.png" alt-text="Diagram showing a representation of External ID in an external tenant.":::

#### External tenant characteristics

An external tenant is a dedicated Microsoft Entra tenant configured exclusively for apps you publish to consumers or business customers:

- **Isolated directory** - Customer accounts are separate from employees and internal resources
- **Neutral default branding** - No Microsoft branding by default; fully customizable appearance
- **Optimized for scale** - Built to handle hundreds of thousands or millions of users
- **App-focused access** - Users access only apps registered in the external tenant

#### CIAM capabilities

External tenants support comprehensive customer identity management:

**Self-service registration flows** define the sign-up steps customers follow and the sign-in methods they can use:
- Email and password with email verification
- Email one-time passcode (passwordless)
- Social accounts from Google, Facebook, or Apple

**Company branding** customizes the sign-in experience with your own:
- Background images and colors
- Company logos
- Custom text across all your apps

**User attributes** collect information during sign-up using built-in attributes or custom attributes you define.

**Analytics** provide user activity and engagement data to support strategic decisions and business growth.

#### Authentication methods for customers

External tenants support MFA through Conditional Access policies with two second-factor methods:

- **Email one-time passcode** - After signing in with email and password, users receive a passcode sent to their email
- **SMS-based authentication** - Users verify via SMS, available for users signing in with email, one-time passcode, or social identities

## Decentralized identity with Microsoft Entra Verified ID

For scenarios requiring privacy-preserving identity verification, Microsoft Entra Verified ID enables users to present cryptographically verifiable claims without requiring direct communication between the verifier and the issuer.

:::image type="content" source="../media/verified-id-flow.png" lightbox="../media/verified-id-flow.png" alt-text="Diagram showing the flow for the issuance and verification of a verifiable credential.":::

### When to use Verified ID

Consider decentralized identity when:

- You need to verify claims without storing personal data (age verification, credential validation)
- Minimizing data liability is important—less stored data means reduced breach impact
- Multiple organizations need to trust the same credentials without sharing databases
- Users should control their identity data, presenting only what's required
- Regulatory compliance mandates data minimization

### Verified ID capabilities

Microsoft Entra Verified ID provides:

- **Credential issuance** based on W3C verifiable credentials standards
- **Credential verification** for claims presented by users
- **Integration** with existing Microsoft Entra ID infrastructure
- **Wallet support** for mobile applications that store user credentials

## Govern external access with Microsoft Entra ID Governance

Microsoft Entra ID Governance is a separate identity governance suite that complements Microsoft Entra External ID. While External ID handles authentication and identity management for external users, ID Governance provides lifecycle management and access control capabilities for both internal and external users.

### Entitlement management for external access

Entitlement management, a feature of Microsoft Entra ID Governance, automates the external access lifecycle when you don't know ahead of time which external users need access. It integrates with B2B collaboration by automatically provisioning guest accounts when access is approved.

Key capabilities include:

- **Access packages** bundle resources (groups, apps, SharePoint sites) with policies and approvals
- **Self-service portal** enables external users to request access without administrator involvement
- **Approval workflows** route requests to appropriate business owners or managers
- **Automatic expiration** removes access after a defined period
- **Access reviews** prompt resource owners to periodically recertify guest access

Upon approval, entitlement management creates guest accounts through B2B collaboration and assigns users to the appropriate groups, apps, and SharePoint sites automatically. When access expires or is revoked, the guest account can be automatically removed.

### Verified ID integration with entitlement management

Entitlement management integrates with Microsoft Entra Verified ID to require identity proofing during access requests. Access package managers can require requestors to present verifiable credentials from trusted issuers—such as training certifications, work authorization, or professional licenses—before granting access. This combination provides high-assurance verification for sensitive resources without storing personal data in your directory.

## Security controls for external identities

Apply these controls regardless of your external identity approach:

| Control | Implementation |
|---------|----------------|
| **Conditional Access** | Create policies specifically targeting guest users or customer sign-ins with appropriate restrictions |
| **MFA requirements** | Require MFA for external users, or trust home tenant MFA through cross-tenant access settings for B2B guests |
| **Terms of use** | Require acceptance of acceptable use policies before accessing resources |
| **Access reviews** | Regularly review guest access and remove users who no longer need access |
| **Session controls** | Limit session duration for external users |
| **Tenant restrictions** | Control which external accounts users can access from managed devices |
