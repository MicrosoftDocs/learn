You have registered your web application with Azure AD. You are now ready to add the authentication code to sign in users in your application. You look for a Java SDK that you can use to handle the authentication details and come across the Microsoft Authentication Library for Java.  In this unit, you will learn about the Microsoft Authentication Library for Java (MSAL4J) and how it helps with authentication.

## Microsoft Authentication Library for Java

The Microsoft Authentication Library for Java (MSAL4J) enables applications to sign in users or apps with Microsoft identities (Azure AD, Microsoft accounts and Azure AD B2C accounts) and obtain tokens to call Microsoft APIs or your own APIs registered with Azure AD. It is built using industry standard OAuth2 and OpenID Connect protocols.

The library provides convenient APIs that enable authentication with Azure AD for different types of applications:
- Web applications
- Daemon services
- Command-line applications
- Desktop applications

## Key MSAL concepts

1. MSAL represents client applications as public clients and confidential clients, distinguished by their ability to authenticate securely with the authorization server and maintain the confidentiality of their client credentials. 

    **Confidential client** applications are apps that run on servers (web apps, web API apps, or even service/daemon apps). Confidential clients can hold configuration-time application secrets. 

    You can create an instance of the Confidential client as follows:

    ```Java
    IClientCredential credential = ClientCredentialFactory.createFromSecret(CLIENT_SECRET);
    ConfidentialClientApplication app = ConfidentialClientApplication
                                            .builder(PUBLIC_CLIENT_ID, credential)
                                            .authority(AUTHORITY)
                                            .build();

    ```

2. MSAL provides `acquireToken` methods to initiate the authentication flow and return an `AuthenticationResult` containing the authentication tokens. 

    When a user completes sign in, an ID token is returned in the authentication result containing some basic authentication claims like user principle name, email, etc. 

    Below is an example of acquiring tokens with MSAL:

    ```Java
    final AuthorizationCodeParameters authParams = AuthorizationCodeParameters
                                                        .builder(authCode, new URI(Config.REDIRECT_URI)).scopes(Collections.singleton(Config.SCOPES))
                                                        .build();

    final IAuthenticationResult result = app.acquireToken(authParams).get();
    ```

