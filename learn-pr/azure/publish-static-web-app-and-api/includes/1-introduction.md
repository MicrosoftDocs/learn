Your company is launching a shopping list web app. Customers can add, edit, view, and remove items from their personal shopping list in the app. Your app and API must be hosted securely, be globally available, and publish automatically.

You don't need a web server that runs code. You do need a hosting solution that serves your assets and API easily, without much setup or configuration.

## What is Azure Static Web Apps?

Azure Static Web Apps solves the hard problems all the way from your source code to global availability.

You focus on developing your app, and Azure Static Web Apps automatically builds and hosts full-stack web apps from a GitHub repository.

Static web apps are commonly built using Angular, React, Svelte, or Vue. You serve the static assets fast without a full back-end web server. You can host your API endpoints in a serverless architecture, again avoiding a full back-end server. The model for Azure Static Web Apps is that you get exactly what you need, no more, no less.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview":::

> [!NOTE]
> Azure Static Web Apps is currently in preview.

When you create an Azure Static Web App, Azure creates a GitHub Actions workflow in the repository containing your app's code. The workflow starts by building your app. Then the workflow deploys your app to Azure every time you accept a pull request or push new code to a branch.

Azure host and serves your static web app while Azure Functions powers back-end API functionality, which provides automatic scaling out and scaling in based on demand to the API.

### Key features

- **Globally distributed web hosting** putting static content like HTML, CSS, JavaScript, and images closer to your users.
- **Integrated API** support provided by Azure Functions.
- **First-party GitHub integration** where repository changes trigger builds and deployments.
- **Free SSL certificates**, which are automatically renewed.
- **Unique URLs**, for branches and pull requests

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

Right about now you might be thinking you need to create the Azure resources first. But a more natural workflow for you is to start with an app. Azure Static Web Apps has your use case in mind. You'll start with an app locally and in GitHub, before creating resources in Azure.
