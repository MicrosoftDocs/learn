The Microsoft Authentication Library (MSAL) enables developers to acquire tokens from the Microsoft identity platform in order to authenticate users and access protected web APIs. It can be used to provide secure access to Microsoft Graph, other Microsoft APIs, third-party web APIs, or your own web API. MSAL supports many different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS.

The diagram provides a high-level overview of the Microsoft identity platform implementation of Open ID Connect (OIDC) and OAuth 2.0 to add sign-in support and API access to a web app.

:::image type="content" source="../media/5-webapp-authentication-flow.png" border="false" alt-text="Web app sign in authentication flow":::

As in the preceding diagram, the authorization code grant in MSAL Python consists of two main steps. In the first leg, the application requests an authorization code which is redeemed for an access token. In the second leg, the application uses the access token to call a protected web API. 


## Instantiating client applications

When using MSAL Python, you must first create an instance of the client application. There are two types of client applications distinguished by their ability to authenticate securely with the authorization server and maintain the confidentiality of their client credentials:

### Public client applications

Public client applications are apps that run on mobile devices, desktop computers, or in a web browser. They're not trusted to securely maintain the confidentiality of their client credentials and can only access web APIs on behalf of the user. Public clients can't hold configuration-time secrets, so they don't have client secrets.

The following code snippet shows how to instantiate a public client application.

```python
app = msal.PublicClientApplication(
    config["client_id"],
    authority=config["authority"],
    )
```
### Confidential client applications

Confidential client applications are apps that run on servers (web apps, web API apps, or even service/daemon apps). They're considered difficult to access and can maintain the confidentiality of their application credentials. Confidential clients can hold configuration-time secrets. Each instance of the client has a distinct configuration (including client ID and client secret). These values are difficult for end users to extract. A web app is the most common confidential client. The client ID is exposed through the web browser, but the secret is passed only in the back channel and never directly exposed.


The following code snippet shows how to instantiate a Confidential Client application object 

```python
app = msal.ConfidentialClientApplication(
        config["client_id"],
        authority=config["authority"],
        client_credential=config["client_secret"],
        )
```

When creating a confidential client application instance, you must add a client credential such as a certificate or client secret.

## Security tokens

The Microsoft identity platform authenticates users and provides security tokens, such as access tokens, refresh tokens, and ID tokens. Security tokens allow a client application to access protected resources on a resource server.

### Access tokens

An access token is a security token that's issued by an authorization server as part of an OAuth 2.0 flow. It contains information about the user and the resource for which the token is intended. The information can be used to access web APIs and other protected resources. Access tokens are validated by resources to grant access to a client app. To learn more about how the Microsoft identity platform issues access tokens, see Access tokens.

### Refresh tokens

Because access tokens are valid for only a short period of time, authorization servers will sometimes issue a refresh token at the same time the access token is issued. The client application can then exchange this refresh token for a new access token when needed. To learn more about how the Microsoft identity platform uses refresh tokens to revoke permissions, see Refresh tokens.

### ID tokens

ID tokens are sent to the client application as part of an OpenID Connect flow. They can be sent alongside or instead of an access token. ID tokens are used by the client to authenticate the user. To learn more about how the Microsoft identity platform issues ID tokens, see ID tokens.
