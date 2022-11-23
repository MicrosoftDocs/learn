In this exercise, you'll add code to sign in users, grant them access to resources, and sign them out. Follow these steps to build your core application logic:

- Update the web app to use the Azure portal app registration details
- Set up the Flask application
- Create the authorization code flow dictionary
- Create app routes
- Add code to sign users
- Add code to sign out users

## Update your web app with the Azure portal app registration details

The first step is configuring your Python web app to use the app registration details from the Azure portal. To do this, add the following code to *default_settings.py*.

```Python

from environs import Env

env = Env()
env.read_env()

ENV = env.str("FLASK_ENV", default="production")
DEBUG = True

# For local development purposes
SESSION_TYPE = "filesystem"

# 'Application (client) ID' of app registration in Azure portal - this value is a GUID
CLIENT_ID = "enter-your-client-id-here"

# Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
# Read your client credential value from an environment variable
CLIENT_CREDENTIAL = "pass-your-client-secret-value-here"

# 'Tenant ID' of your Azure AD instance - this is a GUID
TENANT_ID = "enter-your-tenant-id-here"
```

After adding the code snippet above, update the client ID, tenant ID, and client secret values with the configuration properties from your application registration. The client ID and tenant ID values are listed in the **Overview** pane of your Azure portal app registration. For enhanced security, don't hardcode your client credential in the source code. Instead, pass the credentials securely by reading them from an environment variable. 

## Set up the Flask application

You're now ready to start writing your core application logic. The *app.py* file in your project directory will hold the code we add in the remaining part of this unit. 

For your application to sign in Azure AD users, start by importing the authentication library into your application. You'll also import Flask modules that your application will use to handle render templates and session access. Add the snippet below to *app.py*:

```python

# Import MSAL Python
import msal
from msal.authority import (AuthorityBuilder, AZURE_PUBLIC)
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

In the snippet above, `Session(app)` initializes a server side session that is used to coordinate the authorization code flow and store the "user" object containing the ID token and all associated claims. It also stores two MSAL client caches - the token cache and the http cache. The token cache contains access and refresh tokens while the http cache contains highly cacheable content like responses associated with HTTP requests.

## Create the authorization code flow

The web app we build in this training module uses the authorization code grant flow. This is the recommended flow for web apps as it is the most secure. 

The first step of building the authorization code flow is creating an MSAL client using the app registration values (client ID and tenant ID). You then use the MSAL client to build the authorization code flow dictionary. Add the snippet below to *app.py* to build the authorization code flow dictionary using the MSAL client. You also request users to consent to the `User.Read` scope that our application requires.

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

In the code snippet above, when a user attempts to navigate to a location in the application that raises an `Unauthorized` error, the error handler will redirect them through the authorization code flow where they can sign in. An alternative to this user flow would be presenting the user with a sign-in page or link where they can manually initiate the authorization code flow.

In the authorization code flow dictionary, we'll add an entry to store the post sign-in url where users are redirected after going through the authorization code flow.

Next, add the authorization code flow initiation to the session and update the MSAL http response cache. You also redirect users to Azure AD, where they can perform the necessary authorization code flow actions. This could be logging in and consenting to the required permissions, if they haven't already. 

## Create app routes

You can add several routes to your web application to grant or prevent access to certain parts of your application. For the scenario in this module, we'll add three routes to the web app we build. Each route will require a different level of authentication or authorization, as follows:

 - Route 1: Accessible by all users as it requires no authentication or authorization. This route will render the `public/index.html` template you created in the previous exercise.
 - Route 2: Accessible by all authenticated users and doesn't require users to have any specific role assignments. This route will render the `authenticated/graph.html` template.
 - Route 3: Accessible by authenticated and authorized users with an application-defined, admin role assigned. This route will render the `authenticated/admin.html` template.

To create route one that allows access for all users, authenticated or not, add the following code to *app.py*.

```python
@app.get("/")
# This route doesn't require any authentication or authorization
def index():

    # Return the "Index" view
    return render_template("public/index.html")

@app.get("/auth/redirect")
# Azure AD redirects users back to this URL after signing in
def authorized():
    """
    Handles the redirect from Azure AD for the second leg of the auth code flow.
    """

    # Pop out the existing auth code flow as it isn't needed after completing this request
    auth_code_flow: "dict[str, Any]" = session.pop("auth_code_flow")

    # Hydrate the existing MSAL token cache from the session or start an empty one.
    token_cache = msal.SerializableTokenCache()
    if session.get("token_cache"):
        token_cache.deserialize(session["token_cache"])

    # The MSAL ConfidentialClientApplication makes an HTTP request to the metadata endpoint for 
    # your tenant. The HTTP cache is used for data that would survive the entire user's session.
    http_cache: dict = session.get("msal_http_response_cache", {})

    # Create an instance of the MSAL confidential client using the app registration values
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

    # Our "user" session object contains the raw ID token and the deserialized claims. 
    # Access to the claims allows us to check if the id_token is still valid
    session["user"] = {
        "id_token": result["id_token"],
        "id_token_claims": result["id_token_claims"],
    }

    # Send the user to their original destination captured in the auth_code_flow session object.
    return redirect(auth_code_flow["post_sign_in_url"])
```

The route you create in the preceding code snippet isn't initiated directly by a user's action in the application. Instead, Azure AD redirects the user's browser to this page when they sign in and consent to the required permissions.

The other two routes that require a specific level of authentication and authorization are covered in the next section of this unit, [sign in users](#sign-in-users).

## Sign in users

To create a route that authenticates users without specific role assignments, add the following code to *app.py*.

```Python
@app.get("/graph")
# This route requires prior authentication
def graph():

    # Check whether session contains a "user" entry or the token cache entry and 
    #raise an Unauthorized error to trigger a new auth code flow.
    if not session.get("user") or not session.get("token_cache"):
        raise Unauthorized()

    # Perform additional session validation and raise an unauthorized error, if appropriate
    try:
        msal.oauth2cli.oidc.decode_id_token(session["user"]["id_token"])
    except RuntimeError as err:
        raise Unauthorized("ID Token expired or invalid") from err

    # Get an access token containing the necessary scope for User.Read on graph. 
    # If the cached access token is expired, use the refresh token to fetch a new token.

    token_cache = msal.SerializableTokenCache()
    token_cache.deserialize(session["token_cache"])

    http_cache: dict = session.get("msal_http_response_cache", {})
    # Create an MSAL client using the app's configuration values and provide the token cache.
    msal_client = msal.ConfidentialClientApplication(
        app.config.get("CLIENT_ID"),
        authority=AuthorityBuilder(AZURE_PUBLIC, app.config.get("TENANT_ID")),
        client_credential=app.config.get("CLIENT_CREDENTIAL"),
        token_cache=token_cache,
        http_cache=http_cache,
    )

    # Invoke the acquire_token flow on the MSAL client for the requested account and scope. 
    # Look for an existing valid token or use the refresh token to fetch a new token.
    result: "dict[str: Any]" = msal_client.acquire_token_silent(
        scopes=["https://graph.microsoft.com/User.Read"],
        account=msal_client.get_accounts()[0],
    )

    # Update the session's token cache to reflect the new access and refresh token.
    if token_cache.has_state_changed:
        session["token_cache"] = token_cache.serialize()
    session["msal_http_response_cache"] = http_cache

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

In the code snippet above, we start by checking whether the session contains a user entry and that the ID token is valid. If not, raise an unauthorized error to trigger the authorization code flow, and redirect the user to sign in. 

To create the `@app.get("/admin")` route that requires the user to have an application-defined, admin role assigned, update *app.py* with the following code.

```Python
# This route requires prior authentication and authorization. 
# Users should have the application-defined, admin role assigned.
@app.get("/admin")
def admin():
    # If session doesn't contain a "user" entry, raise an unauthorized error to trigger the auth code flow.
    if not session.get("user"):
        raise Unauthorized()

    # Perform additional session validation as desired.
    try:
        msal.oauth2cli.oidc.decode_id_token(session["user"]["id_token"])
    except RuntimeError as err:
        raise Unauthorized("ID Token expired or invalid.") from err

    # Look at the user's claims for the "roles" claim. If the claim doesn't exist 
    # or does not contain "admin" as an item in it, then raise a Forbidden error.
    user_claims = session["user"]["id_token_claims"]
    if "roles" not in user_claims or "admin" not in user_claims["roles"]:
        raise Forbidden("User is missing a required role.")

    # Upon successful authentication, show the "Admin" view
    return render_template(
        "authenticated/admin.html", graphCallResponse=user_claims
```

In the code sample above, you verify that the user is authenticated and that their session is still valid. If either of the two statements is false, raise an unauthorized error to trigger the auth code flow and redirect the user to the sign-in page. After signing in, we perform a role check to verify that the user has the application-defined, admin-role assigned. If the user's claim doesn't exist or doesn't contain the `admin` role, prevent the user from accessing the page. If the required application-defined role exists, grant access to the page. 

## Sign out users

To sign out users from the application, clear the user's session information from the application and the identity provider. Removing the `user`, `auth_code_flow`, and `token_cache` from the dictionary clears anything in the session that is tied to the authorization code flow. Add the following code to `app,py`: 

```python
@app.get("/logout")
def logout():
    # Completely remove anything in the user session tied to the auth code flow
    session.pop("user", None)
    session.pop("auth_code_flow", None)
    session.pop("token_cache", None)
    return redirect(url_for("index"))

return app
```
In this module, we didn't add an extra front-channel logout URL during the application registration process. Your web app will therefore be called back to its public URL, `index.html` as shown in the code snippet above. 