Developers can leverage the identity platform to add authentication to a Python Flask web application to enable users to sign in. Adding authentication enables your application to access limited profile information. Once the user grants consent, the application can obtain a token from Azure AD on their behalf and use it to request data from a protected web API.

In this unit, you'll sign in users in a Python Flask web application that uses the Microsoft Authentication Library (MSAL). Follow these steps to enable sign in: 

- Import the auth library
- Import Flask modules
- Initialize the Flask app

## Import the auth library

Before you can sign in Azure AD users, install MSAL for Python in your application. Add the following code to `app.py`

```python
# Import Microsoft Authentication Library (MSAL) for Python
import msal
from msal.authority import (AuthorityBuilder, AZURE_PUBLIC)
```

## Import Flask modules

Next, import Flask modules to handle render templates and session access.

```python
# Flask imports to handle render templates and session access
from werkzeug.middleware.proxy_fix import ProxyFix
from werkzeug.exceptions import Forbidden, Unauthorized
from flask import Flask, render_template, session, request, redirect, url_for
from flask_session import Session
```

## Initialize the Flask app

After importing the required modules, add code to initialize your Python Flask application. You'll also load the default Flask configurations such as session configs, as shown below. 

```Python
def create_app():
    """Configure the flask application"""

    # Initialize the flask app
    app = Flask(__name__)

    # Load Flask configuration settings such as session configs
    app.config.from_object("default_settings")

    # Initialize the serverside session for the app to cordinate auth flows, store the 
    # "user" object and store MSAL client caches (token cache and http cache)
    Session(app)

    # Support both http (localhost) and https (deployed behind a web
    # proxy such as in most cloud deployments). See:
    # https://flask.palletsprojects.com/en/2.0.x/deploying/wsgi-standalone/#proxy-setups
    app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1)
```

In addition to the Flask-specific configurations, ` app.config.from_object("default_settings")` also gets the client id, client credential, and tenant id that will be used with the MSAL client.

The `Session(app)` object initializes a server side session that is used to coordinate the authorization code flow between auth legs and store the "User" object (id token/claims). It also stores two MSAL client caches; (i) the token cache that contains access tokens and refresh tokens and (ii) the http cache that contains highly cacheable content like the metadata endpoint.