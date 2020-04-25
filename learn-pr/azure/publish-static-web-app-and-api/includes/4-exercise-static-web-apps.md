In this exercise you'll create the Azure Static Web App including a GitHub Action that will automatically build and publish your application.

## Activate the Azure sandbox

First, you'll connect to an Azure sandbox. you'll be able to create the Azure Static Web Apps resources from here.

1. Start by **activating the Azure sandbox above**.
1. Once it's activated, [sign into the Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

## Create a Static Web App

Now that your GitHub repository is created, you can create a Static Web App from the Azure portal.

1. In the top bar, search for **Static Web Apps**
1. Click **Static Web Apps**

### Basics

Next, configure your new app and link it to your GitHub repository.

1. Select your sandbox _Azure subscription_
1. Select or create a new _Resource Group_
1. Name the app **my-first-static-web-app**.

   - Valid characters are `a-z` (case insensitive), `0-9`, and `_`.

1. Select _Region_ closest to you
1. Select the **Free** _SKU_
1. Click the **Sign-in with GitHub** button and authenticate with GitHub
1. Select your preferred _Organization_

   - This should be the same organization where you created your new repository

1. Select **my-first-static-web-app** from the _Repository_ drop-down
1. Select **master** from the _Branch_ drop-down
1. Click the **Next: Build >** button to edit the build configuration

### Build

Next, add configuration details specific to your preferred front-end framework.

::: zone pivot="angular"

# [Angular](#tab/angular)

- Enter **src** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="react"

# [React](#tab/react)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **build** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="svelte"

# [Svelte](#tab/svelte)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Clear the default value from _App artifact location_ box
- Click the **Review + create** button

::: zone-end

::: zone pivot="vue"

# [Vue](#tab/vue)

- Enter **/** in the _App location_ box
- Clear the default value from the _Api location_ box
- Enter **dist** in the _App artifact location_ box
- Click the **Review + create** button

::: zone-end

### Review + create

After the build validates, you can continue to create the application.

- Click the **Create** button
- Once the deployment is complete, click the **Go to resource** button

## View website

There are two automated aspects to deploying a static web app. The first aspect provisions the underlying Azure resources that make up your app. The second aspect is a GitHub Actions workflow that builds and publishes your application.

> [!NOTE]
> You can ensure that the GitHub Actions workflow is complete by checking the status of your commits available at `https://github.com/<YOUR_GITHUB_USERNAME>/my-first-static-web-app/actions`.

Once the provisioning and deployment is complete, you can click on the _URL_ link in the Azure portal to launch your app in the browser.

## Next steps

Your app is using mock data for its shopping list. Next, you'll explore the benefits and your motivation before creating an API.
