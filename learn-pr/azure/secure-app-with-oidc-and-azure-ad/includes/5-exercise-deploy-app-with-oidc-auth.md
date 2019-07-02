You can use the Azure CLI to deploy and test an application that uses OpenID Connect.

You've previously registered the application in Azure AD. You can now deploy and run the application and see if the authentication works.

In this exercise, you'll configure an application to authenticate users against your Azure AD tenant and deploy the web app.

## Configure and deploy the application that uses OpenID Connect to authenticate users

1. Switch back to the default directory for your subscription (**not AD-Tenant**). Sign in if prompted.

1. Run the following command in Cloud Shell to clone the repo that contains the source for our app.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-secure-app-with-oidc-and-azure-ad.git
    ```

1. Move to the **mslearn-secure-app-with-oidc-and-azure-ad/app** folder.

    ```bash
    cd ~/mslearn-secure-app-with-oidc-and-azure-ad
    ```

1. Now you'll update the `appsettings.json` file to specify the configuration details to enable the application to communicate with Azure AD. Open this file in the code editor.

    ```bash
    code ./app/appsettings.json
    ```

1. Update the following fields as follows:

    |   |   |
    | - | - |
    | `<domain-name>` | Your AAD tenant name |
    | `<TenantID-GUID>` | Set to the **Directory (tenant) ID** you noted in the previous exercise |
    | `<ClientID-GUID>` | Set to the **Application (client) ID** you noted in the previous exercise |
    
    Once complete, your file will look similar to this:

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "Domain": "youraadtenant.onmicrosoft.com",
        "TenantId": "fa66e1ef-a41b-3bae-898d-842ab314cd78",
        "ClientId": "168a0d47-596a-4f92-a153-0408634caf9d",
        "CallbackPath": "/signin-oidc"
      },
      "Logging": {
        "LogLevel": {
          "Default": "Warning"
        }
      },
      "AllowedHosts": "*"
    }

1. Press `Ctrl-s` to save the file and `Ctrl-q` to close the Code editor.

1. Run the following command to build and deploy the initial web app.

    ```azurecli
    az webapp up \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --sku B1 \
        --name educationapp-$RANDOM \
        --output table
    ```

1. Copy the URL from the command output. You'll need this address for the app registration configuration.

## Configure the App registration

Now let's configure the app registration to authorize the URL of the web service you created above:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), switch back to the AD-Tenant directory you created earlier. Sign in when prompted.

1. In the navigation bar on the left, click **Azure Active Directory**.

1. Under **Manage**, select **App Registrations**, and then click the registration you created in the previous exercise.

1. Click **Authentication**.

1. Paste the URL from the Cloud Shell output in the previous section into the **Redirect URIs** area and append the suffix  `/signin-oidc`. Ensure the url uses HTTPS.

1. Delete the redirect URI `https://localhost:5000/signin-odic`.

1. Paste the same URL into the **Logout URL** field and append the suffix `/signout-oidc`.

1. Under **Implicit grant**, check **ID tokens**.

    ![Screenshot of an app registration](../media/5-update-registration.png)

1. Click **Save**

## Test the application

1. Open a new browser window and navigate to the web application URL.

1. When prompted, sign in. You'll be authenticated against your AD tenant. The web app also requests some permissions, and you'll be prompted for your consent.

    ![Screenshot of the request consent dialog box](../media/5-request-consent.png)

1. Click **Accept**. The web app will appear. The title bar will include your authenticated user name.

<!-- ## Configure and test the application

Now, configure the web app with the right client ID and tenant name, and authenticate:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), switch back to the default directory for your account, and sign in.

1. In the navigation bar on the left, click **All resources**, and then click the web app.

1. In the web app pane, under **Development Tools**, click **App Service Editor**.

1. In the **App Service Editor** pane, click **Go**. Sign in again if prompted.

1. In the navigation bar, under **WWWROOT**, click the file **appSettings.json**.

1. Set the **Domain** to the domain name of the Active Directory tenant you created in the previous lab. This domain should have the format ***mydomain*.onmicrosoft.com**.

1. Set the **TenantId** to the GUID of the Active Directory tenant that you created in the previous lab.

    > [NOTE|]
    > You can easily find the tenant ID for a directory by using the **Switch directory** feature of the portal. The list of directories that appears shows the domain name (including the **onmicrosoft.com** suffix), and the tenant ID.
    >
    > ![The Switch directory window, with tenant information highlighted](../media/5-tenant-info.png)

1. Change the **ClientId** to the Application ID you recorded earlier.

     ![Screenshot of an app registration](../media/5-update-client.png)
 -->


You've now created both the application registration and the web app itself. You've configured both these objects with the information they need to locate each other.

Now that the web app is configured to authenticate against Azure AD, you can use that directory to manage all the user accounts that can access your application. The same accounts that grant users access to services like Office 365 can now be used to access your app. Users only have to remember one set of credentials for both systems and administrators have less work to do because each user only has one account.
