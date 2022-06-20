Before making a REST call to an API, such as Microsoft Graph, you'll need to acquire an access token. To get an access token with the necessary scopes, invoke the `acquire_token_flow` on the MSAL client. Based on the requested scopes, Azure AD presents a consent dialogue to the user upon signing in. If the user consents to one or more scopes and obtains a token, the scopes are encoded into the resulting access token.

Note the scope requested by the application by referring app.py. By default, this array is set to `["User.Read]`, the Microsoft Graph API scope for accessing basic user account information. The graph endpoint for accessing this info is `https://graph.microsoft.com/v1.0/me`. 

Any valid requests made to this endpoint must bear an access token containing scope `User.Read` in the Authorization header. A complete cache miss will result in an error and indicates that a former auth code flow exchange didn't include this scope in the request.

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
# Call the Microsoft Graph API

Now that you have a token, you can call a protected web API. To call the Microsoft Graph API, update `app.py` with the following code. 

```python
# Simple HTTP Get to graph showing the usage of the retrieved access token
response = requests.get(
    "https://graph.microsoft.com/v1.0/me",
    headers={"Authorization": f"Bearer {result['access_token']}"},
).json()

# Show the "Graph" view for authenticated users
return render_template("authenticated/graph.html", 
    graphCallResponse=response,
    graphAccessTokenExpiresInSeconds=result['expires_in'])
```

A call to the Microsoft Graph API is a simple HTTP Get that contains the access token in the authorization header. After consenting to the requested permissions and signing in, the app displays that you've successfully logged in using your Azure AD credentials. The controller makes a call to `Microsoft Graph's /me` API endpoint for your user and received the following information. 

:::image type="content" source="../media/6-call-microsoft-graph-api.png" border="false" alt-text="Call Microsoft Graph API":::

 If after making a request, the API call result comes back with an error, the user will need to go through the authorization code grant flow again. In this tutorial, we asked the user to consent to all app permissions upfront. You could also handle this situation by requesting for no specific scopes in the initial auth code flow and performing on-demand, step-up authentication depending on your desired user experience. 