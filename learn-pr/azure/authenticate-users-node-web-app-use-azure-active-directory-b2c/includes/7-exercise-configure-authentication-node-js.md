Now that you've understood how to configure MSAL Node library, you need to use it to add authentication to your Node web app. 

Recall from the eCommerce organization scenario, your organization needed to authenticate users into the Node app. 

Here, you'll configure the Node app that you previously built to authenticate users by using Azure AD B2C. To achieve this, you'll use the Microsoft Authentication Library (MSAL) for Node.

## Update the .env file

As we learnt earlier, the `.env` file holds environment variables, which gets loaded to into `process.env` by dotenv package. 

Use the following steps to update the `.env` file with new variable:

1. Using Visual Studio Code (VS Code), open your Node web app that you created earlier.

1. Select the `.env` file to open it, and add the following code into it:

    ```text
    #web apps client ID
    APP_CLIENT_ID=<App client ID>
    #web app client secret
    APP_CLIENT_SECRET=<Your app client secret>
    #B2C sign up and sign in user flow/policy authority
    SIGN_UP_SIGN_IN_POLICY_AUTHORITY=https://<your-tenant-name>.b2clogin.com/<your-tenant-name>.onmicrosoft.com/<sign-in-sign-up-user-flow-name>
    #B2C authority domain
    AUTHORITY_DOMAIN=https://<your-tenant-name>.b2clogin.com
    #client redirect url
    APP_REDIRECT_URI=http://localhost:3000/redirect
    #Logout endpoint 
    LOGOUT_ENDPOINT=https://<your-tenant-name>.b2clogin.com/<your-tenant-name>.onmicrosoft.com/<sign-in-sign-up-user-flow-name>/oauth2/v2.0/logout?post_logout_redirect_uri=http://localhost:3000
    ```

    Replace:

    - `<App client ID>` with the application (client) ID for the web app you registered in Azure portal.
    - `<Your app client secret>` with the client secret for the web app you registered in Azure portal.
    - `<your-tenant-name>` with the name of your Azure AD B2C tenant.
    - `<sign-in-sign-up-user-flow-name>` with the name of your Sign in and Sign up user flow, which you created in Azure portal such as `B2C_1_susi`.

    If you're using a custom domain for your Azure AD B2C tenant, replace all instances of `<your-tenant-name>.b2clogin.com` with your custom domain.

1. Save the changes.

## Install MSAL Node

To use MSAL Node library in your app, you need to install it. The MSAL Node package name is `@azure/msal-node`.

In your VS Code terminal, run the following command to install MSAL Node:

```text
npm install @azure/msal-node
```

## Update the index.js file

The `index.js` file contains the main app logic. The current web app works, but can't authenticate users. You need to add authentication capability by updating the `index.js` file:

1. To import MSAL Node into your app, add the following line of code at top of the file:

    ```javascript
    const msal = require('@azure/msal-node');
    ```

1. To create a confidential app MSAL Node instance, add the following code just after importing MSAL Node:

  :::code language="JavaScript" source="~/active-directory-b2c-msal-node-sign-in-sign-out-webapp/index.js" id="ms_docref_configure_msal":::

  `confidentialClientConfig` is the MSAL Node instance used to connect to your Azure AD B2C tenant's authentication endpoints.

1. Just after the `confidentialClientConfig` MSAL Node instance, add the following code:

    ```javascript
    /** 
    * The MSAL.js library allows you to pass your custom state as state parameter in the Request object
     * By default, MSAL.js passes a randomly generated unique state parameter value in the authentication requests.
     * The state parameter can also be used to encode information of the app's state before redirect. 
     * You can pass the user's state in the app, such as the page or view they were on, as input to this parameter.
     * For more information, visit: https://docs.microsoft.com/azure/active-directory/develop/msal-js-pass-custom-state-authentication-request
     * In this scenario, the states also serve to show the action that was requested of B2C since only one redirect URL is possible. 
     */
    
    const APP_STATES = {
        LOGIN: 'login',
        LOGOUT: 'logout',
    }
    
    
    /** 
     * Request Configuration
     * We manipulate these two request objects below 
     * to acquire a token with the appropriate claims.
     */
     const authCodeRequest = {
        redirectUri: confidentialClientConfig.auth.redirectUri,
    };
    
    const tokenRequest = {
        redirectUri: confidentialClientConfig.auth.redirectUri,
    };
    ```

    The code snippets defines the following variables:
        - `APP_STATES`: Defines app state parameters. You can define many states depending on the number of requests your app makes.
        - `authCodeRequest`: The configuration object that's used to retrieve the authorization code.
        - `tokenRequest`: The configuration object that's used to acquire a token using authorization code.

1. Just before the express routes, add the following method:

    :::code language="JavaScript" source="~/active-directory-b2c-msal-node-sign-in-sign-out-webapp/index.js" id="ms_docref_authorization_code_url":::

    The method retrieves the authorization code URL

1. Update the `/signin`, `/signout` and `/redirect` express routes as shown below:

    ```javascript
    app.get('/signin',(req, res)=>{
            //Initiate a Auth Code Flow >> for sign in
            //no scopes passed. openid, profile and offline_access will be used by default.
            getAuthCode(process.env.SIGN_UP_SIGN_IN_POLICY_AUTHORITY, [], APP_STATES.LOGIN, res);
    });
    
    /**
     * Sign out end point
    */
    app.get('/signout',async (req, res)=>{    
        logoutUri = process.env.LOGOUT_ENDPOINT;
        req.session.destroy(() => {
            //When session destruction succeeds, notify Azure AD B2C service using the logout uri.
            res.redirect(logoutUri);
        });
    });
    
    app.get('/redirect',(req, res)=>{
        
        //determine the reason why the request was sent by checking the state
        if (req.query.state === APP_STATES.LOGIN) {
            //prepare the request for authentication        
            tokenRequest.code = req.query.code;
            confidentialClientApplication.acquireTokenByCode(tokenRequest).then((response)=>{
            
            req.session.sessionParams = {user: response.account, idToken: response.idToken};
            console.log("\nAuthToken: \n" + JSON.stringify(response));
            res.render('signin',{showSignInButton: false, givenName: response.account.idTokenClaims.given_name});
            }).catch((error)=>{
                console.log("\nErrorAtLogin: \n" + error);
            });
        }else{
            res.status(500).send('We do not recognize this response!');
        }
    
    })
    ```