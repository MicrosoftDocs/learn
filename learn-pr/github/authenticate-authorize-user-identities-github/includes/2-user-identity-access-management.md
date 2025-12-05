Authentication is the gateway to your enterprise's software development ecosystem. Every user's interaction with GitHub begins with identity verification. While individual accounts can rely on usernames and passwords, strong enterprise security mandates **two-factor authentication (2FA)** or more advanced methods like **passkeys** and **biometric login**. Balancing usability with security is key—especially in a fast-paced development environment.

## Modern Authentication in GitHub Enterprise

To ensure a secure and streamlined authentication experience, GitHub supports multiple modern methods that integrate with your identity management systems:

### Passkeys and WebAuthn
- **Passkeys** are a passwordless login method, tied to a physical device, and resistant to phishing.
- **WebAuthn** supports biometric factors and hardware tokens like YubiKey.
- These methods significantly reduce credential-based attacks and improve login UX.

### GitHub Mobile for 2FA
Users can authenticate with **GitHub Mobile**, which supports push notifications for quick, secure approval—enhancing 2FA without disrupting workflows.

### OAuth and GitHub Apps
- **OAuth Apps** use GitHub's OAuth 2.0 flow to authenticate users and grant scoped access to external applications.
- **GitHub Apps** authenticate as individual installations with fine-grained permissions and are ideal for CI/CD and automation pipelines.

### Enterprise Managed Users (EMU)
In **GitHub Enterprise Cloud**, EMUs ensure that authentication happens strictly through your **Identity Provider (IdP)**. This model:
- Restricts access to enterprise-managed accounts only.
- Enforces centralized control over identity, credentials, and session policies.

## Organization Management with SAML SSO

One foundational capability for enterprise-grade authentication is **SAML Single Sign-On (SSO)**. SAML links your IdP with GitHub, enabling users to sign in across services using one set of credentials. GitHub uses the IdP to verify user identity before granting access to organization or enterprise resources.

When users log into GitHub, they can see the enterprises they belong to—but access to repository data requires SAML reauthentication via the IdP.

As an **Enterprise Admin**, your responsibilities include:
- Authorizing access based on role and need-to-know.
- Monitoring and auditing user activity.
- Scoping permissions and minimizing surface area for attacks.

:::image type="content" source="../media/repository-permission-list-example.png" alt-text="Screenshot of an example of admin repository permission list review.":::

To configure SAML SSO for your organization, integrate your IdP with GitHub. Supported providers include:
- Active Directory Federation Services (AD FS)
- Microsoft Entra ID
- Okta
- OneLogin
- PingOne
- Shibboleth

> [!NOTE]
> GitHub provides limited support for identity providers that implement the SAML 2.0 standard.

## Enterprise Access and Authorization Controls

Access in GitHub is governed by a robust, multi-layered authorization model:

### Fine-Grained Personal Access Tokens (PATs)
Unlike classic PATs, **fine-grained PATs**:
- Restrict access to specific repositories and scopes.
- Support automatic expiration for reduced risk exposure.
- Offer enhanced traceability and compliance controls.

### Custom Repository Roles
Admins can define **custom roles** that extend beyond the default permission sets. This supports:
- Delegated access tailored to unique workflows.
- Least-privilege enforcement for sensitive repositories.

### Security Policy Enforcement
You can enforce global security controls such as:
- Mandatory **2FA** for all users.
- **IP allowlists** to restrict access to approved networks.
- Blocking unverified OAuth apps unless explicitly approved.

### Organizational and Enterprise-Level Controls
- **Organization-level** controls include default roles, team-based access, and the management of external collaborators.
- **Enterprise-level** governance includes:
  - Centralized SAML enforcement.
  - IdP-based login restrictions.
  - Global policy enforcement via **GitHub Enterprise Cloud**.

## Repository Visibility and Internal Access

When organization members create repositories, they can choose among **public**, **private**, or **internal** visibility options:
- **Public**: Available to anyone on the internet.
- **Private**: Restricted to selected users.
- **Internal**: Visible to all members within the enterprise but hidden from external users.

This granularity ensures that source code, documentation, and other assets are only shared with appropriate stakeholders.
