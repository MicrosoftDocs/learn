You are ready to set up your web application to authenticate using Azure Active Directory and secure access to employees in your company. The first step to enable authentication is to register your application with Azure Active Directory.

In this unit, you'll register your application with Azure Active Directory.

## Register your application with Azure Active Directory

Registering your application establishes a trust relationship between your application and the Identity provider which is Azure Active Directory in this case.

Follow these steps to register your application on the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. If you have access to multiple tenants, in the top menu, use the **Directory + subscription** filter to select the tenant in which you want to register an application.
1. Search for and select **Azure Active Directory**.
1. Under **Manage**, select **App registrations** > **New registration**.
1. In the **Register an application page** that appears, enter your application's registration information:
   - In the **Name** section, enter a meaningful application name that will be displayed to users of the app, for example `java-servlet-webapp-authentication`.
   - Under **Supported account types**, select an option.
     - For this exercise module, select **Accounts in this organizational directory only** since you are building an application for use only by users in the organizational tenant (**single-tenant**).  

   - In the **Redirect URI** section, select **Web** in the combo-box and enter the  redirect URI of your web application. This is the URI where your application wants to handle the authentication response after the user signs in. For this exercise, enter the following redirect URI of the sample application: `http://localhost:8080/msal4j-servlet-graph/auth/redirect`.

   :::image type="content" source="../media/app-registration-new.png" alt-text="Screenshot showing registration of a new app with Azure Active Directory on Azure portal.":::

1. Select **Register** to create the application.
1. In the app's registration screen, find and note the **Application (client) ID**. You use this value in your app's configuration file(s) later in your code.

   :::image type="content" source="../media/app-registration-blade.png" alt-text="Screenshot highlighting the App ID of an app registered with Azure Active Directory on Azure portal.":::

1. In the app's registration screen, click on the **Certificates & secrets** blade in the left to open the page to generate secrets and upload certificates. In the **Client secrets** section, click on **New client secret**:
   - Type a key description (for instance `app secret`),
   - Select one of the available key durations (**In 1 year**, **In 2 years**, or **Never Expires**) as per your security concerns.
   - The generated key value will be displayed when you click the **Add** button. Copy the generated value for use in the steps later.
   - You'll need this key later in your code's configuration files. This key value will not be displayed again, and is not retrievable by any other means, so make sure to note it from the Azure portal before navigating to any other screen or blade.

   :::image type="content" source="../media/app-registration-credentials.png" alt-text="Screenshot highlighting the certificates & secrets blade of an app registered with Azure Active Directory on Azure portal":::

You have now successfully registered a web application with Azure Active Directory.
