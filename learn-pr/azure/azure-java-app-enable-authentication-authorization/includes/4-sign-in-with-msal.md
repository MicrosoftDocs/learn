You've registered your web application with Microsoft Entra ID. You're now ready to add the authentication code to sign in users in your application and would like to use an SDK that can handle the authentication details for you. In this unit, you'll learn about the Microsoft Authentication Library for Java (MSAL4J) and how it helps with authentication.

## Microsoft Authentication Library for Java

The Microsoft Authentication Library for Java (MSAL4J) enables applications to sign in users or apps with Microsoft identities (Microsoft Entra ID, Microsoft accounts, and Azure Active Directory B2C accounts) and obtain tokens to call Microsoft APIs or your own APIs registered with Microsoft Entra ID. It's built using industry-standard OAuth2 and OpenID Connect protocols.

The library provides convenient APIs that enable authentication with Microsoft Entra ID for different types of applications:

- Web applications
- Daemon services
- Command-line applications
- Desktop applications

### Initialize the MSAL object

To start using MSAL, you'll need to initialize and configure the MSAL object in your application code.

MSAL represents client applications as public clients and confidential clients, distinguished by their ability to authenticate securely with the authorization server and maintain the confidentiality of their client credentials.

**Confidential client** applications are apps that run on servers (web apps, web API apps, or even service/daemon apps). Confidential clients can hold configuration-time application secrets.

You can create an instance of the Confidential client as follows:

```Java
IClientCredential credential = ClientCredentialFactory.createFromSecret(CLIENT_SECRET);
ConfidentialClientApplication app = ConfidentialClientApplication
                                        .builder(CLIENT_ID, credential)
                                        .authority(AUTHORITY)
                                        .build();
```

- **CLIENT_ID**: The client ID is the unique application (client) ID assigned to your app by Microsoft Entra ID when the app was registered.
- **CLIENT_SECRET**: The client secret for the confidential client app, created when registering the app.
- **AUTHORITY**: The authority is a URL that indicates a directory that MSAL can request tokens from. It's composed of the identity provider instance and sign-in audience for the app.

### Acquire authentication tokens with MSAL

MSAL provides `acquireToken` methods to initiate the authentication flow and return an `AuthenticationResult` containing the authentication tokens.

When a user completes sign in, an ID token is returned in the authentication result containing some basic authentication claims like user principle name, email, and so on.

Here's an example of acquiring tokens with MSAL:

```Java
final AuthorizationCodeParameters authParams = AuthorizationCodeParameters
                                                    .builder(authCode, new URI(Config.REDIRECT_URI)).scopes(Collections.singleton(Config.SCOPES))
                                                    .build();

final IAuthenticationResult result = app.acquireToken(authParams).get();
```

- **REDIRECT_URI**: The redirect URI is the URI to which the identity provider will send the security tokens back. It must match the redirect URI in the Microsoft Entra app registration.
- **SCOPES**: Scopes are permissions the application requested. Normally, the three scopes `openid profile offline_access` suffice for receiving an ID token response for a user sign in and are set by default by MSAL.

Use the `acquireToken` methods in your application when initiating a sign-in flow for users and calling APIs to access data.
