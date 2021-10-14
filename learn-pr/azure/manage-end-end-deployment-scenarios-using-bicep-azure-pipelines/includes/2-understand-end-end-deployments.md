Pipelines are flexible tools that you can configure in many different ways to suit your needs. In this unit, you'll learn about how pipelines can be used to deploy an entire solution, including configuring the Azure infrastructure as well as performing other deployment operations.

## How many pipelines?

In some organizations, the team that manages the Azure environment is different to the team that develops the code that runs in the environment. In these situations, it's often tempting to create multiple pipelines, each owned by the team holding responsibility for their particular area. For example, you might create one pipeline to deploy the Bicep code that deploys your website's Azure resources, and another pipeline that deploys the website application.

Although this might give you some flexibility in how you manage the pipelines, it can be challenging to keep everything in sync. For example, suppose your website team needs a new setting on their App Service app to enable a feature they're building. The application deployment pipeline can't run until the infrastructure deployment pipeline has completed successfully. Also, it can become complicated to send data between the pipelines, like the names of Azure resources created by your infrastructure pipeline.

Instead, it's often better to create a single pipeline that deploys everything required for your solution, even if the components are managed by different people or different teams. You can use tools like Git and Azure DevOps to coordinate your work. When a new feature is added, you can use a branch to make the necessary changes to your Bicep file. And when the change is ready to be integrated and released, a single pipeline performs all of the steps necessary to build and deploy the solution, which reduces the chance of things getting out of sync.

## Control plane and data plane

Many Azure resources provide two different *planes* for access. The *control plane* deploys and configures the resource. The *data plane* enables you to access the resource's functionality.

When you create and deploy Bicep files, you interact with the control plane. In Azure, the control plane is Azure Resource Manager. You use Resource Manager to define the configuration of each of your resources.

But your pipeline often needs to do more than just interact with the control plane. For example, you might need to:

- Upload a blob to a storage account.
- Modify a database schema.
- Make an API call to a third-party service.
- Trigger the update of a machine learning model.
- Deploy a website to an Azure App Service app.
- Deploy software to a virtual machine.
- Register a DNS entry with a third-party provider.

When we consider an end-to-end pipeline, we typically need to deploy our Azure resources, and then perform a series of operations against the data planes of those resources. Sometimes, these are called the *last mile* of the deployment, because the majority of the deployment happens by using the control plane and there's a small amount of configuration remaining.

> [!NOTE]
> There are also some resources that don't have a clear division between their control plane and data plane. These include Azure Data Factory and Azure API Management. Both services support fully automated deployments by using Bicep, but they require special considerations. We link to more information in the summary.

## How to perform data plane operations

When you create a deployment pipeline that interacts with the data plane of your resources, there are three common approaches: Resource Manager deployment scripts, pipeline scripts, and pipeline tasks.

Resource Manager deployment scripts are defined within your Bicep file. They run Bash or PowerShell scripts, and they can interact with the Azure CLI and Azure PowerShell cmdlets. A deployment script uses a managed identity to authenticate to Azure, and Azure automatically provisions and manages the resources it needs to run the deployment script.

Deployment scripts are good when you need to run a simple script within your deployment process. However, they don't easily provide you with access to other elements from your pipeline.

You can also run your own logic from within a deployment pipeline. Azure Pipelines provides a rich ecosystem of *tasks* for common things you need to do. If you can't find a task that meets your needs, you can use a *script* to run your own Bash or PowerShell code. Pipeline tasks and scripts run from your pipeline's agent. You often need to authenticate the task or script to the data plane of the service you're using, and the way that you do this depends on the service.

Pipeline tasks and scripts provide you with flexibility and control. They also enable you to access *pipeline artifacts*, which you'll learn about soon. In this module, we focus on pipeline scripts and tasks. To learn more about Resource Manager deployment scripts, see [Extend ARM templates by using deployment scripts](xref:learn.azure.extend-resource-manager-template-deployment-scripts).

## Outputs

Typically, a pipeline creates and configures your Azure resources by deploying a Bicep file. Then, the subsequent parts of the pipeline interact with the data plane of those resources. To be able to interact with the resources, the pipeline tasks and steps need information about the Azure resource that was created.

For example, suppose you create a Bicep file that deploys a storage account. You want your pipeline to deploy the storage account, and then uploads some blobs to a blob container in the storage account. The pipeline task that uploads the blobs needs to know the name of storage account to connect to and the name of the blob container to upload the file to.

It's good practice for the Bicep file to decide on the names of your Azure resources. It might use parameters, variables, or expressions to create the names for the storage account and blob container. It can then expose an output that provides each resource's name. Later steps in the pipeline can read the value of the output. That way, your pipeline definition doesn't need to hard-code any names or other information that might change between environments or based on rules defined in your Bicep file.

Azure Pipelines enables you to propagate the values of outputs by using *pipeline variables*. You can set the value of a pipeline variable within a pipeline script. You use a specially formatted log output that Azure Pipelines understands how to interpret:

:::code language="yaml" source="code/2-outputs-jobs.yml" highlight="8, 13" :::

When you access variables that were created in another job in the same stage, you need to *map* the variable to make it accessible to the job that reads it:

:::code language="yaml" source="code/2-outputs-stages.yml" range="1-18" highlight="13-14" :::

You can access variables across pipeline stages, too. You also need to map the variable, but you use a slightly different syntax:

:::code language="yaml" source="code/2-outputs-stages.yml" highlight="24-25" :::

By using Bicep outputs and pipeline variables, you can create a multistage pipeline that deploys your Bicep code and then performs a variety of actions on the resources as part of your deployment.
