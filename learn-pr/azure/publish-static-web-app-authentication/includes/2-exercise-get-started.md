In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that automatically builds and publishes your application.

This module uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you've activated the sandbox at the top of this page.

> [!TIP]
> If you encounter issues with your node dependencies, ensure that you have [Node Version Manager installed](https://github.com/nvm-sh/nvm#intro) and can switch to an earlier version. 

## Create a repository

Next, create a new repository by using a GitHub template repository. A series of templates is available where each contains a starter app built with a different front-end framework.

1. Go to the [create from template page](https://github.com/login?return_to=/MicrosoftDocs/mslearn-staticwebapp-authentication/generate?azure-portal=true) for the template repository.
   - If you get a 404 Page Not Found error, sign in to GitHub and try again.

1. If prompted for **Owner**, choose one of your GitHub accounts.

1. Name your repository **my-static-web-app-authn**.

1. Select **Create repository from template**.

## Clone your app locally

You just created a GitHub repository named **my-static-web-app-authn** in your GitHub account. Next, you'll clone the repo and run the code locally on your computer.

1. Open a terminal on your computer.

1. Start by cloning the GitHub repository to your computer.

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/my-static-web-app-authn
   ```

1. Go to the folder for your source code.

   ```bash
   cd my-static-web-app-authn
   ```

### Configure CORS locally

You won't have to worry about cross-origin resource sharing (CORS) when you publish to Azure Static Web Apps. Azure Static Web Apps automatically configures your app so it can communicate with your API on Azure using a reverse proxy. But when running locally, you need to configure CORS to allow your web app and API to communicate.

Now, instruct Azure Functions to allow your web app to make HTTP requests to the API on your computer.

1. Create a file named _api/local.settings.json_.

1. Add the following contents to the file:

   ::: zone pivot="angular"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:4200"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:3000"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:5000"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:8080"
     }
   }
   ```

   ::: zone-end

> [!NOTE]
> The _local.settings.json_ file is listed in the _.gitignore_ file, which prevents this file from being pushed to GitHub. This is because you could store secrets in this file you would not want that in GitHub. This is why you had to create the file when you created your repo from the template.

### Run the API

The `api` folder contains the Azure Functions project with the HTTP endpoints for the web app. Start by running the API locally by following these steps:

> [!NOTE]
> Be sure to install the [Azure Functions Core Tools](/azure/azure-functions/functions-run-local) which will allow you to run Azure Functions locally.

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>.

1. Enter and select **Terminal: Create New Integrated Terminal**.

1. Go to the _api_ folder:

   ```bash
   cd api
   ```

1. Run the Azure Functions app locally:

   ```bash
   func start
   ```

### Run the web app

1. Next, go to the folder of your preferred front-end framework, as follows:

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

1. Select the link to browse to your application.

::: zone pivot="angular"

2. Browse to `http://localhost:4200`.

   :::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="Screenshot showing the UI of your Angular web app.":::

::: zone-end

::: zone pivot="react"

2. Browse to `http://localhost:3000`.

   :::image type="content" source="../media/my-shopping-list-app-react.png" alt-text="Screenshot showing the UI of your React web app.":::

::: zone-end

::: zone pivot="svelte"

2. Browse to `http://localhost:5000`.

   :::image type="content" source="../media/my-shopping-list-app-svelte.png" alt-text="Screenshot showing the UI of your Svelte web app.":::

::: zone-end

::: zone pivot="vue"

2. Browse to `http://localhost:8080`.

   :::image type="content" source="../media/my-shopping-list-app-vue.png" alt-text="Screenshot showing the UI of your Vue web app.":::

::: zone-end

   Your app should display a list of products.

3. Now, stop your running app by pressing <kbd>Ctrl-C</kbd> in the terminal.

You built your application and now it's running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.

## Create a static web app

Now that you've created your GitHub repository, you can create a Static Web Apps instance using the Azure Static Web Apps extension for Visual Studio Code.

### Install the Azure Static Web Apps extension for Visual Studio Code

1. Go to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps&azure-portal=true), and install the **Azure Static Web Apps** extension for Visual Studio Code.

1. When the extension tab loads in Visual Studio Code, select **Install**.

1. After installation is complete, select **Reload**.

### Sign in to Azure in Visual Studio Code

1. In Visual Studio Code, sign in to Azure by selecting **View** > **Command Palette** and entering *Azure: Sign In*.

   > [!IMPORTANT]
   > Log in to Azure using the same account used to create the sandbox. The sandbox provides access to a Concierge Subscription.

1. Follow the prompts to copy and paste the code provided in the web browser, which authenticates your Visual Studio Code session.

## Select your subscription

1. Open Visual Studio Code, and select **File > Open** to open the repository you cloned to your computer in the editor.

1. Verify that you've filtered your Azure subscriptions to include the Concierge Subscription by opening the command palette <kbd>F1</kbd>, entering `Azure: Select Subscriptions`, and pressing <kbd>Enter</kbd>.

1. Select **Concierge Subscription**, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-concierge-subscription.png" alt-text="Screenshot showing how to filter by subscription.":::

### Create a Static Web App with Visual Studio Code

1. Open Visual Studio Code, and select **File > Open** to open the repository you cloned to your computer in the editor.

1. Inside Visual Studio Code, select the Azure logo in the activity bar to open the Azure extensions window.

    :::image type="content" source="../media/extension-azure-logo.png" alt-text="Screenshot of the Azure Logo in VS Code.":::

   > [!NOTE]
   > Azure and GitHub sign-in are required. If you are not already signed in to Azure and GitHub from Visual Studio Code, the extension will prompt you to sign in to both during the creation process.

1. Place your mouse over the _Static Web Apps_ label, and select **+** (plus sign).

    :::image type="content" source="../media/extension-create-button.png" alt-text="Screenshot showing the application name typed out.":::

1. When the command palette opens at the top of the editor, select **Concierge Subscription**, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-concierge-subscription-select.png" alt-text="Screenshot showing how to select a subscription.":::

1. Enter *my-static-web-app-authn*, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-create-app.png" alt-text="Screenshot showing how to create Static Web Apps.":::

1. Select the region closest to you, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-location-option.png" alt-text="Screenshot showing location selection.":::

1. Select the corresponding framework option, and press <kbd>Enter</kbd>.

::: zone pivot="angular"

8. Select **angular-app** as the location for the application code, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-app-location-angular.png" alt-text="Screenshot showing the Angular application code location.":::

9. Enter *dist/angular-app* as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-angular.png" alt-text="Screenshot showing the Angular app files path.":::

::: zone-end

::: zone pivot="react"

8. Select **react-app** as the location for the application code, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-app-location-react.png" alt-text="Screenshot showing the React application code location.":::

9. Enter *build* as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-react.png" alt-text="Screenshot showing the React app files path.":::

::: zone-end

::: zone pivot="svelte"

8. Select **svelte-app** as the location for the application code, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-app-location-svelte.png" alt-text="Screenshot showing the Svelte application code location.":::

9. Enter *public* as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-svelte.png" alt-text="Screenshot showing the Svelte app files path.":::

::: zone-end

::: zone pivot="vue"

8. Select **vue-app** as the location for the application code, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-app-location-vue.png" alt-text="Screenshot showing the Vue application code location.":::

9. Enter *dist* as the output location where files are built for production in your app, and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/extension-artifact-vue.png" alt-text="Screenshot showing the Vue app files path.":::

::: zone-end

> [!NOTE]
> Your repository may be a bit different than the ones you may have used in the past. It contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. Typically, you have one app in the root of your repository and specify `/` for the app path location. This is a great example of why Azure Static Web Apps lets you configure the locations in the first place - you get full control over how the app is built.

10. After the app is created, a confirmation notification appears in Visual Studio Code.

    :::image type="content" source="../media/extension-confirmation.png" alt-text="Screenshot showing the Open Actions in GitHub or View/Edit Config pop-up window.":::

   As the deployment is in progress, the Visual Studio Code extension reports the build status to you.

    :::image type="content" source="../media/extension-waiting-for-deployment.png" alt-text="Screenshot showing the waiting for deployment button.":::

11. You can view the progress of the deployment using GitHub Actions by expanding the **Actions** menu.

    :::image type="content" source="../media/extension-actions.png" alt-text="Screenshot showing the GitHub Actions menu in VS Code.":::

    After the deployment is complete, you can go directly to your website.

12. To view the website in the browser, right-click the project in the Static Web Apps extension, and select **Browse Site**.

    :::image type="content" source="../media/extension-browse-site.png" alt-text="Screenshot showing the browse site button.":::

Congratulations! You've deployed your app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that states the app hasn't been built and deployed yet. Refresh the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. If you see the splash page, the app is still being deployed.

### Pull the changes from GitHub

Pull the latest changes from GitHub to bring down the workflow file that was created by Azure Static Web Apps:

1. Open the command palette by pressing <kbd>F1</kbd>.

1. Enter and select **Git: Pull**, and then press <kbd>Enter</kbd>.

## Next steps

Next, you'll learn how to integrate user authentication into your app.
