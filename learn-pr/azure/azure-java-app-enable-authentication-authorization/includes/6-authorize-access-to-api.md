The company portal's design includes reading the signed-in user's profile from Microsoft Graph. Authentication identifies the user to the portal, but an API call also needs an access token with appropriate permissions.

This unit explains permission types, scopes, and an illustrative MSAL4J token-cache pattern. It doesn't assume that an application or signed-in session is running.

## API permissions and scopes

A protected API defines permissions for its functionality and data. Microsoft Graph, for example, has different permissions for reading a profile, reading a calendar, and sending mail. An application requests only the permissions needed for its intended operation.

Microsoft Entra ID supports two permission types:

| Permission type | Context | Consent |
|---|---|---|
| Delegated permissions | The application acts on behalf of a signed-in user. Access is constrained by the granted permissions and the user's access. | A user or authorized administrator can grant consent, depending on the permission and tenant policy. |
| Application permissions | The application acts as itself without a signed-in user, such as a background service. | Administrator consent is required. |

The portal uses **delegated `User.Read`** to read the signed-in user's profile. This permission doesn't grant access to every user's data or unrelated resources such as calendars.

### Scopes describe the requested access

In a delegated authorization request, OAuth 2.0 scopes express the permissions the application requests. A scope can identify both the resource and the permission; for example, `https://graph.microsoft.com/Calendars.Read` requests calendar-reading permission for Microsoft Graph.

The examples use the single scope `User.Read`. For Microsoft Graph scopes, the resource identifier can be omitted, so this represents `https://graph.microsoft.com/User.Read`. For more information, see [Scopes and permissions](/entra/identity-platform/scopes-oidc).

Configured API permissions, requested scopes, and consent are distinct. Adding an API permission to an app registration doesn't itself grant consent or change the scopes requested by the application's code.

## An access token is specific to its API

An access token is intended for a particular resource. A token for Microsoft Graph isn't interchangeable with a token for another API, and an ID token isn't a replacement for an API access token.

MSAL4J acquires and caches tokens. The application uses the token for its intended resource rather than parsing it to make assumptions about the signed-in user's identity or treating it as a reusable authorization code.

## Illustrative silent token acquisition

For later requests, a web application can ask MSAL for a token without sending the user through another sign-in interaction. The following fragment is adapted from the reference sample's `AuthHelper`. It illustrates restoring a session-associated cache and requesting a token for an account already represented in that context.

```java
final SilentParameters parameters = SilentParameters
                                        .builder(Collections.singleton(Config.SCOPES), context.getAccount())
                                        .build();

final ConfidentialClientApplication client = getConfidentialClientInstance();
client.tokenCache().deserialize(context.getTokenCache());

final IAuthenticationResult result = client.acquireTokenSilently(parameters).get();
```

`SilentParameters` identifies the requested scope and account. In this sample, `Config.SCOPES` contains `User.Read`, and `context` supplies the account and serialized cache associated with the authenticated session. These are sample application helpers, not values that the learner needs to obtain.

After the cache is restored, `acquireTokenSilently` attempts to satisfy the request without user interaction. It can return a usable cached access token or use a cached refresh token when applicable. "Silent" doesn't necessarily mean that no network request occurs.

This fragment omits the surrounding cache persistence and exception handling. If MSAL indicates that user interaction is required, the web application starts a new authorization request and processes the resulting callback. It doesn't redeem the old authorization code again. Other failures, such as network or configuration errors, need appropriate error handling rather than an unconditional sign-in loop.

Token-cache and session data contain sensitive information. A complete application must protect that data, associate it with the correct account and session, and persist cache changes appropriately.

## Interpret the result before the API call

Successful token acquisition produces an `IAuthenticationResult` containing the access token and information about its lifetime and account context. For a Microsoft Graph request, the application supplies the Graph access token to its HTTP client or Graph authentication provider.

MSAL4J doesn't read a user's profile merely by acquiring that token. The separate API request performs the data operation.

## Microsoft Graph provides the resource

Microsoft Graph exposes Microsoft cloud data and services through `https://graph.microsoft.com`. The `/v1.0/me` endpoint represents the signed-in user and requires a delegated user context.

The next unit examines an illustrative request to that endpoint and the equivalent request through the Java Graph SDK. The [Microsoft Graph overview](/graph/overview) describes the broader API.
