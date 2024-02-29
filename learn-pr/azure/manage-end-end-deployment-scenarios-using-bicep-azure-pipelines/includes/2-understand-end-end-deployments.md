Pipelines are flexible tools that you can configure in many different ways to suit your needs. In this unit, you learn how to use pipelines to deploy an entire solution, including configuring the Azure infrastructure, and how to perform other deployment operations.

## How many pipelines?

In some organizations, the team that manages the Azure environment is different from the team that develops the code that runs in the environment. In these situations, it's often tempting to create multiple pipelines, each owned by the team that's responsible for its particular area. For example, you might create one pipeline to deploy the Bicep code that deploys your website's Azure resources, and another pipeline that deploys the website application.

Although this approach might give you some flexibility in how you manage the pipelines, it can be challenging to keep everything in sync. For example, suppose your website team needs a new setting on its Azure App Service app to enable a feature that it's building. The application deployment pipeline can't run until the infrastructure deployment pipeline finishes successfully. Also, it can become complicated to send data, such as the names of Azure resources created by your infrastructure pipeline, between the pipelines.

Instead, it's often better to create a single pipeline that deploys everything required for your solution, even if different people or different teams manage the components. You can use tools such as Git and Azure DevOps to coordinate your work. When a new feature is added, you can use a branch to make the necessary changes to your Bicep file. And when the change is ready to be integrated and released, a single pipeline performs all the steps necessary to build and deploy the solution. A single pipeline reduces the chance of things getting out of sync.

> [!TIP]
> When you're building code for your solution, you probably need to deploy it frequently so that you can test how it works. You might find that deploying your infrastructure together with your application code makes your pipeline run slowly and inhibits your progress.
>
> If you're in this position, you might consider disabling the infrastructure deployment for your development environment. You can use path filters, pipeline templates, and conditions to achieve this. However, you should leave the full deployment sequence intact for your other environments.

## The control plane and the data plane

Many Azure resources provide two different *planes* for access. The *control plane* deploys and configures the resource. The *data plane* enables you to access the resource's functionality.

When you create and deploy Bicep files, you interact with the control plane. In Azure, the control plane is Azure Resource Manager. You use Resource Manager to define the configuration of each of your resources.

But your pipeline often needs to do more than just interact with the control plane. For example, you might need to do other tasks:

- Upload a blob to a storage account.
- Modify a database schema.
- Make an API call to a third-party service.
- Trigger the update of a machine learning model.
- Deploy a website to an Azure App Service app.
- Deploy software to a virtual machine.
- Register a Domain Name Server (DNS) entry with a third-party provider.

When you consider an end-to-end pipeline, you ordinarily need to deploy your Azure resources, and then perform a series of operations against the data planes of those resources. Sometimes, these operations are called the *last mile* of the deployment, because you're performing most of the deployment by using the control plane, and only a small amount of configuration remains.

> [!NOTE]
> Some resources don't have a clear division between their control plane and data plane. These include Azure Data Factory and Azure API Management. Both services support fully automated deployments by using Bicep, but they require special considerations. You can find links to more information on the Summary page at the end of the module.

## How to perform data plane operations

When you create a deployment pipeline that interacts with the data plane of your resources, you can use any of three common approaches:

- Resource Manager deployment scripts.
- Pipeline scripts.
- Pipeline tasks.

*Resource Manager deployment scripts* are defined within your Bicep file. They run Bash or PowerShell scripts, and can interact with Azure CLI or Azure PowerShell cmdlets. You create a managed identity so the deployment script can authenticate to Azure, and Azure automatically provisions and manages the other resources it needs to run the deployment script.

Deployment scripts are good when you need to run a basic script within your deployment process. However, they don't easily provide you with access to other elements from your pipeline.

You can also run your own logic from within a deployment pipeline. Azure Pipelines provides a rich ecosystem of *tasks* for common things you need to do. If you can't find a task that meets your needs, you can use a *script* to run your own Bash or PowerShell code. Pipeline tasks and scripts run from your pipeline's agent. You often need to authenticate the task or script to the data plane of the service you're using, and the way that you authenticate depends on the service.

Pipeline tasks and scripts give you flexibility and control. They also enable you to access *pipeline artifacts*, which you learn about soon. In this module, we focus on pipeline scripts and tasks. We link to more information about Resource Manager deployment scripts on the Summary page at the end of the module.

## Outputs

A pipeline ordinarily creates and configures your Azure resources by deploying a Bicep file. The subsequent parts of the pipeline then interact with the data plane of those resources. To be able to interact with the resources, the pipeline tasks and steps need information about the Azure resource you created.

For example, suppose you have a Bicep file that deploys a storage account. You want your pipeline to deploy the storage account and then upload some blobs to a blob container in the storage account. The pipeline task that uploads the blobs needs to know the name of storage account to connect to and the name of the blob container to upload the file to.

It's good practice to have the Bicep file decide on the names of your Azure resources. It might use parameters, variables, or expressions to create the names for the storage account and blob container. The Bicep file can then expose an output that provides each resource's name. Later steps in the pipeline can read the value of the output. That way, your pipeline definition doesn't need to hard-code any names or other information that might change between environments. Also, the definition doesn't need to be based on rules that are defined in your Bicep file.

With Azure Pipelines, you can propagate the values of outputs by using *pipeline variables*. You can set the value of a pipeline variable within a pipeline script. You use a specially formatted log output that Azure Pipelines understands how to interpret, as shown here:

:::code language="yaml" source="code/2-outputs-jobs.yml" highlight="8, 13" :::

When you create a variable in one job, but want to access it in another job in the same stage, you need to *map* it.

:::code language="yaml" source="code/2-outputs-stages.yml" range="1-18" highlight="13-14" :::

To access a variable across pipeline stages, you also need to *map* the variable, but you use a different syntax:

:::code language="yaml" source="code/2-outputs-stages.yml" highlight="24-25" :::

By using Bicep outputs and pipeline variables, you can create a multistage pipeline that deploys your Bicep code and then performs various actions on the resources as part of your deployment.
