For a web app solution to authenticate and authorize users, you'll need to implement the authentication logic and authorization policies.

In the insurance data solution scenario, your organization chooses to delegate authentication and authorization capabilities to the Microsoft identity platform. The identity platform supports several authentication flows through the Microsoft Authentication Libraries (MSAL). MSAL is available for different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS.

Here, you'll learn how MSAL Python enables developers to acquire security tokens from the Microsoft identity platform in order to authenticate users and access protected web APIs.


## Why use MSAL Python?

MSAL Python provides several benefits over directly using OAuth 2.0 flows and coding against the protocol by yourself, including:

- Handles the protocol implementation details, so you don't need to manually send HTTP requests to execute OAuth 2.0 flows.
- Handles token expiration by caching and automatically refreshing tokens when they're about to expire.
- Helps you troubleshoot your app by exposing actionable exceptions, logging, and telemetry.
- Regularly updated, so you don't need to change your code when new security updates are rolled out.
- Enables developers to integrate with various latest identity capabilities in the platform, including passwordless authentication and conditional access. 

## The authorization code flow in MSAL Python

To sign in users securely, you need to build an authorization flow using one of the grants and token flows supported by the identity platform. In this training module, we'll use the authorization code grant flow for sign-in. The recommended calling pattern in web apps using this flow is to:

- Instantiate a client application. 
- Acquire an access token using the authorization code flow.
- Using the access token, call a protected web API and fetch user data.

The diagram below provides a high-level overview of the Microsoft identity platform implementation of the authorization code flow to sign in users and access a protected web API.

:::image type="content" source="../media/4-authorization-code-flow.png" border="true" alt-text="Diagram that shows the sign in authentication flow in web apps.":::

As in the preceding diagram, the authorization code flow in MSAL Python consists of two main steps:

- In the first leg, the application requests an authorization code that the client redeems for an access token. 
- In the second leg, the application uses the access token to call a protected web API.

### Configure app instance

When using MSAL Python, you first create an instance of the client application. There are two types of OAuth client applications distinguished by their ability to authenticate securely with the authorization server and maintain the confidentiality of their client credentials:

- Public client applications

    Public client applications are apps that run on mobile devices, desktop computers, or in a web browser. They're not trusted to securely maintain the confidentiality of their client credentials and can only access web APIs on behalf of the user. Public clients can't hold configuration-time secrets.

- Confidential client applications

    Confidential client applications are apps that run on servers, such as web apps, web API apps, or even service/daemon apps. They're considered difficult to access and can maintain the confidentiality of their application credentials.
    
In this scenario, we'll create an instance of a confidential client application. The following code snippet shows how to instantiate a confidential client application object: 

```python
app = msal.ConfidentialClientApplication(
        config["client_id"],
        authority=config["authority"],
        client_credential=config["client_secret"],
        )
```

When creating an instance of a confidential client application, you must add a client credential, like a certificate or client secret. Unlike the client ID, which is exposed in the web browser, the client secret is stored securely on your web app server. It is passed in back channel(non-browser) requests to your authorization server and never exposed directly. 

## Security tokens in the authorization code flow

The Microsoft identity platform authenticates users and provides security tokens, such as access tokens, refresh tokens, and ID tokens. The parties in an authentication flow use these tokens to verify and authenticate users and to grant or deny access to protected resources.

### Access tokens

An access token is a security token that's issued by an authorization server as part of an OAuth 2.0 flow. It contains information about the user and the resource for which the token is intended. This user information, such as permissions, can be used to access web APIs and other protected resources.

### Refresh tokens

The Microsoft identity platform issues refresh tokens that allow client applications to request for a new access token once it expires. Because access tokens are short-lived, client applications exchange refresh tokens for a new access token when needed.

### ID tokens

The identity platform issues ID tokens are to the client application as part of an OpenID Connect flow. ID tokens can be sent alongside or in place of an access token. They're used by the client to authenticate and get basic information about users.