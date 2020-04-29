Your company is launching a shopping list web app. Through the site, customers can add, edit, view, and remove items from their list.

As you build the app, your first concerns are that your app and API are hosted securely, globally available, and publish automatically. Rather than build up a web server to handle all these concerns, you decide to use a hosting solution that serves your assets and API easily, without much setup or configuration.

## What is Azure Static Web Apps?

Azure Static Web Apps solves the hard problems all the way from your source code to global availability.

While you stay focused on developing your app, Azure Static Web Apps automatically builds and hosts full-stack web apps from a GitHub repository.

Static web apps are commonly built using libraries and frameworks like Angular, React, Svelte, or Vue. These apps include HTML, CSS, JavaScript, and image assets that make up the application. Under a traditional web server architecture, these files are served from a single server along side any required API endpoints.

In a Static Web Apps site, static assets are separated from a traditional web server and are instead served from points geographically distributed around the world. This distribution makes serving files much faster as files are physically closer to end users. API endpoints are hosted using a serverless architecture, which avoids the need for a full back-end server all together.

The model for Azure Static Web Apps is that you get exactly what you need, no more, no less.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview":::

> [!NOTE]
> Azure Static Web Apps is currently in preview.

When you create a new app, the Static Web Apps service is set to watch a branch in the repo for changes. The service also creates a GitHub Actions workflow file in the app repository, which contains configuration settings for the build action.

Every time you push commits or accept pull requests into the watched branch, the GitHub Action starts up and your site is automatically built and deployed.

Azure host and serves your static web app while Azure Functions powers back-end API functionality, which provides automatic scaling out and scaling in based on demand to the API.

### Key features

- **Globally distributed web hosting** putting static content like HTML, CSS, JavaScript, and images closer to your users.
- **Integrated API** support provided by Azure Functions.
- **First-party GitHub integration** where repository changes trigger builds and deployments.
- **Free SSL certificates**, which are automatically renewed.
- **Unique preview URLs**, for pull requests

## Learning objectives

In this tutorial, you'll create, modify, and deploy a web app and API to Azure Static Web Apps.

### Choose your own path

This tutorial provides four variations of the sample application for you to choose from: Angular, React, Svelte, and Vue. The power of Azure Static Web Apps is that all of these flavors "just work".

### What you'll do

Once you choose your client application, you'll:

1. Build and run your front-end application
1. Create your API with Azure Functions
1. Modify your web app to make HTTP requests to your API
1. Automatically build and deploy your web app to Azure from a GitHub repository with GitHub Actions
1. Finally, you'll explore and launch your application, as shown below

:::image type="content" source="../media/my-shopping-list-app.png" alt-text="My Shopping List sample application":::

## Next steps

Right about now you might be thinking you need to create the Azure resources first, but Azure Static Web Apps has your daily workflow in mind. A more natural approach is to start with the code in GitHub first, before creating resources in Azure.
