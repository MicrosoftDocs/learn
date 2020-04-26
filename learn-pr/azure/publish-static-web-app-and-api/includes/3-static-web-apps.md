You want your app to be hosted in Azure. Azure Static Web Apps will provision the Azure resources that to host your app.

However, before your app can be hosted, you'll need something that will build your app when you make changes. Those changes could be via commits or pull requests to your repository. Azure Static Web Apps sets up a GitHub Action that will build and publish your application.

## Key components

When you publish your app to the web with Azure Static Web Apps, you're getting fast hosting of your static assets and scalable APIs. You're also getting a unified workflow provided by GitHub Actions.

The key ingredients to create an Azure Static Web App are:

1. Create an Azure Static Web App resource
1. Connect to your GitHub repository and branch
1. Identify the folder locations

| Location example | Description                  |
| ---------------- | ---------------------------- |
| /                | Source code for your web app |
| api              | Source code for your API     |
| public           | Build artifacts              |

## Next steps

So what do you need so you can publish your web app to Azure Static Web Apps? All you need is your app in your GitHub repository.
