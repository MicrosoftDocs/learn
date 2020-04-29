You want your app to be hosted in Azure. Azure Static Web Apps will provision the Azure resources that to host your app.

However, before your app can be hosted, you'll need something that will build your app when you make changes. Those changes could be via commits or pull requests to your repository. Azure Static Web Apps sets up a GitHub Action that will build and publish your application.

## Azure Static Web Apps

There are two automated aspects to deploying a static web app. The first aspect provisions the underlying Azure resources that make up your app. The second aspect is a GitHub Actions workflow that builds and publishes your application.

When you publish your app to the web with Azure Static Web Apps, you're getting fast hosting of your static web app and scalable APIs. You're also getting a unified build and deployment workflow provided by GitHub Actions.

### Key ingredients

The key ingredients to create an Azure Static Web App are:

1. Create an Azure Static Web App resource
1. Connect to your GitHub repository and branch
1. Identify the folder locations

| Location          | Location example | Description                         |
| ----------------- | ---------------- | ----------------------------------- |
| App location      | /                | Source code for your web app        |
| Artifact location | dist             | Build artifacts                     |
| API location      | api              | Source code for your API (optional) |

### From source code to static assets with GitHub Actions

You push your source code to your GitHub repo. Your GitHub repo contains source code, not static assets, and so it needs to be built before it can be published. The GitHub Action performs the build and turns your source code into static assets that can be served by Azure.

The first time your Azure Static Web Apps resource is created, it creates a GitHub Action. The GitHub Action is added to your repository in the _.github/workflows_ folder. You can review or modify this file as needed. The settings you enter when you create the resource are stored in the GitHub Action's file.

### Integrated API with Azure Functions

You can optionally have an API implemented as an Azure Functions project. You don't need to create an Azure Function app in Azure, instead it's built into your Azure Static Web App. Typically you put the API in a folder named _api_ or _functions_, but you can name it whatever you prefer.

What if you don't have an API? Don't worry. If Azure Static Web Apps can't find an API in the folder you indicate, it won't publish an API.

## Next steps

So what do you need so you can publish your web app to Azure Static Web Apps? All you need is your app in your GitHub repository.
