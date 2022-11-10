In this unit, you'll test whether the Python web application you created can sign in users. You'll also use the application to call a protected web API and fetch user data.

## Run the application

To start the server, run the following commands from a terminal in the project's root directory:

```python
pip install -r requirements.txt
flask run --host=localhost
```
Open your browser and navigate to `http://localhost:5000`. If everything worked, the sample app should produce an output similar to the screenshot below.

:::image type="content" source="../media/7-python-web-app-home-page.png" alt-text="Screenshot of the Python web app homepage.":::

The application's homepage is accessible by all users as it requires no authentication or authorization, as created in the previous unit.

## Provide consent for application access

When a user navigates to any of the routes that require authentication, their browser is redirected to the Azure AD sign-in page. After signing into your app for the first time, they'll be prompted by Microsoft identity to consent to the app's request for permission to access their data.

:::image type="content" source="../media/6-consent-to-permissions-request.png"  alt-text="Screenshot of the consent window prompting users to accept the app's request for permissions.":::

In Azure AD tenants, an admin could also choose to disable user consent and instead, consent on behalf of all users. To support this scenario, you'll either need to create your own tenant or receive admin consent.

## Call the Microsoft Graph API

Before making a call to an API, such as Microsoft Graph, you'll need to acquire an access token.

:::image type="content" source="../media/7-acquire-token-interactively.png" alt-text="Diagram that shows the interactive token acquisition flow.":::

To get an access token with the necessary scopes, invoke the `acquire_token_flow` on the MSAL client. Based on the requested scopes, Azure AD presents a consent dialogue to the user upon signing in. If the user consents to one or more scopes and obtains a token, the scopes are encoded into the resulting access token.

Note the scope requested by the application by referring app.py. By default, this array is set to `["User.Read]`, the Microsoft Graph API scope for accessing basic user account information. The graph endpoint for accessing this info is `https://graph.microsoft.com/v1.0/me`. 

Any valid requests made to this endpoint must have an access token containing scope `User.Read` in the Authorization header. A complete cache miss will result in an error and indicates that a former auth code flow exchange didn't include this scope in the request.

```python
# Invoke the acquire_token flow on the MSAL client for the requested
# account and scope. Look for and retrieve an existing valid token in
# the cache or use the refresh token to fetch a new access token.
result: "dict[str: Any]" = msal_client.acquire_token_silent(
    scopes=["https://graph.microsoft.com/User.Read"],
    account=msal_client.get_accounts()[0],
)

# Update the session's token cache to reflect the new access token and
# refresh token.
if token_cache.has_state_changed:
    session["token_cache"] = token_cache.serialize()
session["msal_http_response_cache"] = http_cache
```

Now that you have a token, you can call a protected web API. The following snippet in `app.py` calls the Microsoft Graph API and renders a template with the requested data.

```python
# HTTP Get request to graph showing the usage of the retrieved access token
response = requests.get(
    "https://graph.microsoft.com/v1.0/me",
    headers={"Authorization": f"Bearer {result['access_token']}"},
).json()

# Show the "Graph" view for authenticated users
return render_template("authenticated/graph.html", 
    graphCallResponse=response,
    graphAccessTokenExpiresInSeconds=result['expires_in'])
```

A call to the Microsoft Graph API is an HTTP Get that contains the access token in the authorization header. After the user consents to the requested permissions and signs in, the app displays that they've successfully logged in using Azure AD credentials. The controller makes a call to `Microsoft Graph's /me` API endpoint for the user and receives the following information. 

:::image type="content" source="../media/7-call-microsoft-graph-api.png" border="true" alt-text="Screenshot that shows the response upon calling the Microsoft Graph API.":::

If after making a request, the API call result comes back with an error, the user will need to go through the authorization code grant flow again. In this module, we asked the user to consent to all app permissions upfront. Alternatively, depending on your desired user experience, you could request for no specific scopes in the initial authorization code flow and perform on-demand, step-up authentication.

## Access protected routes 

You can use application-defined roles to access protected app routes. The route users access in this section requires the application-defined admin role assignment. If after signing in the user, performing a role check, and successfully verifying that their claim has this specific app role assigned, you can grant access to the admin view page of the application.

```Python
# Upon successful authentication, show the "Admin" view
return render_template(
    "authenticated/admin.html", graphCallResponse=user_claims
)
```

Accessing the Microsoft Graph API with the admin role assigned returns the protected app page, as shown below.

:::image type="content" source="../media/7-call-graph-administrator-role.png" border="true" alt-text="Screenshot of the response when a user with an application-defined role assignment calls the Microsoft Graph API.":::

When a signed in user tries to navigate to a protected route without the required role assigned, Microsoft identity prevents them from accessing the content, as shown below.

:::image type="content" source="../media/7-required-administrator-role-missing.png" border="true" alt-text="Screenshot of the response when a user without an application-defined role assignment tries to access a protected route.":::