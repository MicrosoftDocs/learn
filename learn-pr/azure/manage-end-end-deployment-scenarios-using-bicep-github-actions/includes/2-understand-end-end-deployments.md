GitHub Actions workflows are flexible tools that you can configure in many different ways to suit your needs. In this unit, you'll learn how to use workflows to deploy an entire solution, including configuring the Azure infrastructure, and to perform other deployment operations.

## How many workflows?

In some organizations, the team that manages the Azure environment is different from the team that develops the code that runs in the environment. In these situations, it's often tempting to create multiple workflows, each owned by the team that's responsible for its particular area. For example, you might create one workflow to deploy the Bicep code that deploys your website's Azure resources, and another workflow that deploys the website application.

Although this approach might give you some flexibility in how you manage the workflows, it can be challenging to keep everything in sync. For example, suppose your website team needs a new setting on its Azure App Service app to enable a feature that it's building. The application deployment workflow can't run until the infrastructure deployment workflow has finished successfully. Also, it can become complicated to send data, such as the names of Azure resources created by your infrastructure workflow, between the workflows.

Instead, it's often better to create a single workflow that deploys everything required for your solution, even if different teams or different people manage the components. You can use tools such as Git and GitHub to coordinate your work. When a new feature is added, you can use a branch to make the necessary changes to your Bicep file. When the change is ready to be integrated and released, a single workflow performs all the steps necessary to build and deploy the solution, which reduces the chance of things getting out of sync.

> [!TIP]
> When you're building code for your solution, you'll probably need to deploy it frequently so that you can test how it works. You might find that deploying your infrastructure together with your application code makes your workflow run slowly and inhibits your progress.
>
> If you're in this position, you might consider disabling the infrastructure deployment for your development environment. You can use path filters, reusable workflows, and conditions to achieve this. However, you should leave the full deployment sequence intact for your other environments.

## The control plane and the data plane

Many Azure resources provide two different _planes_ for access. The _control plane_ deploys and configures the resource. The _data plane_ enables you to access the resource's functionality.

When you create and deploy Bicep files, you interact with the control plane. In Azure, the control plane is Azure Resource Manager. You use Resource Manager to define the configuration of each of your resources.

However, your workflow often needs to do more than just interact with the control plane. For example, you might need to:

- Upload a blob to a storage account.
- Modify a database schema.
- Make an API call to a third-party service.
- Trigger a machine learning model update.
- Deploy a website to an Azure App Service app.
- Deploy software to a virtual machine.
- Register a DNS entry with a third-party provider.

When you consider an end-to-end workflow, you ordinarily need to deploy your Azure resources, then perform a series of operations against the data planes of those resources. Sometimes, these operations are called the _last mile_ of the deployment, because you're performing most of the deployment by using the control plane, and only a small amount of configuration remains.

> [!NOTE]
> Some resources don't have a clear division between their control plane and data plane. These include Azure Data Factory and Azure API Management. Both services support fully automated deployments by using Bicep, but they require special considerations. You'll find links to more information on the Summary page at the end of the module.

## How to perform data-plane operations

When you create a deployment workflow that interacts with the data plane of your resources, you can use any of three common approaches:

- Resource Manager deployment scripts
- Workflow scripts
- Workflow actions

_Resource Manager deployment scripts_ are defined within your Bicep file. They run Bash or PowerShell scripts, and they can interact with Azure CLI commands and Azure PowerShell cmdlets. You create a managed identity for the deployment script to use to authenticate to Azure, and Azure automatically provisions and manages the other resources it needs to run the deployment script.

Deployment scripts are good when you need to run a basic script within your deployment process, but they don't easily provide you with access to other elements from your workflow.

You can also run your own logic from within a deployment workflow. GitHub Actions provides a rich ecosystem of _actions_ for common things you need to do. If you can't find an action that meets your needs, you can use a _script_ to run your own Bash or PowerShell code. Workflow actions and scripts run from your workflow's runner. You often need to authenticate the action or script to the data plane of the service you're using, and how you do this depends on the service.

Workflow actions and scripts give you flexibility and control. They also allow you to access _workflow artifacts_, which you'll learn about soon. In this module, we focus on workflow actions. We link to more information about Resource Manager deployment scripts on the Summary page at the end of the module.

## Outputs

A workflow ordinarily creates and configures your Azure resources by deploying a Bicep file. The workflow's subsequent parts then interact with those resources' data plane. To be able to interact with the resources, the workflow actions and steps need information about the Azure resource that was created.

For example, suppose you have a Bicep file that deploys a storage account. You want your workflow to deploy the storage account and then upload some blobs to a blob container in the storage account. The workflow step that uploads the blobs needs to know the name of storage account to connect to and the name of the blob container to upload the file to.

It's good practice to have the Bicep file decide on the names of your Azure resources. It might use parameters, variables, or expressions to create the names for the storage account and blob container. The Bicep file can then expose an output that provides each resource's name. Later steps in the workflow can read the output value. That way, your workflow definition doesn't need to hard-code any names or other information that might change between environments or be based on rules that are defined in your Bicep file.

With GitHub Actions, you can propagate the values of outputs by using _workflow variables_. The `azure/arm-deploy` action automatically creates variables for each of your Bicep deployment outputs. You can also manually create workflow variables in scripts. You'll find links to more information on the Summary page at the end of this module.

When you access variables that were created in another job, you need to publish the variable to make it accessible to the job that reads it. For example, suppose you create a job that deploys a Bicep file, and you need to propagate the `appServiceAppName` output to your workflow. You use the `outputs` keyword to specify that the `appServiceAppName` workflow variable should be set to the value of the `appServiceAppName` output variable created by the `deploy` step:

:::code language="yaml" source="code/2-outputs-jobs.yml" range="7-26" highlight="3-4" :::

Then, in a later job, you create an explicit dependency on the job that created the variable by including the `needs` keyword, and you refer to the variable by using the name of the published variable:

:::code language="yaml" source="code/2-outputs-jobs.yml" range="28-33" highlight="2, 6" :::

By using Bicep outputs and workflow variables, you can create a workflow that deploys your Bicep code and then performs various actions on the resources as part of your deployment.
