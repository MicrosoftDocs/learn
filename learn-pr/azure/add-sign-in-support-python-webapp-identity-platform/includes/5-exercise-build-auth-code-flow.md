The sign-in flow in MSAL Python takes these high level steps: 

:::image type="content" source="../media/5-webapp-authentication-flow.png" border="false" alt-text="Web app sign in authentication flow":::

In this exercise, you'll add code to sign in users, grant them access to resources, and sign them out. Follow these steps to build your core application logic:

- Set up the Flask application
- Create the authorization code flow dictionary
- Create app routes
- Create a confidential client instance
- Add code to sign users
- Add code to sign out users

## Set up the Flask application

You're now ready to start writing your core application logic. The `app.py` file in your project directory will hold the code. 

For your application to sign in Azure AD users, start by importing the authentication library into your application. Add the following code to `app.py` to import the MSAL Python:

```python
# 📁 app.py
# Import MSAL Python
import msal
from msal.authority import (AuthorityBuilder, AZURE_PUBLIC)
```

Next, import Flask modules that your application will use to handle render templates and session access by adding the snippet below to `app.py`:

```python
# Flask imports to handle render templates and session access
from werkzeug.middleware.proxy_fix import ProxyFix
from werkzeug.exceptions import Forbidden, Unauthorized
from flask import Flask, render_template, session, request, redirect, url_for
from flask_session import Session
```

After importing the authentication library and all required modules, add code to initialize your Python Flask application. 

In the code snippet below, you use the `Flask` class to create an application instance named `app`. You also load the default Flask configurations such as session configs, as shown below: 

```Python
def create_app():
    """Configure the flask application"""

    # Initialize the flask app
    app = Flask(__name__)

    # Load Flask configuration settings
    app.config.from_object("default_settings")

    # Initialize the serverside session for the app
    Session(app)

    # Support both http (localhost) and https (web proxy/cloud)deployments.
    app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1)
```

In addition to the Flask-specific configurations, ` app.config.from_object("default_settings")` gets the client ID, client credential, and tenant ID that will be used with the MSAL client.

The `Session(app)` object initializes a server side session that is used to coordinate the authorization code flow and store the "user" object containing the id token and all associated claims. It also stores two MSAL client caches - the token cache and the http cache. The token cache contains access and refresh tokens while the http cache contains highly cacheable content like responses associated with HTTP requests.

## Create the authorization code flow dictionary

The web app we build in this training module uses the authorization code grant flow. Add the following code to `app.py` to build the auth code flow dictionary using the MSAL client. 

```python
# Redirect unauthorized users through the auth code flow to sign in
@app.errorhandler(Unauthorized)
def initiate_auth_code_flow(error):
    """
    Builds the auth code flow and then redirects to Azure AD for user authorization.
    """

    # Remove stale user from session data, if any.
    session.pop("user", None)

    # The MSAL ConfidentialClientApplication makes an HTTP request to
    # the metadata endpoint for your tenant upon creation.
    http_cache: dict = session.get("msal_http_response_cache", {})

    # Create an MSAL client before initiating the auth code flow.
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

    # Add a dictionary entry to store a post sign-in url where users are redirected.
    auth_code_flow["post_sign_in_url"] = request.url_rule.rule

    # Add the auth code flow initiation to the session
    session["auth_code_flow"] = auth_code_flow

    # Update the session's MSAL http response cache
    session["msal_http_response_cache"] = http_cache

    # Redirect to Azure AD to allow the user to perform any auth steps required. 
    return redirect(session["auth_code_flow"]["auth_uri"])
```

In the code snippet above, when a user attempts to navigate to a location in the application that raises an `Unauthorized` error, the error handler will redirect them through the authorization code flow where they can sign in. An alternative to this user flow would be presenting the user with a sign in page or link where they can manually initiate the authorization code flow.

The first step of building the authorization code flow is creating an an MSAL client using the app registration values (client ID and tenant ID). You then use the MSAL client to build the authorization code flow dictionary. In the snippet above, we also ask the user to consent to the scope `User.Read` that our application requires. 

In the authorization code flow dictionary, we'll add an entry to store the post sign in url where users are redirected after going through the authorization code flow.

Next, add the authorization code flow initiation to the session and update the MSAL http response cache. You also redirect users to Azure AD, where they can perform the necessary authorization code flow actions such as logging in and consenting to the required permissions, if they haven't already. 

## Create app routes

You can add several routes to your web application to grant or prevent access to certain parts of your application. For the scenario in this module, we'll add three routes to the web app we build. Each route will require a different level of authentication or authorization, as follows:

 - Route 1: Accessible by all users as it requires no authentication or authorization. This route will render the `public/index.html` template you created in the previous exercise.
 - Route 2: Accessible by all authenticated users and doesn't require users to have any specific role assignments. This route will render the `authenticated/graph.html` template.
 - Route 3: Accessible by authenticated and authorized users with an application-defined, admin role assigned.This route will render the `authenticated/admin.html` template.

To create route one above that allows access for all users, authenticated or not, add the following code to `app.py`.

```python
@app.get("/")
# This route doesn't require any authentication or authorization
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
    # permissions, Azure AD will redirect the user back to this route.
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

The first step of the sign-in process is to send a request to the `/authorize` endpoint on the identity platform. The authorize endpoint can be used to request tokens or authorization codes via the browser. To do this, we create an application instance of the MSAL Python confidential client using the app registration values, as follows:

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

In the code snippet above, we start by checking whether the session contains a user entry and that the id token is valid. If not, raise an unauthorized error to trigger the auth code flow and redirect the user to sign in. 

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

To sign out users from the application, clear the user's session information from the app's state. Removing the `user`, `auth_code_flow`, and `token_cache` from the dictionary clears anything in the session that is tied to auth.

```python
@app.get("/logout")
def logout():
    # Completely remove anything in the user session tied to authentication.
    session.pop("user", None)
    session.pop("auth_code_flow", None)
    session.pop("token_cache", None)
    return redirect(url_for("index"))

return app
```
In this module, we didn't add an extra front-channel logout URL during the application registration process. Your web app will therefore be called back to its public URL, `index.html` as shown in the code snippet above. 