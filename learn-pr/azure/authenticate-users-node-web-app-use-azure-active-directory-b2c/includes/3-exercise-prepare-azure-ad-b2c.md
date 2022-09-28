Now that you've understood the components in Azure AD B2C that work together to support its features, you need to configure the components so that your Node web app can use them. 

In this exercise, you complete the following tasks:

* Register a web app in your Azure AD B2C tenant.

* Create a combined **Sign up and sign in** user flow and configure an identity provider, user attributes and token claims.

* Test the user flow in Azure portal.

## Step 1: Register a web app in your Azure AD B2C tenant

To enable your application to authenticate with Azure AD B2C, you need to register your app in the Azure AD B2C tenant. The app registration establishes a trust relationship between the app and Azure AD B2C.

During app registration, you'll specify two *Redirect URIs*. A redirect URI is the endpoint to which the user is redirected by Azure AD B2C after they authenticate with Azure AD B2C. You'll use one of the redirect URIs, `https://jwt.ms`, to test your user flow with the registered app within Azure portal, and the other, `http://localhost:3000/redirect` to be used for your real Node web app.

You'll also create your web app's client secret.

### Step 1.1: Register the web app

Use the following steps to register your web app in Azure AD B2C tenant:

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Make sure you're using the directory that contains your Azure AD B2C tenant:
    1. Select the **Directories + subscriptions** (:::image type="icon" source="./../media/portal-directory-subscription-filter.png" border="false":::) icon in the portal toolbar.
    1. On the **Portal settings | Directories + subscriptions** page, find your Azure AD B2C directory in the **Directory name** list, and then select **Switch** button next to it.

1. In the Azure portal, search for and select **Azure AD B2C**.

1. Select **App registrations**, and then select **New registration**.

1. Under **Name**, enter a name for the application, such as, `nodewebapp`.

1. Under **Supported account types**, select **Accounts in any identity provider or organizational directory (for authenticating users with user flows)**.

1. Under **Redirect URI**, select **Web** and then, in the URL box, enter `http://localhost:3000/redirect`.

1. Under **Permissions**, select the **Grant admin consent to openid and offline_access permissions** checkbox.

1. Select **Register**.

    :::image type="content" alt-text="Screenshot of registering web app in Azure portal." source="./../media/register-web-app-in-azure-portal.png" :::

1. In the left menu, select **Overview**.

1. Record the **Application (client) ID** for later use, when you configure your Node web application.

    :::image type="content" alt-text="Screenshot of the web app Overview page for recording your web app I D." source="./../media/get-azure-ad-b2c-app-id.png" :::

1. To add the second redirect URI:
    1. In the left menu, select **Authentication**.

    1. Under **Platform configurations**, select **Add URI**, and enter `https://jwt.ms`.

    1. Select **Save**.


### Step 1.2: Create a web app client secret

Configure a client secret for the registered web application. The web application uses the client secret to prove its identity when it requests tokens.

1. In the left menu, under **Manage**, select **Certificates & secrets**.

1. Select **New client secret**.

1. In the **Description** box, enter a description for the client secret, such as, *clientsecret*.

1. Under **Expires**, select a duration for which the secret is valid, and then select **Add**.

1. Record the secret's **Value**. You'll use this value later to configure your Node web app.

## Step 2: Create a Sign up and sign in user flow

Use the following steps to create a **Sign up and sign in** user flow in your Azure AD B2C tenant:

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Make sure you're using the directory that contains your Azure AD B2C tenant:
    1. Select the **Directories + subscriptions** (:::image type="icon" source="./../media/portal-directory-subscription-filter.png" border="false":::) icon in the portal toolbar.
    1. On the **Portal settings | Directories + subscriptions** page, find your Azure AD B2C directory in the **Directory name** list, and then select **Switch** button next to it.

1. In the Azure portal, search for and select **Azure AD B2C**.

1. Under **Policies**, select **User flows**, and then select **New user flow**.

    ![Screenshot of creating user flows in Azure portal.](./../media/sign-up-sign-in-user-flow.png)

1. On the **Create a user flow** page, select the **Sign up and sign in** user flow.

1. Under **Select a version**, select **Recommended**, and then select **Create**.

1. Enter a **Name** for the user flow, such as, `susi`. A prefix of *B2C_1* is automatically prepended to the name, so the name becomes `B2C_1_susi`.  

1. Under **Identity providers**, for **Local accounts**, select **Email signup**.

1. Under **Multifactor authentication**, for **Type of method**, select **Email**, and for **MFA enforcement**, select **Always on**. This configuration will require users to verify their identity with a second authentication method, email in this case.

1. Under **User attributes and token claims**, for both **Collect attribute** and **Return claim**, select **Display Name**, **Email Address**, **Surname** and **Street Address**. **Collect attribute** is the user information you'll collect from the user during sign-up and **Return claim** is the claims in a token that is returned from Azure AD B2C to your Node web app after the user completes sign up or sign in. For the full list of values, select **Show more**, choose the values, and then select **OK**.

1. Select **Create** to add the user flow.

1. To configure Self-service password reset:

    1. Select the Sign up and sign in user flow you've created from the list, such as `B2C_1_susi`.
    1. Under **Password configuration**, select **Self-service password reset** check box. This setting enables users to reset their password using the *Forgot password link* in a sign in page.
    1. At the top of the page, select **Save**.

## Step 3: Test the user flow in Azure portal

You can test your Sign up and sign in user flow from within Azure portal before you integrate it into your Node web app. 
 
### Step 3.1: Enable ID token implicit grant settings 

To test your user flow in Azure portal using `https://jwt.ms/` redirect URI, you need to enable ID token implicit grant settings: 

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Make sure you're using the directory that contains your Azure AD B2C tenant:
    1. Select the **Directories + subscriptions** (:::image type="icon" source="./../media/portal-directory-subscription-filter.png" border="false":::) icon in the portal toolbar.
    1. On the **Portal settings | Directories + subscriptions** page, find your Azure AD B2C directory in the **Directory name** list, and then select **Switch** button next to it.

1. In the Azure portal, search for and select **Azure AD B2C**.

1. In the left menu, select **App registrations**.

1. Find and select the web app you registered in [step 1.1](#step-11-register-the-web-app) such as `nodewebapp`.

1. In the left menu, under **Manage**, select **Authentication**.

1. Under **Implicit grant and hybrid flows**, select both the **Access tokens (used for implicit flows)** and **ID tokens (used for implicit and hybrid flows)** check boxes.

1. Select **Save**.

### Step 3.2: Test the user flow

1. In the Azure AD B2C tenant overview page, in the left menu, select **User flows**.

1. Select the Sign up and sign in user flow you created in [step 2](#step-2-create-a-sign-up-and-sign-in-user-flow) from the list, such as `B2C_1_susi` to open it.

1. At the top of the page, select **Run user flow**.

1. For Application, select the web application you registered in [step 1.1](#step-11-register-the-web-app) such as `nodewebapp`. For **Reply URL**, select `https://jwt.ms`.

1. Select **Run user flow**, and you're redirected to Azure AD B2C sign in page.

1. Select **Sign up now**, and then sign up by entering the required details. After you successfully sign up, you're redirected to `https://jwt.ms/` with an ID token. The decoded ID token is also shown.

    :::image type="content" alt-text="Screenshot of I D token and decoded I D token to show application claims." source="./../media/token-and-token-claims.png" :::

> [!NOTE]
> The **Implicit grant and hybrid flows** settings are only required to test your user flow with `https://jwt.ms/` app. So you can remove them after you complete testing the user flow.