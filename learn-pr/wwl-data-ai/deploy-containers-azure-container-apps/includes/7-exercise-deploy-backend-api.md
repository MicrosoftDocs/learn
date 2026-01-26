In this exercise, you deploy a containerized backend API that represents an AI document-processing service. You use a private registry for the image, configure secrets and environment variables, and verify the deployment using logs and revision status. The goal is to practice an end-to-end workflow that you can adapt for real AI services.

In this exercise, you deploy a containerized backend API to Azure Container Apps. You use a managed identity to securely pull images from Azure Container Registry and configure secrets as environment variables.

Tasks performed in this exercise:

- Download the project starter files and deploy Azure services
- Deploy the container app with managed identity authentication
- Configure secrets and reference them from environment variables
- Verify the deployment by calling API endpoints and reviewing logs

This exercise takes approximately **30** minutes to complete.

>**Important:** Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a Pay-As-You-Go, or another paid plan.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](cli/azure/install-azure-cli?view=azure-cli-latest).
- Optional - [Python 3.12](https://www.python.org/downloads/) or greater.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2348000" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
