Suppose you are finalizing the development of your photo sharing web app; you are now going to verify that your authentication methods do not collect unnecessary information from your users, and want to be able to show your development team how to trace the authentication traffic, in order to ensure that everything is done in the most efficient and secure manner.

In this unit, you will view authentication tokens and session cookies, and configure authentication providers to limit app access to user information.

### Edit App Code to Return the Token

In this exercise, you'll use the App Service Editor (which is currently in Preview) to make changes to your app's index.js file, as an alternative method to the one you used in Unit 5. You'll add code to return the authentication token, as well as a sign-out link. 

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the Azure portal, in the left menu, click **Resource groups**, then click the available resource group, and then click your web app.

1. On the **my-webapp-\<_your_string_\>** pane, under **Development Tools**, click **App Service Editor (Preview)**.

1. On the **App Service Editor (Preview)** pane, click **Go**.

1. If you are prompted for a username and password, use your Azure normal credentials.

1. In the **App Service Editor** tab, in the left navigation, click **index.js**, and edit the existing **server** code so that it matches the following:
    ```javascript
    var server = http.createServer(function(request, response) {

        response.writeHead(200, {"Content-Type": "text/html"});
        response.write("Welcome to my website!<br/>");
        response.write("<a href='/.auth/login/microsoftaccount'>Log in with Microsoft Account</a>");
        response.write("<br/>"); 
        response.write("<a href='/.auth/me'>View token</a>");   
        response.end();

    });
    ```
1. The file is automatically saved.

### Authenticate to the Web App and View Token

In this exercise, you obtain the raw unformatted JSON token, and view a formatted version of the contents by using an online service; you could use a code editor, such as Visual Studio, if one is installed on your computer.

1. Switch to the welcome page browser tab, and refresh the page.

1. Note the pre-authentication message, then click **Yes**.

1. Enter your Azure (or other Microsoft) credentials.

1. On the welcome page, click the **View token** link.

1. The authentication token is now displayed, but the formatting makes it difficult to see the information. To view the token in a clearer format, select all the text, and then copy it to the clipboard.

1. Open a new browser tab, and go to https://jsonformatter.curiousconcept.com/ (or other JSON viewer site), and paste the text into the raw text box; then click **Process** to view the formatted JSON. You should now be able to see various elements in the token, including:
	- access_token
	- expires_on
	- provider_name
	- user_claims
	- user_id

1. Expand **user_claims**, and make a note of the claims that have been returned (you might want to take a screenshot of the formatted JSON); the claims might include:
	- nameidentifier
	- name
	- givenname
	- surname
	- microsoft account: locale
	- microsoft account: id
	- microsoft account: name

1. Click the Back button in your browser to return to the welcome page.

### Use Provider Scope to Enable App to Request Access to User Information

You'll now configure the Microsoft provider scope, so that your app can request additional user information. 

1. Switch back to the Azure portal, and on the **my-webapp-\<_your_string_\>** pane, under **Settings**, click **Authentication / Authorization**.

1. In the **Authentication Providers** list, click **Microsoft**.

1. Select the **Scope** checkbox, ensure that all items in the list are selected, and then click **OK**.

1. On the click **Authentication / Authorization** blade, click **Save**.

1. Switch to the welcome page browser tab, and refresh the page.

1. Note the pre-authentication message now includes a long list of user details that your app is now requesting permission to access.

1. Click **Yes**, and if prompted enter your Azure (or other Microsoft) credentials.

1. On the welcome page, click the **View token** link.

1. Select all the text in the authentication token, and copy it to the clipboard.

1. Switch to your JSON viewer tab (or other JSON viewer), and view the formatted JSON. Under **user_claims**, you might now have additional items, such as **emailaddress** (depending on how much information you have entered in your Microsoft Account profile).

1. Close the tab.

### Use Dev Tools to View the AppServiceAuthSession Cookie

Finally, you'll use your browser's developer tools to check for the AppServiceAuthSession cookie; this cookie is only set after successful authentication. 

1. Open the developer tools in your browser. For Microsoft Edge, Internet Explorer, and Chrome, press F12 to open the developer tools console.

1. In the developer tools console, look for the cookies option; for example, in Microsoft Edge, cookies are an option when the network is selected.

1. On the welcome page, click the **sign in with Microsoft Account** link.

1. In the developer tools console, click for the **200 OK** message, and then check for **Request Cookies**; verify that the **AppServiceAuthSession** cookie has been created.

In this exercise, you used several methods to view authentication tokens and session cookies, and you also configured the Microsoft authentication providers in order to control how your app requests access to user information.