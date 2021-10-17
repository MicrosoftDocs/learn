In this exercise, you'll create an Azure Static Web App instance, including a GitHub Action that automatically builds and publishes your application.

This module uses resources made available to you via the sandbox, which provides free, temporary access to an Azure subscription, along with the resources that you need to complete the exercises. Make sure you have activated the sandbox at the top of this page. When working through the exercises in this module, each unit is dependent on content you created in a previous exercise. For this reason, please choose one JavaScript framework and use it for all subsequent exercises.

## Create a repository

Let's create your repository by using a GitHub template. Azure has defined a series of GitHub repository templates, each of which contains a starter app and a collection of  front-end frameworks for the starter app.

1. Go to the GitHub [create from template page](https://github.com/login?return_to=/MicrosoftDocs/mslearn-staticwebapp-api/generate?azure-portal=true) to open the template repository.

   > [!NOTE]
   > If you get a `404 Page Not Found` error, sign in to GitHub first and try again.

1. If prompted for **Owner**, select one of your GitHub accounts.

1. For **repository name**, enter *my-static-web-app-and-api*.

1. Select **Create repository from template**. GitHub builds your repository.

## Run your app locally

You created your own GitHub repository named **my-static-web-app-and-api** in your GitHub account. Next, you'll clone the GitHub repo and run the code locally on your computer.

1. Open a terminal window on your computer (in Windows system tray search box, enter `cmd`.

1. Start by cloning the GitHub repository to your computer. Paste the following code into the `Command Prompt` window, replacing `<YOUR_GITHUB_USERNAME>` with your GitHub username. 

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/my-static-web-app-and-api
   ```

   > [!NOTE]
   > If you have trouble copying into the `Command Prompt` terminal session, right click the icon in the title bar, and in the **Properties** tab, ensure that **Use Ctrl+Shift+C/V as Copy/Paste** is checked.

1. Go to the directory for the source code you cloned.

   ```bash
   cd my-static-web-app-and-api
   ```

1. Next, go to the directory for your preferred front-end framework. Each front end must run in the 

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

1. Install the application dependencies, and update to the latest by entering the following commands

   ```bash
   npm install
   npm audit fix
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

When the application bundle is generated and compiled, a browser tab automatically opens to display your application running locally. Each front-end application runs on a different local host port:

::: zone pivot="angular"

1. Local host for angular is `http://localhost:4200`.

   :::image type="content" source="../media/my-shopping-list-app-loading-angular.png" alt-text="local host for your Angular web app.":::

::: zone-end

::: zone pivot="react"

1. Local host for react is  `http://localhost:3000`.

   :::image type="content" source="../media/my-shopping-list-app-loading-react.png" alt-text="local host for your React web app.":::

::: zone-end

::: zone pivot="svelte"

1. Local host for svelte is `http://localhost:5000`.

   :::image type="content" source="../media/my-shopping-list-app-loading-svelte.png" alt-text="local host for your Svelte web app.":::

::: zone-end

::: zone pivot="vue"

1. Local host for vue is `http://localhost:8080`.

   :::image type="content" source="../media/my-shopping-list-app-loading-vue.png" alt-text="Browsing to your Vue web app.":::

::: zone-end

  - Your app should say **Loading data ...** because there is no data or API yet. You'll add the API for your web app later on in this module.

2. In the terminal session, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop your batch job. Press <kbd>y</kbd>+<kbd>enter</kbd> to confirm.

Congratulations! You built your application and saw it running locally in your browser. Now, let's publish your application to Azure Static Web Apps service.

## Create a static web app

Now that you've created your own GitHub repository, you can create a Static Web App instance using the Azure Static Web Apps extension for Visual Studio Code.

### Install the Azure Static Web Apps extension for Visual Studio Code

1. In Visual Studio Code menu, select Extensions, and enter **Azure Static Web Apps**. 

1. When the extension tab loads in Visual Studio Code, select **Install**.

1. After installation is complete, in Visual Studio Code menu, select **Settings** (the gear), and then select **Restart to Update**.

   :::image type="content" source="../media/2-restart-to-update.png" alt-text="Screenshot of Visual Studio Code menu showing restart to update.":::

### Sign in to Azure in Visual Studio Code

1. In Visual Studio Code, sign in to Azure by selecting **View** > **Command Palette** (<kbd>Ctrl+Shift+P</kbd>) and entering **Azure: Sign In**.

   :::image type="content" source="../media/2-vs-sign-in.png" alt-text="Screenshot of Command Palette in VS Code menu.":::

   > [!IMPORTANT]
   > Log in to Azure using the same account you used to activate the sandbox so that you can access the Concierge Subscription.

1. If prompted, copy and paste the code provided in the web browser to authenticate your Visual Studio Code session.

## Select your subscription

1. In Visual Studio Code, select **Open Folder** and select **my-static-web-app-and-api** repository folder you cloned to your computer, and then select **Open**.

1. Open the Command Palette (<kbd>Ctrl+Shift+P</kbd>), enter `Azure: Select Subscriptions`, and clear all selections except the Concierge Subscription.

   :::image type="content" source="../media/extension-concierge-subscription.png" alt-text="Screenshot showing concierge subscription is selected.":::

### Create a static web app with Visual Studio Code

1. In Visual Studio Code EXPLORER pane, select **MY-STATIC-WEB-APP-AND-API**.

1. In Visual Studio Code menu, select the Azure (<kbd>Ctrl+Shift+A</kbd>) to open Azure extensions. You should see four panels showing the Concierge subscription and your Local Project.

   :::image type="content" source="../media/extension-azure-logo.png" alt-text="Screenshot showing Azure Logo and static web apps extensions.":::
   
   > [!NOTE]
   > Azure and GitHub sign-in are required. If you are not already signed in to Azure and GitHub from Visual Studio Code, the extension will prompt you to sign in to both during the creation process.

1. Place your mouse over the _Static Web Apps_ panel title, and select the `+` (plus sign) to create a Static Web App.
 
   :::image type="content" source="../media/extension-create-button.png" alt-text="Add button on the static web app menu.":::

1. Visual Studio Code verifies your login and prompts you to commit the changes that you made in your local repo. Select **Commit**, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-concierge-subscription-select.png" alt-text="Screenshot of dialog box prompting you to commit changes. Concierge subscription filter shows in the background.":::

1. **Create Static Web App (1/5)** prompts you to enter a name for the new static web app, prefilled with **my-static-web-app-and-api**. Verify the name, and then press <kbd>Enter</kbd> to confirm.

   :::image type="content" source="../media/extension-create-app.png" alt-text="Screenshot of Create Static Web App 1 of 5.":::

1. **Create Static Web App (2/5)** prompts you to select a region. Select **West US 2**, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-configure-location.png" alt-text="Screenshot Create Static Web App 2 of 5.":::
   
1. **Create Static Web App (3/5)** prompts you to select a build preset to configure the default project structure. Select the **Custom** option, and press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-custom-option.png" alt-text="Screenshot Create Static Web App 3 of 5.":::

::: zone pivot="angular"

8. **Create Static Web App (4/5)** prompts you to enter the location of your application code. Enter **angular-app** as the relative path for the application code, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-angular.png" alt-text="Angular application code location.":::

9. **Create Static Web App (5/5)** prompts you enter the location of your build output. Enter **dist/angular-app** as the build output location for your app, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-angular.png" alt-text="Angular app build output path.":::

::: zone-end

::: zone pivot="react"

8. **Create Static Web App (4/5)** prompts you to enter the location of your application code. Enter **react-app** as the relative path for the application code, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-react.png" alt-text="React application code location.":::

9. **Create Static Web App (5/5)** prompts you enter the location of your build output. Enter **build** as the build output location for your app, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-react.png" alt-text="React app build output path.":::

::: zone-end

::: zone pivot="svelte"

8. **Create Static Web App (4/5)** prompts you to enter the location of your application code. Enter  **svelte-app** as the location for the application code, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-svelte.png" alt-text="Svelte application code location.":::

9. **Create Static Web App (5/5)** prompts you enter the location of your build output. Enter **public** as the build output location for your app, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-svelte.png" alt-text="Svelte app build output path.":::

::: zone-end

::: zone pivot="vue"

8. **Create Static Web App (4/5)** prompts you to enter the location of your application code. Enter **vue-app** as the location for the application code, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-app-location-vue.png" alt-text="Vue application code location.":::

9. **Create Static Web App (5/5)** prompts you enter the location of your build output. Enter **`dist`** as the build output location for your app, and then press <kbd>Enter</kbd>.

   :::image type="content" source="../media/extension-artifact-vue.png" alt-text="Vue app build output path.":::

::: zone-end

   > [!NOTE]
   > Your repository for this app differs from the repos you may have used in the past. This repository contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. Typically, you'd have only one app in the root of your repository and thus the default `/` for the app path location. This is a great example of why Azure Static Web Apps lets you configure locations in the first place - you have full control over how the app is built.

10. Once the app is created, a confirmation notification is shown in Visual Studio Code.

   :::image type="content" source="../media/extension-confirmation.png" alt-text="Open Actions in GitHub or View/Edit Config.":::

   While you are configuring the build, Visual Studio Code reports the build status to you.

   :::image type="content" source="../media/extension-waiting-for-deployment.png" alt-text="Waiting for Deployment.":::

11. You can view the progress of the deployment using GitHub Actions by expanding the **Actions** menu.

    :::image type="content" source="../media/extension-actions.png" alt-text="GitHub Actions.":::

    Once the deployment is complete, you can navigate directly to your website.

12. To view the website in the browser, right-click on the project in the Static Web Apps extension, and select Browse Site.

    :::image type="content" source="../media/extension-browse-site.png" alt-text="Browse Site.":::

   Your app should say **Loading data ...** because there is no data or API yet. You'll add the API for your web app later on in this module.

Congratulations! You've deployed your app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that states the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action service runs automatically when the Azure Static Web App is created. So if you see the splash page, the app is still being deployed.

### Pull the changes from GitHub

Pull the latest changes from GitHub to bring down the workflow file that was created by Azure Static Web Apps service.

1. Open the Command Palette by pressing <kbd>Ctrl+Shift+P</kbd>.

1. Enter and select **Git: Pull**.

1. Press <kbd>Enter</kbd>.

## Next steps

Next you'll learn how to build and run your API using an Azure Functions project.
