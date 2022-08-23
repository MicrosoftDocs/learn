You're ready to set up your daemon app to authenticate using Azure Active Directory (Azure AD) and secure access to a protected web API. The first step to enable authentication is to register your application with Azure AD.

In this exercise, you'll register your application with Azure AD.

## Register an application

Registering your application establishes a trust relationship between your application and the identity provider, which is Azure AD in this case.

Follow these steps to register your application on the Azure portal.

1. Sign in to the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/portal-directory-subscription-filter.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application.
1. Search for and select **Azure Active Directory**.
1. Under **Manage**, select **App registrations** > **New registration**.
1. Enter a display **Name** for your application. Enter a meaningful application name that will be displayed to users of the app, for example `python-daemon-app`.
   You can change the display name at any time and multiple app registrations can share the same name. The app registration's automatically generated **Application (client) ID**, not its display name, uniquely identifies your app within the identity platform.
1. Specify who can use the application, sometimes called its _sign-in audience_.

   Under **Supported account types**, select an option.

      - **Accounts in this organizational directory only**. This choice is the most common one because daemon applications are written by line-of-business (LOB) developers.
      - **Accounts in any organizational directory**. You'll make this choice if you're an Independent Software Vendor (ISV) providing a utility tool to your customers. You'll need your customers' tenant admins to approve it.

   For this exercise module, select **Accounts in this organizational directory only**.

1. Don't enter anything for **Redirect URI (optional)**.
1. Select **Register** to complete the initial app registration.

When registration finishes, the Azure portal displays the app registration's **Overview** pane. You see the **Application (client) ID**. Also called the **client ID**, this value uniquely identifies your application in the Azure AD.

## Add credentials

Credentials are used by confidential client applications that access a web API. Confidential client applications are apps that run on servers. They're considered difficult to access, and for that reason capable of keeping an application secret.

Examples of confidential clients applications are web apps, web APIs, or service-type and daemon-type applications. Credentials allow your application to authenticate as itself, requiring no interaction from a user at runtime.

You can add both certificates and client secrets (a string) as credentials to your confidential client app registration.

:::image type="content" source="../media/portal-05-app-reg-04-credentials.png" alt-text="Screenshot of the Azure portal in a web browser, showing the Certificates & secrets pane.":::

### Add a client secret

Sometimes called an _application password_, a client secret is a string value your app can use in place of a certificate to identity itself.

**Client secrets** are considered less secure than certificate credentials. Application developers sometimes use client secrets during local app development because of their ease of use. However, you should use certificate credentials for any of your applications that are running in production.

Complete the following steps to add **client secrets** for your app in the Azure portal:

1. In the Azure portal, in **App registrations**, select your application.
1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
1. Add a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
    - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months.
    - Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. _Record the secret's value_ for use in your client application code. This secret value is _never displayed again_ after you leave this page.

You've now successfully registered a daemon app with Azure AD.