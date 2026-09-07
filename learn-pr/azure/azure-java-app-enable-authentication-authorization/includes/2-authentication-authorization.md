Microsoft Entra ID supports modern identity protocols, including OAuth 2.0 and OpenID Connect. Libraries such as MSAL4J help applications use those protocols without implementing every protocol interaction themselves.

In the company-portal scenario, Microsoft Entra ID is the identity provider. The portal relies on it to authenticate accounts and issue tokens, but the portal still has responsibilities for its own sessions and authorization decisions.

## Authentication

**Authentication** establishes and verifies an identity. For a user-facing application, it answers the question, "Who's this user?"

OpenID Connect adds an identity layer to OAuth 2.0. An application can receive an **ID token** containing claims about an authenticated user and the authentication event. The ID token is intended for the client application; it isn't the token that the application sends to Microsoft Graph.

## Authorization

**Authorization** determines whether an identity has permission to perform an operation or access data. It answers the question, "What's this user or application allowed to do?"

OAuth 2.0 provides flows for obtaining **access tokens** for protected APIs. In the portal scenario, a Microsoft Graph access token allows the portal to request specific data on behalf of the signed-in user, subject to the granted permissions.

The following table distinguishes the portal's authentication and authorization responsibilities.

| Concern | Example in the portal |
|---|---|
| Authentication | Microsoft Entra ID authenticates an account and the portal receives an ID token through the sign-in flow. |
| API authorization | A Microsoft Graph access token carries delegated permission to read the signed-in user's profile. |
| Application authorization | The portal applies any additional rules that control access to its own pages or business operations. |

Successful authentication doesn't automatically grant access to every page or API. For example, tenant membership alone doesn't establish that a person is an employee.

## Application registration

An **application registration** describes an application to Microsoft Entra ID. It establishes the application's identity and records settings such as its sign-in audience and redirect URIs. Registrations can be managed through the Azure portal, Azure CLI, or Microsoft Graph APIs; no registration is created in this module.

The supported account types define the sign-in audience:

- **Accounts in this organizational directory only** identifies a single-tenant audience, including user and guest accounts in the selected tenant.
- **Accounts in any organizational directory** allows accounts from Microsoft Entra tenants in a multitenant design.
- **Accounts in any organizational directory and personal Microsoft accounts** also allows personal Microsoft accounts.
- **Personal Microsoft accounts** limits the audience to personal Microsoft accounts, such as Outlook.com accounts.

The registration has an **Application (client) ID** that identifies the application in protocol requests. A confidential web application also uses an application credential to authenticate itself during token acquisition. The client ID and the credential have different purposes: an identifier isn't a secret.

The next unit interprets an example registration and connects its settings to the code samples.
