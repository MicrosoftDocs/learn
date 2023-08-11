You can use Azure CLI to deploy and test an application that uses OpenID Connect.

In the previous exercise, you registered an application in Azure Active Directory (Azure AD). You can now deploy and run the application and see if authentication works.

In this exercise, you'll configure an application to authenticate users against your Azure AD tenant and deploy the web app.

## Configure and deploy the application that uses OpenID Connect to authenticate users

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. From the top right-hand side of the Azure portal, select **Cloud Shell**.

1. In Cloud Shell, select **Bash**.

1. Create a resource group by running the following command where you replace the placeholders with a location like **centralus** and resource group name like **learn-openid-connect-rg**.

    ```azurecli
    LOCATION=<region>
    RESOURCEGROUP=<resource-group-name>
    az group create \
    --name $RESOURCEGROUP \
    --location $LOCATION
   ```

1. Run the following command in Azure Cloud Shell to clone the repo that contains the source for your app.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-secure-app-with-oidc-and-azure-ad.git
    ```

1. Change directories to the `mslearn-secure-app-with-oidc-and-azure-ad/app` folder.

    ```bash
    cd ~/mslearn-secure-app-with-oidc-and-azure-ad/app
    ```

1. Open the `appsettings.json` file in the code editor.

    ```bash
    code appsettings.json
    ```

1. In the code editor, replace the values shown below to configure the application to communicate with Azure AD:

    |  Existing value | New value |
    | --- | --- |
    | `<domain-name>` | Your Azure AD tenant name (the user-facing display name you used when you registered your application: WebApp-OpenIDConnect-DotNet). |
    | `<ClientID-GUID>` | The application (client) ID that you copied in the previous exercise. |
    | `<TenantID-GUID>` | The directory (tenant) ID that you copied in the previous exercise. |
  
    Your completed file will look similar to the following JSON code.

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "Domain": "WebApp-OpenIDConnect.onmicrosoft.com",
        "ClientId": "168a0d47-596a-4f92-a153-0408634caf9d",
        "TenantId": "fa66e1ef-a41b-3bae-898d-842ab314cd78",
        "CallbackPath": "/signin-oidc"
      },
      "Logging": {
        "LogLevel": {
          "Default": "Warning"
        }
      },
      "AllowedHosts": "*"
    }
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file, and press <kbd>Ctrl+Q</kbd> to close the code editor.

1. Make sure you're still in the project directory (~/mslearn-secure-app-with-oidc-and-azure-ad/app), and then run the following command to build and deploy the initial web app.

    ```azurecli
    az webapp up \
        --resource-group $RESOURCEGROUP \
        --location $LOCATION \
        --sku F1 \
        --name educationapp-$RANDOM
    ```

1. When deployment completes successfully, you should see a block of JSON output. Copy and save the URL from the output. You'll need this address to configure the app registration.

## Configure the app registration

Now let's configure the app registration to authorize the URL for the web service.

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), verify that you're signed in to **Learn Module AAD Tenant**. If not, select your user name in the upper-right corner, select **Switch directory**, and then select the **Learn Module AAD Tenant** directory that you created earlier. Sign in if you're prompted.

1. From the **Home** page or the resource menu, select **Azure Active Directory**. The **Learn Module AAD Tenant** Azure Active Directory Overview pane appears.

1. In the menu, under **Manage**, select **App registrations**. The **App registrations pane appears.

1. From the list of applications, select the **WebApp-OpenIDConnect-DotNet** application that you created in the previous exercise.

1. In the menu, under **Manage**, select **Authentication**.

1. Expand the **Web** section, and under *Redirect URIs*, select **Add URI**. In the new text box, paste the URL from the Cloud Shell output in the previous section and append the suffix `/signin-oidc` to the URI. Ensure that the URI starts with `https`.

1. Delete the redirect URI `https://localhost:5000/signin-oidc`.

1. Paste the same URL into the **Front-channel logout URL** field, and append the suffix `/signout-oidc`.

1. Under **Implicit grant and hybrid flows**, select **ID tokens**.

1. In the command bar, select **Save**. Wait for the authentication to update.

    :::image type="content" source="../media/5-update-registration.png" alt-text="Screenshot of an app registration." lightbox="../media/5-update-registration.png":::

## Test the application

1. Open a new browser window and go to the base URL for the web application.

1. If you're prompted, sign in. You'll be authenticated against the Azure AD tenant we created. The web app also requests some permissions, and you'll be prompted for your consent.

    :::image type="content" source="../media/5-request-consent.png" alt-text="Screenshot of the dialog box that requests consent.":::

1. Select **Accept**. The web app then appears. The title bar includes your authenticated username, indicating that you've been successfully logged in with the identity in the Learn Module AAD Tenant directory.

    :::image type="content" source="../media/5-webapp.png" alt-text="Screenshot of the web app with your credentials.":::

You've now created both the application registration and the web app itself. You've configured these objects with the information that they need to locate each other.

Now that the web app is configured to authenticate against Azure AD, you can use Open ID Connect to manage all the user accounts that you want to allow to access your application. The same accounts that grant users access to services like Microsoft 365 can now be used to access your app. Users have to remember only one set of credentials. Administrators have less work to do because each user has only one account.
