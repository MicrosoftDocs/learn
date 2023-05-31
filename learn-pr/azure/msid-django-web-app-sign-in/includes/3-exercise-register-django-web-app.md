You must register your web app with Azure Active Directory (Azure AD) to enable user authentication. In our example, the banking company intends to build a Django web app to allow its customers to access services. Here, you register a single-tenant web app in Azure AD and configure a Django app to use the registration details. You also create a test user for testing purposes.

## Register a single-tenant web application

Apps that use the Microsoft identity platform are registered and managed in Azure AD tenants.

1. Sign in to the [Azure portal](https://portal.azure.com/). If your account is in more than one Azure AD tenant, select your profile at the upper-right corner of the page, and then switch the directory to change your portal session to the desired Azure AD tenant.
1. Go to the [App registrations page](https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade) for the Microsoft identity platform for developers.
1. Select **+ New registration**.

    :::image type="content" source="../media/03-app-registration-page.png" alt-text="Screenshot of the Azure portal that shows the page for app registrations." :::

1. On the **Register an application** pane that appears, enter your application's registration information:

    1. In the **Name** section, enter a meaningful application name that will appear for users of the app. For example, enter **python-django-webapp-auth**.
    1. Under **Supported account types**, select **Accounts in this organizational directory only**.
    1. In the **Redirect URI (optional)** section, select **Web** and enter the following redirect URI: **http://localhost:8000/auth/redirect**.

    :::image type="content" source="../media/03-app-registration-form.png" alt-text="Screenshot of the Azure portal that shows an app registrations form." :::

1. Select **Register** to create the application.
1. On the app's registration pane, find and note the **Application (client) ID** and **Directory (tenant) ID** values. You'll use these values in your app's configuration files later in your code.

    :::image type="content" source="../media/03-app-registration-details.png" alt-text="Screenshot of that Azure portal that shows an app ID and tenant ID." :::

1. Select **Save** to save your changes.

## Create a client secret for the app registration

The web app needs a client secret to sign in with Azure AD and exchange the authorization code for an access token.

1. On the app's registration pane, select **Certificates & secrets** to open the pane where you can generate secrets and upload certificates.
1. In the **Client secrets** section, select **+ New client secret** to open the **Add a client secret** panel.

    :::image type="content" source="../media/03-app-certificates-and-secrets.png" alt-text="Screenshot of the Azure portal that shows the pane for creating certificates and secrets." :::

    1. Enter a key description. For example, enter **Django web app secret**.
    1. Select one of the available key durations, based on your security concerns.
    1. Select **Add**, and then copy the generated key value. You'll need this key later in your code's configuration files.
    
       This key value won't appear again, and you can't retrieve it by any other means. Be sure to note it before you go anywhere else in Azure portal.

       :::image type="content" source="../media/03-app-registration-secret-value.png" alt-text="Screenshot of the Azure portal that shows details of app secrets." :::

## Create a test user

Create a test user account to use with the test app.

1. Go to your tenant's overview page and select **Users** on the left menu.

    :::image type="content" source="../media/03-tenant-users-page.png" alt-text="Screenshot of the Azure portal that shows the tenant overview page." :::

1. On the **Users** page, select **+ New user** > **Create new user**.

    :::image type="content" source="../media/03-add-new-user-page.png" alt-text="Screenshot of the Azure portal that shows the page for adding a new user to a tenant." :::

1. In the form that appears, fill in the required fields and then select **Create**.

## Configure the Django web app to use app registration details

To configure your Django web app to use the Azure AD app registration details, ensure that you have a running Django project. Then use the following steps.

1. Install the `ms-identity-web` library. The `ms-identity-web` library is a wrapper for the Microsoft Authentication Library (MSAL) for Python and handles much of the required MSAL for Python configurations.

    ```bash
        pip install git+https://github.com/azure-samples/ms-identity-python-utilities@main
    ```

1. Create the Azure AD JSON configuration file that stores the registration details. You create this file at the base of the project, in the same directory as the *manage.py* file. Name the file *aad.config.json* and add the following content:

    1. Find the string `{enter-your-tenant-id-here}` and replace the existing value with your Azure AD tenant ID.
    1. Find the string `{enter-your-client-id-here}` and replace the existing value with the application ID (client ID).
    1. Find the string `{enter-your-client-secret-here}` and replace the existing value with the client secret value.

    ```json
        {
            "type": {
                "client_type": "CONFIDENTIAL",
                "authority_type": "SINGLE_TENANT",
                "framework": "DJANGO"
            },
            "client": {
                "client_id": "{enter-your-client-id-here}",
                "client_credential": "{enter-your-client-secret-here}",
                "authority": "https://login.microsoftonline.com/{enter-your-tenant-id-here}"
            },
            "auth_request": {
                "redirect_uri": null,
                "scopes": [],
                "response_type": "code"
            },
            "flask": null,
            "django": {
                "id_web_configs": "MS_ID_WEB_CONFIGS",
                "auth_endpoints": {
                    "prefix": "auth",
                    "sign_in": "sign_in",
                    "edit_profile": "edit_profile",
                    "redirect": "redirect",
                    "sign_out": "sign_out",
                    "post_sign_out": "post_sign_out"
                }
            }
        }
    ```

1. In the project's settings file, add the `MsalMiddleware` class from the `ms_identity_web` library to the project's middleware.

   The Azure AD configuration object is created from the JSON configuration file. This Azure AD configuration object is used to instantiate `IdentityWebPython`. It must be named `MS_IDENTITY_WEB`.

    ```python
        from ms_identity_web.configuration import AADConfig
        from ms_identity_web import IdentityWebPython
 
        AAD_CONFIG = AADConfig.parse_json(file_path='aad.config.json')
        MS_IDENTITY_WEB = IdentityWebPython(AAD_CONFIG)
        ERROR_TEMPLATE = 'auth/{}.html' # for rendering 401 or other errors from msal_middleware
        MIDDLEWARE.append('ms_identity_web.django.middleware.MsalMiddleware')
    ```

## Check your work

At this point, you've registered a single-tenant web app in Azure AD. You've also configured a Django web app to use the app registration details.

Run your Django project by using the following command to confirm that it's working well:

```bash
    python manage.py runserver
```
