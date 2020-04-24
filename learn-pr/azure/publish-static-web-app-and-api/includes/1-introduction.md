Your company is launching a shopping list website that helps customers add, edit, view, and remove items from their personal shopping list. You need to host the app and an API, keep it secure with SSL, be globally available, and have it automatically re-deploy with continuous deployment.

Azure Static Web Apps deals with the hard problems all the way from your source code to global availability. You can focus on building a better app to differentiate your business.​

## Learning objectives

In this tutorial, you will create and deploy an app to Azure Static Web Apps.

You prefer to develop with your JavaScript framework or library of choice. That's why there are four variations of the client application for you to choose from.

- Angular
- React
- Svelte
- Vue

Once you choose your client application, you'll:

1. Build and run your front-end application
1. Create your API with Azure Functions
1. Automatically build and deploy your web app to Azure from a GitHub repository with GitHub Actions
1. Finally, you'll explore and launch your application, as shown below

[TODO] - Replace image with a 4 panel image of angular, react svelte, and vue

:::image type="content" source="../media/my-shopping-list-app.png" alt-text="My Shopping List sample application":::

## What is Azure Static Web Apps (Preview)?

Azure Static Web Apps is a service that automatically builds and deploys web apps to Azure from a GitHub repository.

:::image type="content" source="../media/static-web-apps-overview.png" alt-text="Static Apps overview":::

Applying commits and pull requests to a designated branch triggers a GitHub Action workflow. The workflow builds the application for production and globally deploys the app to the web.

Back-end API functionality is powered by Azure Functions which provides automatic scaling (up and down) based on demand to the API.

## Key features

- **Free web hosting** for static content like HTML, CSS, JavaScript, and images.
- **Free API** support provided by Azure Functions.
- **First-party GitHub integration** where repository changes trigger builds and deployments.
- **Globally distributed** static content, putting content closer to your users.
- **Free SSL certificates**, which are automatically renewed.

## Next steps

Right about now you might be thinking that you need to create the Azure resources first. But is that really natural for you? You probably already have an app in mind that you work on. A more natural workflow could be to start with an app. Azure Static Web Apps has your use case in mind. You'll start with an app locally and in GitHub.

Next, you'll create the app and the GitHub repository.
