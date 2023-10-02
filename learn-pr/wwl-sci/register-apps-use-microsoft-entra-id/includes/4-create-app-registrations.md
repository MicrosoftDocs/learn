In this example of registering an app in Microsoft Entra ID uses a single-page application (SPA). To register a single-page application in the Microsoft identity platform, complete the following steps. The process is simple, and only requires a few pieces of information.

## Create the app registration

:::image type="content" source="../media/entra-app-registration-40420a82-0148f11f-11175fff.png" alt-text="Screenshot of the Microsoft Entra admin center with the new app registration dialog open.":::
 Steps are based on the Microsoft Entra admin center.

1.  Sign in to the Microsoft Entra admin center - [entra.microsoft.com](https://entra.microsoft.com/).
2.  Under the **Identity** menu, expand the **Applications** menu.
3.  Select **App registrations** \- **New registration**.
4.  Enter a Name for your application. Users of your app might see this name, and you can change it later.
5.  Choose the Supported account types for the application. Do NOT enter a Redirect URI. For a description of the different account types, see the Register an application.
6.  Select **Register** to create the app registration.

Follow these steps to add a redirect URI for an app that uses MSAL.js 2.0 or later. MSAL.js 2.0+ supports the authorization code flow with PKCE and CORS in response to browser third party cookie restrictions. The implicit grant flow isn't supported in MSAL.js 2.0+.

1.  In the **Entra admin center**, select the app registration you created in the previous step.
2.  Under **Manage**, select **Authentication**
3.  Select **+ Add a platform**.
4.  Under Web applications, select the Single-page application tile.
5.  Under Redirect URIs, enter a redirect URI. Do NOT select either checkbox under Implicit grant and hybrid flows.
6.  Select Save to finish adding the redirect URI.

You've now completed the registration of your single-page application (SPA) and configured a redirect URI to which the client will be redirected and any security tokens are sent. By configuring your redirect URI using the Single-page application tile in the Add a platform pane, your application registration is configured to support the authorization code flow with PKCE and CORS.
