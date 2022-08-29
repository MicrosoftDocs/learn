You're ready to set up your daemon app to authenticate using Azure Active Directory (Azure AD) and secure access to a protected web API. The first step to enable authentication is to register your application with Azure AD.

In this exercise, you'll register and configure your application with Azure AD.

## Register an application

Registering your application establishes a trust relationship between your application and the identity provider, which is Azure AD in this case.

Follow these steps to register your application on the Azure portal.

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application.
1. Search for and select **Azure Active Directory**.
1. Under **Manage**, select **App registrations** > **New registration**.
1. Enter or select the following information:

   | **Field**         | **Value**     |
   |--------------|-----------|
   | **Name** | `python-daemon-app`      |
   | **Supported account types**     | **Accounts in this organizational directory only**  |
   | **Redirect URI (optional)**     | **Leave this field blank** |

1. Select **Register** to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's **Overview** pane. Record the **Application (client) ID** and **Directory (tenant) ID** values for use in your client application code.

## Add a client secret

Complete the following steps to add **client secrets** for your app in the Azure portal:

1. In the Azure portal, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.

   :::image type="content" source="../media/portal-05-app-reg-04-credentials.png" alt-text="Screenshot of the Azure portal in a web browser, showing the Certificates & secrets pane.":::

1. Add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
    - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the secret's value for use in your client application code. This secret value is _never displayed again_ after you leave this page.

You've now successfully registered and configured your app with Azure AD.
