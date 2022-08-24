For a web app to use Microsoft identity to enable users to authenticate, you must register a new app with Azure AD. In the banking company example, the company intends to build a Django web app to allow its customers access services. Here, you'll register a single-tenant web app in Azure AD and configure a Django app to use the registration details. You'll also create a test user for testing purposes.

<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->

## Register a single-tenant web application

Apps using the Microsoft identity platform are registered and managed in Azure AD tenants.

1. Sign in to the [Azure portal](https://portal.azure.com/). If your account is present in more than one Azure AD tenant, select your profile at the top right corner in the menu on top of the page, and then switch directory to change your portal session to the desired Azure AD tenant.
1. Navigate to the Microsoft identity platform for developers [App registrations page](https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade).
1. Select **+ New registration**.

    :::image type="content" source="../media/03-app-registration-page.png" alt-text="Screenshot of Azure portal showing app registrations page." :::

1. In the **Register an application** page that appears, enter your application's registration information:

    - In the **Name** section, enter a meaningful application name that will be displayed to users of the app, for example *python-django-webapp-auth*.
    - Under **Supported account types**, select *Accounts in this organizational directory only*.
    - In the **Redirect URI (optional)** section, select *Web* and enter the following redirect URI: *http://localhost:8000/auth/redirect*.

    :::image type="content" source="../media/03-app-registration-form.png" alt-text="Screenshot of Azure portal showing app registrations form." :::

1. Select **Register** to create the application.
1. In the app's registration screen, find and note the **Application (client) ID** and **Directory (tenant) ID**. You use this value in your app's configuration file(s) later in your code.

    :::image type="content" source="../media/03-app-registration-details.png" alt-text="Screenshot of Azure portal showing app ID and tenant ID." :::

1. Select **Save** to save your changes.

## Create a client secret for the app registration

The web app will also need a client secret to sign in with Azure AD to exchange the authorization code for an access token.

1. In the app's registration screen, select **Certificates & secrets** blade in the left to open the page where we can generate secrets and upload certificates.
1. In the **Client secrets** section, select *+ New client secret*:

    :::image type="content" source="../media/03-app-certificates-and-secrets.png" alt-text="Screenshot of Azure portal showing page to create certificates and secrets." :::

    - Type a key description. For example, *Django web app secret*.
    - Select one of the available key durations as per your security concerns. 
    - The generated key value will be displayed when you select the *Add* button. Copy the generated value for use in the steps later. You'll need this key later in your code's configuration files. **This key value won't be displayed again**, and isn't retrievable by any other means, so make sure to note it from the Azure portal before navigating to any other screen or blade.

    :::image type="content" source="../media/03-app-registration-secret-value.png" alt-text="Screenshot of Azure portal showing app secrets details." :::

## Configure Django web app to use app registration details
<!-- Introduction paragraph -->


<!-- 5. Validation -------------------------------------------------------------------------------------------

    Goal: Enables the learner to evaluate if they completed the exercise correctly. Feedback like this is critical for learning.

    Structure:
        1. A heading of "## Check your work".
        2. An introductory paragraph describing how they'll validate their work at a high level.
        3. Numbered steps (if the learner needs to perform multiple steps to verify if they were successful).
        4. Video of an expert performing the exact steps of the exercise (optional).

    Example:
         "At this point, the app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

## Check your work
<!-- Introduction paragraph -->



<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
