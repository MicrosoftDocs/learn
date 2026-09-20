This walkthrough traces a sign-in request through illustrative Java servlet code. It explains how the browser, Microsoft Entra ID, MSAL4J, and the application's session helpers interact.

> [!NOTE]
> These fragments aren't a complete application or a production-ready implementation. They omit surrounding servlet code, imports, configuration, and some error handling to focus on the flow. No application needs to be built or run to complete this unit.

## Identify the application-defined helpers

MSAL4J supplies the token-acquisition APIs. The application supplies the surrounding code that coordinates browser redirects, callback processing, and sessions. The fragments use these illustrative helpers:

| Helper | Role in the examples |
|---|---|
| `Config` | Supplies application settings. `REDIRECT_URI` represents the registered callback URI, and `SCOPES` contains the single Microsoft Graph scope `User.Read`. |
| `getConfidentialClientInstance` and `AuthHelper.getConfidentialClientInstance` | Return a configured `ConfidentialClientApplication`. |
| `contextAdapter` | Connects the HTTP request and response to the application's session context. Its `redirectUser` method redirects the browser. |
| `IdentityContextData` and `context` | Hold data associated with a sign-in request and session, including the nonce, token claims, authentication result, and serialized token cache. |

These names and their helper methods are application-defined, not MSAL4J APIs. Their roles are explained in the walkthrough, but their implementations aren't included.

## An authorization URL starts browser interaction

The first fragment shows how the application creates an authorization URL and redirects the browser. The helper supplies a configured confidential client. The application has also generated fresh, unpredictable `state` and `nonce` values for this sign-in request and retained them for later comparison.

```java
final ConfidentialClientApplication client = getConfidentialClientInstance();
AuthorizationRequestUrlParameters parameters = AuthorizationRequestUrlParameters
                                                    .builder(Config.REDIRECT_URI, Collections.singleton(Config.SCOPES))
                                                    .responseMode(ResponseMode.QUERY)
                                                    .prompt(Prompt.SELECT_ACCOUNT)
                                                    .state(state)
                                                    .nonce(nonce)
                                                    .build();

final String authorizeUrl = client.getAuthorizationRequestUrl(parameters).toString();
contextAdapter.redirectUser(authorizeUrl);
```

`AuthorizationRequestUrlParameters` describes the callback URI, requested scope, and protocol options. `Collections.singleton` is appropriate here because `Config.SCOPES` contains one scope, rather than a space-separated list of multiple scopes. MSAL adds the standard OpenID Connect scopes `openid`, `profile`, and `offline_access` by default.

With MSAL4J 1.9.1, `ResponseMode.QUERY` places the authorization response parameters in the callback's query string. `Prompt.SELECT_ACCOUNT` requests account selection. `state` helps correlate the response with the sign-in request, while `nonce` binds the ID token to that request.

> [!NOTE]
> Starting with [MSAL4J 1.24.0](https://github.com/AzureAD/microsoft-authentication-library-for-java/blob/c084f2f50f217126f0c7a19d879b7f46cecd222a/changelog.txt), `ResponseMode.QUERY` is deprecated. When passed this value, `AuthorizationRequestUrlParameters.Builder.responseMode` substitutes `ResponseMode.FORM_POST` and logs a warning. This is a library behavior change; Microsoft Entra still supports [query-mode authorization code responses at the protocol level](/entra/identity-platform/v2-oauth2-auth-code-flow#request-an-authorization-code).
>
> For form-post responses, a servlet callback needs POST-capable handling, such as `doPost`, rather than relying only on `doGet`. Callback processing must still preserve the associated session, `state` and `nonce` validation, and error handling. Changing only the response-mode enum doesn't address these responsibilities.

`getAuthorizationRequestUrl` constructs the URL; `redirectUser` is the application-defined helper that redirects the browser. Neither operation redeems an authorization code.

> [!IMPORTANT]
> The illustrated request includes delegated Microsoft Graph `User.Read` during sign-in. A consent prompt appears only when consent is needed and tenant policy allows the user to grant it; prior user or administrator consent can mean no prompt appears. A **Need admin approval** message indicates that an authorized administrator must review the request through the organization's approved process. The appropriate response isn't to weaken tenant-wide consent policy. See [User and admin consent](/entra/identity/enterprise-apps/user-admin-consent-overview).

## The callback exchanges a code for tokens

After a successful authorization response, Microsoft Entra ID redirects the browser to the application's callback URI with an authorization code. The following fragment focuses on redemption, after the callback has validated `state`, handled error responses, and extracted `authCode`. It doesn't show the entire callback implementation.

```java
final AuthorizationCodeParameters authParams = AuthorizationCodeParameters
                                                    .builder(authCode, new URI(Config.REDIRECT_URI))
                                                    .scopes(Collections.singleton(Config.SCOPES))
                                                    .build();

final ConfidentialClientApplication client = AuthHelper.getConfidentialClientInstance();
final IAuthenticationResult result = client.acquireToken(authParams).get();
```

`AuthorizationCodeParameters` connects the received code to the callback URI and requested scope. The redirect URI must match the one used in the authorization request and the app registration. The confidential client authenticates the application while exchanging the code at the token endpoint.

`acquireToken` returns a future, and `.get()` waits for its result in this example. Successful redemption produces an `IAuthenticationResult`; a failed exchange must be handled as an error. Authorization codes are short-lived and single-use, not reusable credentials for later API calls.

> [!NOTE]
> For new implementations, follow the [current authorization code flow guidance](/entra/identity-platform/v2-oauth2-auth-code-flow#request-an-authorization-code): Microsoft recommends Proof Key for Code Exchange (PKCE) for all application types, including confidential web apps. PKCE is required for single-page applications (SPAs), but isn't a platform requirement for the confidential web app illustrated here.
>
> The explicit MSAL4J URL-construction and code-redemption APIs shown here don't generate PKCE inputs automatically. Generate a fresh, unpredictable verifier for each sign-in request and retain it securely for the matching callback. On the authorization-request builder, supply its S256-derived challenge as `codeChallenge` and set `codeChallengeMethod("S256")`; on the redemption builder, supply the matching `codeVerifier`. PKCE doesn't replace client authentication or `state` and `nonce` validation. The fragments above omit these PKCE inputs.

## The application associates the result with a session

The next fragment illustrates the boundary between receiving tokens and treating a session as authenticated. Here, `context` is an application-defined `IdentityContextData` instance.

```java
context.setIdTokenClaims(result.idToken());
validateNonce(context);
context.setAuthResult(result, client.tokenCache().serialize());
```

The first call makes the ID-token claims available to the application's nonce validation. The application-defined `validateNonce` helper compares the returned nonce with the value retained for the original request and stops processing if validation fails. The final call records the authentication result and serialized token cache in the application context, which the surrounding code associates with the session.

These helpers don't replace the application's broader security responsibilities. A complete implementation also needs correct response processing, secure session and token-cache storage, appropriate error handling, and authorization for protected operations.

## Connect the flow

The browser carries the user through sign-in and returns an authorization code. The server redeems that code with MSAL4J, processes the result, and maintains the application's session. Later Microsoft Graph calls use an access token, not the authorization code or ID token.

For more information about the library APIs, see [MSAL4J authorization code URL builder](/entra/msal/java/advanced/authorization-code-url-builder) and [Acquire tokens with authorization codes](/entra/msal/java/getting-started/acquiring-tokens-with-authorization-codes).
