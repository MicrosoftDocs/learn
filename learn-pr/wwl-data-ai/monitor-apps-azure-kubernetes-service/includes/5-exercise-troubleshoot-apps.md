In this exercise, you deploy a containerized API to Azure Kubernetes Service (AKS) and then diagnose and resolve common Kubernetes issues. You use **kubectl** commands to identify problems, inspect pod status, check logs, and view events. You then use **kubectl edit** to fix misconfigurations including Service selector mismatches, missing environment variables, and invalid readiness probe paths.

Tasks performed in this exercise:

- Download the project starter files
- Deploy resources to Azure (Azure Container Registry, AKS cluster)
- Diagnose and resolve some common issues
- Clean up Azure resources

This exercise takes approximately **30** minutes to complete.

> [!IMPORTANT]
> Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a pay-as-you-go, or another paid plan.

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

<a href="https://go.microsoft.com/fwlink/?linkid=2346293" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>