AI applications often experience unpredictable workloads—a surge in inference requests, batch jobs, or sudden spikes from an agent-based workflow. KEDA-based autoscaling in Azure Container Apps allows your workloads to scale to zero when idle (saving costs) and rapidly scale out when demand increases.

In this exercise, you deploy a mock agent API and configure autoscaling based on **HTTP concurrent requests**. You then generate concurrent load and observe how the app scales out and creates new revisions when configuration changes are applied.

Tasks performed in this exercise:

- Create Azure Container Registry and Container Apps resources
- Deploy a mock agent API container app
- Configure an HTTP concurrency scale rule using KEDA
- Generate concurrent requests to trigger scale-out and monitor replica count changes in real-time
- Configure scale rules using YAML

This exercise takes approximately **30** minutes to complete.

>**Important:** Azure Container Registry task runs are temporarily paused from Azure free credits. This exercise requires a Pay-As-You-Go, or another paid plan.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest).
- [Python 3.12](https://www.python.org/downloads/) or greater.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2348401" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
