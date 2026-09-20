MSAL4J connects application configuration to Microsoft identity platform authentication and token-acquisition APIs. This unit explains a client-construction sample and the library's role in a web application's sign-in flow.

## Microsoft Authentication Library for Java

The Microsoft Authentication Library for Java (MSAL4J) enables applications to authenticate with Microsoft identities and obtain tokens for protected APIs. It supports scenarios involving Microsoft Entra ID, personal Microsoft accounts, and Azure AD B2C, using OAuth 2.0 and OpenID Connect.

> [!NOTE]
> Existing Azure AD B2C customers can continue using the service. It hasn't been available for purchase by new customers since May 1, 2025, and support continues until at least May 2030. Azure AD B2C P2 was discontinued for all customers on March 15, 2026; continuing service support doesn't cover retired P2-only features.
>
> For new customer identity projects, use Microsoft Entra External ID. The scenario in this module concerns a Microsoft Entra workforce tenant, not an Azure AD B2C tenant or an External ID external tenant. For details, see the [Azure AD B2C end-of-sale FAQ](/azure/active-directory-b2c/faq#azure-ad-b2c-end-of-sale).

MSAL4J supports several application types, including web applications, background services, command-line applications, and desktop applications. The appropriate client type and token-acquisition flow depend on the application's environment.

## A confidential client represents the server application

MSAL distinguishes **public clients**, which can't reliably keep application credentials confidential, from **confidential clients**, which can authenticate themselves using securely held credentials. A server-side Java web application is a confidential client.

The following illustrative fragment constructs that client. The uppercase names are configuration placeholders, not real identifiers or secrets. Imports, surrounding application code, and exception handling aren't shown.

```java
IClientCredential credential = ClientCredentialFactory.createFromSecret(CLIENT_SECRET);
ConfidentialClientApplication app = ConfidentialClientApplication
                                        .builder(CLIENT_ID, credential)
                                        .authority(AUTHORITY)
                                        .build();
```

The fragment connects three inputs:

| Input | Meaning |
|---|---|
| `CLIENT_ID` | The application identifier from the registration. |
| `CLIENT_SECRET` | A placeholder for secret material supplied to the server. This illustrates one credential factory, not a request to create or embed a secret. |
| `AUTHORITY` | The identity-provider URL and sign-in audience. In the single-tenant scenario, it identifies the selected Microsoft Entra tenant. |

`ClientCredentialFactory` creates a credential object, and the builder associates that credential with the application's client ID and authority. Calling `build()` constructs the MSAL client; it doesn't sign in a user or send the browser anywhere.

## MSAL's role in the authorization-code flow

A confidential client authenticates the application, while the browser interaction authenticates the user. The application coordinates these parts of the flow:

| Phase | MSAL API | Application responsibility |
|---|---|---|
| Start browser sign-in | `getAuthorizationRequestUrl` | Construct an authorization request and redirect the browser to it. |
| Redeem an authorization code | `acquireToken` with `AuthorizationCodeParameters` | Process the callback, validate the response, and exchange the received code for tokens. |
| Obtain a token for a later API call | `acquireTokenSilently` with `SilentParameters` | Supply the account and appropriate token-cache context, and handle cases that require user interaction. |

For this web application, the callback receives an authorization code, not the Microsoft Graph access token. Code redemption happens through a server-to-server request to the token endpoint.

## Interpret the authentication result

Successful code redemption returns an `IAuthenticationResult`. In this OpenID Connect scenario, the result provides an ID token for the application and an access token for the requested API. It also provides information used to manage the account and token lifetime.

The ID token contains identity claims; the access token enables a request to its intended API. An ID token isn't a substitute for a Microsoft Graph access token. MSAL4J acquires tokens, but the application or an API-specific SDK makes the subsequent business API call.

The next unit follows these responsibilities through annotated servlet code. The [MSAL overview](/entra/identity-platform/msal-overview) provides additional context about supported scenarios and token management.
