In this exercise, you troubleshoot a failing container app and apply targeted fixes. You use revision status, logs, and the Azure CLI to isolate deployment issues. This workflow is common in AI solutions because startup behavior changes frequently when you update models and dependencies.

Tasks performed in this exercise:

- Deploy a mock AI document processing API as a container app
- Introduce and diagnose a missing environment variable error
- Introduce and diagnose an ingress configuration issue
- Query Log Analytics for historical troubleshooting data

This exercise takes approximately **30** minutes to complete.

> [!IMPORTANT]
> Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a Pay-As-You-Go, or another paid plan.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- Optional: [Python 3.12](https://www.python.org/downloads/) or greater.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2348400" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
