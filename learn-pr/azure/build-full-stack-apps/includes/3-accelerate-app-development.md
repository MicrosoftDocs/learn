
Azure Static Web Apps is a modern web app service that offers streamlined full-stack development from source code to global high availability.

Now that you've built the foundation for your application, it's time to think about the application. Recall in the catching the bus scenario, one part of the challenge is to create a website where users can go to review the real-time bus data of their monitored routes on a map. They also want to see the real-time buses in relation to where their geofence is so they can plan when to head to the bus stop. A geofence is a defined polygon on a map, and in this scenario, a geofence is an area surrounding where a user wants to catch the bus. This capability would allow them to not have to wait a long time for the bus or miss the bus, since they can track buses.

One possible solution that meets the requirements is to use Azure Static Web Apps. First, you need to learn about Azure Static Web Apps, and then you can evaluate why it's a good fit for this scenario.

## Deploy static web applications with API support using Azure Functions

Azure Static Web Apps has been selected as the best solution for the bus-catching scenario. Let's explore why.

### Build applications where server side rendering isn't required

Static web apps are commonly built using libraries and frameworks like Angular, React, Svelte, Vue, jQuery, or Blazor where server side rendering isn't required. These apps include HTML, CSS, JavaScript, and image assets that make up the application. With a traditional web server, these assets are served from a single server alongside any required API endpoints.

### Build applications that use serverless APIs

Azure Functions provides an easy, scalable way to deploy serverless APIs. Azure Functions supports building and debugging event-driven functions in Visual Studio Code, with CI/CD with GitHub Actions. Azure Functions can also scale automatically and only charge you for what is used.

### Combine static web application hosting and serverless APIs with Azure Static Web Apps

Azure Static Web Apps combines the power of static web apps with Azure Functions. This service enables you to accelerate application development with a static front end and dynamic back end powered by serverless APIs (Azure Functions). In addition, Azure Static Web Apps integrates GitHub-native workflows to build and deploy your app, plus unified hosting and management in the cloud.

## Create a solution for catching the bus using Azure Static Web Apps

To visualize geospatial data and project geofences and bus positions on a map, you'll need a static HTML page, and one possible solution is to use the well-known jQuery and the OpenLayers libraries. The static page will need to fetch data from a server-side REST API that will be provided by another Azure Function. As both the client and the back end are needed to make the visualization page work, Azure Static Web Apps is the perfect option to develop and deploy the end-to-end visualization solution.

### Deploy the solution using Azure Static Web Apps

Azure Static Web Apps can be deployed using Visual Studio Code, the Azure portal, and the Azure CLI. Regardless of deployment option, you must have an Azure account, a GitHub account, and an existing GitHub repository before you deploy.

If you use Visual Studio Code to deploy initially, the Azure Static Web Apps extension for Visual Studio Code makes it easy to configure, connect to GitHub and Azure, and deploy. You can also use the Azure portal, which will take you through a similar process. You'll sign in to GitHub and authorize Azure Static Web Apps to contribute to the repository. If you use the Azure CLI it's a similar process, except you use a GitHub personal access token to authorize Azure Static Web Apps. Authorization is required because the deployment process creates a YAML file that specifies the GitHub workflow for CI/CD with GitHub Actions. The GitHub workflow YAML file essentially contains the information on how to build and deploy your application as changes are pushed.

A typical generated workflow file could look similar to the following file. The workflow basically tells GitHub how to build your application. The main things that may differ among applications is where in the repository the application and function files are located, denoted by `app_location` and `api_location`.

```yml
name: Azure Static Web Apps CI/CD

on:
  push:
    branches:
      - main
  pull_request:
    types: [opened, synchronize, reopened, closed]
    branches:
      - main 

jobs:
  build_and_deploy_job:
    if: github.event_name == 'push' || (github.event_name == 'pull_request' && github.event.action != 'closed')
    runs-on: ubuntu-latest
    name: Build and Deploy Job
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true
      - name: Build And Deploy
        id: builddeploy
        uses: Azure/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
          repo_token: ${{ secrets.GITHUB_TOKEN }} # Used for Github integrations (i.e. PR comments)
          action: "upload"
          ###### Repository/Build Configurations - These values can be configured to match your app requirements. ######
          # For more information regarding Static Web App workflow configurations, please visit: https://aka.ms/swaworkflowconfig
          app_location: "azure-static-web-app/client" # App source code path
          api_location: "azure-static-web-app/api" # Api source code path - optional
          output_location: ".github/workflows" # Built app content directory - optional
          ###### End of Repository/Build Configurations ######

  close_pull_request_job:
    if: github.event_name == 'pull_request' && github.event.action == 'closed'
    runs-on: ubuntu-latest
    name: Close Pull Request Job
    steps:
      - name: Close Pull Request
        id: closepullrequest
        uses: Azure/static-web-apps-deploy@v1
        with:
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
          action: "close"
```

During deployment, not only is the GitHub workflow file created, the secrets you see in the file are also added to your repository's secrets. GitHub secrets are a way to securely store sensitive information that is needed by the application.
