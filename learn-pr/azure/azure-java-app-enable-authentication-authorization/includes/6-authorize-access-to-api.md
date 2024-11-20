You can now sign in your company's users into the web application. Next, you want to display information such as their job title, work email, and so on from their employee profile on the page. You find that the Microsoft Graph API provides access to user related data.

In this unit, you'll learn how MSAL can help you get authorized access to Microsoft services such as the Microsoft Graph API.

## API permissions and scopes

Web services secured by Microsoft Entra ID define a set of permissions that provide access to the API functionality and data that service exposes. An application can request these permissions from users and administrators, who must approve the request before the application can access data or act on a user's behalf. As an example, Microsoft Graph has defined permissions to do the following tasks, among others:

* Read a user's calendar
* Write to a user's calendar
* Send mail as a user

Users and administrators can exercise control and know what data the application can access.
Before your application can access an API secured by Microsoft, you'll need to provide the application permissions to perform the actions.

Microsoft Entra ID supports two types of permissions: delegated permissions and application permissions.

* **Delegated permissions** are used by apps that have a signed-in user present. For these apps, either the user or an administrator consents to the permissions that the app requests. The app is delegated permission to act as the signed-in user when it makes calls to the target API. Some high-privileged permissions require administrator consent.

* **Application permissions** are used by apps that run without a signed-in user present; for example, apps that run as background services or daemons. Only an administrator can consent to application permissions.

You can assign these API permissions to your app registration from the Azure portal.

### Scopes

Microsoft Entra ID implements the OAuth 2.0 authorization protocol through which an application can access web-hosted resources on behalf of a user.

In OAuth 2.0, these types of permission sets are called **scopes**.  When making an authorization request to Microsoft Entra ID, an application requests the permissions it needs by specifying the permission in the request's `scope` query parameter. For example, the scope value `https://graph.microsoft.com/Calendars.Read` is used to request permission to read user's calendars in Microsoft Graph.

## Acquire access tokens with MSAL

**Access tokens** enable client applications to securely call web APIs protected by Microsoft Entra ID. There are several ways to acquire an access token by using the Microsoft Authentication Library (MSAL). In general, the method used for acquiring a token depends on whether the application is a public client application like desktop or mobile app, or a confidential client application like web app, web API, or daemon application.

Several of MSAL's token acquisition methods require a `scopes` parameter, which is a list of strings that declare the desired permissions and the resources requested.

### Recommended call pattern for web apps

MSAL caches a token after it has been acquired. For Web applications that use the OpenID Connect authorization code flow, the recommended pattern in the controllers is to:

* First try to get a token silently from the cache before attempting to acquire a token by other means:

    ```Java
    final SilentParameters parameters = SilentParameters
                                            .builder(Collections.singleton(Config.SCOPES), context.getAccount())
                                            .build();

    final ConfidentialClientApplication client = getConfidentialClientInstance();
    
    client.tokenCache().deserialize(context.getTokenCache());

    final IAuthenticationResult result = client.acquireTokenSilently(parameters).get();
    ```

* If there's no token in the cache and the silent token request fails to get a token, you can acquire the token using the authorization code flow:

    ```Java
    final AuthorizationCodeParameters authParams = AuthorizationCodeParameters
                                                        .builder(authCode, new URI(Config.REDIRECT_URI)).scopes(Collections.singleton(Config.SCOPES))
                                                        .build();

    final IAuthenticationResult result = app.acquireToken(authParams).get();
    ```

MSAL is also capable of refreshing a token when it's getting close to expiration (as the token cache also contains a refresh token).

### Authentication results

When your client requests an access token, Microsoft Entra ID also returns an authentication result that includes metadata about the access token. This data allows your app to do intelligent caching of access tokens without having to parse the access token itself. The `AuthenticationResult` MSAL returns exposes:

* The access token for the web API.
* The ID token for the user (a JWT).
* The token expiration, which tells the date/time when the token expires.
* The tenant ID contains the tenant in which the user was found.
* The scopes for which the token was issued.
* The unique ID for the user.

## Introduction to Microsoft Graph

The Microsoft Graph API offers a single endpoint, `https://graph.microsoft.com`, to provide access to rich, people-centric data and insights in the Microsoft cloud. You can use REST APIs or SDKs to access the endpoint and build apps that support Microsoft 365 scenarios, spanning across productivity, collaboration, education, people and workplace intelligence, and much more. Microsoft Graph also includes a powerful set of services that manage user and device identity.

For example, you can read the properties of a signed in user by accessing the `https://graph.microsoft.com/v1.0/me` endpoint.
