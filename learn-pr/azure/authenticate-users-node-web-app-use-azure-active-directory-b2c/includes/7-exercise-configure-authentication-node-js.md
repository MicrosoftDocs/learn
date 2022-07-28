Now that you've understood how to configure MSAL Node library, you need to use it to add authentication to your Node web app. 

Recall from the eCommerce organization scenario, your organization needed to authenticate users into the Node app.

Here, you'll configure the Node app that you previously built to authenticate users by using Azure AD B2C. To achieve this configuration, you'll use the Microsoft Authentication Library (MSAL) for Node.

## Update the .env file

As you learned earlier, the `.env` file holds environment variables, which get loaded to into `process.env` by dotenv package. 

Use the following steps to update the `.env` file with new variable:

1. Using Visual Studio Code (VS Code), open your Node web app that you created earlier.

1. Select the `.env` file to open it, and add the following code into it while retaining the initial code:

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
    - `<sign-in-sign-up-user-flow-name>` with the name of your Sign in and Sign up user flow, which you created in Azure portal, such as `B2C_1_susi`.

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

1. To create a confidential app MSAL Node instance, add the following code just after importing MSAL Node. The `confidentialClientConfig` variable is the MSAL Node instance used to connect to your Azure AD B2C tenant's authentication endpoints.

    ```javascript
         const confidentialClientConfig = {
            auth: {
                clientId: process.env.APP_CLIENT_ID, 
                authority: process.env.SIGN_UP_SIGN_IN_POLICY_AUTHORITY, 
                clientSecret: process.env.APP_CLIENT_SECRET,
                knownAuthorities: [process.env.AUTHORITY_DOMAIN], //This must be an array
                redirectUri: process.env.APP_REDIRECT_URI,
                validateAuthority: false
            },
            system: {
                loggerOptions: {
                    loggerCallback(loglevel, message, containsPii) {
                        console.log(message);
                    },
                    piiLoggingEnabled: false,
                    logLevel: msal.LogLevel.Verbose,
                }
            }
        };
        
        // Initialize MSAL Node
        const confidentialClientApplication = new msal.ConfidentialClientApplication(confidentialClientConfig);    
    ```

1. Just after the `confidentialClientConfig` MSAL Node instance, add the following code:

    ```javascript
        
        const APP_STATES = {
            LOGIN: 'login',
            LOGOUT: 'logout',
        }   
        const authCodeRequest = {
            redirectUri: confidentialClientConfig.auth.redirectUri,
        };
        
        const tokenRequest = {
            redirectUri: confidentialClientConfig.auth.redirectUri,
        }
    ```

    The code snippet defines the following variables:
    - `APP_STATES` - Defines app state parameters. You can define many states depending on the number of requests your app makes.
    - `authCodeRequest` - The configuration object that's used to retrieve the authorization code.
    - `tokenRequest` - The configuration object that's used to acquire a token using authorization code.

1. Just before the express routes, add the following method, which retrieves the authorization code URL.

    ```javascript
        /**
         * This method is used to generate an auth code request
         * @param {string} authority: the authority to request the auth code from 
         * @param {array} scopes: scopes to request the auth code for 
         * @param {string} state: state of the application
         * @param {Object} res: express middleware response object 
         */        
         const getAuthCode = (authority, scopes, state, res) => {
        
            // prepare the request
            console.log("Fetching Authorization code")
            authCodeRequest.authority = authority;
            authCodeRequest.scopes = scopes;
            authCodeRequest.state = state;    
            tokenRequest.authority = authority;
        
            // request an authorization code to exchange for a token
            return confidentialClientApplication.getAuthCodeUrl(authCodeRequest)
                .then((response) => {
                    console.log("\nAuthCodeURL: \n" + response);
                    //redirect to the auth code URL/send code to 
                    res.redirect(response);
                })
                .catch((error) => {
                    res.status(500).send(error);
                });
        }
    ```

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
            
            //determine that you indeed sent out this request by checking the state
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

    - Invoke the `/signin` route when the user selects the **Sign in** button. It calls the `getAuthCode()` method and passes `authority` for the Sign in and sign up user flow, `APP_STATES.LOGIN`, and an empty `scopes` array to it. If necessary, it causes a challenge on the user to enter their credentials. The response from this route includes an authorization code from Azure AD B2C, which posted to the `/redirect` route.

    - `/redirect` route is set as Redirect URI in the web app in Azure portal. This route uses the `state` query parameter in the response from Azure AD B2C to ascertain tha the request was sent by our web app. For example, if the app state is `login`, use the authorization code in the response to retrieve an ID token by using the `acquireTokenByCode()` method. The information included in the response, such as the `given_name` is sent to the app UI. Notice how the user `account` is added to the session.

    - The `/signout` route notifies Azure AD B2C to sign out the user by using the sign out uri after it successfully destroys the user's session in the app.

After you make all the changes required in index.js file, it should look similar to the following file:

```javascript
    /*
     * Copyright (c) Microsoft Corporation. All rights reserved.
     * Licensed under the MIT License.
     */
     
    require('dotenv').config();
    const express = require('express');
    const session = require('express-session');
    const {engine}  = require('express-handlebars');
    const msal = require('@azure/msal-node');

    /**
     * Confidential Client Application Configuration
     */
     const confidentialClientConfig = {
        auth: {
            clientId: process.env.APP_CLIENT_ID, 
            authority: process.env.SIGN_UP_SIGN_IN_POLICY_AUTHORITY, 
            clientSecret: process.env.APP_CLIENT_SECRET,
            knownAuthorities: [process.env.AUTHORITY_DOMAIN], //This must be an array
            redirectUri: process.env.APP_REDIRECT_URI,
            validateAuthority: false
        },
        system: {
            loggerOptions: {
                loggerCallback(loglevel, message, containsPii) {
                    console.log(message);
                },
                piiLoggingEnabled: false,
                logLevel: msal.LogLevel.Verbose,
            }
        }
    };
    
    // Initialize MSAL Node
    const confidentialClientApplication = new msal.ConfidentialClientApplication(confidentialClientConfig);
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
    
    /**
     * Using express-session middleware. Be sure to familiarize yourself with available options
     * and set them as desired. Visit: https://www.npmjs.com/package/express-session
     */
     const sessionConfig = {
        secret: process.env.SESSION_SECRET,
        resave: false,
        saveUninitialized: false,
        cookie: {
            secure: false, // set this to true on production
        }
    }
     
    //Create an express instance
    const app = express();
    
    //Set handlebars as your view engine
    app.engine('.hbs', engine({extname: '.hbs'}));
    app.set('view engine', '.hbs');
    app.set("views", "./views");
    
    //usse session configuration 
    app.use(session(sessionConfig));

    /**
     * This method is used to generate an auth code request
     * @param {string} authority: the authority to request the auth code from 
     * @param {array} scopes: scopes to request the auth code for 
     * @param {string} state: state of the application
     * @param {Object} res: express middleware response object 
     */
     const getAuthCode = (authority, scopes, state, res) => {
    
        // prepare the request
        console.log("Fetching Authorization code")
        authCodeRequest.authority = authority;
        authCodeRequest.scopes = scopes;
        authCodeRequest.state = state;    
        tokenRequest.authority = authority;
    
        // request an authorization code to exchange for a token
        return confidentialClientApplication.getAuthCodeUrl(authCodeRequest)
            .then((response) => {
                console.log("\nAuthCodeURL: \n" + response);
                //redirect to the auth code URL/send code to 
                res.redirect(response);
            })
            .catch((error) => {
                res.status(500).send(error);
            });
    }

     app.get('/', (req, res) => {
        res.render('signin', { showSignInButton: true });
    });
    
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
    
    });

    //start app server to listen on set port
    app.listen(process.env.SERVER_PORT, () => {
        console.log(`Msal Node Auth Code Sample app listening on port !` + process.env.SERVER_PORT);
    });    
```

## Run and test the app

You've added authentication to the Node web app, so you test if it authenticates users correctly. 

Use the following steps to test your app.

1. From your VS Code terminal, run `node index.js` command to start the express server.

1. In your browser, go to http://localhost:3000. You should see the page with a **Sign in** button. You saw this page earlier.

1. To sign in, select the **Sign in** button. You're redirected to a sign in sign up page.

    :::image type="content" source="../media/azure-ad-b2c-sign-in.png" alt-text="Screenshot of Azure A D B 2 C sign in page.":::

1. Enter your sign-in credentials, such as email address and password. If you don't have an account, select **Sign up now** to create an account. After you successfully sign in or sign up, you're redirected to a page in your app that shows sign-in status. **User1** is the user's given name.

    :::image type="content" source="../media/sign-in-status.png" alt-text="Screenshot of Node web app sign in status page.":::

1. To sign out, select the **Sign out** button.