Now that you've understood why you need to register an application with Azure Active Directory (Azure AD), you need to configure Azure AD to support a Python daemon application.

In this exercise, you complete the following tasks:

- Register a daemon application in your Azure AD tenant.
- Configure a client secret for the registered daemon application.

## Register an application

Registering your application establishes a trust relationship between your application and the identity provider, which is Azure AD in this case.

Follow these steps to register your application on the Azure portal.

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application.
1. Search for and select **Azure Active Directory**.
1. Under **Manage**, select **App registrations** 
1. On the **App registrations**, select **New registration**.
1. Enter or select the following information:

   | **Field**         | **Value**     |
   |--------------|-----------|
   | **Name** | `python-daemon-app`      |
   | **Supported account types**     | **Accounts in this organizational directory only** |
   | **Redirect URI (optional)**     | **Leave this field blank** |

1. Select **Register** to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's **Overview** pane. Record the **Application (client) ID** and **Directory (tenant) ID** values for use in your client application code.

## Add a client secret

Configure a client secret for the registered daemon application. The daemon application uses the client secret to prove its identity when it requests tokens.

1. In the left menu, under **Manage**, select **Certificates & secrets**.
1. Select **New client secret**.
1. In the **Description** box, enter a description for the client secret, such as, _daemon-client-secret_.
1. Under **Expires**, select a duration for which the secret is valid.
1. Select **Add**.
1. Record the secret's value for use in your daemon application. This secret value is _never displayed again_ after you leave this page.

You've now successfully registered and configured your app with Azure AD.
