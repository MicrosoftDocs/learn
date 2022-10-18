For your web application to access protected resources like user data, it requires authorization by the resource owner. When the app sends an authorization request to access this data, the resource owner can accept or deny it. Understanding these foundational concepts of permissions and access control will help you build more secure applications that request only the access they need and when they need it.

## Consent

One way that applications in Microsoft identity platform are granted permissions to access user data is through consent. Consent is a process where users or admins authorize an application to access a protected resource. For example, when a user attempts to sign into an application for the first time, the application can request permission to sign in the user, read their profile, and maintain access to the data. The user sees a consent prompt with the publisher information and a list of permissions the app is requesting, as shown below:

:::image type="content" source="../media/6-consent-to-permissions-request.png" border="true" alt-text=" Screenshot of the consent prompt window requesting users to accept the app's request for permissions.":::

When an application needs to get a new access token from the identity platform, it doesn't prompt the user for consent, if they had already consented to the specified permissions. This is because consent grants can outlast a token as they remain valid until a user or admin revokes them  manually. 

### Acquire token silently

After a user signs in, your app shouldn't ask them to reauthenticate every time they need to access a protected resource. To prevent such reauthentication requests, you acquire an access token without user interaction by calling `acquire_token_silent`. This will first look for a valid access token from the cache, or if needed, find a valid refresh token and use it to redeem a new access token. 

If the `acquire_token_flow` found an expired access token and had to use the refresh token, you update the session's token cache to reflect the new access token and refresh token. As such, the next invocation won't require exchanging the refresh token for an access token again.  

There are some situations, however, where you might need to force users to interact with the Microsoft identity platform. For example:

- Users need to reenter their credentials because the session has expired.
- The refresh token has expired.
- The application is requesting access to a resource that requires specific permissions that the user had not consented to.
- Two-factor authentication is required.
- The refresh token has been revoked by the server because of a change in credentials, user action, or admin action.

Calling `acquireTokenPopup` opens a pop-up window (or `acquireTokenRedirect`) redirects users to the Microsoft identity platform. In that window, users need to interact with the identity platform by confirming their credentials, consenting to the required permissions, or completing the two-factor authentication. After that, the pop-up window closes and the app receives the response. The response contains the requested tokens. The app can then use the tokens to call the Microsoft Graph API. The tokens are cached in the browser and are available for the next request.