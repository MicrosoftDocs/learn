In this unit, you'll learn how the `deploymentScripts` resource can extend Azure Resource Manager (ARM) templates.

ARM templates are wonderful things. You can use them to declare the desired state of your cloud infrastructure and let the APIs and services figure out how to get you there. However, you occasionally need to perform actions that are outside what Azure Resource Manager provides.

## What are deployment scripts?

`deploymentScripts` resources are either PowerShell or Bash scripts that run in a Docker container as part of your template deployment. The default container images have either the Azure CLI or Azure PowerShell available. These scripts run during the processing of the ARM template, so you can add custom behavior to the deployment process.

Deployment scripts use a [managed service identity](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview) to authenticate to Azure. A managed service identity is a service principal whose credential and lifecycle are managed by the Azure platform. This identity is what the Azure PowerShell or Azure CLI commands will use to act on the environment. Because you assign the identity, you control the scope of what a `deploymentScripts` resource can affect.

The `deploymentScripts` resource produces output that other resources in the deployment can use. You can then look up information from an external system or provide data based on the current state of your environment to affect the rest of the deployment.

## How deployment scripts work

A `deploymentScripts` resource takes a user-provided script (either from the template or by URI) and possibly some supporting scripts, and runs them in an [Azure container instance](https://docs.microsoft.com/azure/container-instances). That container instance is assigned the managed identity that you provide. The scripts and their output are stored in a [file share for an Azure storage account](https://docs.microsoft.com/azure/storage/files/storage-files-introduction).

When the template deployment runs, it checks whether there's an existing `deploymentScripts` resource in the targeted resource group. If so, it compares the properties. If everything matches, nothing new happens. If the resource doesn't exist or has been changed, Azure Resource Manager creates a new container instance and runs the deployment scripts inside that container instance. Any defined output will be passed back to Azure Resource Manager for use later in the deployment.

## Deployment script structure

To add a custom behavior to an ARM template, you start with the `deploymentScripts` resource. At a minimum, you need to provide common details like:

- A `name` for the `deploymentScripts` resource.
- The `type` and `apiVersion` values.
- The location (`location` value) where the supporting resources will be created.
- An empty `properties` object. You'll get to that shortly.

Two `deploymentScripts`-specific values are required:

- `kind`: The type of script to run (either `AzurePowerShell` or `AzureCLI`).

  :::code language="json" source="code/example-template.json" range="10-20" highlight="5" :::

- `identity`: The managed identity that the container instance will use. You can create the managed identity ahead of time and specify it like the following example. Or you can create it in the template and reference it there (which is what you'll do in the next exercise).

  :::code language="json" source="code/example-template.json" range="10-20" highlight="6-10" :::

After you set those elements, you can move into the `properties` section of the `deploymentScripts` resource. There, you can define the various options that `deploymentScripts` can take. In this module, we'll keep it simple and add just enough to get the script to run. At a minimum, you need to provide the version of Azure PowerShell or the Azure CLI to use, a script to run, and a retention interval. 

The retention interval is how long the results should be kept if you want to keep the resources. By default, the results are removed after you run the script.

  :::code language="json" source="code/example-template.json" range="21-30" :::

Our full template would look something like:

  :::code language="json" source="code/example-template.json" :::

You can find all the properties for the `deploymentScripts` resource in the [ARM template reference documentation](https://docs.microsoft.com/azure/templates/microsoft.resources/deploymentscripts).
