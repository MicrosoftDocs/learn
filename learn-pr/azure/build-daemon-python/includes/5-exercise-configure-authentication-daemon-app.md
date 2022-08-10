You'll use the Microsoft Authentication Library (MSAL) for Python to add authentication to a daemon app that uses its identity to get access tokens from Azure Active Directory (Azure AD).

In this exercise, you'll configure application permissions for Microsoft Graph and build your daemon app.

## Application permission to Microsoft Graph

Configure application permissions for an application that needs to authenticate as itself without user interaction or consent. Application permissions are typically used by background services or console apps that access an API in a "headless" manner, and by web APIs that access another (downstream) API.

In the following steps, you grant the registered app permission to Microsoft Graph's _User.Read.All_ permission:

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: in the top menu to select the tenant containing your client app's registration.
1. Select **Azure Active Directory** > **App registrations**, and then select your client application.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. All permissions exposed by Microsoft Graph are shown under **Select permissions**.
1. Select the permission or permissions you want to grant your application. In our case, we have a daemon app that needs to read users profile.

    Under **Select permissions**, expand **User**, and then select the *User.Read.All* permission.
1. Select **Add permissions**.

Some permissions, like Microsoft Graph's *User.Read.All* permission, require admin consent. You grant admin consent by selecting the **Grant admin consent** button.

## Install the authentication library

After activating your virtual environment, you can now install the MSAL for Python package using `pip`:

```bash
pip install msal
```

## Create a Python daemon application

From your shell or command line:

1. Create a folder for the application.

   ```bash
   mkdir cli-access-protected-api
   ```

1. First, change to your project directory in your terminal, create a file named `cli.py` and add the following code:

   ```python
    import json
    import requests
    
    # import the required MSAL for Python module(s)
    from msal import ConfidentialClientApplication
    
    # MSAL requires these values for interaction with the Microsoft identity platform.
    # Get the values from Azure portal > Azure Active Directory > App registrations > $YOUR_APP_NAME.
    config = {
        # Full directory URL, in the form of https://login.microsoftonline.com/<tenant_id>
        "authority": "",
        # 'Application (client) ID' of app registration in Azure portal - this value is a GUID
        "client_id": "",
        # Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
        "client_secret": "",
        # Client 'Object ID' of app registration in Azure portal - this value is a GUID
        "client_objectid": "",
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

   In the sample code we've created, we import the required Python module for our daemon app. The `config` section contains the values required for interaction with the Azure AD.

   Modify the values in the config section as described here:

     - `authority` is the full URL that points to your tenant. The `tenant_id` is the **Directory (tenant) ID** for the app you registered. To find the value for the **Directory (tenant) ID**, go to the app's **Overview** pane in the Azure portal.
     - `client_id` is the **Application (client) ID** for the app that you registered. To find the value for the **Application (client) ID**, go to the app's **Overview** pane in the Azure portal.
     - `client_secret` is the `Value` for the `Client secrets` that you registered for your app in the Azure portal.
     - `client_objectid` is the **Object ID** for the app that you registered. To find the value for the **Object ID**, go to the app's **Overview** pane in the Azure portal.

   The `app` section creates `ConfidentialClientApplication` instance, and reuses it during the lifecycle of the app. The `result` section checks if there's no suitable token in the cache, we send a request to Azure AD to get a new token. The `acquire_token_silent` helps to fetch the token of the current logged in identity silently. If the token expires, it sends a request, and automatically refreshes the token.

### Authorize access to Microsoft Graph API

Now, let's update the daemon app to register support for calling Microsoft Graph.

Underneath result section, add the following code snippet:

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

```python
import json
import requests
# import the required MSAL for Python module(s)
from msal import ConfidentialClientApplication
# MSAL requires these values for interaction with the Microsoft identity platform.
# Get the values from Azure portal > Azure Active Directory > App registrations > $YOUR_APP_NAME.
config = {
    # Full directory URL, in the form of https://login.microsoftonline.com/<tenant_id>
    "authority": "",
    # 'Application (client) ID' of app registration in Azure portal - this value is a GUID
    "client_id": "",
    # Client secret 'Value' (not its ID) from 'Client secrets' in app registration in Azure portal
    "client_secret": "",
    # Client 'Object ID' of app registration in Azure portal - this value is a GUID
    "client_objectid": "",
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

### Run the daemon app

Let's verify our Python daemon works. If you haven't already, change to the `cli-access-protected-api` directory and run the following command:

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
  "userPrincipalName": "henrymbuguakiarie_gmail.com#EXT#@henrymbuguakiariegmail.onmicrosoft.com",
  "id": "12db367f-7896-437d-b7bd-f9295ea9a921"
}
```
