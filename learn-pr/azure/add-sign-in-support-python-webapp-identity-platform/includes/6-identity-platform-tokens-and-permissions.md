To access a protected resource like email or calendar data, your application needs the resource owner's authorization. The resource owner can consent to or deny your app's request. Understanding these foundational concepts will help you build more secure and trustworthy applications that request only the access they need, when they need it, from its users and administrators.


## Permissions and consent



### Acquire token silently

After a user signs in, your app shouldn't ask users to reauthenticate every time they need to access a protected resource. To prevent such re-authentication requests, you acquire an access token without user interaction by calling `acquire_token_silent`, as illustrated in the code sample above. This will first look for a valid access token from the cache, or if needed, find a valid refresh token and then use it to redeem a new access token. 

If the `acquire_token_flow` found an expired access token and needed to use the refresh token, you update the session's token cache to reflect the new access token and refresh token. As such, the next invocation won't require exchanging the refresh token for the access token again.  

There are some situations, however, where you might need to force users to interact with the Microsoft identity platform. For example:

- Users need to re-enter their credentials because the session has expired.
- The refresh token has expired.
- Your application is requesting access to a resource and you need the user's consent.
- Two-factor authentication is required.
- The refresh token has been revoked by the server because of a change in credentials, user action, or admin action.

Calling `acquireTokenPopup` opens a pop-up window (or `acquireTokenRedirect`) redirects users to the Microsoft identity platform. In that window, users need to interact by confirming their credentials, giving consent to the required resource, or completing the two-factor authentication.
