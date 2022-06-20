
After a user signs in, your app shouldn't ask users to reauthenticate every time they need to access a protected resource. To prevent such reauthentication requests, you acquire an access token without user interaction by calling `acquire_token_silent`, as illustrated in the code sample above. This will first look for a valid access token from the cache, or if needed, find a valid refresh token and then use it to redeem a new access token. 

If the `acquire_token_flow` found an expired access token and needed to use the refresh token, you update the session's token cache to reflect the new access token and refresh token. As such, the next invocation won't require exchanging the refresh token for the access token again.  

There are some situations, however, where you might need to force users to interact with the Microsoft identity platform. For example:

- Users need to reenter their credentials because the session has expired.
- The refresh token has expired.
- Your application is requesting access to a resource and you need the user's consent.
- Two-factor authentication is required.
- The refresh token has been revoked by the server because of a change in credentials, user action, or admin action.

Calling `acquireTokenPopup` opens a pop-up window (or `acquireTokenRedirect`) redirects users to the Microsoft identity platform. In that window, users need to interact by confirming their credentials, giving consent to the required resource, or completing the two-factor authentication.

## Access protected routes 

You can use application-defined roles to access protected app routes. The route users access in this section requires the application-defined, admin role assignment. If after signing in the user, performing a role check, and successfully verifying that their claim has this specific app role assigned, you can grant access to the admin view page of the application.

```Python
# Upon successful authentication, show the "Admin" view
return render_template(
    "authenticated/admin.html", graphCallResponse=user_claims
)
```

Accessing the Microsoft Graph API with the admin role assigned returns the protected app page, as shown below.

:::image type="content" source="../media/7-call-graph-admin-role.png" border="false" alt-text="Call Microsoft Graph API with defined role assignment":::
