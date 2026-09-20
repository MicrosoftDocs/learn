This walkthrough explains how a Java web application can read the signed-in user's profile from Microsoft Graph. The request, Java fragment, and response below are illustrative samples with explanations, not a lab or a requirement to send a real API request.

## Relate configuration, scopes, and consent

The reference servlet sample uses delegated `User.Read`. Its `aad.scopes` configuration property supplies that value to `Config.SCOPES`, which the authentication code requests during sign-in.

The app registration's **API permissions** list describes configured permissions. The following screenshot is an example of that view, not an instruction to change a registration.

:::image type="content" source="../media/api-permissions.png" alt-text="Screenshot of the API permissions page for an application registration." lightbox="../media/api-permissions.png":::

Three facts explain the authorization context:

- The code requests delegated `User.Read` for Microsoft Graph.
- Consent can come from the user or an authorized administrator, depending on tenant policy and existing grants.
- Adding a permission to the registration doesn't itself grant consent or change the code's requested scopes.

The sample requests this permission during sign-in, so there isn't a separate assumption that every Graph request displays a consent prompt.

## Read the HTTP request

The following HTTP sample shows the essential parts of a profile request. `<graph-access-token>` is an explanatory placeholder, not a token to obtain or paste into a tool.

```http
GET /v1.0/me HTTP/1.1
Host: graph.microsoft.com
Authorization: Bearer <graph-access-token>
```

The request uses HTTPS to reach `https://graph.microsoft.com/v1.0/me`. `/me` identifies the signed-in user in a delegated context. The `Authorization` header carries an access token intended for Microsoft Graph; it doesn't carry the application's ID token, an authorization code, or a client secret.

`User.Read` is sufficient for the illustrated operation of reading the signed-in user's profile. It doesn't authorize arbitrary access to other users' information. The [Get a user API reference](/graph/api/user-get?view=graph-rest-1.0&preserve-view=true) describes the endpoint and permissions.

## Read the Java SDK equivalent

The historical sample's `CallGraphServlet` handles its own `/call_graph` route and uses the Microsoft Graph SDK to make the API request. The following fragment illustrates that call after token acquisition has succeeded.

```java
User user = GraphHelper.getGraphClient(contextAdapter).me().buildRequest().get();
```

`GraphHelper` is a helper defined by the sample, not a built-in MSAL4J API. It creates a `GraphServiceClient` whose authentication provider supplies the signed-in user's Graph access token from the sample's authenticated context. `contextAdapter` connects the current request to that application context.

In this SDK version, `me()` selects the signed-in-user endpoint, `buildRequest()` creates the request, and `get()` sends it and deserializes the response into a Microsoft Graph `User` model. The fragment omits the surrounding servlet, imports, session handling, and error processing; it isn't a complete application.

> [!NOTE]
> This fragment reflects the historical sample's Microsoft Graph SDK for Java **5.5.0** syntax. The v6 SDK changes the request pattern, client construction, authentication integration, and model access. The [Microsoft Graph Java SDK v6 upgrade guide](https://github.com/microsoftgraph/msgraph-sdk-java/blob/main/docs/upgrade-to-v6.md) explains those differences. A v6-only request expression isn't compatible with the sample's v5 dependency and helper code.

## Interpret an illustrative response

A shortened example response could contain the following profile fields. The values are fictional and aren't output that the learner needs to reproduce.

```json
{
  "displayName": "Avery Rivera",
  "jobTitle": "Service specialist",
  "mail": "avery@example.com"
}
```

The application can use these fields to present profile information. Actual values depend on the user's directory profile, and fields can be absent or null. A profile field isn't proof of employment or a substitute for the application's authorization policy.

The overall division of responsibilities is important: Microsoft Entra ID issues a token under the applicable permission and consent rules, MSAL4J acquires that token, and the Graph SDK or an HTTP client uses it to request data. Merely constructing a Graph client doesn't grant access.
