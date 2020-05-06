In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that will automatically build and publish your application.

## Create a routing rule

Before publishing your app, create routing rules that include a fallback route.

### Create the file routes.json

1. Open the folder _my-static-web-app_ in Visual Studio Code

::: zone pivot="angular"

1. In Visual Studio Code, right-click the folder _angular-app/src/_

::: zone-end

::: zone pivot="react"

1. In Visual Studio Code, right-click the folder _react-app/public_

::: zone-end

::: zone pivot="svelte"

1. In Visual Studio Code, right-click the folder _svelte-app/public_

::: zone-end

::: zone pivot="vue"

1. In Visual Studio Code, right-click the folder _vue-app/public_

::: zone-end

2. Select **New File**
3. Type _routes.json_ and press <kbd>Enter</kbd>
4. Update the _routes.json_ file to include the following fallback route:

   ```json
   {
     "routes": [
       {
         "route": "/*",
         "serve": "/index.html",
         "statusCode": 200
       }
     ]
   }
   ```

::: zone pivot="angular"

### Configure Angular

Angular apps don't copy files in the _src_ folder to the artifact folder by default. Use the following steps to ensure the _routes.json_ is copied to the appropriate location.

1. In Visual Studio Code, open the file _angular-app/angular.json_
1. Go to the property at:

   ```json-schema
    projects
     └── angular-app
       └── architect
         └── build
           └── options
              └──  assets
   ```

1. Extend the `assets` array to include the _src/routes.json_ file:

   ```json
   "assets": ["src/routes.json", "src/favicon.ico", "src/assets"],
   ```

Now Angular is configured to copy the _routes.json_ file to your artifact location when your app builds.

::: zone-end

### Push your changes to Git

Now save, commit, and push your changes to Git by following these steps:

1. Open the command palette by pressing <kbd>F1</kbd>.
1. Type and select **Git: Commit All**. If Visual Studio Code prompts you to automatically stage all of your changes and commit them directly, select **Yes**.
1. Enter a commit message such as **added routing rules for a fallback route**.
1. Open the command palette by pressing <kbd>F1</kbd>.
1. Type and select **Git: Push**.

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), making sure you use the same account to sign in as you did to activate the sandbox.
1. In the top bar, search for **Static Web Apps**.
1. Select **Static Web Apps**.
1. Select **New**.

### Basics

Next, configure your new app and link it to your GitHub repository.

1. Enter the **Project Details**

   | Setting          | Value                                    |
   | ---------------- | ---------------------------------------- |
   | _Subscription_   | **Concierge subscription**               |
   | _Resource Group_ | <rgn>[Sandbox resource group name]</rgn> |

1. Enter the **Static Web Apps details**

   | Setting  | Value                                                                         |
   | -------- | ----------------------------------------------------------------------------- |
   | _Name_   | Name your app. Valid characters are `a-z` (case insensitive), `0-9`, and `_`. |
   | _Region_ | Select the region closest to you                                              |
   | _SKU_    | **Free**                                                                      |

1. Click the **Sign-in with GitHub** button and authenticate with GitHub
1. Enter the **Source Control Details**

   | Setting        | Value                                                    |
   | -------------- | -------------------------------------------------------- |
   | _Organization_ | Select the Organization where you created the repository |
   | _Repository_   | **my-static-web-app**                                    |
   | _Branch_       | **master**                                               |

1. Click the **Next: Build >** button to edit the build configuration

:::image type="content" source="../media/next-build-button.png" alt-text="Next: Build button":::

### Build

Next, add configuration details specific to your preferred front-end framework.

::: zone pivot="angular"

| Setting                 | Value                |
| ----------------------- | -------------------- |
| _App location_          | **angular-app**      |
| _Api location_          | **api**              |
| _App artifact location_ | **dist/angular-app** |

::: zone-end

::: zone pivot="react"

| Setting                 | Value         |
| ----------------------- | ------------- |
| _App location_          | **react-app** |
| _Api location_          | **api**       |
| _App artifact location_ | **build**     |

::: zone-end

::: zone pivot="svelte"

| Setting                 | Value          |
| ----------------------- | -------------- |
| _App location_          | **svelte-app** |
| _Api location_          | **api**        |
| _App artifact location_ | **public**     |

::: zone-end

::: zone pivot="vue"

| Setting                 | Value       |
| ----------------------- | ----------- |
| _App location_          | **vue-app** |
| _Api location_          | **api**     |
| _App artifact location_ | **dist**    |

::: zone-end

Click the **Review + create** button. This will bring you to the page where you can review the resource before you create it.

:::image type="content" source="../media/review-create-button.png" alt-text="Review + create button":::

> [!NOTE]
> Your repository is extraordinary in that it contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. This isn't common. Typically, you have one app in the root of your repository and specify `/` for the app path location. This is a great example of why Azure Static Web Apps lets you configure the locations in the first place - you get full control over how the app is built.

### Review + create

Continue to create the application.

1. Click the **Create** button

   :::image type="content" source="../media/create-button.png" alt-text="Create button":::

1. Once the deployment is complete, click the **Go to resource** button

   :::image type="content" source="../media/go-to-resource-button.png" alt-text="Go to resource button":::

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app isn't yet deployed. The GitHub Action that Azure creates in your repository will run automatically to trigger the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below to navigate to the Actions page of your GitHub repository:

:::image type="content" source="../media/goto-action.png" alt-text="Browse to see the progress of the GitHub Actions workflow":::

1. Click **Azure Static Web Apps CI/CD**
1. Click the commit titled **Azure Static Web Apps added workflow for file for CI/CD**
1. Click the **Build and Deploy Job** link

From here, you can observe the progress of your app as it builds.

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-web-apps-resource-overview.png" alt-text="Azure Static Web Apps overview page":::

Your app's now globally available, but it's still stuck at **Loading data ...** because there is no data or API yet. You'll add the API for your web app in the next section.

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

### Try the fallback route

Your app is displaying the **Products** page in the browser. Notice the URL is **/products**. Now refresh the browser and test your fallback route.

In your browser, press <kbd>F5</kbd> to refresh the page. Your app should reload successfully thanks to your fallback route in your routing rules!

## Next steps

Your app is missing an API for its shopping list. Next, you'll explore how to add an Azure Functions API to your app that will be published to Azure alongside the static assets.
