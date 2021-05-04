## Scenario

Your company is launching a shopping list web app. Through the site, customers can add, edit, view, and remove items such as food and household needs from their list.

The site and APIs need to be secure to ensure customer privacy. Your users will be distributed all over the world, and you want everyone to get great performance. You’d prefer a solution that removes as much of the infrastructure work, including building and publishing, as possible so you can concentrate on features and user experience.

You could deploy your web assets to cloud storage, create, and assign your own SSL certificate, create your API on a cloud server, establish a reverse proxy that allows your app to make calls to the API, distribute the app globally, and set up your own CI/CD process.

When you use Azure Static Web Apps, you get all of this out of the box.

## What is Azure Static Web Apps?

Azure Static Web Apps solves the hard problems all the way from your source code to global availability.

While you stay focused on developing your app, Azure Static Web Apps automatically builds and hosts it from a GitHub repository.

Static web apps are commonly built using libraries and frameworks like Angular, React, Svelte, or Vue. These apps include HTML, CSS, JavaScript, and image assets that make up the application. When using a traditional web server architecture, these files are served from a single server along side any required API endpoints.

With Azure Static Web Apps, static assets are separated from a traditional web server and are instead served from points globally distributed around the world. This distribution makes serving files much faster as files are physically closer to users. API endpoints, which are optional, are hosted using a serverless architecture, which avoids the need for a full back-end server all together.

The model for Azure Static Web Apps is that you get exactly what you need, no more, no less.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview":::

> [!NOTE]
> Azure Static Web Apps is currently in preview.

When you create an Azure Static Web Apps resource, Azure sets up a GitHub Actions workflow in the app's source code repository. The workflow monitors a branch of your choice. Every time you push commits or create pull requests into the watched branch, the GitHub Action automatically builds and deploys your app and its API to Azure.

Azure hosts and serves your web app. Azure Functions powers back-end API functionality, which provides automatic scaling out and scaling in based on demand.

### Optional APIs

Azure Static Web Apps is ideal for serving purely static content, but it also has great support for static web apps that need APIs behind them. So you can host your static web app with or without an API.

In this module's exercises, you'll deploy an app using your preferred web framework.

> [!NOTE]
> You'll be deploying an app, without an API in this module. See the Next Steps section in the final unit for information about the next tutorial, where you'll deploy an API alongside your app.

### Key features

- **Globally distributed web hosting** puts static content like HTML, CSS, JavaScript, and images closer to your users
- **Integrated API** support provided by Azure Functions
- **First-party GitHub integration** where repository changes trigger builds and deployments
- **Free SSL certificates**, which are automatically renewed
- **Unique preview URLs** for previewing pull requests

## Learning objectives

In this tutorial, you'll create, modify, and deploy a web app to Azure Static Web Apps.

### Choose your own path

This tutorial provides four variations of the sample application for you to choose from: Angular, React, Svelte, and Vue. The power of Azure Static Web Apps is that all of these flavors "just work".

The starter code includes the four apps that you'll use.

```files
├ angular-app  👈 The Angular client app
├ react-app    👈 The React client app
├ svelte-app   👈 The Svelte client app
└ vue-app      👈 The Vue client app
```

### What you'll do

After you choose your client application, you'll:

- Build and run your front-end application.
- Automatically build and deploy your web app to Azure from a GitHub repository with GitHub Actions.
- Finally, you'll explore and launch your application, as follows.

::: zone pivot="angular"

:::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="A screenshot illustrating the angular sample application":::

::: zone-end

::: zone pivot="react"

:::image type="content" source="../media/my-shopping-list-app-react.png" alt-text="A screenshot illustrating the react sample application":::

::: zone-end

::: zone pivot="svelte"

:::image type="content" source="../media/my-shopping-list-app-svelte.png" alt-text="A screenshot illustrating the svelte sample application":::

::: zone-end

::: zone pivot="vue"

:::image type="content" source="../media/my-shopping-list-app-vue.png" alt-text="A screenshot illustrating the vue sample application":::

::: zone-end

## Next steps

About now, you might be thinking you need to create the Azure resources first, but Azure Static Web Apps has your daily workflow in mind. A more natural approach is to start with the code in GitHub first, before creating resources in Azure.
