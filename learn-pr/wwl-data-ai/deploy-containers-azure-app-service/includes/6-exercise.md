In this exercise, you learn to deploy a Linux container image from Azure Container Registry (ACR) to Azure App Service. You configure the web app to use a system-assigned managed identity and the **AcrPull** role so App Service can pull images from your private registry without storing registry credentials in app settings.

Tasks performed in this exercise:

- Download the project starter files
- Deploy Azure Container Registry and build a container image using ACR Tasks
- Deploy an App Service plan for Linux containers
- Create and configure a Web App for Containers to pull from ACR using managed identity
- Configure runtime settings and enable container logging
- Verify the deployment and test the document processing endpoint

This exercise takes approximately **30** minutes to complete.

> [!IMPORTANT]
> Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a pay-as-you-go, or another paid plan.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest).
- Optional: [Python 3.12](https://www.python.org/downloads/) or greater.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2347415" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
