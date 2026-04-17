This unit demonstrates registering an application in Microsoft Entra ID using a single-page application (SPA). To register a single-page application in the Microsoft identity platform, complete the following steps. The process is straightforward and requires only a few pieces of information.

 > [!Note]
 > This example uses a single-page application, but the core registration process is similar for other application types (web apps, mobile apps, etc.). The main differences are in the platform-specific configuration steps.

## Create the app registration

:::image type="content" source="../media/entra-app-registration-40420a82-0148f11f-11175fff.png" alt-text="Screenshot of the Microsoft Entra admin center with the new app registration dialog open.":::
Steps are based on the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) with appropriate permissions (at least Application Developer role).
2. Under the **Identity** menu, expand the **Applications** menu.
3. Select **App registrations**, then **New registration**.
4. Enter a **Name** for your application. Users of your app might see this name, and you can change it later.
5. Choose the **Supported account types** for the application. For most single-tenant applications, select "Accounts in this organizational directory only." Do NOT enter a Redirect URI at this stage.
6. Select **Register** to create the app registration.

 > [!Important]
 > Record the **Application (client) ID** and **Directory (tenant) ID** from the Overview page, as you'll need these values to configure your application code.

## Configure the Single-Page Application Platform

Follow these steps to add a redirect URI for an app that uses MSAL.js 2.0 or later. MSAL.js 2.0+ supports the authorization code flow with Proof Key for Code Exchange (PKCE) and Cross-Origin Resource Sharing (CORS), which provides enhanced security compared to the legacy implicit grant flow.

1. In the **Microsoft Entra admin center**, select the app registration you created in the previous step.
2. Under **Manage**, select **Authentication**.
3. Select **+ Add a platform**.
4. Under **Web applications**, select the **Single-page application** tile.
5. Under **Redirect URIs**, enter a redirect URI (for example, `http://localhost:3000/` for local development).
6. Do **NOT** select either checkbox under **Implicit grant and hybrid flows** - legacy patterns no longer recommended.
7. Select **Save** to finish adding the redirect URI.

 > [!NOTE]
 > **Security Note**: The Single-page application (SPA) platform configuration automatically enables the authorization code flow with PKCE. PKCE is more secure than the legacy implicit grant flow. Modern SPAs should use this approach.

## Registration Complete

The registration of your single-page application (SPA) is complete. You configured a redirect URI to which the client is redirected, and any security tokens are sent. By configuring your redirect URI using the Single-page application tile in the **Add a platform** pane, your application registration is configured to support the authorization code flow with PKCE and CORS.

**Next Steps:**
- Configure API permissions if your app needs to access Microsoft Graph or other APIs
- Add certificates or client secrets if your app type requires them (not needed for SPAs using authorization code flow)
- Test your configuration with your application code

 > [!NOTE]
 > **Best Practice**: New app registrations are hidden from users by default. When you're ready for users to see the app on their My Apps page, you can enable it through **Enterprise apps** then **Properties** and set **Visible to users?** value to **Yes**.
