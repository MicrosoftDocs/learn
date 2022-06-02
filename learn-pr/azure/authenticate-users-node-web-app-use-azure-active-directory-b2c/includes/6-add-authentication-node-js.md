
For a web app to authenticate users, you need to add that capability.

In the eCommerce organization scenario, your organization chooses to use Azure AD B2C to add authentication capability to the web app. So, you need to configure your web app to communicate with Azure AD B2C services whenever a user signs in to your web app. This procedure requires you understand authentication protocols such as OAuth 2.0 and OpenID Connect.

Here, we'll learn about Microsoft Authentication Library (MSAL), which is a recommended open-source library used to configure your app to authenticate users by using Azure AD B2C.

## What is Microsoft Authentication Library?

The Microsoft Authentication Library (MSAL) enables developers to acquire tokens from the Microsoft identity platform, in this case Azure AD B2C service, in order to authenticate users (ID token) and access secured web APIs (access token). MSAL supports many different application architectures and platforms including .NET, JavaScript, Java, Python, Android, and iOS. For JavaScript, it supports MSAL browser, MSAL Angular MSAL React and MSAL Node.  

If you're not using MSAL, you'd use platform-independent approach, where you make HTTP calls and handle responses from Azure AD B2C. With the second approach, you've to handle the protocol details yourself. Using MSAL provides the following benefits:

* Handles the protocol details for you, so you only need to call functions to accomplish tasks.

* Caches and refreshes tokens automatically when they're about to expire.

* Regularly updated, so you don't need to change your code when new security updates are rolled out.

* Helps you troubleshoot your app by exposing actionable exceptions, logging, and telemetry.

## MSAL Node installation

To install MSAL Node, you run the following command in the terminal:

```text
npm install @azure/msal-node
```

To import MSAL Node into your Node web app, you add the following line of code:

```javascript
const msal = require('@azure/msal-node')
```

## MSAL Node instance

You can create two types of MSAL Node objects, for *confidential client application* or *public client application*:

### Confidential client application

Confidential client applications are apps that run on servers (web apps, web API apps, or even service/daemon apps). They're considered difficult to access, and for that reason can keep an application secret. Each instance of the client has a distinct configuration (including client ID and client secret). These values are difficult for end users to extract. A web app is the most common confidential client, such as a Node web app. The client ID is exposed through the web browser, but the secret is passed only in the back channel and never directly exposed.

### Public client applications

Public client applications are apps that run on devices or desktop computers or in a web browser. They're not trusted to safely keep application secrets, so they only access web APIs on behalf of the user. (They support only public client flows.) Public clients can't hold configuration-time secrets, so they don't have client secrets. Examples of public client apps are desktop and mobile apps.

The following code snippet shows how to instantiate a `ConfidentialClientApplication` object for authenticating with Azure AD B2C:

```javascript
    const confidentialClientConfig = {
        auth: {
            clientId: "APP CLIENT ID here", 
            authority: "SIGN UP AND SIGN IN POLICY AUTHORITY here", 
            clientSecret: "APP CLIENT SECRET here",
            knownAuthorities: "AUTHORITY DOMAIN(S) as an array",
            redirectUri: "APP REDIRECT URI here"
        },
        system: {
            loggerOptions: {
                loggerCallback(loglevel, message, containsPii) {
                    console.log(message);
                },
                piiLoggingEnabled: false,
                logLevel: msal.LogLevel.Verbose
            }
        },
    };
    
    //Initialize MSAL Node (MSAL Node confidential Client Application instance)
    const confidentialClientApplication = new msal.ConfidentialClientApplication(confidentialClientConfig);
```

The `auth` element of the `confidentialClientConfig` configuration object has the following information:

|Key  |Value  |
|---------|---------|
|`clientId`|The Application (client) ID for the web app you register in Azure portal|
|`authority`|The sign in and sign up user flow authority. It is in the form of `https://<your-tenant-name>.b2clogin.com/<your-tenant-name>.onmicrosoft.com/<sign-in-sign-up-user-flow-name>`. You need to replace `<your-tenant-name>` with the name of your Azure AD B2C tenant and `<sign-in-sign-up-user-flow-name>` with the name of your sign in and sign up user flow, which you create in the Azure portal, such as `B2C_1_susi`|
|`clientSecret`|The client secret for the web app you create in Azure portal.|
|`knownAuthorities`|The Azure AD B2C authority domain. It is in the form `https://<your-tenant-name>.b2clogin.com`. You need to replace `<your-tenant-name>` with the name of your Azure AD B2C tenant.|
|`redirectUri`|The application redirect URI where Azure AD B2C returns authentication responses (tokens). It matches the Redirect URI you set while registering your app in Azure portal, and it must be publicly accessible. It looks something like `http://localhost:3000` if your web app runs locally in your computer, and on port `3000`.|

In MSAL Node, logging is part of the configuration options and is created with the initialization of the MSAL Node instance. You can see this configuration under the `system` element of the `confidentialClientConfig` object as shown in the code snippet above.

## Authorization code flow in MSAL Node

MSAL Node supports authorization code flow using two methods accessible via the MSAL Node object:

* **getAuthCodeUrl()** method is the first leg of the *authorization code grant* for MSAL Node. It creates the URL of the authorization request, letting the user to input their credentials and consent to the web application. Once the user inputs their credentials and consents, the authority will send a response to the *redirect URI* sent in the request and should contain an *authorization code*, which can then be used to acquire tokens. The `getAuthCodeUrl()` method requires a parameter, which is constructed as shown the following example:

    ```javascript
        const authCodeRequest = {
            redirectUri: "APP REDIRECT URI here",
            authority: "SIGN UP AND SIGN IN POLICY AUTHORITY here",
            scopes: "App scopes here",
            state: "App state here"
        };
        
        confidentialClientApplication.getAuthCodeUrl(authCodeRequest)
        .then((response) => {
            //The response is a URL which you use to generate an authorization code
            res.redirect(response);
        })
        .catch((error) => {
            res.status(500).send(error);
        });
    ```
    
    The `authCodeRequest` object has two other information not required by `confidentialClientConfig` configuration object above, *scopes* and *state*:
    
    |Key  |Value  |
    |---------|---------|
    |`state`|A value included in the request (not required but recommended) and returned in the token response. Usually, a randomly generated unique value is used, to prevent cross-site request forgery attacks. The state also is used to encode information about the user's state in the app before the authentication request occurred. For example, the page the user was on, or the user flow that was being executed or the authentication action such as sign in, password reset and profile edit. |
    |`scopes`| Array of scopes the application is requesting access to. You require this value if your app needs an access token. If your app only needs to sign in users to an app, you don't need to pass any scopes.|

* **acquireTokenByCode()** method is the second leg of the *authorization code grant* for MSAL Node. Here,  the authorization code obtained in the first leg of the *authorization code grant* is used to obtain an ID token. If you'd passed *scopes* in the first leg of the authorization code grant, you also receive an access toke. The `acquireTokenByCode()` method requires a parameter, which is constructed as shown the following example:

    ```javascript
        const tokenRequest = {
            scopes: "App scopes here",
            authority: "SIGN UP AND SIGN IN POLICY AUTHORITY here",
            redirectUri: "APP REDIRECT URI here",
            code: "Authorization code obtained in the first leg here"
        };

        confidentialClientApplication.acquireTokenByCode(tokenRequest).then((response)=>{
            //process the response here
        }).catch((error)=>{
            console.log("\nErrorAtSignIn: \n" + error);
        });
    ```

    From the response returned by acquireTokenByCode(), you can obtain various information, such as ID token as user's given name and user's username. Here's is an example:

    ```JavaScript
        let idToken = response.idToken;
        let username = response.account.idTokenClaims.username;
        let givenName = response.account.idTokenClaims.given_name;
    ```

## Signing out

Web apps use a session to track users, and when a user signs out of the app, you need to clear the session. However, clearing a user session in the app isn't sufficient to sign out the user from it in Azure AD B2C. You need to explicitly sign out the user by sending a sign out request to Azure AD B2C by using the logout URI.

Azure AD B2C's logout URI is in the form of `https://<your-tenant-name>.b2clogin.com/<your-tenant-name>.onmicrosoft.com/<sign-in-sign-up-user-flow-name>/oauth2/v2.0/logout?post_logout_redirect_uri=<logout_redirect_uri>`. You need to replace `<your-tenant-name>` with the name of your Azure AD B2C tenant, `<sign-in-sign-up-user-flow-name>` with the name of your sign in and sign up user flow and `<logout_redirect_uri>` with publicly accessible URL in your web app, where Azure AD B2C redirects user after they sign out. This redirect URL doesn't need to match the redirect URI you use when you create MSAL Node instance. 

Here's an example:

```JavaScript
    logoutUri = "logout_redirect_uri here";
    req.session.destroy(() => {
        //When you successfully destroy user session, notify Azure AD B2C service by using the logout uri.
        res.redirect(logoutUri);
    })
```