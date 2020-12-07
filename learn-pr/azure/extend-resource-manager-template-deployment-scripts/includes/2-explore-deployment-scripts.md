In this unit, you will learn how the `deploymentScripts` resource can extend Azure Resource Manager (ARM) templates.

Azure Resource Manager templates are wonderful things.  They allow us to declare the desired state of our cloud infrastructure and let the APIs and services figure out how to get us there.  However, you occasionally need to perform actions that are outside of what Azure Resource Manager provides.

## What are deployment scripts?

`deploymentScripts` resources are either PowerShell or Bash scripts that are run in a Docker container as part of your template deployment. The default container images have either Azure CLI or Azure PowerShell available. These scripts run during the processing of the ARM template, allowing us to add custom behavior to the deployment process.

Deployment scripts use a [managed service identity](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview) to authenticate to Azure. A managed service identity is a service principal whose credential and lifecycle are managed by the Azure platform. This identity is what the Azure PowerShell or Azure CLI commands will use to act on the environment.  Because you assign the identity, you control the scope of what the `deploymentScripts` can affect.

Like other resources, the `deploymentScripts` resource can produce output that can be used by other resources in the deployment.  This lets us look up information from an external system or provide data based on the current state of our environment to impact the remainder of the deployment.

## How deployment scripts work

A `deploymentScripts` resource takes a user-provided script (either from the template or by URI) and possibly some supporting scripts, and run them in an [Azure Container Instance](https://docs.microsoft.com/azure/container-instances) (ACI).  That ACI container is assigned the managed identity provided. The scripts and their output are stored in an [Azure storage account file share](https://docs.microsoft.com/azure/storage/files/storage-files-introduction).

When the template deployment runs, it checks to see whether there is an existing `deploymentScripts` resource in the targeted resource group. If so, it compares the properties. If everything matches, nothing new is done. However, if the resource doesn't exist or has been changed, Azure Resource Manager creates a new ACI instance and executes the deployment scripts inside that container instance. Any defined output will be passed back to the Azure Resource Manager for use later in the deployment.

## Deployment scripts structure

To add a custom behavior to our ARM template, you start with the `deploymentScripts` resource.  At a minimum, you will need to provide some common details like:

- a `name` for the `deploymentScripts`
- the `type` and `apiVersion`
- the `location` where the supporting resources will be created
- an empty `properties` object - you'll get to that shortly.

Then there are two `deploymentScripts`-specific values which are required (and shown below):

- the `kind` of script to run (either `AzurePowerShell` or `AzureCLI`)

  :::code language="json" source="code/example-template.json" range="10-20" highlight="5" :::

- the managed `identity` the ACI instance will use. The managed identity can be created ahead of time and specified like this example or created in the template and referenced there (which is what you'll do in the next exercise).

  :::code language="json" source="code/example-template.json" range="10-20" highlight="6-10" :::

Once those elements are set, you can move into the `properties` section of the `deploymentScripts` resource, where you can define the various options our `deploymentScripts` can take.  You'll keep it simple and add just enough to get our script to run. At a minimum, you need to provide the version of Azure PowerShell or Azure CLI to use, a script to run, and a retention interval (how long the results should be kept if you want to keep the resources - by default they are removed after running).

  :::code language="json" source="code/example-template.json" range="21-30" :::

Our full template would look something like,

  :::code language="json" source="code/example-template.json" :::

You can find all the properties the `deploymentScripts` resource in the [Azure Resource Manager template Reference Documentation](https://docs.microsoft.com/azure/templates/microsoft.resources/deploymentscripts).
