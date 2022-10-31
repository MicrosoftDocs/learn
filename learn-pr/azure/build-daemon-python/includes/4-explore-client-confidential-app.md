You configured a daemon application with Azure Active Directory (Azure AD). In the financial company scenario, the task is to build an application that acquires a token to call a protected web API on behalf of itself (not on behalf of a user). This application uses OAuth 2.0 client credentials flow to access a protected web API using the identity of the application. This type of grant is commonly used for server-to-server interactions that must run in the background, without immediate interaction with a user. These types of applications are often referred to as _daemons_.

In this unit, you'll learn about the confidential client application, OAuth 2.0 client credentials flow, and how to create a confidential client instance.

## Confidential client applications

Confidential client applications are apps that run on servers (service/daemon apps). They're considered difficult to access and for that reason can keep an application secret. Confidential clients can hold configuration-time secrets. Each instance of the client has a distinct configuration (including client ID and client secret). These values are difficult for end users to extract.

## OAuth 2.0 client credentials flow

The OAuth 2.0 client credentials flow permits a confidential client application to use its own credentials, instead of impersonating a user, to authenticate when calling a protected web API. There's no user authentication involved in the process.

In the client credentials flow, permissions are granted directly to the application itself by an administrator. Application permissions are typically used by background services or console apps that access an API without a graphical user interface (GUI), and by web APIs that access another (downstream) API.

When the app presents a token to a resource, the resource enforces that the app itself has authorization to perform an action since there's no user involved in the authentication.

## Microsoft Authentication Library (MSAL) for Python

The MSAL for Python enables applications to integrate with the Microsoft identity platform. It allows you to sign in users or apps with Microsoft identities (Azure AD, Microsoft Accounts and Azure AD B2C accounts) and obtain tokens to call Microsoft APIs like Microsoft Graph or your own APIs registered with the Microsoft identity platform.

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

- **client_id**: The client id is the unique **Application (client) ID** assigned to your app by Azure AD when the app was registered.
- **authority**: The authority is a URL that indicates a directory that MSAL can request tokens from. It's composed of the identity provider instance and a sign-in audience for the app.
- **client_secret**: The client secret for the confidential client app, created when registering the app.
