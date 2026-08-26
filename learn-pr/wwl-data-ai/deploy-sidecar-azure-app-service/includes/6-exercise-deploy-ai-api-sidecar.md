In this exercise, you deploy a Python chat API as the main App Service container and a local model server as a sidecar. The deployment script builds both images in Azure Container Registry. A separate Flask client runs on your development computer and calls the public chat API. You configure managed-identity image pulls, `localhost` communication, a shared temporary volume, and container-specific diagnostics.

Tasks performed in this exercise:

- Download the project starter files
- Deploy Azure Container Registry and build the chat API and model-server images using ACR Tasks
- Deploy an App Service plan and a sidecar-enabled web app with managed-identity image pulls
- Define and apply the main and sidecar container configuration
- Verify model-sidecar readiness and shared-volume access
- Configure the Python environment for the local Flask client
- Run the chat client and test end-to-end model inference

This exercise takes approximately **30** minutes to complete.

> [!IMPORTANT]
> Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a pay-as-you-go, or another paid plan.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli).
- [Python 3.12](https://www.python.org/downloads/) or greater.

## Get started

When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

Select the button to launch the exercise and follow the instructions.

<a href="https://go.microsoft.com/fwlink/?linkid=2377304" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
