
Modern authentication is a framework in which authentication and authorization services are provided by a dedicated, centralized service—the *identity provider*—rather than being built into each individual application. This approach transforms how organizations manage access and significantly improves consistency, visibility, and control.

## The role of the identity provider

An *identity provider (IdP)* creates, maintains, and manages identity information, and offers authentication, authorization, and auditing services to applications and services. Instead of each application managing its own user accounts and security policies, applications delegate these responsibilities to the identity provider.

When a user wants to sign in to an application, the application directs them to the identity provider. The identity provider verifies their credentials and—if verification succeeds—issues a *security token* that the user presents back to the application. The application trusts the identity provider and accepts the token as proof of successful authentication.

This video introduces modern authentication and how it works with a central identity provider:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=24d9f006-33a7-4b37-9aba-d35f16ab372d]

## Why centralize authentication?

Without a central identity provider, each application manages its own user accounts and enforces its own security policies. This creates several challenges:

- **Fragmented credentials**: Users maintain separate usernames and passwords for each application. This leads to password reuse, weak passwords, and difficulty removing access when someone leaves the organization.
- **Inconsistent security policies**: Each application may have different standards for password complexity and MFA requirements, making it difficult to enforce a consistent security baseline.
- **Administrative overhead**: When a user's role changes or they leave the organization, administrators must update access in every application separately. Forgotten accounts in disconnected systems become security risks.

By delegating authentication and authorization to a central identity provider, organizations can:

- Apply consistent authentication policies—including MFA requirements—across all applications from a single place
- Monitor sign-in activity and detect suspicious patterns across the entire environment, not just one application
- Manage the full user lifecycle—provisioning when users join, and deprovisioning when they leave

## Security tokens and claims

The communication between an identity provider and an application is carried through *security tokens*. A security token is a structured package of data that the identity provider issues after verifying a user's identity. The application validates the token and uses the information inside it to grant access.

Tokens carry information in the form of *claims*—individual pieces of data about the authenticated identity. Claims can include:

- The user's unique identifier
- Their display name and email address
- Their assigned roles or group memberships
- When the token was issued and when it expires
- What the token grants permission to do

There are two primary types of security tokens in modern authentication:

- **ID token**: Proof that the user has successfully signed in (authentication). The application uses the ID token to know who the user is—their name, email, and unique identifier.
- **Access token**: Permission for the application to access a specific resource on behalf of the user (authorization). An access token specifies what the application is allowed to do, such as reading calendar data or calling an API.

Tokens are time-limited—they expire after a set period so that a stolen token can't be used indefinitely. The server validates the token through its *trust relationship* with the identity provider.

## Authentication protocols

Identity providers and applications communicate using industry-standard protocols. These protocols define how authentication requests and security tokens are formatted and exchanged. The three most common protocols are:

- **OpenID Connect (OIDC)**: Widely used for authentication in modern cloud and mobile applications. It enables applications to verify a user's identity and obtain basic profile information. OpenID Connect is built on top of OAuth 2.0.
- **OAuth 2.0**: Used for authorization. It allows applications to obtain access tokens that grant permission to access protected resources on behalf of the user.
- **Security Assertion Markup Language (SAML)**: Commonly used in enterprise scenarios, particularly for integrating older applications and for federation between organizations. SAML is often used with on-premises identity systems.

Standard protocols ensure that identity providers and applications built by different organizations can work together securely, enabling the broad ecosystem of applications and services that organizations rely on today.

## Single sign-on

One of the most valuable capabilities that a central identity provider enables is *single sign-on (SSO)*. With SSO, a user signs in once to the identity provider and is automatically signed in to all applications that trust that same identity provider—without entering credentials again.

SSO works because the identity provider issues tokens that the user presents to multiple applications. Each application validates the token against its trust relationship with the identity provider, and grants access without requiring another sign-in.

The benefits of SSO include:

- **Better user experience**: Users don't need to remember separate credentials for each application.
- **Stronger security**: Fewer credential prompts reduce the opportunities for phishing or password theft. With fewer passwords, there's less risk of reuse.
- **Centralized control**: Disabling a user account in the identity provider immediately removes their access to all connected applications, making offboarding faster and more reliable.

SSO can happen within a single identity provider—one sign-in, many apps. When two different identity providers trust each other to authenticate users across boundaries, that's called *federation*, which is explored in the next unit.

Microsoft Entra ID is an example of a cloud-based identity provider that supports SSO across thousands of applications. Other examples include Google, Amazon, LinkedIn, and GitHub.
