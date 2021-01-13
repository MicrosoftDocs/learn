Your ultimate goal is to host your app in Azure. Azure Static Web Apps takes care of provisioning all the necessary Azure resources for you.

However, before your app can be hosted, you need something to build your app as you make changes. Those changes could be via commits or pull requests to your repository. A key feature of Azure Static Web Apps is that it sets up a GitHub Actions workflow to build and publish your application.

When you create the Azure Static Web Apps resource, it creates the GitHub Actions workflow. The workflow is triggered immediately and takes care of building and publishing your app. The workflow is also triggered every time you make a change to the watched branch in your repository.

## Azure Static Web Apps

There are two automated aspects to deploying a web app. The first provisions the underlying Azure resources that make up your app. The second is a GitHub Actions workflow that builds and publishes your application.

When you publish your app to the web with Azure Static Web Apps, you're getting fast hosting of your web app and scalable APIs. You're also getting a unified build and deployment workflow provided by GitHub Actions.

### Connect your Static Web Apps instance to GitHub

Azure Static Web Apps is designed to host applications where the source code lives on GitHub. When you create a Static Web Apps instance, you'll sign in to GitHub and specify the repository containing your app's code.

You also need to specify three folder paths within your repository so your app can be automatically built and deployed:

| Location              | Location example | Description                                                               | Required |
| --------------------- | ---------------- | ------------------------------------------------------------------------- | -------- |
| App location          | /                | The location of the source code for your web app                          | Yes      |
| App artifact location | dist             | The location of your app's build artifacts, relative to your app location | No       |
| API location          | api              | The location of the source code for your API                              | No       |

The **App artifact location** is a relative path to the build output directory of your application. For example, consider we have an app at `my-app` that outputs its built assets to a `my-app/dist` folder. In this case, you specify `dist` for this location.

### From source code to static assets with GitHub Actions

Your GitHub repository contains source code, so it needs to be built before it can be published.

When you create a Static Web Apps instance, Azure creates a GitHub Actions workflow in your repository. The workflow builds your app every time you push changes or create a pull request against the branch you chose to track. This build process turns your source code into static assets, which are served by Azure. Once the build is complete, then the action deploys the assets.

The GitHub Action is added to your repository in the _.github/workflows_ folder. You can review or modify this file as needed. The settings you enter when you create the resource are stored in the GitHub Action's file.

### Integrated API with Azure Functions

If your app requires an API, you can implement it as an Azure Functions project in your repository. Your API will automatically deploy and be hosted by your Static Web Apps instance. The GitHub Actions workflow that builds and deploys your app locates the API within your repo by the name of the folder you specify.

Typically, you put the API app in a folder named _api_ or _functions_, but you can name it whatever you prefer.

What if you don't have an API? Don't worry. If Azure Static Web Apps can't find an API in the folder you indicate, it won't publish an API, but it will still publish your app.

### Handle fallback routes

There's a client-side route **/products** in your front-end application that displays a list of products for your shopping list. When you navigate to **/products** in your app by selecting the **Products** link, your browser's address bar will confirm that you're at **/products**. When you refresh the browser while on this page, you want the app to refresh and display the products once again. However, without a fallback route, you'll see a 404 error stating the page cannot be found.

You see a 404 error when you refresh the page because the browser sends a request to the hosting platform to serve **/products**. There's no page on the server named **products** to serve.

Fortunately, it's easy to resolve this by creating a fallback route. A fallback route is a route that matches all unmatched page requests to the server.

#### Configure a fallback route

Azure Static Web Apps supports custom routing rules defined in an optional _routes.json_ file located in the app's artifact folder. You can define a route in the **routes** array. A common fallback route configuration follows.

```json
{
  "routes": [
    {
      "route": "/*",
      "serve": "/index.html",
      "statusCode": 200
    }
  ]
}
```

| Setting    | Value         | Description                                                                 |
| ---------- | ------------- | --------------------------------------------------------------------------- |
| route      | `/*`          | The matching rule. The **/\*** is a wildcard route that matches all routes. |
| serve      | `/index.html` | The page to serve.                                                          |
| statusCode | 200           | The status code to return.                                                  |

## Route file location

Azure Static Web Apps expects your _routes.json_ file to be in the `output_location` by default. If your build process copies your _routes.json_ file to the `output_location`, then there is nothing else you need to do.

::: zone pivot="angular"

The _routes.json_ file for your application is located in the folder _angular-app/src/assets_

::: zone-end

::: zone pivot="react"

The _routes.json_ file is located in the folder _react-app/public_

::: zone-end

::: zone pivot="svelte"

The _routes.json_ file is located in the folder _svelte-app/public_

::: zone-end

::: zone pivot="vue"

The _routes.json_ file is located in the folder _vue-app/public_

::: zone-end

## Next steps

So what do you need so you can publish your web app to Azure Static Web Apps? All you need is your app in your GitHub repository.
