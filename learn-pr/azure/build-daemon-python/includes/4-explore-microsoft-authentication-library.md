You've registered your daemon application with Azure Active Directory (Azure AD). You're now ready to add an authentication code to acquire an access token in your daemon app and would like to use an SDK that can handle the authentication details for you.

In this unit, you'll learn about the Microsoft Authentication Library (MSAL) for Python and how it helps with authentication.

## Microsoft Authentication Library for Python

The MSAL for Python allows you to sign in users or apps with Microsoft identities (Azure AD, Microsoft Accounts, and Azure AD B2C accounts) and obtain tokens to call Microsoft APIs such as Microsoft Graph or your own APIs registered with Azure AD.

## Acquire authentication tokens with MSAL

Acquiring tokens with MSAL for Python follows three-step pattern. There will be some variations for different flows.

1. MSAL proposes a clean separation between public client applications, and confidential client applications.

   - **Public client applications:** are apps that run on devices or desktop computers or in a web browser. They're not trusted to safely keep application secrets, so they only access web APIs on behalf of the user.
   - **Confidential client applications:** are apps that run on servers (web apps, web API apps, or even service/daemon apps). They're considered difficult to access, and for that reason capable of keeping an application secret.

   Therefore, create either a `PublicClientApplication` or a `ConfidentialClientApplication` instance, and reuse it during the lifecycle of your app. The following example shows a `PublicClientApplication`:

   ```python
   from msal import PublicClientApplication
   
   app = PublicClientApplication(
    "your_client_id",
    authority="https://login.microsoftonline.com/Enter_the_Tenant_Name_Here")
   ```

   Later, each time you would want an access token, you start by:

   ```python
   result = None  # It is just an initial value. Please follow instructions below.
   ```

1. The API model in MSAL provides you explicit control on how to utilize token cache. This cache part is technically optional, but we highly recommend you to harness the power of MSAL cache. It will automatically handle the token refresh for you.

   ```python
   # We now check the cache to see
   # whether we already have some accounts that the end user already used to sign in before.
   accounts = app.get_accounts()
   if accounts:
        # If so, you could then somehow display these accounts and let end user choose
        print("Pick the account you want to use to proceed:")
        for a in accounts:
            print(a["username"])
        # Assuming the end user chose this one
        chosen = accounts[0]
        # Now let's try to find a token in cache for this account
        result = app.acquire_token_silent(["your_scope"], account=chosen)
   ```

1. If there's no suitable token in the cache or you've chosen to skip the previous step, send a request to Azure AD to get a token. There are different methods based on your client type and scenario. Here we demonstrate a placeholder flow.

   ```python
   if not result:
    # So no suitable token exists in cache. Let's get a new one from Azure AD.
    result = app.acquire_token_by_one_of_the_actual_method(..., scopes=["User.Read"])
   if "access_token" in result:
       print(result["access_token"])  # Yay!
   else:
       print(result.get("error"))
       print(result.get("error_description"))
       print(result.get("correlation_id"))  # You may need this when reporting a bug
   ```
