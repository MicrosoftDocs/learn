In this exercise, you deploy Azure resources including a Microsoft Foundry AI model, Azure Container Registry (ACR), and Azure Kubernetes Service (AKS) cluster. You then complete Kubernetes manifest files to define container specifications, health probes, resource limits, and load balancing. After deploying the containerized API to AKS, you use a Python client application to test the deployed API endpoints including health checks, readiness validation, and AI model inference requests.

Tasks performed in this exercise:

- Download the project starter files
- Deploy resources to Azure
- Complete the *deployment.yaml* and *service.yaml* files and deploy the container to AKS
- Run the client app to test the API

This exercise takes approximately **30-40** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest).
- The Kubernetes command-line tool, [kubectl](https://kubernetes.io/docs/tasks/tools/).

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2345722" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>