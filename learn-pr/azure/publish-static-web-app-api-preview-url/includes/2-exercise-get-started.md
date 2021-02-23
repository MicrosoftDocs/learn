In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that automatically builds and publishes your application.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

## Create a repository

Next, create a new repository by using a GitHub template repository. A series of templates are available where each contains a starter app built with a different front-end framework.

1. Navigate to the [create from template page](https://github.com/MicrosoftDocs/mslearn-staticwebapp-api/generate?azure-portal=true) for the template repository.
   - If you get a 404 Page Not Found error, sign in to GitHub and try again.
1. If prompted for **Owner**, choose one of your GitHub accounts
1. Name your repository **my-static-web-app**
1. Click the **Create repository from template** button

## Run your app locally

You just created a GitHub repository named **my-static-web-app** in your GitHub account. Next, you'll clone the repo and run the code locally on your computer.

1. Open a terminal on your computer.
1. Start by cloning the GitHub repository to your computer.

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/my-static-web-app
   ```

1. Go to the folder for your source code.

   ```bash
   cd my-static-web-app
   ```

1. Next, go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Now install the application dependencies.

   ```bash
   npm install
   ```

1. Finally, run the front-end client application.

   ::: zone pivot="angular"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   npm run serve
   ```

   ::: zone-end

## Browse to your app

It's time to see your application running locally. Each front-end application runs on a different port.

Click the link to browse to your application.

::: zone pivot="angular"

Browse to `http://localhost:4200`.

:::image type="content" source="../media/my-shopping-list-app-loading-angular.png" alt-text="Browsing to your Angular web app":::

::: zone-end

::: zone pivot="react"

Browse to `http://localhost:3000`.

:::image type="content" source="../media/my-shopping-list-app-loading-react.png" alt-text="Browsing to your React web app":::

::: zone-end

::: zone pivot="svelte"

Browse to `http://localhost:5000`.

:::image type="content" source="../media/my-shopping-list-app-loading-svelte.png" alt-text="Browsing to your Svelte web app":::

::: zone-end

::: zone pivot="vue"

Browse to `http://localhost:8080`.

:::image type="content" source="../media/my-shopping-list-app-loading-vue.png" alt-text="Browsing to your Vue web app":::

::: zone-end

Your app should say **Loading data ...** because there is no data or API yet. You'll add the API for your web app later on in this tutorial.

Now stop your running app by pressing <kbd>Ctrl-C</kbd> in the terminal.

You built your application and now it's running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance using the Azure Static Web Apps extension for Visual Studio Code.

### Install the Azure Static Web Apps extension for Visual Studio Code

1. Go to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps&azure-portal=true) and install the **Azure Static Web Apps** extension for Visual Studio Code.

1. When the extension tab loads in Visual Studio Code, click **Install**.

1. After installation is complete, click **Reload**.

### Sign into Azure in Visual Studio Code

1. In Visual Studio Code, sign in to Azure by clicking **View** > **Command Palette** and typing **Azure: Sign In**.

   > [!IMPORTANT]
   > Login to Azure using the same account used to create the sandbox. The sandbox provides access to a Concierge Subscription.

1. Follow the prompts to copy and paste the code provided in the web browser, which authenticates your Visual Studio Code session.

## Select Your Subscription

1. Open Visual Studio Code, and select **File > Open** to open the repository you cloned to your computer in the editor.

1. Verify that you have filtered your Azure subscriptions to include the Concierge Subscription by opening the command palette <kbd>F1</kbd>, entering `Azure: Select Subscriptions`, and press <kbd>Enter</kbd>.

1. Select **Concierge Subscription** and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-concierge-subscription.png" alt-text="Filter by subscription":::

### Create a static web app with Visual Studio Code

1. Open Visual Studio Code, and select **File > Open** to open the repository you cloned to your computer in the editor.

1. Inside Visual Studio Code, select the Azure logo in the Activity Bar to open the Azure extensions window.

   :::image type="content" source="../media/extension-azure-logo.png" alt-text="Azure Logo":::

   > [!NOTE]
   > Azure and GitHub sign in are required. If you are not already signed in to Azure and GitHub from Visual Studio Code, the extension will prompt you to sign in to both during the creation process.

1. Place your mouse over the _Static Web Apps_ label, and select the **+** (plus sign).

   :::image type="content" source="../media/extension-create-button.png" alt-text="Application name":::

1. When the command palette opens at the top of the editor, select **Concierge Subscription** and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-concierge-subscription-select.png" alt-text="Select Subscription":::

1. Enter **my-static-web-app-and-api**, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-create-app.png" alt-text="Create Static Web App":::

1. Select the **Custom** option, and press <kbd>Enter</kbd>

   :::image type="content" source="../media/extension-custom-option.png" alt-text="Create Static Web App - Custom":::

1. Select the **Manually enter location** option, and press <kbd>Enter</kbd>

   :::image type="content" source="../media/extension-manually-enter-location-of-app-option.png" alt-text="Create Static Web App - manually enter application location":::

::: zone pivot="angular"

8. Select **angular-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-angular.png" alt-text="Angular application code location":::

::: zone-end

::: zone pivot="react"

8. Select **react-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-react.png" alt-text="React application code location":::

::: zone-end

::: zone pivot="svelte"

8. Select **svelte-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-svelte.png" alt-text="Svelte application code location":::

::: zone-end

::: zone pivot="vue"

8. Select **vue-app** as the location for the application code, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-vue.png" alt-text="Vue application code location":::

::: zone-end

9. The extension is looking for the location of the API in your application. We'll skip this for now and focus on the API later in this module.

   Select **Skip for now** and press **Enter**.

   :::image type="content" source="../media/extension-api-location.png" alt-text="API location":::

::: zone pivot="angular"

10. Enter **dist/angular-app** as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-angular.png" alt-text="Angular app files path":::

::: zone-end

::: zone pivot="react"

10. Enter **build** as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-react.png" alt-text="React app files path":::

::: zone-end

::: zone pivot="svelte"

10. Enter **public** as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-svelte.png" alt-text="Svelte app files path":::

::: zone-end

::: zone pivot="vue"

10. Enter **dist** as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-vue.png" alt-text="Vue app files path":::

::: zone-end

11. Select a location nearest you, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-location.png" alt-text="Resource location":::

12. Select **Select Existing** to select the resource group that has been created for you in the Azure sandbox.

    :::image type="content" source="../media/extension-no-permissions.png" alt-text="Select existing resource group":::

13. Select the resource group named <rgn>[Sandbox resource group]</rgn>.

    :::image type="content" source="../media/extension-select-resource-group.png" alt-text="Select resource group":::

    After the app is created, a confirmation notification appears in Visual Studio Code.

    :::image type="content" source="../media/extension-confirmation.png" alt-text="Created confirmation":::

14. In the Visual Studio Code Explorer window, return to the _Static Web Apps_ section, right-click on **my-static-web-app-and-api**, and select **Open in Portal** to view app in the Azure portal.

    :::image type="content" source="../media/extension-open-in-portal.png" alt-text="Open portal":::

> [!NOTE]
> Your repository is a bit different than the ones you may have used in the past. It contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. This isn't common. Typically, you have one app in the root of your repository and specify `/` for the app path location. This is a great example of why Azure Static Web Apps lets you configure the locations in the first place - you get full control over how the app is built.

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app isn't yet deployed. The GitHub Action that Azure creates in your repository will run automatically to trigger the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by navigating to the Actions page of your GitHub repository.

1. Select the link shown in the following image.

   :::image type="content" source="../media/portal-goto-action.png" alt-text="Browse to see the progress of the GitHub Actions workflow":::

1. Select **Azure Static Web Apps CI/CD**.

1. Select the topmost commit titled similar to **ci: add Azure Static Web Apps workflow file**.

1. Select the **Build and Deploy Job** link on the left.

From here, you can observe the progress of your app as it builds.

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

1. In the Visual Studio Code Explorer window, return to the _Static Web Apps_ section and right-click on **my-static-web-app-and-api** and select **Browse Site** to view app in your browser.

   :::image type="content" source="../media/extension-browse-site.png" alt-text="Browse Site":::

Your app should say **Loading data ...** because there is no data or API yet. You'll add the API for your web app later on in this tutorial.

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

### Pull the changes from GitHub

Pull the latest changes from GitHub to bring down the workflow file that was created by Azure Static Web Apps.

1. Open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Pull**
1. Press <kbd>Enter</kbd>

## Next steps

Next you'll learn how to build and run your API using an Azure Functions project.
