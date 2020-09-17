In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that will automatically build and publish your application.

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

## Customize Visual Studio Code

Before you begin, you need to grant Visual Studio Code access to the Azure subscription used by the sandbox. This subscription was created when you activate the sandbox and allows you to use Azure services without incurring any costs.

### Add concierge tenant to Visual Studio Code

The following steps associate the free Azure subscription created for you with Visual Studio Code. At the end of the tutorial you'll follow steps to restore Visual Studio Code back to its original settings.

1. In the Cloud Shell, run the following command and copy the tenant ID to your clipboard.

   ```bash
   az account list --query "[?name=='Concierge Subscription'].tenantId" -o tsv
   ```

1. Open Visual Studio Code and go to **File > Open Folder** to open the repository you cloned to your computer in the editor.

1. Open settings in Visual Studio Code. On Windows or Linux, select **File > Preferences > Settings**. On macOS, select **Code > Preferences > Settings**.

1. Navigate through **User Settings > Extensions > Azure configuration**

1. Enter the tenant in the **Azure: Tenant** textbox.

![Add tenant ID to Visual Studio Code Azure extension configuration](../media/vs-code-tenant.png)

### Sign out and back in

Now that you've made these changes, you need to sign out and back into the Azure extension.

1. Press **F1** to open the Visual Studio Code command palette.

1. Search for and select **Azure: Sign Out**.

1. Press **F1** again.

1. Search for and select **Azure: Sign In** and sign in with the same account you used to sign into the Learn sandbox.

### Select subscription

1. Click on the Azure extension icon.

   ![Visual Studio Code Azure extension icon](../media/vs-code-azure-extension-icon.png)

1. Under the _Static Web Apps (Preview)_ heading, click on **Select Subscriptions**.

   ![Visual Studio Code Azure extension: Functions section](../media/vs-code-select-subscriptions.png)

1. Next, the command palette appears. Select **Concierge Subscription** and click **OK**.

   ![Visual Studio Code Azure extension: Select concierge subscription](../media/vs-code-select-concierge.png)

Now Visual Studio Code is configured to use the sandbox resources and avoid any billing against your account.

## Create a static web app

1. Inside Visual Studio Code, select the Azure logo in the Activity Bar to open the Azure extensions window.

   :::image type="content" source="../media/extension-azure-logo.png" alt-text="Azure Logo":::

   > [!NOTE]
   > Azure and GitHub sign in are required. If you are not already signed in to Azure and GitHub from Visual Studio Code, the extension will prompt you to sign in to both during the creation process.

1. Place your mouse over the _Static Web Apps_ label and select the **plus sign**.

   :::image type="content" source="../media/extension-create-button.png" alt-text="Application name":::

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

9. Once the app is created, a confirmation notification is shown in Visual Studio Code.

   :::image type="content" source="../media/extension-confirmation.png" alt-text="Created confirmation":::

10. In the Visual Studio Code Explorer window, return to the _Static Web Apps_ section and right-click on **my-first-static-web-app** and select **Open in Portal** to view app in the Azure portal.

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
