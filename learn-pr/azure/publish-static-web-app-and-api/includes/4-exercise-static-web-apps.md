In this exercise, you'll create the Azure Static Web App including a GitHub Action that will automatically build and publish your application.

## Activate the Azure sandbox

First, you'll connect to an Azure sandbox. You can create the Azure Static Web Apps resources from here.

1. Start by **activating the Azure sandbox above**.
1. Once it's activated, [sign into the Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

## Create a Static Web App

Now that your GitHub repository is created, you can create a Static Web App from the Azure portal.

1. In the top bar, search for **Static Web Apps**
1. Click **Static Web Apps**

### Basics

Next, configure your new app and link it to your GitHub repository.

1. Select your sandbox _Azure subscription_
1. Select the _Resource Group_ <rgn>[Sandbox resource group name]</rgn>
1. Name your app. Valid characters are `a-z` (case insensitive), `0-9`, and `_`.
1. Select _Region_ closest to you
1. Select the **Free** _SKU_
1. Click the **Sign-in with GitHub** button and authenticate with GitHub
1. Select your preferred _Organization_

   - Use the same organization where you created your new repository

1. Select **my-first-static-web-app** from the _Repository_ drop-down
1. Select **master** from the _Branch_ drop-down
1. Click the **Next: Build >** button to edit the build configuration

### Build

Next, add configuration details specific to your preferred front-end framework.

::: zone pivot="angular"

- Enter **src** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist/angular-app** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="react"

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **build** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="svelte"

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **public** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="vue"

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

### Review + create

Continue to create the application.

1. Click the **Create** button
1. Once the deployment is complete, click the **Go to resource** button

There are two automated aspects to deploying a static web app. The first aspect provisions the underlying Azure resources that make up your app. The second aspect is a GitHub Actions workflow that builds and publishes your application.

> [!NOTE]
> You can ensure that the GitHub Actions workflow is complete by checking the status of your commits available at `https://github.com/<YOUR_GITHUB_USERNAME>/my-first-static-web-app/actions`.

### Review the GitHub Action

The first time your Azure Static Web Apps resource is created, it creates a GitHub Action. The GitHub Action is added to your repository in the _.github/worksflows_ folder. You can review or modify this file as needed. The settings you entered when cerating the resource are stored in the GitHub Action's file.

While your app is being built you can watch the progress of the GitHub Action by clicking the link shown below:

:::image type="content" source="../media/goto-action.png" alt-text="Browser to see the progress of the GitHub Action":::

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

1. Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-web-apps-resource-overview.png" alt-text="Azure Static Web Apps overview page":::

Congratulations! You've just deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web App is created. So if you see the splash page, the app is still being deployed.

## Next steps

Your app is missing an API for its shopping list. Next, you'll explore how to add an Azure Functions API to your app that will be published to Azure alongside the static assets.
