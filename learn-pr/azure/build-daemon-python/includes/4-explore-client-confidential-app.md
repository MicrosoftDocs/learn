Your application will acquire a token to call a protected web API on behalf of itself (not on behalf of a user). The application uses the standard OAuth 2.0 client credentials grant.

In this unit, you'll learn about confidential client application, OAuth 2.0 client credentials flow and how to grant permissions to the confidential client application itself.

## Confidential client applications

Confidential client applications are apps that run on servers (web apps, web API apps, or even service/daemon apps). They're considered difficult to access, and for that reason can keep an application secret. Confidential clients can hold configuration-time secrets. Each instance of the client has a distinct configuration (including client ID and client secret). These values are difficult for end users to extract.

## OAuth 2.0 client credentials flow

The OAuth 2.0 client credentials grant flow permits a confidential client application to use its own credentials, instead of impersonating a user, to authenticate when calling another web service. There's no user authentication involved in the process.

In the client credentials flow, permissions are granted directly to the application itself by an administrator. When the app presents a token to a resource, the resource enforces that the app itself has authorization to perform an action since there's no user involved in the authentication.

## Application permission to Microsoft Graph

Configure application permissions for an application that needs to authenticate as itself without user interaction or consent. Application permissions are typically used by background services or console apps that access an API in a "headless" manner, and by web APIs that access another (downstream) API.

In the following steps, you grant the registered app permission to Microsoft Graph's _User.Read.All_ permission:

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: in the top menu to select the tenant containing your client app's registration.
1. Select **Azure Active Directory** > **App registrations**, and then select your client application.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. All permissions exposed by Microsoft Graph are shown under **Select permissions**.
1. Select the permission or permissions you want to grant your application. In our case, we have a daemon app that needs to read users profile.

    Under **Select permissions**, expand **User**, and then select the *User.Read.All* permission.
1. Select **Add permissions**.

Some permissions, like Microsoft Graph's *User.Read.All* permission, require admin consent. You grant admin consent by selecting the **Grant admin consent** button.
