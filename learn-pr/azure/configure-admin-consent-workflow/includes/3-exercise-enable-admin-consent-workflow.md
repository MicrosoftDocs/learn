In this unit, You'll create a Node.js single page application (SPA). You'll then register the application in the Azure portal and use it to test how the admin consent workflow feature works.

## Create a Node.js single page application

To create the single page application, you'll create a Node.js web server to serve the HTML page from a web server running on your workstation as http://localhost:3007.

>[!NOTE]
>The instructions i this section assume you are using v2.14.2 of the Microsoft Authentication Library for JavaScript 2.0.

Before you proceed, ensure you have the latest version of Node.js v16.14.2, or later installed and you've set the environment path variables for the application to run.

1. Visit [this link](https://github.com/Azure-Samples/app-mgnt-javascript-node-spa) to access the code sample you'll use to create the test application in this unit.
1. Follow the instructions in the readme file to clone the repo and set up the project dependencies on your local machine.

## Create an Azure AD application

The single page application you created will submit a request to Microsoft Graph to read the user's profile. All requests to Microsoft Graph must include an access token as proof of the user's identity and that they have the necessary permissions to call Microsoft Graph. To obtain an access token, you must create an Azure AD application.

1. Open a browser and navigate to the [Azure Active Directory admin center](https://aad.portal.azure.com). Sign in using a **Work or School Account** that has global administrator rights to the tenancy.

1. Select **Azure Active Directory** in the left-hand navigation.

1. Then select **App registrations** in the left-hand navigation.

1. On the **App registrations** page, select **New registration**.

1. On the **Register an application** page, set the values as follows:

   - **Name**: Spa-test
   - **Supported account types**: Accounts in this organizational directory only (Single tenant)

1. Select **Register** to create the application.

1. On the **Spa-test** overview page, copy the values **Application (client) ID** and **Directory (tenant) ID**; you'll need these values later in this exercise.
  :::image type="content" source="../media/3-new-app-reg-details.png" alt-text="Screenshot showing new app registration details.":::
1. Select **Manage > Authentication** in the left-hand navigation.

1. On the **Authentication** page, select **Add a platform**. On the **Configure platforms** panel, select **Single-page application**.

1. In the **Configure single-page application** panel, add **http://localhost:3007** under **Redirect URIs**, and select **Configure**.

### Update the web page with the Azure AD application details

Locate the `var msalConfig = {}` code in the **index.html** file. The `auth` object contains three properties you need to set as follows:

- `clientId`: set to the Azure AD application's ID
- `authority`: set to **`https://login.microsoftonline.com/{{DIRECTORY_ID}}`**, replacing the **{{DIRECTORY_ID}}** with the Azure AD directory ID of the Azure AD application
- `redirectURI`: set to the Azure AD application's redirect URI: **http://localhost:3007**

## Enable admin consent workflow

1. Search for and select **Azure Active Directory**.
1. Select **Enterprise applications**.
1. Under **Manage**, select **User settings**.
1. Under **Security**, select **Consent and permissions**, then select **Admin consent settings**.
1. On the **Admin consent settings** panel, select **Yes** for **Users can request admin consent to apps they are unable to consent to**.

   :::image type="content" source="../media/3-enable-admin-consent-workflow.png" alt-text="Screenshot of configure admin consent workflow settings panel.":::

1. Configure the following settings:

   - **Who can review admin consent requests​** - Reviewers can view, block, or deny admin consent requests, but only global administrators can approve admin consent requests. People designated as reviewers can view incoming requests in the **My Pending** tab after they have been set as reviewers. Any new reviewers won't be able to act on existing or expired admin consent requests.
   - **Selected users will receive email notifications for requests** - Enable or disable email notifications to the reviewers when a request is made.  
   - **Selected users will receive request expiration reminders** - Enable or disable reminder email notifications to the reviewers when a request is about to expire.  
   - **Consent request expires after (days)** - Specify how long requests stay valid.
1. Select **Save**. It can take up to an hour for the workflow to become enabled.

> [!NOTE]
> You can add or remove reviewers for this workflow by modifying the **Select admin consent requests reviewers** list. A current limitation of this feature is that a reviewer can retain the ability to review requests that were made while they were designated as a reviewer.

To see how the workflow with the single page application, disable user consent so that users aren't able to consent to the application.

### Turn off user consent

1. Search for and select **Azure Active Directory**.
1. Select **Enterprise applications**.
1. Under **Security**, select **Consent and permissions**. The **User consent settings** appears.
1. Under **User consent for applications**, select **Do not allow user consent**.
1. Select **Save**.

## Test admin consent workflow

We'll use the Node.js application to test the admin consent workflow.

1. To start the application, first start the local web server. In the command prompt, execute the following command from the root of the project:

   ```console
      node server.js
   ```

1. Open a browser where you aren't signed-in to Office 365 and navigate to `http://localhost:3007`. The page initially contains a default welcome message and sign-in button.

   :::image type="content" source="../media/3-sign-in-screen.png" alt-text="Screenshot of the default web page for an anonymous user.":::

1. Select the **Sign In** button.

   Depending on the browser, you're using, a popup window will load or the page will redirect to the Azure AD sign-in prompt.

1. Sign in using a **Work or School Account** with a user *who isn't assigned* the global administrator role. On the next screen, you'll see the **Approval required** message. In the given text box, enter a justification for requiring admin consent and select **Request Approval**.

   :::image type="content" source="../media/2-need-admin-approval-justification.png" alt-text="Screenshot of the consent screen for requesting admin consent.":::

The designated reviewer is alerted about this request through email and they can view the incoming admin consent request in the Azure portal.
