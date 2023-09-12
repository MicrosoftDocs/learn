
By completing this exercise you will:

- Create a new Azure Static Web App resource in your subscription together with your application skeleton based on the React Javascript framework, using the Azure Static Web Apps Visual Studio Code extension.
- Build a CI/CD pipeline to deploy your React application on Azure, using Azure Static Web Apps service and [Github actions](https://github.com/features/actions). Automatizing the deployment process is one of the key best practice reccommended by the [DevOps guidelines](https://learn.microsoft.com/devops/what-is-devops?WT.mc_id=academic-105496-cacaste), to catch bugs early and to ensure that your app is always up-to-date.

## Specification

Azure Static Web App publishes a website by building an app from a code repository. Create a new GitHub repository using a [template](https://github.com/new?template_name=react-basic&template_owner=staticwebdev) that includes a sample React application. Name it 'analyze-and-generate-images-with-Azure-AI' and clone it locally.
Open the cloned repo in Visual Studio Code and use the Azure Static Web Apps extension to create a new Azure resource in your subscription connected with that GitHub repo, using 'React' as build preset.

## Check your work

To validate that you succesfully created your React application and deployed it to an Azure Static Web App, open the URL of your app in a browser.

1. Retrieve the url by clicking on the Azure icon in the Visual Studio Code menu, right-clicking the recently deployed resources and selecting 'Browse site'. Another option is to open the Azure portal, navigate to your resource and click on the 'URL' link in the 'Overview' section.
2. You should see a web page with a 'Hello World' message.
