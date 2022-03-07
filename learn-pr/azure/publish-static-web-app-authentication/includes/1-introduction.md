Your company is launching a shopping list web app. Through the site, customers can add, edit, view, and remove items from their list.

As you build the app, your first concerns are that your app and API are hosted securely, are globally available, and published automatically. Rather than build up a web server to handle all these concerns, you decide to use a hosting solution that serves your assets and API easily, without much setup or configuration.

## What is Azure Static Web Apps?

Azure Static Web Apps solves the hard problems all the way from your source code to global availability.

While you stay focused on developing your app, Azure Static Web Apps automatically builds and hosts it from GitHub or Azure DevOps.

Static web apps are commonly built using libraries and frameworks like Angular, React, Svelte, or Vue. These apps include HTML, CSS, JavaScript, and image assets that make up the application. When using a traditional web server architecture, these files are served from a single server along side any required API endpoints.

With Azure Static Web Apps, static assets are separated from a traditional web server and are instead served from points globally distributed around the world. This distribution makes serving files much faster as files are physically closer to users. API endpoints, which are optional, are hosted using a serverless architecture, which avoids the need for a full back-end server altogether.

The model for Azure Static Web Apps is that you get exactly what you need - no more, no less.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview.":::

When you create an Azure Static Web Apps resource, Azure sets up a GitHub Actions or Azure DevOps workflow in the app's source code repository. The workflow monitors a branch of your choice. Every time you push commits or create pull requests into the watched branch, the workflow automatically builds and deploys your app and its API to Azure.

Azure hosts and serves your web app. Azure Functions powers back-end API functionality, which provides automatic scaling out and scaling in based on demand.

### Optional APIs

Azure Static Web Apps is ideal for serving purely static content, but it also has great support for static web apps that need APIs behind them. You can host your static web app with or without an API.

Azure hosts and serves your web app while Azure Functions powers back-end API functionality, which provides automatic scaling out and scaling in based on demand to the API.

### Key features

- **Globally distributed web hosting** puts static content like HTML, CSS, JavaScript, and images closer to your users.
- **Integrated API** support provided by Azure Functions.
- **First-class GitHub and Azure DevOps integration** where repository changes trigger builds and deployments.
- **Free SSL certificates**, which are automatically renewed.
- **Unique preview URLs** for previewing pull requests.
- **Built-in authentication** with multiple providers.

## Learning objectives

In this module, you'll create, modify, and deploy a web app and API with user authentication to Azure Static Web Apps.

### Choose your own path

This module provides four variations of the sample application for you to choose from: Angular, React, Svelte, and Vue. The power of Azure Static Web Apps is that all of these flavors "just work."

The starter code includes the four apps and the starting point for an API that you'll use.

```files
├ angular-app  👈 The Angular client app
├ api          👈 The API server app
├ react-app    👈 The React client app
├ svelte-app   👈 The Svelte client app
└ vue-app      👈 The Vue client app
```

### What you'll do

After you choose your client application, you'll:

- Automatically build and deploy your web app and API to Azure from a GitHub repository with GitHub Actions.
- Modify your web app to add login and logout buttons, and display information about the current logged in user.
- Modify your web app and API to block unauthenticated users and allow only specific authentication providers.
- Finally, you'll explore and launch your application, as follows.

::: zone pivot="angular"

:::image type="content" source="../media/my-shopping-list-app-auth-angular.png" alt-text="A screenshot illustrating the angular sample application.":::

::: zone-end

::: zone pivot="react"

:::image type="content" source="../media/my-shopping-list-app-auth-react.png" alt-text="A screenshot illustrating the react sample application.":::

::: zone-end

::: zone pivot="svelte"

:::image type="content" source="../media/my-shopping-list-app-auth-svelte.png" alt-text="A screenshot illustrating the svelte sample application.":::

::: zone-end

::: zone pivot="vue"

:::image type="content" source="../media/my-shopping-list-app-auth-vue.png" alt-text="A screenshot illustrating the vue sample application.":::

::: zone-end

## Next steps

Right about now, you might be thinking you need to create the Azure resources first, but Azure Static Web Apps has your daily workflow in mind. A more natural approach is to start with the code in GitHub first, before creating resources in Azure.
