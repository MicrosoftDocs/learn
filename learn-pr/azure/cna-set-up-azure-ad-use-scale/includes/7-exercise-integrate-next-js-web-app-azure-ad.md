This exercise takes you through the process of configuring a simple Next.js-based application that integrates with Azure AD. 

In this exercise, you'll:

* Register an Azure AD application.
* Implement a simple Azure AD-integrated Next.js-based application.
* Validate the Azure AD integration of the Next.js-based application.

## Prerequisites

To perform this exercise, you'll need:

* An Azure subscription.
* A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.
* To have completed the first and second exercises of this module.
* A computer on which you either have installed or can install Node.js and Git.

> [!NOTE]
> For information about installing Node.js, refer to [Node.js Downloads](https://nodejs.org/en/download/?azure-portal=true). For information about Git, refer to [Git downloads](https://git-scm.com/downloads?azure-portal=true). Install both before you start this exercise.

## Register an application with Azure AD

To implement a sample Next.js-based application that uses Azure AD authentication to access an Azure Database for PostgreSQL database, you must first create an Azure AD application object and the corresponding security principal. This will allow the Next.js-based application to impersonate Azure AD users when accessing database objects.

1. If needed, start a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true), and sign in to access the Azure subscription you'll be using in this module.
1. Use the **Search resources, services, and docs** text box to search for **Azure Active Directory**, and in the list of results, select **Azure Active Directory**.
1. On the **Azure Active Directory** blade, in the vertical menu, in the **Manage** section, select **App registrations**.
1. On the **App registrations** blade, select **+ New registration**.
1. On the **Register an application** blade, in the **Name** text box, enter **cna-nextjs-app**.
1. In the **Supported account types** section, ensure that the option **Accounts in this organizational directory only (Default Directory only - Single tenant)** is selected. In the **Redirect URI (optional)** section, set the **Single-page application (SPA)** entry to **http://localhost:3000**, and then select **Register**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-register.png" alt-text="Screenshot of the Register an application blade in the Azure portal.":::

    > [!NOTE]
    > You have the option of configuring multitenant support for your Azure AD-registered applications at this point. However, detailed coverage of this approach is outside the scope of this module.

    > [!NOTE]
    > After you deploy your application, you'll need to modify the **Redirect URI (optional)** value to reflect its actual URL.

1. On the **cna-nextjs-app** blade, review the resulting settings and record the values of the **Application (client) ID** and the **Directory (tenant) ID** properties.

    :::image type="content" source="../media/7-azure-ad-next-js-app-registered.png" alt-text="Screenshot of the cna-nextjs-app blade in the Azure portal.":::

1. On the **cna-nextjs-app** blade, in the vertical menu, in the **Manage** section, select **API permissions**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-configure-api-permissions.png" alt-text="Screenshot of the cna-nextjs-app API permissions blade in the Azure portal.":::

1. On the **cna-nextjs-app \| API permissions** blade, select **+ Add a permission**, on the **Request API permission** blade, select the **APIs my organization uses** tab, in the search text box, enter **Azure OSSRDBMS Database**, and then in the list of results, select **Azure OSSRDBMS Database**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-configure-api-permissions-ossrdbms.png" alt-text="Screenshot of the Request API permissions blade in the Azure portal.":::

1. On the **Request API permission** blade, select **Delegated permissions**, select the **user_impersonation** checkbox, and then select **Add permissions**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-configure-api-permissions-ossrdbms-impersonation.png" alt-text="Screenshot of the Request API permissions blade in the Azure portal, with the Delegated permissions option selected.":::

1. Back on the **cna-nextjs-app \| API permissions** blade, select **Grant admin consent for Default Directory**, and when prompted for confirmation, select **Yes**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-configure-api-permissions-full.png" alt-text="Screenshot of the cna-nextjs-app API permissions blade in the Azure portal, with the prompt to confirm granting of the admin consent.":::

1. On the **cna-nextjs-app \| API permissions** blade, verify that the permissions have been granted.

    :::image type="content" source="../media/7-azure-ad-next-js-app-configure-api-permissions-granted.png" alt-text="Screenshot of the cna-nextjs-app API permissions blade in the Azure portal, with the consent and permissions granted.":::

## Implement a simple Azure AD-integrated Next.js-based application

With the application registered in the Azure AD tenant, you can now proceed with its implementation. To simplify your task, you'll clone a GitHub repo containing a sample Next.js code and customize it to integrate with your Azure AD tenant.

1. On your local computer, start the Node.js command prompt.

    > [!NOTE]
    > Make sure to run this using the local installation of Node.js on your computer.

1. From the Node.js command prompt, run the following command to clone the GitHub repo containing the sample Next.js application code you'll use in this exercise:

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-cloud-native-apps.git
    ```

1. Run the following command to switch to the directory that hosts the clone of the GitHub repo:

    ```azurecli
    cd ./mslearn-cloud-native-apps/m06u07
    ```

1. Use your preferred text editor to review the content of the **./src/App.jsx** file, which retrieves an access token from Azure AD for a single-page application:

    > [!NOTE]
    > The sample code is based on [Tutorial: Sign in users and call the Microsoft Graph API from a React single-page app (SPA) using auth code flow](/azure/active-directory/develop/tutorial-v2-react?azure-portal=true).

    The **./src/App.jsx** file has the following content:

    ```json
    import React, { useState } from "react";
    import { AuthenticatedTemplate, UnauthenticatedTemplate, useMsal } from "@azure/msal-react";
    import { loginRequest } from "./authConfig";
    import { PageLayout } from "./components/PageLayout";
    import { ProfileData } from "./components/ProfileData";
    import { callMsGraph } from "./graph";
    import Button from "react-bootstrap/Button";
    import "./styles/App.css";

    var accessToken = '';

    /**
     * Renders information about the signed-in user or a button to retrieve data about the user
     */
    const ProfileContent = () => {
        const { instance, accounts } = useMsal();
        const [graphData, setGraphData] = useState(null);

        function RequestProfileData() {
            // Silently acquires an access token which is then attached to a request for MS Graph data
            instance.acquireTokenSilent({
                ...loginRequest,
                account: accounts[0]
            }).then((response) => {
                accessToken = response.accessToken;
                callMsGraph(response.accessToken).then(response => setGraphData(response));
            });
        }

        return (
            <>
                <h5 className="card-title">Welcome {accounts[0].name}</h5>
                {graphData ? 
                    <ProfileData graphData={graphData} />
                    :
                    <Button variant="secondary" onClick={RequestProfileData}>Request Profile Information</Button>
                }
                <p>{accessToken}</p>
            </>
        );
    };

    /**
     * If a user is authenticated the ProfileContent component above is rendered. Otherwise, a message indicating a user is not authenticated is rendered.
     */
    const MainContent = () => {    
        return (
            <div className="App">
                <AuthenticatedTemplate>
                    <ProfileContent />
                </AuthenticatedTemplate>

                <UnauthenticatedTemplate>
                    <h5 className="card-title">Please sign-in to review your profile information.</h5>
                    </UnauthenticatedTemplate>
            </div>
        );
    };

    export default function App() {
        return (
            <PageLayout>
                <MainContent />
            </PageLayout>
        );
    }
    ```

1. Use your preferred text editor to review the content of the **./src/authConfig.js** file, which stores the information required to identify the target Azure AD application that you registered in the previous task of this exercise.

    The **./src/authConfig.js** file has the following content:

    ```javascript
    /*
     * Copyright (c) Microsoft Corporation. All rights reserved.
     * Licensed under the MIT License.
     */

    import { LogLevel } from "@azure/msal-browser";

    /**
     * Configuration object to be passed to MSAL instance on creation. 
     * For a full list of MSAL.js configuration parameters, visit:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/configuration.md 
     */
    export const msalConfig = {
        auth: {
            clientId: "<client_ID>",
            authority: "https://login.microsoftonline.com/<tenant_ID>",
            redirectUri: "http://localhost:3000"
        },
        cache: {
            cacheLocation: "sessionStorage", // This configures where your cache will be stored
            storeAuthStateInCookie: false, // Set this to "true" if you are having issues on IE11 or Edge
        },
        system: {	
            loggerOptions: {	
                loggerCallback: (level, message, containsPii) => {	
                    if (containsPii) {		
                        return;		
                    }	
                    switch (level) {		
                        case LogLevel.Error:		
                            console.error(message);		
                            return;		
                        case LogLevel.Info:		
                            console.info(message);		
                            return;		
                        case LogLevel.Verbose:		
                            console.debug(message);		
                            return;		
                        case LogLevel.Warning:		
                            console.warn(message);		
                            return;		
                    }	
                }	
            }	
        }
    };

    /**
     * Scopes you add here will be prompted for user consent during sign-in.
     * By default, MSAL.js will add OIDC scopes (openid, profile, email) to any login request.
     * For more information about OIDC scopes, visit: 
     * https://learn.microsoft.com/azure/active-directory/develop/v2-permissions-and-consent#openid-connect-scopes
     */
    export const loginRequest = {
        scopes: ["User.Read"]
    };

    /**
     * Add here the scopes to request when obtaining an access token for MS Graph API. For more information, review:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/resources-and-scopes.md
     */
    export const graphConfig = {
        graphMeEndpoint: "https://graph.microsoft.com/v1.0/me"
    };
    ```

1. Within the text editor displaying the content of the **./src/authConfig.js** file, replace the `<client_ID>` and `<tenant_ID>` placeholders with their respective values, which you identified in the previous task of this exercise.
1. Within the text editor displaying the content of the **./src/authConfig.js** file, replace the entry `scopes: ["User.Read"]` with `scopes: ["User.Read","https://ossrdbms-aad.database.windows.net/user_impersonation"]`.
1. Save the changes and close the file.

## Validate the Azure AD integration of the Next.js-based application

You're ready to validate the Azure AD integration of the app. You could containerize it, but for simplicity you'll run it locally on your computer first, within the Node.js development environment. This will provide a quick way to validate its functionality and ensure that containerizing it is a viable option.

1. From the Node.js command prompt, run the following command to install the dependency packages of the sample Next.js application:

    ```cmd
    npm install
    ```

    > [!NOTE]
    > Wait for the installation process to complete.

1. From the Node.js command prompt, run the following command to build the Next.js application:

    ```cmd
    npm run-script build
    ```

    > [!NOTE]
    > Wait for the build process to complete.

1. From the Node.js command prompt, run the following command to start the Next.js application:

    ```cmd
    npm run-script start
    ```

    > [!NOTE]
    > This will automatically open a browser window displaying the **Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart** page.

1. Close the web browser window displaying **Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart** page, start another web browser window in the Incognito/InPrivate mode, and navigate to the **http://localhost:3000** URL.
1. On the **Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart** page, select **Sign In**, and then in the expanding menu, select **Sign in using Popup**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-sign-in-popup.png" alt-text="Screenshot of the Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart page with the Sign in using Popup menu option.":::

1. When prompted to sign in, authenticate by using the **adatumuser1** **userPrincipalName** and its password **Pa55w.rd1234**.

    > [!NOTE]
    > You created this user account in the first exercise of this module.

1. On the **Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart** page, select **Request Profile Information**.

    :::image type="content" source="../media/7-azure-ad-next-js-app-request-profile-info.png" alt-text="Screenshot of the Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart page with the Request Profile Information button.":::

    > [!NOTE]
    > Verify that the output includes the Email, Id, and the access token of the **adatumuser1** Azure AD user account.

    :::image type="content" source="../media/7-azure-ad-next-js-app-displayed-profile-info.png" alt-text="Screenshot of the Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart page with the adatumuser1 profile information.":::

1. Open another browser tab in the same web browser window and navigate to the web application you deployed in the previous exercise.

    > [!NOTE]
    > The URL should have the following format: `https://<webapp_name>.azurewebsites.net/auth`

    > [!NOTE]
    > Verify that the resulting web page displays the inventory data for the first tenant.

    > [!NOTE]
    > If the initial attempt fails, try again.

    :::image type="content" source="../media/7-azure-ad-next-js-app-displayed-database-inventory.png" alt-text="Screenshot of the page of the Express.js web app displaying the inventory data." lightbox="../media/7-azure-ad-next-js-app-displayed-database-inventory.png":::

1. Close the web browser window in the Incognito/InPrivate mode.

    > [!NOTE]
    > Now, you will repeat the same sequence of steps as the **contosouser1** and verify that you also can access the inventory data and display set of records corresponding to the second tenant.

1. Start another web browser window in the Incognito/InPrivate mode, and navigate to the **http://localhost:3000** URL.
1. On the **Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart** page, select **Sign In**, and then in the expanding menu, select **Sign in using Popup**.
1. When prompted to sign in, authenticate by using the **contosouser1** **userPrincipalName** and its password **Pa55w.rd1234**.

    > [!NOTE]
    > You created this user account in the first exercise of this module.

    > [!NOTE]
    > If prompted, accept an access request and change the password of the **contosouser1** account.

1. On the **Welcome to the Microsoft Authentication Library For JavaScript - React Quickstart** page, select **Request Profile Information**.

    > [!NOTE]
    > Verify that the output includes the Email, Id, and the access token of the **contosouser1** Azure AD user account.

1. Open another browser tab in the same web browser window and navigate to the web application you deployed in the previous exercise.

    > [!NOTE]
    > Verify that the resulting web page displays the inventory data for the second tenant.

## Results

Congratulations! You completed the third exercise of this module. In this exercise, you implemented a simple AD-integrated Next.js-based application and verified its functionality.

## Clean up the resources

To avoid unnecessary charges from using Azure resources, you should delete the **postgresql-db-RG** and **cna-aadexpress-RG** resource groups you created in the previous exercise of this module. To do so, in the Azure portal, navigate to the blade of each of these resource groups, and select the **Delete resource group** entry in the toolbar. In the **TYPE THE RESOURCE GROUP NAME** textbox, enter the name of the resource group, and then select **Delete**. 
