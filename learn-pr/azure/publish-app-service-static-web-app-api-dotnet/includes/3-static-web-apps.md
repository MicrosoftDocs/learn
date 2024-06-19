Your ultimate goal is to host your app in Azure. Azure Static Web Apps takes care of provisioning all the necessary Azure resources for you.

However, before your app can be hosted, you need something to build your app as you make changes. Those changes could be via commits or pull requests to your repository. A key feature of Azure Static Web Apps is that it sets up a GitHub Actions workflow to build and publish your application.

When you create the Azure Static Web Apps resource, it creates the GitHub Actions workflow. The workflow is triggered immediately and takes care of building and publishing your app. The workflow is also triggered every time you make a change to the watched branch in your repository.

## Azure Static Web Apps

There are two automated aspects to deploying a web app. The first provisions the underlying Azure resources that make up your app. The second is a GitHub Actions workflow that builds and publishes your application.

When you publish your app to the web with Azure Static Web Apps, you're getting fast hosting of your web app and scalable APIs. You're also getting a unified build and deployment workflow provided by GitHub Actions.

### Connect your Static Web Apps instance to GitHub

Azure Static Web Apps is designed to host applications while the source code lives on GitHub. When you create a Static Web Apps instance, you sign in to GitHub and specify the repository containing your app's code.

You also need to specify three folder paths within your repository so your app can be automatically built and deployed:

| Location              | Location example | Description                                                               | Required |
| --------------------- | ---------------- | ------------------------------------------------------------------------- | -------- |
| App location          | Client          | The location of the source code for your web app                          | Yes      |
| Output location       | wwwroot          | The location of your app's build artifacts                    | No       |
| API location          | Api             | The location of the source code for your API                          | No       |

The **Output location** is a relative path to the publish directory of your application. For example, consider we have an app at `Client` that outputs its built assets to a `bin/<build profile>/<framework>/publish/wwwroot` folder. In this case, you only need to specify `wwwroot` for this location, as the publish system takes care of the rest of the prefix.

### From source code to static assets with GitHub Actions

Your GitHub repo contains source code, not static assets, so it needs to be built before it can be published.

When you create a Static Web Apps instance, Azure creates a GitHub Actions workflow in your repository. Every time you push changes or create a pull request against the branch you release from, the workflow builds your app. This process turns your source code into static assets that Azure serves. After the build is complete, the action deploys the assets.

The GitHub Action is added to your repository in the *.github/workflows* folder. You can review or modify this file as needed. The settings you enter when you create the resource are stored in the GitHub Action's file.

### Integrated API with Azure Functions

If your app requires an API, you can implement it as an Azure Functions project in your repository, and your Static Web Apps instance automatically deploys and hosts it. The GitHub Actions workflow that builds and deploys your app, locates the API within your repo using the name of the folder you specified in the *API location* path.

What if you don't have an API? Don't worry. If Azure Static Web Apps can't find an API in the folder you indicate, it doesn't publish an API, but it still publishes your app.

## Next steps

What do you need so you can publish your web app to Azure Static Web Apps? All you need is your app in your GitHub repository.
