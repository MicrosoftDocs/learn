Your company is launching a shopping list web app. Through the site, customers can add, edit, view, and remove items from their list.

As you build the app, your first concerns are that your app and API are hosted securely, are globally available, and published automatically. Rather than build up a web server to handle all these concerns, you decide to use a hosting solution that serves your assets and API easily, without much setup or configuration.

## What is Azure Static Web Apps?

Azure Static Web Apps solves the hard problems all the way from your source code to global availability.

While you stay focused on developing your app, Azure Static Web Apps automatically builds and hosts it from a GitHub repository.

Static web apps are commonly built using WebAssembly frameworks such as Blazor, as well as JavaScript frameworks and libraries. These apps include HTML, CSS, JavaScript, and image assets that make up the application. Under a traditional web server architecture, these files are served from a single server along side any required API endpoints.

With Azure Static Web Apps, static assets are separated from a traditional web server and are instead served from points globally distributed around the world. This distribution makes serving files much faster as files are physically closer to end users. API endpoints are hosted using a serverless architecture, which avoids the need for a full back-end server all together.

The model for Azure Static Web Apps is that you get exactly what you need, no more, no less.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview":::

> [!NOTE]
> Azure Static Web Apps is currently in preview.

When you create an Azure Static Web Apps resource, Azure sets up a GitHub Actions workflow in the app's source code repository that monitors a branch of your choice. Every time you push commits or create pull requests into the watched branch, the GitHub Action automatically builds and deploys your app and its API to Azure.

Azure hosts and serves your web app while Azure Functions powers back-end API functionality, which provides automatic scaling out and scaling in based on demand to the API.

### Key features

- **Globally distributed web hosting** puts static content like HTML, CSS, JavaScript, and images closer to your users
- **Integrated API** support provided by Azure Functions
- **First-party GitHub integration** where repository changes trigger builds and deployments
- **Free SSL certificates**, which are automatically renewed
- **Unique preview URLs** for previewing pull requests

## Learning objectives

In this tutorial, you'll create, modify, and deploy a web app and API to Azure Static Web Apps.

This tutorial provides a sample Blazor application, as well as an API written in C#.

### What you'll do

Once you choose your client application, you'll:

1. Build and run your Blazor application
1. Create your API with Azure Functions
1. Modify your web app to make HTTP requests to your API
1. Automatically build and deploy your web app to Azure from a GitHub repository with GitHub Actions
1. Finally, you'll explore and launch your application, as shown below

:::image type="content" source="../media/my-shopping-list-app.png" alt-text="A set of four screenshots illustrating the four sample applications":::

## Next steps

Right about now you might be thinking you need to create the Azure resources first, but Azure Static Web Apps has your daily workflow in mind. A more natural approach is to start with the code in GitHub first, before creating resources in Azure.
