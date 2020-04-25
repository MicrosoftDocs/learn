You want your app to be hosted in Azure. Azure Static Web Apps will provision the Azure resources that make up your app.

However, before your app can be hosted, your app must be pulled from GitHub and built. So you'll need something that will build your app when you make changes via commits and pull requests to your repository. Azure Static Web Apps sets up a GitHub Action that'll build and publish your application.

## Key components

When you publish your app to the web with Azure Static Web Apps, you're getting fast hosting of your static assets and scalable APIs. You're also getting a single unified workflow provided by GitHub Actions.

The key ingredients to create an Azure Static Web App are:

1. Create an Azure Static Web App resource
1. Connect to your GitHub repository and branch
1. Identify the folder locations for your:
   - source code for your web app
   - build artifacts
   - source code for your API

## Next steps

So what do you need to publish your web app to Azure Static Web Apps? Simply put, all you need is your app in your GitHub repository.
