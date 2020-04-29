In this exercise, you'll create the Azure Static Web App including a GitHub Action that will automatically build and publish your application.

## Activate the Azure sandbox

First, you'll connect to an Azure sandbox. You can create the Azure Static Web Apps resources from here.

1. Start by **activating the Azure sandbox above**.
1. Once it's activated, [sign into the Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

## Create a Static Web App

Now that your GitHub repository is created, you can create a Static Web App from the Azure portal.

1. In the top bar, search for **Static Web Apps**
1. Select **Static Web Apps**
1. Select **New**

### Basics

Next, configure your new app and link it to your GitHub repository.

1. Enter the **Project Details**

   | Setting          | Value                                    |
   | ---------------- | ---------------------------------------- |
   | _Subscription_   | **Concierge subscription**               |
   | _Resource Group_ | <rgn>[Sandbox resource group name]</rgn> |

1. Enter the **Static Web App details**

   | Setting  | Value                                                                         |
   | -------- | ----------------------------------------------------------------------------- |
   | _Name_   | Name your app. Valid characters are `a-z` (case insensitive), `0-9`, and `_`. |
   | _Region_ | Select Region closest to you                                                  |
   | _SKU_    | **Free**                                                                      |

1. Click the **Sign-in with GitHub** button and authenticate with GitHub
1. Enter the **Source Control Details**

   | Setting        | Value                                                    |
   | -------------- | -------------------------------------------------------- |
   | _Organization_ | Select the Organization where you created the repository |
   | _Repository_   | **my-first-static-web-app**                              |
   | _Branch_       | **master**                                               |

1. Click the **Next: Build >** button to edit the build configuration

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

Click the **Review + create** button

> [!NOTE]
> Your repository is extraordinary in that it contains four different apps in four different folders. Each folder contains an app created in a different JavaScript framework. This is not common. Normally you'll have one app in the root of your repository and _/_ for the app path location. This is a great example of why Azure Static Web Apps lets you configure the locations in the first place - to be accommodating to multiple repository shapes/needs.

### Review + create

Continue to create the application.

1. Click the **Create** button
1. Once the deployment is complete, click the **Go to resource** button

> [!NOTE]
> You can ensure that the GitHub Actions workflow is complete by checking the status of your commits available at `https://github.com/<YOUR_GITHUB_USERNAME>/my-first-static-web-app/actions`.

### Review the GitHub Action

While your app is being built, you can watch the progress of the GitHub Action by clicking the link shown below:

:::image type="content" source="../media/goto-action.png" alt-text="Browser to see the progress of the GitHub Action":::

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

1. Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-web-apps-resource-overview.png" alt-text="Azure Static Web Apps overview page":::

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web App is created. So if you see the splash page, the app is still being deployed.

## Next steps

Your app is missing an API for its shopping list. Next, you'll explore how to add an Azure Functions API to your app that will be published to Azure alongside the static assets.
