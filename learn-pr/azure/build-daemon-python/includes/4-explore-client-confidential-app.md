Your application will acquire a token to call a protected web API on behalf of itself (not on behalf of a user). The application uses the standard OAuth 2.0 client credentials flow.

In this unit, you'll learn about the confidential client application, OAuth 2.0 client credentials flow, how to create a confidential client instance, and how to grant permissions to the confidential client application itself.

## Confidential client applications

Confidential client applications are apps that run on servers (service/daemon apps). They're considered difficult to access, and for that reason, can keep an application secret. Confidential clients can hold configuration-time secrets. Each instance of the client has a distinct configuration (including client ID and client secret). These values are difficult for end users to extract.

## OAuth 2.0 client credentials flow

The OAuth 2.0 client credentials flow permits a confidential client application to use its own credentials, instead of impersonating a user, to authenticate when calling a protected web API. There's no user authentication involved in the process.

In the client credentials flow, permissions are granted directly to the application itself by an administrator. When the app presents a token to a resource, the resource enforces that the app itself has authorization to perform an action since there's no user involved in the authentication.

## Microsoft Authentication Library (MSAL) for Python

The MSAL for Python enables applications to integrate with the Microsoft identity platform. It allows you to sign in users or apps with Microsoft identities (Azure AD, Microsoft Accounts and Azure AD B2C accounts) and obtain tokens to call Microsoft APIs such as Microsoft Graph or your own APIs registered with the Microsoft identity platform.

### Initialize the MSAL object

To start using MSAL, you'll need to initialize and configure the MSAL object in your application code. Create a **ConfidentialClientApplication** instance, and reuse it during the lifecycle of your app.

The following example shows a **ConfidentialClientApplication** instance:

```python
from msal import ConfidentialClientApplication

app = ConfidentialClientApplication(
    client_id="client_id",
    authority="authority",
    client_credential="client_secret",
)
```

- **client_id**: The client id is the unique **Application (client) ID** assigned to your app by Azure Active Directory (Azure AD) when the app was registered.
- **authority**: The authority is a URL that indicates a directory that MSAL can request tokens from. It's composed of the identity provider instance and a sign-in audience for the app.
- **client_secret**: The client secret for the confidential client app, created when registering the app.

## Application permission to Microsoft Graph

Configure application permissions for an application that needs to authenticate as itself without user interaction or consent. Application permissions are typically used by background services or console apps that access an API in a "headless" manner, and by web APIs that access another (downstream) API.

In the following steps, you grant the registered app permission to Microsoft Graph's _User.Read.All_ permission:

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. Make sure you're using the directory that contains your client app's registration:
   a. Select the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: icon in the top menu.
   b. On the **Portal settings | Directories + subscriptions** page, find the directory you want to use in the **Directory name** list, and select **Switch** button next to it.

1. Select **Azure Active Directory** > **App registrations**, and then select your client application.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. Under **Select permissions**, search and expand **User**, and then select the *User.Read.All* permission.
1. Select **Add permissions**.
1. Select **Grant admin consent** to grant admin consent.
