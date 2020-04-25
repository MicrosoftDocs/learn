Your company is launching a shopping list website that helps customers add, edit, view, and remove items from their personal shopping list. Your app and an API must be hosted securely, globally available, and publish automatically with continuous deployment.

Your web app serves HTML, CSS, and JavaScript along with other static assets. Static web apps are commonly built using Angular, React, Svelte, or Vue. You can serve the static assets fast without the need for a full back-end web server. You can host your API endpoints in serverless architecture, again avoiding a full back-end server. This is the model for Azure Static Web Apps. You get exactly what you need, no more, no less. THere is no complicated server configuration to pay for or maintain. Azure Static Web Apps reduces configuration and adds value by automatically deploying from GitHub, global availability, and API hosting via Azure Functions.

Azure Static Web Apps deals with the hard problems all the way from your source code to global availability. You can focus on building a better app to differentiate your business.​

## What is Azure Static Web Apps (Preview)?

Azure Static Web Apps is a service that automatically builds and hosts static web apps from a GitHub repository.

> [!NOTE] Azure Static Web Apps is currently in preview.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview":::

A GitHub Action workflow is triggered when you apply commits and pull requests to a branch. The workflow builds the application for production and deploys a globally distributed app to the web.

Back-end API functionality is powered by Azure Functions, which provides automatic scaling (up and down) based on demand to the API.

## Key features

- **Globally distributed web hosting** for static content like HTML, CSS, JavaScript, and images.
- **Scalable API** with support provided by Azure Functions.
- **First-party GitHub integration** where repository changes trigger builds and deployments.
- **Globally distributed** static content, putting content closer to your users.
- **Free SSL certificates**, which are automatically renewed.
- **Staging URLs**, for branches and pull requests

## Learning objectives

In this tutorial, you'll create and deploy an app to Azure Static Web Apps.

You prefer to develop with your JavaScript framework or library of choice. That's why there are four variations of the client application for you to choose from to build your static web app. The power in Azure Static Web Apps is that all of these flavors "just work".

- Angular
- React
- Svelte
- Vue

Once you choose your client application, you'll:

1. Build and run your front-end application
1. Create your API with Azure Functions
1. Automatically build and deploy your web app to Azure from a GitHub repository with GitHub Actions
1. Finally, you'll explore and launch your application, as shown below

:::image type="content" source="../media/my-shopping-list-app.png" alt-text="My Shopping List sample application":::

## Next steps

Right about now you might be thinking you need to create the Azure resources first. But a more natural workflow for you would be to start with an app. Azure Static Web Apps has your use case in mind. You'll start with an app locally and in GitHub, before creating resources in Azure.

Next, you'll create the app and the GitHub repository.
