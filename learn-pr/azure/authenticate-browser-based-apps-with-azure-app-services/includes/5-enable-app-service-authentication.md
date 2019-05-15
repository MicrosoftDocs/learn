Suppose you are continuing the development of your photo sharing web app; you are now going to implement an App Service Authentication provider, and you need to explore the ways that this authentication can be implemented in your Node.js web app.

In this unit, you will use the Azure portal to enable App Service Authentication, and configure the Microsoft Authentication provider. You'll then add authentication provider code to a Node.js app, and explore authentication endpoints.

### Open the configuration settings for authentication

Start by checking the configuration settings that are required when you are using the Microsoft Authentication provider.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. In the Azure portal, in the left menu, click **Resource groups**, choose <rgn>[sandbox resource group name]</rgn>, and then click your web app.
1. On the **my-webapp-\<_your_string_\>** pane, under **Settings**, click **Authentication / Authorization**.
1. The current setting is "Anonymous access is enabled on the App Service app. Users will not be prompted for login."
1. Under **App Service Authentication**, click **On**.
1. Note the list of available Authentication Providers.
1. In the **Authentication Providers** list, click **Microsoft**.
1. The Azure Portal will prompt you for a **Client ID** and a **Client Secret**; you will return to this prompt after you have completed the steps in the next section.

### Create authentication endpoints

Now you can create authentication endpoints; when typing the endpoint, don't overlook the period (.) before auth (/.auth/login).

1. In a new browser tab, go to the **App Registration Portal** at https://apps.dev.microsoft.com/, and sign in with your Azure Sandbox credentials if you are prompted.
1. In the App Registration Portal, click **Add an app**.
1. On the **Register your application** page, in the **Application Name** box, type **My Web App**, and then click **Create application**.
1. Select **Not now** if a dialog box appears.
1. On the **My Web App Registration** page, select the **Application ID**, and copy this string to Notepad. 
1. Under **Platforms**, click **Add Platform**, and then click **Web**.
1. In the **Web** section, in the **Redirect URLs** box, type **https://my-webapp-\<_your_string_\>.azurewebsites.net/.auth/login/microsoftaccount/callback**, replacing **\<_your_string_\>** with the string you used to make your app name unique.
1. Click **Save**.
1. Under **Application Secrets**, click **Generate New Password**.
1. In the popup window, select the password, copy it to Notepad, and then close the popup.

### Configure the Microsoft Authentication provider

The next step is to configure the Microsoft Authentication provider by adding the authentication endpoint details.

1. In the Azure portal, switch back to the **Microsoft Account Authentication Settings** pane from earlier when you were prompted for a **Client ID** and **Client Secret**.
1. In the **Client ID** box, paste the **Application ID** that you copied to Notepad.
1. In the **Client Secret** box, paste the **Application Password** that you copied to Notepad.
1. In the **Microsoft Account Authentication Settings** pane, click **OK**.
1. In the **Authentication / Authorization** pane, click **Save**; this will save your authentication settings for your web app.

### Add authentication provider link to Node.js code

You can now add a link to the authentication provider in your Node.js code, so that users can initiate a sign-in to the provider.

1. Switch to your local folder that contains the extracted Node.js files.
1. In the extracted files, locate **index.js**, and open this file using Notepad or other editor.
1. Replace the existing **respond.writeHead** and **respond.end** commands, with the following code:
    ```javascript
    response.writeHead(200, {"Content-Type": "text/html"});
    response.write("Welcome to my website!<br/>");
    response.write("<a href='/.auth/login/microsoftaccount'>Log in with Microsoft Account</a>");
    response.end();
    ```
1. Save the file.
1. Select all the files in the folder that contains index.js, and then zip these files to **MyWebsite.zip**.
1. Switch to the Kudu browser tab, and on the Kudu ZipDeploy page, drag your **MyWebsite.zip** file onto the file items area.
1. Wait until you see a **Deployment successful message**.
1. Switch to the your welcome page browser tab, and refresh the page.
1. On the welcome page, click the **Log in with Microsoft Account** link.
1. Your web app should request your permission to view your profile information and your contact list; you will edit these permissions in Unit 7.
1. Click **No** to close the permissions dialog box.
1. Click the Back button in your browser to return to the welcome page.

### Reconfigure the Microsoft Authentication provider for forced authentication

Now change the settings for Microsoft Authentication provider, so that users are forced to authenticate.

1. Switch back to your app's **Authentication / Authorization** pane in the Azure portal.
1. Under **Action to take when request is not authenticated**, click **Login with Microsoft Account**, and then click **Save**, to save the authentication settings.

### Explore the authentication endpoints

Finally, test the user experience when forced authentication is enabled.

1. Switch to the browser tab with your welcome page, and refresh the page.
1. Your web app now automatically launches the  /.auth/login/<provider> endpoint, and is requesting your permission to view your profile information and your contact list; click **No** to close the permissions dialog box.
1. Note the HTTP 401 message that has been returned, reporting that _The user has denied access to the scope requested by the client application_.

In this exercise, you used the Azure portal to enable App Service Authentication, and then configured the Microsoft Authentication provider to require users to authenticate before accessing the app. You added code to your web app for an authentication provider, and you tested your modified app.