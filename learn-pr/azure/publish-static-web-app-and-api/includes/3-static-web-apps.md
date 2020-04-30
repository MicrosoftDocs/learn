Your ultimate goal is to host your app in Azure. Azure Static Web Apps takes care of provisioning all the necessary Azure resources for you.

However, before you app can be hosted, you need something to build your app as you make changes. Those changes could be via commits or pull requests to your repository. A key feature of Azure Static Web Apps is that is sets up a GitHub Action to build and publish your application.

## Azure Static Web Apps

There are two automated aspects to deploying a web app. The first provisions the underlying Azure resources that make up your app. The second is a GitHub Actions workflow that builds and publishes your application.

When you publish your app to the web with Azure Static Web Apps, you're getting fast hosting of your web app and scalable APIs. You're also getting a unified build and deployment workflow provided by GitHub Actions.

### Connecting your Static Web Apps instance to GitHub

Azure Static Web Apps is specifically designed to host applications where the source code lives on GitHub. When you create a Static Web Apps instance, you'll sign in to GitHub and specify the repository containing your app's code. 

You also need to specify three folder paths within your repository so your app can be automatically built and deployed:

| Location              | Location example | Description                                                           | Required |
| --------------------- | ---------------- | --------------------------------------------------------------------- | ------ |
| App location          | /                | Source code for your web app                                          | Yes |
| App artifact location | dist             | Location of your app's build artifacts, relative to your app location | No |
| API location          | api              | Source code for your API                                    | No |

The **App artifact location** is a relative path to the build output directory of your application. For example, consider we have an app at `/` that outputs its built assets to a `dist` folder. In this case, you specify `dist` for this location.

### From source code to static assets with GitHub Actions

Your GitHub repo contains source code, not static assets, and so it needs to be built before it can be published.

When you create a Static Web Apps instance, Azure creates a GitHub Action in your repository. This action performs the build, which turns your source code into static assets that can be served by Azure. Once the build is complete, then the action deploys the assets.

The GitHub Action is added to your repository in the _.github/workflows_ folder. You can review or modify this file as needed. The settings you enter when you create the resource are stored in the GitHub Action's file.

### Integrated API with Azure Functions

If your app requires an API, you can implement it as an Azure Functions project in your repository, which is automatically deployed and hosted by your Static Web Apps instance. The GitHub Action that performs the build and deployment locates the API within your repo by the name of the folder you designate.

Typically you put the API app in a folder named _api_ or _functions_, but you can name it whatever you prefer.

What if you don't have an API? Don't worry. If Azure Static Web Apps can't find an API in the folder you indicate, it won't publish an API.

## Next steps

So what do you need so you can publish your web app to Azure Static Web Apps? All you need is your app in your GitHub repository.
