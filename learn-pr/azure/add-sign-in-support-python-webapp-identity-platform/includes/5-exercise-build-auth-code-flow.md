To sign in users securely, you need to build an authorization flow using one of the grants and token flows supported by the identity platform. In this tutorial, you use the authorization code grant flow for sign-in. Add the following code to `app.py` to build the auth code flow dictionary and redirect users to Azure AD to perform the necessary authorization code flow actions.

```python
# Redirect unauthorized users through the auth code flow to sign in
@app.errorhandler(Unauthorized)
def initiate_auth_code_flow(error):
    """
    Builds the auth code flow and then redirects to Azure AD to allow the
    user to perform authorization.
    """

    # Remove stale user from session data (if any)
    session.pop("user", None)

    # The MSAL ConfidentialClientApplication will always make an HTTP
    # request to the metadata endpoint for your tenant upon creation.
    http_cache: dict = session.get("msal_http_response_cache", {})

    # The MSAL client has a method to initiate the auth code flow, so the
    # first step is to create a MSAL client.
    msal_client = msal.ConfidentialClientApplication(
        app.config.get("CLIENT_ID"),
        authority=AuthorityBuilder(AZURE_PUBLIC, app.config.get("TENANT_ID")),
        http_cache=http_cache,
    )

    # Use the MSAL client to build the auth code flow dictionary.
    auth_code_flow: "dict[str, Any]" = msal_client.initiate_auth_code_flow(
        scopes=["https://graph.microsoft.com/User.Read"],
        redirect_uri=url_for("authorized", _external=True),
    )

    # Add a dictionary entry to store where the user should be directed to
    # after the last leg of the auth code flow
    auth_code_flow["post_sign_in_url"] = request.url_rule.rule

    # Add the auth code flow initiation to the session
    session["auth_code_flow"] = auth_code_flow

    # Update the session's MSAL http response cache
    session["msal_http_response_cache"] = http_cache

    # Redirect to Azure AD to allow the user to perform any auth steps required. 
    return redirect(session["auth_code_flow"]["auth_uri"])
```

## Create app routes

You can add several routes to your application to grant or prevent access to certain parts of your app without authorization. The web app we build in this tutorial has three routes, each requiring a different level of authentication or authorization, as follows:

 - Route 1: Accessible by all users as it requires no authentication or authorization.
 - Route 2: Accessible by all authenticated users and doesn't require users to have any specific role assignments
 - Route 3: Accessible by authenticated and authorized users with an application-defined, admin role assigned.

To create route one above that allows access for all users, unauthenticated or not, add the following code to `app.py`.

```python
@app.get("/")
# This route does not require any authentication or authorization
def index():

    # Return the "Index" view
    return render_template("public/index.html")

@app.get("/auth/redirect")
# Azure AD will redirect the user back to this URL after their sign-in is complete.
def authorized():
    """
    Handles the redirect from Azure AD for the second leg of the auth code flow.
    """

    # After the user signs in and accepts the required application
    # permissions, Azure AD #will redirect the user back to this route.
    # Pop out the auth code flow in which we started in their prior call
    # as it isn't needed that after this request is complete.
    auth_code_flow: "dict[str, Any]" = session.pop("auth_code_flow")

    # Hydrate the existing MSAL token cache from the session or start an
    # empty one.
    token_cache = msal.SerializableTokenCache()
    if session.get("token_cache"):
        token_cache.deserialize(session["token_cache"])

    # The MSAL ConfidentialClientApplication will always make an HTTP
    # request to the metadata endpoint for your tenant upon creation.
    # Using the http cache feature will optimize that process as that
    # data is highly cacheable, and ideally would survive for the whole
    # user's session. This shouldn't be cached across user sessions.
    http_cache: dict = session.get("msal_http_response_cache", {})

    msal_client = msal.ConfidentialClientApplication(
        app.config.get("CLIENT_ID"),
        authority=AuthorityBuilder(AZURE_PUBLIC, app.config.get("TENANT_ID")),
        client_credential=app.config.get("CLIENT_CREDENTIAL"),
        token_cache=token_cache,
        http_cache=http_cache,
    )

    # Exchange the original auth code flow request and the new Azure AD
    # response parameters for id, access, and refresh tokens based on the
    # requested scopes from the original request.
    result: "dict[str, Any]" = msal_client.acquire_token_by_auth_code_flow(
        auth_code_flow, request.args
    )

    # Persist the MSAL client caches in the user's session for future
    # calls to acquire_token_silently.
    session["token_cache"] = token_cache.serialize()
    session["msal_http_response_cache"] = http_cache

    # Our "user" session object will contain both the raw ID token and the
    # deserialized claims. This supports easy access to the claims and
    # easy access to check if the id_token is still valid (not expired,
    # for example)
    session["user"] = {
        "id_token": result["id_token"],
        "id_token_claims": result["id_token_claims"],
    }

    # Send the user to their original destination, which was captured in
    # the auth_code_flow session object.
    return redirect(auth_code_flow["post_sign_in_url"])
```

The route you create in the code snippet above isn't called by the user, but instead, Azure AD redirects the user's browser to this page when they sign in and consent to the required permissions.

The other two routes that require a specific level of authentication and authorization are covered in the [sign in users](#sign-in-users) section of this tutorial series.

## Create a confidential client using the app registration values

The first step of the sign-in process is to send a request to the `/authorize` endpoint on the identity platform. The authorize endpoint can be used to request tokens or authorization codes via the browser. To do this, we create an application instance of
 the MSAL Python confidential client using the app registration values, as follows:

```python
# Create an MSAL client using the app's configuration values and provide the token cache.
msal_client = msal.ConfidentialClientApplication(
    app.config.get("CLIENT_ID"),
    authority=AuthorityBuilder(AZURE_PUBLIC, app.config.get("TENANT_ID")),
    client_credential=app.config.get("CLIENT_CREDENTIAL"),
    token_cache=token_cache,
    http_cache=http_cache,
)
```

The MSAL client doesn't need a token cache as none of its interactions use or produce tokens in the initiate auth code flow process.

## Sign in users

This confidential client instance is leveraged to construct an `/authorize` request URL with the appropriate parameters, and the browser is redirected to this URL.

To create a route that authenticates users without specific role assignments, add the following code to `app.py`.

```Python
@app.get("/graph")
# This route requires prior authentication
def graph():
    # If the session doesn't currently contain a "user" entry or is missing
    # the token cache entry, raise an Unauthorized error, which can be used to trigger a new auth code flow.
    if not session.get("user") or not session.get("token_cache"):
        raise Unauthorized()

    # Perform additional session validation and raise an unauthorized error
    # to trigger a new auth code flow if needed.
    try:
        msal.oauth2cli.oidc.decode_id_token(session["user"]["id_token"])
    except RuntimeError as err:
        raise Unauthorized("ID Token expired or invalid") from err

    # Perform a request to graph that only requires User.Read scope
    # This scope was already requested to be granted by the user.

    # Get an access token that contains the necessary scope for User.Read on graph. 
    # This token will come from the cache (and if expired, will use the 
    #refresh token found in the cache to fetch and cache a new token.

    token_cache = msal.SerializableTokenCache()
    token_cache.deserialize(session["token_cache"])

    http_cache: dict = session.get("msal_http_response_cache", {})
```

As illustrated in the code snippet above, we start by checking whether the session contains a user entry and that the  id token is valid. If not, raise an unauthorized error to trigger the auth code flow and redirect the user to sign in. 

To create the `@app.get("/admin")` route that requires the user to have an application-defined, admin role assigned, update `app.py` with the following code.

```Python
# This route requires prior authentication and authorization. 
# Users should have the application-defined, admin role assigned.
@app.get("/admin")
def admin():
    # If the session doesn't currently contain a "user" entry that means we
    # haven't completed the auth code flow yet. Raise an Unauthorized error,
    # which can be used to trigger a new auth code flow.
    if not session.get("user"):
        raise Unauthorized()

    # Perform additional session validation as desired.
    try:
        msal.oauth2cli.oidc.decode_id_token(session["user"]["id_token"])
    except RuntimeError as err:
        raise Unauthorized("ID Token expired or invalid.") from err

    # If a role check was requested, look at the user's claims for the "roles"
    # claim. If the claim doesn't exist or does not contain "admin" as an item
    # in it, then raise a Forbidden error.
    user_claims = session["user"]["id_token_claims"]
    if "roles" not in user_claims or "admin" not in user_claims["roles"]:
        raise Forbidden("User is missing a required role.")
```

In the code sample above, you verify that the user is authenticated and that their session is still valid. If either of the two statements is false, raise an unauthorized error to trigger the auth code flow and redirect the user to the sign in page. After signing in, we perform a role check to verify that the user has the application-defined, admin-role assigned. If the user's claim doesn't exist or doesn't contain the `admin` role, prevent the user from accessing the page. If the required application-defined role exists, grant access to the page. 

## Sign out users

To sign out a user from your Python web app, you clear the session information about the signed-in account from the app's state. This should completely remove anything in the session that is tied to auth. 

You could also redirect the user to the Microsoft identity platform logout endpoint to sign out. When your web app redirects the user to the logout endpoint, this endpoint clears the user's session from the browser. If your app didn't go to the logout endpoint, the user will still have a valid single sign-in session with the identity platform. As such, they could reauthenticate to your app without entering their credentials again.

```python
@app.get("/logout")
def logout():
    # If we had anything in our session tied to auth, completely remove it.
    # The msal_http_response_cache can survive this as there is nothing
    # related to an individual authentication cached in there.
    session.pop("user", None)
    session.pop("auth_code_flow", None)
    session.pop("token_cache", None)
    return redirect(url_for("index"))

return app
```

In this module, we didn't add an extra front-channel logout URL during the application registration process.Your web app will therefore be called back to its main URL, as shown in the `logout` code snippet above. 