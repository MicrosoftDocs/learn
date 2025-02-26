The settings for each application type, including redirect URIs, are configured in Platform configurations in the Azure portal. Some platforms, like Web and Single-page applications, require you to manually specify a redirect URI. For other platforms, like mobile and desktop, you can select from redirect URIs generated for you when you configure their other settings.

To configure application settings based on the platform or device you're targeting, follow these steps:

1.  Open the **Microsoft Entra admin center**, then under **Applications**, select **App registrations**.
2.  Select your application.
3.  Under Manage, select **Authentication**.
4.  Under Platform configurations, select **Add a platform**.
5.  Under Configure platforms, select the tile for your application type (platform) to configure its settings.
    
    :::image type="content" source="../media/app-registration-add-platform-a68858c7-7a4b2033-834d30fe.png" alt-text="Screenshot of the app registration, authentication, add a platform selection screen.":::
    
    
    | **Platform**                    | **Configuration settings**                                                                                                                                                                                                                                                                              |
    | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Web                             | Enter a Redirect URI for your app. This URI is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication.                                                                                                                             |
    | Single-page application         | Enter a Redirect URI for your app. This URI is the location where the Microsoft identity platform redirects a user's client and sends security tokens after authentication.                                                                                                                             |
    | iOS / macOS                     | Enter the app Bundle ID. Find it in Build Settings or in Xcode in Info.plist.                                                                                                                                                                                                                           |
    | Android                         | Enter the app Package name. Find it in the AndroidManifest.xml file. Also generate and enter the Signature hash.                                                                                                                                                                                        |
    | Mobile and desktop applications | Select one of the suggested Redirect URIs. Or specify one or more Custom redirect URIs. For desktop applications using embedded browser, we recommend: `https://login.microsoftonline.com/common/oauth2/nativeclient`. For desktop applications using system browser, we recommend: `http://localhost`. |

Select **Save** to complete the platform configuration.

### Redirect URI

A redirect URI, or reply URL, is the location where the authorization server sends the user once the app has been successfully authorized and granted an authorization code or access token. The authorization server sends the code or token to the redirect URI, so it's important you register the correct location as part of the app registration process. The Microsoft Entra application model specifies these restrictions to redirect URIs:

 -  Redirect URIs must begin with the scheme https. There are some exceptions for localhost redirect URIs.
 -  Redirect URIs are case-sensitive and must match the case of the URL path of your running application.
 -  Redirect URIs not configured with a path segment are returned with a trailing slash ('/') in the response.
 -  Redirect URIs that contain a path segment aren't appended with a trailing slash in the response.
 -  Redirect URIs don't support special characters - `! $ ' ( ) , ;`<br>
