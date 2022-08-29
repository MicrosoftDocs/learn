You'll use the Microsoft Authentication Library (MSAL) for Python to add authentication to a daemon app that uses its identity to get access tokens from Azure Active Directory (Azure AD).

In this exercise, you'll add application permissions to access Microsoft Graph and build your daemon app.

## Application permission to Microsoft Graph

Configure application permissions for an application that needs to authenticate as itself without user interaction or consent. Application permissions are typically used by background services or console apps that access an API without a graphical user interface (GUI), and by web APIs that access another (downstream) API.

In the following steps, you grant the registered app permission to Microsoft Graph's _User.Read.All_ permission:

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: in the top menu to select the tenant containing your client app's registration.
1. Select **Azure Active Directory** > **App registrations**, and then select your client application.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. Under **Select permissions**, search and expand **User**, and then select the *User.Read.All* permission.
1. Select **Add permissions**.
1. Select **Grant admin consent** to grant admin consent.

## Install the authentication library

From your terminal, run the following command to install the MSAL for Python package:

```bash
pip install msal
```

## Create a Python daemon application

1. Create a folder named `cli-access-protected-api` for your application.

1. Inside the `cli-access-protected-api` folder, create a new file named `cli.py` and add the following code:

   ```python
    import json
    import requests
    
    # import the required MSAL for Python module(s)
    from msal import ConfidentialClientApplication
    
    # MSAL requires these values for interaction with the Microsoft identity platform.
    # Get the values from Azure portal > Azure Active Directory > App registrations > $YOUR_APP_NAME.
    config = {
        # Full directory URL, in the form of https://login.microsoftonline.com/<tenant_id>
        "authority": "https://login.microsoftonline.com/tenant_id",
        # 'Application (client) ID' of app registration in Azure portal - this value is a GUID
        "client_id": "Enter_the_Application_Id_Here",
        # Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
        "client_secret": "Enter_the_Client_Secret_Here"
    }
    
    # This app instance should be a long-lived instance because
    # it maintains its own in-memory token cache (the default).
    app = ConfidentialClientApplication(
        client_id=config["client_id"],
        authority=config["authority"],
        client_credential=config["client_secret"],
    )
    
    # First, check for a token in the cache, refreshing it if needed
    result = app.acquire_token_silent(
        scopes=["https://graph.microsoft.com/.default"], account=None
    )
    
    # If no token was found in the cache or the token refresh failed, get a new one
    if not result:
        result = app.acquire_token_for_client(
            scopes=["https://graph.microsoft.com/.default"]
        )
    
    print("Could not find a cached token, so fetching a new one.")
    
   ```

   In the sample code we've created, we import `json`, `requests` and `msal` module for our daemon app. The `config` section contains the values required for interaction with the Azure AD.

1. Replace the values in the config section as described here:

     - Replace `tenant_id` with the **Directory (tenant) ID** you recorded during your app registration.
     - Replace `Enter_the_Application_Id_Here` with the **Application (client) ID** you recorded during your app registration.
     - Replace `Enter_the_Client_Secret_Here` with the `Value` for the `Client secrets` you recorded during your app registration.

   The `app` section creates `ConfidentialClientApplication` instance, and reuses it during the lifecycle of the app. The `result` section checks if there's no suitable token in the cache, we send a request to Azure AD to get a new token. The `acquire_token_silent` helps to fetch the token of the current logged in identity silently. If the token expires, it sends a request, and automatically refreshes the token.

   The `app` section creates a `ConfidentialClientApplication` instance and reuses it during the lifecycle of the app. The `acquire_token_silent` helps to fetch the token of the current logged in identity silently. If the token expires, it sends a request, and automatically refreshes the token.

### Authorize access to Microsoft Graph API

Now, let's update the daemon app to register support for calling Microsoft Graph.

Underneath the `if not result` section, add the following code snippet:

```python
if "access_token" in result:
    # Get *this* application's application object from Microsoft Graph
    response = requests.get(
        f"https://graph.microsoft.com/v1.0/users",
        headers={"Authorization": f'Bearer {result["access_token"]}'},
    ).json()
    print(f"Graph API call result: {json.dumps(response, indent=2)}")
else:
    print("Error encountered when requesting access token: " f"{result.get('error')}")
    print(result.get("error_description"))
```

Once we get a valid access token, we send it in the request authorization header in order to gain access to the Microsoft Graph API.

## Complete code snippet

Your final source code should look like the following snippet:

```python
import json
import requests
# import the required MSAL for Python module(s)
from msal import ConfidentialClientApplication
# MSAL requires these values for interaction with the Microsoft identity platform.
# Get the values from Azure portal > Azure Active Directory > App registrations > $YOUR_APP_NAME.
config = {
    # Full directory URL, in the form of https://login.microsoftonline.com/<tenant_id>
    "authority": "https://login.microsoftonline.com/tenant_id",
    # 'Application (client) ID' of app registration in Azure portal - this value is a GUID
    "client_id": "Enter_the_Application_Id_Here",
    # Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
    "client_secret": "Enter_the_Client_Secret_Here"
}
# This app instance should be a long-lived instance because
# it maintains its own in-memory token cache (the default).
app = ConfidentialClientApplication(
    client_id=config["client_id"],
    authority=config["authority"],
    client_credential=config["client_secret"],
)
# First, check for a token in the cache, refreshing it if needed
result = app.acquire_token_silent(
    scopes=["https://graph.microsoft.com/.default"], account=None
)
# If no token was found in the cache or the token refresh failed, get a new one
if not result:
    result = app.acquire_token_for_client(
        scopes=["https://graph.microsoft.com/.default"]
    )
print("Could not find a cached token, so fetching a new one.")
if "access_token" in result:
    # Get users from Microsoft Graph
    response = requests.get(
        f"https://graph.microsoft.com/v1.0/users",
        headers={"Authorization": f'Bearer {result["access_token"]}'},
    ).json()
    print(f"Graph API call result: {json.dumps(response, indent=2)}")
else:
    print("Error encountered when requesting access token: " f"{result.get('error')}")
    print(result.get("error_description"))
```

### Run the daemon app

Let's verify that our Python daemon app works. If you haven't already, change to the `cli-access-protected-api` directory and run the following command:

```bash
python cli.py
```

If your Python daemon runs successfully, you’ll see the following similar output on the command line:

```json
Could not find a cached token, so fetching a new one.
Graph API call result: {
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users/$entity",
  "businessPhones": [],
  "displayName": "Henry Kiarie",
  "givenName": "Henry",
  "jobTitle": null,
  "mail": null,
  "mobilePhone": null,
  "officeLocation": null,
  "preferredLanguage": "en",
  "surname": "Kiarie",
  "userPrincipalName": "henry.com#EXT#@henry.onmicrosoft.com",
  "id": "12db367f-7896-437d-b7bd-f9295ea9b971"
}
```

You've successfully created a Python daemon app that uses its own identity and acquires a valid access token to call a protected web API. You can use Celery to run your app in the background.
