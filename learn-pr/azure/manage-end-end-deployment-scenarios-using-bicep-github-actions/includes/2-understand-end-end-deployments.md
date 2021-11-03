Workflows are flexible tools that you can configure in many different ways to suit your needs. In this unit, you'll learn about how workflows can be used to deploy an entire solution, including configuring the Azure infrastructure as well as performing other deployment operations.

## How many workflows?

In some organizations, the team that manages the Azure environment is different to the team that develops the code that runs in the environment. In these situations, it's often tempting to create multiple workflows, each owned by the team holding responsibility for their particular area. For example, you might create one workflow to deploy the Bicep code that deploys your website's Azure resources, and another workflow that deploys the website application.

Although this might give you some flexibility in how you manage the workflows, it can be challenging to keep everything in sync. For example, suppose your website team needs a new setting on their App Service app to enable a feature they're building. The application deployment workflow can't run until the infrastructure deployment workflow has completed successfully. Also, it can become complicated to send data between the workflows, like the names of Azure resources created by your infrastructure workflow.

Instead, it's often better to create a single workflow that deploys everything required for your solution, even if the components are managed by different people or different teams. You can use tools like Git and GitHub to coordinate your work. When a new feature is added, you can use a branch to make the necessary changes to your Bicep file. And when the change is ready to be integrated and released, a single workflow performs all of the steps necessary to build and deploy the solution, which reduces the chance of things getting out of sync.

## Control plane and data plane

Many Azure resources provide two different *planes* for access. The *control plane* deploys and configures the resource. The *data plane* enables you to access the resource's functionality.

When you create and deploy Bicep files, you interact with the control plane. In Azure, the control plane is Azure Resource Manager. You use Resource Manager to define the configuration of each of your resources.

But your workflow often needs to do more than just interact with the control plane. For example, you might need to:

- Upload a blob to a storage account.
- Modify a database schema.
- Make an API call to a third-party service.
- Trigger the update of a machine learning model.
- Deploy a website to an Azure App Service app.
- Deploy software to a virtual machine.
- Register a DNS entry with a third-party provider.

When we consider an end-to-end workflow, we typically need to deploy our Azure resources, and then perform a series of operations against the data planes of those resources. Sometimes, these are called the *last mile* of the deployment, because the majority of the deployment happens by using the control plane and there's a small amount of configuration remaining.

> [!NOTE]
> There are also some resources that don't have a clear division between their control plane and data plane. These include Azure Data Factory and Azure API Management. Both services support fully automated deployments by using Bicep, but they require special considerations. We link to more information in the summary.

## How to perform data plane operations

When you create a deployment workflow that interacts with the data plane of your resources, there are three common approaches: Resource Manager deployment scripts, workflow scripts, and workflow tasks.

Resource Manager deployment scripts are defined within your Bicep file. They run Bash or PowerShell scripts, and they can interact with the Azure CLI and Azure PowerShell cmdlets. A deployment script uses a managed identity to authenticate to Azure, and Azure automatically provisions and manages the resources it needs to run the deployment script.

Deployment scripts are good when you need to run a simple script within your deployment process. However, they don't easily provide you with access to other elements from your workflow.

You can also run your own logic from within a deployment workflow. GitHub Actions provides a rich ecosystem of *actions* for common things you need to do. If you can't find an action that meets your needs, you can use a *script* to run your own Bash or PowerShell code. Workflow actions and scripts run from your workflow's runner. You often need to authenticate the task or script to the data plane of the service you're using, and the way that you do this depends on the service.

Workflow tasks and scripts provide you with flexibility and control. They also enable you to access *workflow artifacts*, which you'll learn about soon. In this module, we focus on workflow scripts and actions. To learn more about Resource Manager deployment scripts, see [Extend ARM templates by using deployment scripts](xref:learn.azure.extend-resource-manager-template-deployment-scripts).

## Outputs

Typically, a workflow creates and configures your Azure resources by deploying a Bicep file. Then, the subsequent parts of the workflow interact with the data plane of those resources. To be able to interact with the resources, the workflow actions and steps need information about the Azure resource that was created.

For example, suppose you create a Bicep file that deploys a storage account. You want your workflow to deploy the storage account, and then uploads some blobs to a blob container in the storage account. The workflow task that uploads the blobs needs to know the name of storage account to connect to and the name of the blob container to upload the file to.

It's good practice for the Bicep file to decide on the names of your Azure resources. It might use parameters, variables, or expressions to create the names for the storage account and blob container. It can then expose an output that provides each resource's name. Later steps in the workflow can read the value of the output. That way, your workflow definition doesn't need to hard-code any names or other information that might change between environments or based on rules defined in your Bicep file.

GitHub Actions enables you to propagate the values of outputs by using *workflow variables*. The `azure/arm-deploy` action automatically creates variables for each of your Bicep deployment outputs. You can also manually create workflow variables in scripts. We link to more information in the summary.

When you access variables that were created in another job, you need to publish the variable to make it accessible to the job that reads it. For example, suppose you create a job that deploys a Bicep file, and you need to propagate the `appServiceAppName` output to your workflow. You use the `outputs` keyword to specify that the `appServiceAppName` workflow variable should be set to the value of the `appServiceAppName` output variable created by the `deploy` step:

:::code language="yaml" source="code/2-outputs-jobs.yml" range="8-25" highlight="3-4" :::

Then, in a later job, you create a dependency on the job that created the variable by including the `needs` keyword, and you refer to the variable by using the name of the published variable:

:::code language="yaml" source="code/2-outputs-jobs.yml" range="27-31" highlight="2, 5" :::

By using Bicep outputs and workflow variables, you can create a workflow that deploys your Bicep code and then performs a variety of actions on the resources as part of your deployment.
