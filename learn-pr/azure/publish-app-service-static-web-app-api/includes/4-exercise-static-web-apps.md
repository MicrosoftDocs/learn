In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that will automatically build and publish your application.

## Create a static web app

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This module uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

The Azure sandbox that you activated allows you to use Azure services without incurring any costs.

## Install the Azure Static Web Apps extension for Visual Studio Code

1. Go to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps&azure-portal=true), and install the **Azure Static Web Apps** extension for Visual Studio Code.

1. When the extension tab loads in Visual Studio Code, select  the **Install** button.

1. After installation is complete, select **Restart to update** if prompted.

## Sign in to Azure in Visual Studio Code

1. In Visual Studio Code, sign in to Azure by selecting **View** > **Command Palette**, and entering **Azure: Sign In**.

   > [!IMPORTANT]
   > Log in to Azure using the same account used to create the sandbox. The sandbox provides access to a Concierge Subscription.

1. Follow the prompts to copy and paste the code provided in the web browser, which authenticates your Visual Studio Code session.

## Select Your Subscription

1. Open Visual Studio Code, and select **File > Open** and open the repository you cloned to your computer in the editor.

1. Verify that you have filtered your Azure subscriptions to include the Concierge Subscription by opening the command palette and entering `Azure: Select Subscriptions`, and press <kbd>Enter</kbd>.

1. Select **Concierge Subscription** and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-concierge-subscription.png" alt-text="Screenshot of VS Code showing how to filter by subscription.":::

## Create a static web app

1. Open Visual Studio Code, and select **File > Open** to open the repository you cloned to your computer in the editor.

1. Inside Visual Studio Code, select the Azure logo in the Activity Bar to open the Azure extensions window.

   :::image type="content" source="../media/extension-azure-logo.png" alt-text="Screenshot of the Azure Logo in VS Code.":::

   > [!NOTE]
   > Azure and GitHub sign-in are required. If you are not already signed in to Azure and GitHub from Visual Studio Code, the extension will prompt you to sign in to both during the creation process.

1. Place your mouse over the *Static Web Apps* heading, right click, and select **Create Static Web App**.

   :::image type="content" source="../media/create-first-step.png" alt-text="Screenshot showing where to go to create a web app.":::

1. Enter **my-first-static-web-app**, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-create-app.png" alt-text="Screenshot showing how to create a Static Web App.":::

1. Select your **location** and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-location-option.png" alt-text="Screenshot showing how to select a subscription.":::

::: zone pivot="angular"

1. Select the **Angular** option, and press <kbd>Enter</kbd>

   :::image type="content" source="../media/extension-angular-option.png" alt-text="Screenshot showing the angular option selected.":::

1. Enter **/angular-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-angular.png" alt-text="Screenshot showing the code location entered as Angular app.":::

1. Enter **dist/angular-app** as the build output location where files are built for production in your app, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-angular.png" alt-text="Screenshot showing how to enter the build output location for Angular.":::

::: zone-end

::: zone pivot="react"

1. Select the **React** option, and press <kbd>Enter</kbd>

   :::image type="content" source="../media/extension-react-option.png" alt-text="Screenshot showing the react option selected.":::

1. Enter **/react-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-react.png" alt-text="Screenshot showing the code location entered as react app.":::

1. Enter **build** as the build output location where files are built for production in your app, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-react.png" alt-text="Screenshot showing how to enter the build output location for React.":::

::: zone-end

::: zone pivot="svelte"

1. Select the **Svelte** option, and press <kbd>Enter</kbd>

   :::image type="content" source="../media/extension-svelte-option.png" alt-text="Screenshot showing the svelte option selected.":::

1. Enter **/svelte-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-svelte.png" alt-text="Screenshot showing the code location entered as Svelte app.":::

1. Enter **public** as the build output location where files are built for production in your app, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-svelte.png" alt-text="Screenshot showing how to enter the build output location for Svelte.":::

::: zone-end

::: zone pivot="vue"

1. Select the **Vue** option, and press <kbd>Enter</kbd>

   :::image type="content" source="../media/extension-vue-option.png" alt-text="Screenshot showing the vue option selected.":::

1. Enter **/vue-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-vue.png" alt-text="Screenshot showing the code location entered as Vue app.":::

1. Enter **dist** as the build output location where files are built for production in your app, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-vue.png" alt-text="Screenshot showing how to enter the build output location for Vue":::

::: zone-end

   > [!NOTE]
   > Your repository may be a bit different than the ones you may have used in the past. It contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. Typically, you have one app in the root of your repository and specify `/` for the app path location. This is a great example of why Azure Static Web Apps lets you configure the locations in the first place - you get full control over how the app is built.

4. Once the app is created, a confirmation notification is shown in Visual Studio Code.

   :::image type="content" source="../media/extension-confirmation.png" alt-text="Screenshot of the confirmation code asking the user to open actions in GitHub or View/Edit Configure.":::

   As the deployment is in progress, the Visual Studio Code extension reports the build status to you.

   :::image type="content" source="../media/extension-waiting-for-deployment.png" alt-text="Screenshot of the VS Code UI showing waiting for deployment.":::

5. You can view the progress of the deployment using GitHub Actions by expanding the **Actions** menu.

    :::image type="content" source="../media/extension-actions.png" alt-text="Screenshot showing how to check progress via GitHub Actions.":::

    Once the deployment is complete, you can navigate directly to your website.

6. To view the website in the browser, right-click on the project in the Static Web Apps extension, and select Browse Site.

    :::image type="content" source="../media/extension-browse-site.png" alt-text="Screenshot showing how to browse to your static web app site.":::

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Refresh the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. If you see the splash page, the app is still being deployed.
