In this exercise, you create an Azure Static Web App instance, including a GitHub Action that automatically builds and publishes your web site.

This module uses resources made available to you via the sandbox, which provides free, temporary access to an Azure subscription, along with the resources that you need to complete the exercises. Make sure to activate the sandbox at the top of this page. As you work through the exercises in this module, each unit is dependent on content you created in a previous exercise. For this reason, select a JavaScript framework and use it for all subsequent exercises.

## Create a repository

To begin, create a repository by using a GitHub template. A series of repository templates are available, which contain a starter app implemented in various front end frameworks.

1. Go to the GitHub [create from template page](https://github.com/login?return_to=/MicrosoftDocs/mslearn-staticwebapp-api/generate?azure-portal=true) to open the template repository.

1. If prompted for _Owner_, select one of your GitHub accounts.

1. For _repository name_, enter **my-static-web-app-and-api**.

1. Select **Create repository from template**.

    As you create the project from a template, GitHub builds your repository in the background.

## Run your app locally

Now you have a GitHub repository named **my-static-web-app-and-api** in your GitHub account. Next, you clone the GitHub repo and run the code locally on your computer.

1. Open a terminal window on your computer.

    If you're on Windows, you can enter `cmd` in the system tray search box.

1. To clone the repository to your machine, paste the following code into the command prompt window.

    Make sure to replace `<YOUR_GITHUB_USERNAME>` with your GitHub username.

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/my-static-web-app-and-api
   ```

   > [!NOTE]
   > If you have trouble copying into the command prompt terminal, right-click the icon in the title bar, and in the **Properties** tab, ensure that **Use Ctrl+Shift+C/V as Copy/Paste** is checked.

1. Change to the directory for the source code you cloned.

   ```bash
   cd my-static-web-app-and-api
   ```

1. Go to the directory for your preferred front end framework.

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

1. Install the application dependencies.

   ```bash
   npm install
   ```

1. Ensure the latest version of each dependency is installed with the following command.

   ```bash
   npm audit fix
   ```

1. Run the front end client application.

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

When the application bundle is generated and compiled, a browser tab automatically opens to display your application running locally.

::: zone pivot="angular"

Local host for angular is `http://localhost:4200`.

:::image type="content" source="../media/my-shopping-list-app-loading-angular.png" alt-text="Screenshot of the local host for your Angular web app.":::

::: zone-end

::: zone pivot="react"

Local host for react is  `http://localhost:3000`.

:::image type="content" source="../media/my-shopping-list-app-loading-react.png" alt-text="Screenshot of the local host for your React web app.":::

::: zone-end

::: zone pivot="svelte"

Local host for svelte is `http://localhost:5000`.

:::image type="content" source="../media/my-shopping-list-app-loading-svelte.png" alt-text="Screenshot of the local host for your Svelte web app.":::

::: zone-end

::: zone pivot="vue"

Local host for Vue is `http://localhost:8080`.

:::image type="content" source="../media/my-shopping-list-app-loading-vue.png" alt-text="Screenshot of the local host for your Vue web app.":::

::: zone-end

Your app should say **Loading data ...** because there's no data or API yet. You add the API for your web app later in this lesson.

In the terminal, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop your batch job.

Congratulations! You built your application and saw it running locally in your browser. Next you can publish your application to Azure Static Web Apps.

## Create a static web app

You created your own GitHub repository. Now you can create your own static web app using the Azure Static Web Apps extension for Visual Studio Code.

### Install the Azure Static Web Apps extension for Visual Studio Code

1. Open Visual Studio Code.

1. From the top menu, select **View** > **Extensions**, and enter **Azure Static Web Apps** in the search box.

1. When the extension tab loads in Visual Studio Code, select **Install**.

## Open the application folder

1. Select <kbd>F1</kbd> to open the Visual Studio Code command palette.

2. Enter **File: Open Folder...**.

3. Select the **my-static-web-app-and-api** folder.

4. Select **Open** to open the folder in Visual Studio Code.

### Sign in to Azure in Visual Studio Code

1. Select <kbd>F1</kbd> to open the Visual Studio Code command palette.

1. Enter **Azure: Sign In** and follow the prompts to authenticate.

   > [!IMPORTANT]
   > Make sure to sign in to Azure using the same account you used to activate the in-browser sandbox. Using the same account makes Concierge Subscription available, which gives you access to free Azure resources during this tutorial.

### Select your subscription

1. Select <kbd>F1</kbd> to open the Visual Studio Code command palette.

1. Enter **Azure: Select Subscriptions**, and clear all selections except the **Concierge Subscription**.

    :::image type="content" source="../media/extension-concierge-subscription.png" alt-text="Screenshot showing concierge subscription is selected.":::

### Commit changes

When you installed the application dependencies, some of the files in your project were updated in the process. In order to proceed, you need to commit those changes to the repository.

1. Select <kbd>F1</kbd> to open the Visual Studio Code command palette.

1. Enter and select **Git Commit All**.

1. Enter **initial commit** to the top of the file.

1. Save and close the git commit file.

    Don't worry about syncing your changes with the server at this point. The updates are copied up to GitHub when you publish the static web app.

### Create the static web app

Current Azure and GitHub authenticated sessions are required to create a static web app. If you aren't already signed in to both providers, the extension prompts you to sign in during the creation process.

1. Select <kbd>F1</kbd> to open the Visual Studio Code command palette.

::: zone pivot="angular"

2. Enter and select **Azure Static Web Apps: Create Static Web App...**.

    Enter the following values for the remainder of the command palette prompts.

      | Prompt | Value |
      |--|--|
      | Subscription | Select the **Concierge Subscription** |
      | Name | Enter **my-static-web-app-and-api** |
      | Region | Select the region closest to you |
      | Preset | Select **Angular** |
      | Application code location | Enter **angular-app** |
      | Output location | Enter **dist/angular-app** |

::: zone-end

::: zone pivot="react"

2. Enter and select **Azure Static Web Apps: Create Static Web App...**.

    Enter the following values for the remainder of the command palette prompts.

      | Prompt | Value |
      |--|--|
      | Subscription | Select the **Concierge Subscription** |
      | Name | Enter **my-static-web-app-and-api** |
      | Region | Select the region closest to you |
      | Preset | Select **React** |
      | Application code location | Enter **react-app** |
      | Output location | Enter **dist** |

::: zone-end

::: zone pivot="svelte"

2. Enter and select **Azure Static Web Apps: Create Static Web App...**.

    Enter the following values for the remainder of the command palette prompts.

      | Prompt | Value |
      |--|--|
      | Subscription | Select the **Concierge Subscription** |
      | Name | Enter **my-static-web-app-and-api** |
      | Region | Select the region closest to you |
      | Preset | Select **Svelte** |
      | Application code location | Enter **svelte-app** |
      | Output location | Enter **public** |

::: zone-end

::: zone pivot="vue"

2. Enter and select **Azure Static Web Apps: Create Static Web App...**.

    Enter the following values for the remainder of the command palette prompts.

      | Prompt | Value |
      |--|--|
      | Subscription | Select the **Concierge Subscription** |
      | Name | Enter **my-static-web-app-and-api** |
      | Region | Select the region closest to you |
      | Preset | Select **Vue** |
      | Application code location | Enter **vue-app** |
      | Output location | Enter **dist** |

::: zone-end

   > [!NOTE]
   > This repository differs from other projects you may have used in the past. This project contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. Typically, you'd have only one app in the root of your repository and thus the default `/` for the app path location. This is a great example of how Azure Static Web Apps lets you configure locations in the first place - you have full control over how the app is built.

3. Once the app is created, a confirmation notification is shown in Visual Studio Code.

   :::image type="content" source="../media/extension-confirmation.png" alt-text="Screenshots of the Open Actions in GitHub or View/Edit Config pop-up window.":::

   While you're configuring the build, Visual Studio Code reports the build status to you.

   :::image type="content" source="../media/extension-waiting-for-deployment.png" alt-text="Screenshot showing production status as waiting for deployment.":::

4. You can view the progress of the deployment using GitHub Actions by expanding the **Actions** menu.

    :::image type="content" source="../media/extension-actions.png" alt-text="Screenshot showing how to see GitHub Actions.":::

    Once the deployment is complete, you can navigate directly to your website.

5. To view the website in the browser, right-click on the project in the Static Web Apps extension, and select Browse Site.

    :::image type="content" source="../media/extension-browse-site.png" alt-text="Screenshot showing how to use the Visual Studio Code extension to browse the static web app.":::

    Your app should say **Loading data ...** because there's no data or API yet. You add the API for your web app later on in this module.

Congratulations! Your app is deployed to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that states the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action service runs automatically when the Azure Static Web App is created. So if you see the splash page, the app is still being deployed.

### Pull the changes from GitHub

Pull the latest changes from GitHub to bring down the workflow file created by Azure Static Web Apps service.

1. Open the Command Palette by pressing <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>.

1. Enter and select **Git: Pull**.

1. Press <kbd>Enter</kbd>.

## Next steps

Next you learn how to build and run your API using an Azure Functions project.
