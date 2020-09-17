In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that will automatically build and publish your application.

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

The Azure sandbox that you just activated allows you to use Azure services without incurring any costs.

## Install the Azure Static Web Apps extension for Visual Studio

1. Go to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps&azure-portal=true) and install the **Azure Static Web Apps** extension for Visual Studio Code.

1. When the extension tab loads in Visual Studio Code, click **Install**.

1. After installation is complete, click **Reload**.

## Sign into Azure in Visual Studio Code

1. In Visual Studio Code, sign in to Azure by clicking **View** > **Command Palette** and typing **Azure: Sign In**. You must have the [Azure Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account&azure-portal=true) extension installed to use Azure: Sign In.

   > [!IMPORTANT]
   > Login to Azure using the same account used to create the sandbox. The sandbox provides access to a Concierge Subscription.

1. Follow the prompts to copy and paste the code provided in the web browser, which authenticates your Visual Studio Code session.

## Create a static web app

1. Open Visual Studio Code and go to **File > Open Folder** to open the repository you cloned to your computer in the editor.

1. Inside Visual Studio Code, select the Azure logo in the Activity Bar to open the Azure extensions window.

   :::image type="content" source="../media/extension-azure-logo.png" alt-text="Azure Logo":::

   > [!NOTE]
   > Azure and GitHub sign in are required. If you are not already signed in to Azure and GitHub from Visual Studio Code, the extension will prompt you to sign in to both during the creation process.

1. Place your mouse over the _Static Web Apps_ label and select the **plus sign**.

   :::image type="content" source="../media/extension-create-button.png" alt-text="Application name":::

1. Select the **Concierge Subscription**
   :::image type="content" source="../media/extension-select-subscription.png" alt-text="Select Subscription":::

   > [!NOTE]
   > If you do not see the Concierge Subscription listed, ensure you logged into Azure in Visual Studio Code using the same account used to create the sandbox. Additionally, if you have filtered your Azure subscriptions in the Azure Account extension, verify the Concierge Subscription is checked in the `> Azure: Select Subscriptions` command.

1. The command palate opens at the top of the editor and prompts you to name your application.

   Type **my-first-static-web-app** and press **Enter**.

   :::image type="content" source="../media/extension-create-app.png" alt-text="Create Static Web App":::

1. Select the **main** branch and press **Enter**.

   :::image type="content" source="../media/extension-branch.png" alt-text="Branch name":::

::: zone pivot="angular"

5. Select **angular-app** as the location for the application code and press **Enter**.

   :::image type="content" source="../media/extension-app-location.png" alt-text="Application code location":::

::: zone-end

::: zone pivot="react"

5. Select **react-app** as the location for the application code and press **Enter**.

::: zone-end

::: zone pivot="svelte"

5. Select **svelte-app** as the location for the application code and press **Enter**.

::: zone-end

::: zone pivot="vue"

5. Select **vue-app** as the location for the application code and press **Enter**.

::: zone-end

6. The extension is looking for the location of the API in your application. This article doesn't implement an API.

   Select **Skip for now** and press **Enter**.

   :::image type="content" source="../media/extension-api-location.png" alt-text="API location":::

7. Select the location where files are built for production in your app.

   ::: zone pivot="angular"

   Type **dist/angular-app** and press **Enter**.

   :::image type="content" source="../media/extension-artifact-angular.png" alt-text="Angular app files path":::

   ::: zone-end

   ::: zone pivot="react"

   Type **build** and press **Enter**.

   :::image type="content" source="../media/extension-artifact-react.png" alt-text="React app files path":::

   ::: zone-end

   ::: zone pivot="svelte"

   Type **public** and press **Enter**.

   :::image type="content" source="../media/extension-artifact-svelte.png" alt-text="Svelte app files path":::

   ::: zone-end

   ::: zone pivot="vue"

   Type **dist** and press **Enter**.

   :::image type="content" source="../media/extension-artifact-vue.png" alt-text="Vue app files path":::

   ::: zone-end

8. Select a location nearest you and press **Enter**.

   :::image type="content" source="../media/extension-location.png" alt-text="Resource location":::

9. Click the **Select Existing** button to select the resource group that has been created for you in the Azure sandbox

   :::image type="content" source="../media/extension-no-permissions.png" alt-text="Select existing resource group":::

10. Select the resource group beginning with the word **learn**

    :::image type="content" source="../media/extension-select-resource-group.png" alt-text="Select resource group":::

11. Once the app is created, a confirmation notification is shown in Visual Studio Code.

    :::image type="content" source="../media/extension-confirmation.png" alt-text="Created confirmation":::

12. In the Visual Studio Code Explorer window, return to the _Static Web Apps_ section and right-click on **my-first-static-web-app** and select **Open in Portal** to view app in the Azure portal.

    :::image type="content" source="../media/extension-open-in-portal.png" alt-text="Open portal":::

> [!NOTE]
> Your repository is a bit different than the ones you may have used in the past. It contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. This isn't common. Typically, you have one app in the root of your repository and specify `/` for the app path location. This is a great example of why Azure Static Web Apps lets you configure the locations in the first place - you get full control over how the app is built.

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app isn't yet deployed. The GitHub Action that Azure creates in your repository will run automatically to trigger the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below screenshot allows you to navigate to the Actions page of your GitHub repository:

:::image type="content" source="../media/goto-action.png" alt-text="Browse to see the progress of the GitHub Actions workflow":::

Once you're there:

1. Click **Azure Static Web Apps CI/CD**
1. Click the commit titled **Azure Static Web Apps added workflow for file for CI/CD**
1. Click the **Build and Deploy Job** link

From here, you can observe the progress of your app as it builds.

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-web-apps-resource-overview.png" alt-text="Azure Static Web Apps overview page":::

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

## Next steps

Next you'll learn how to handle all unmatched page requests to the server and map them to navigate to a valid page in your app.
