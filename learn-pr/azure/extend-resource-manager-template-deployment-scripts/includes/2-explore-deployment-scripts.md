In this unit, you'll learn how the `deploymentScripts` resource can extend Azure Resource Manager (ARM) templates.

ARM templates are wonderful things. You can use them to declare the desired state of your cloud infrastructure and let the APIs and services figure out how to get you there. However, you occasionally need to perform actions that are outside what Azure Resource Manager provides.

## What are deployment scripts?

`deploymentScripts` resources are either PowerShell or Bash scripts that run in a Docker container as part of your template deployment. The default container images have either the Azure CLI or Azure PowerShell available. These scripts run during the ARM template processing, so you can add custom behavior to the deployment process.

Deployment scripts use a [managed identity](/azure/active-directory/managed-identities-azure-resources/overview) to authenticate to Azure. A managed identity is a service principal whose credential and lifecycle are managed by the Azure platform. This identity is what the Azure PowerShell or Azure CLI commands will use to act on the environment. Because you assign the identity, you control the scope of what a `deploymentScripts` resource can affect.

The `deploymentScripts` resource produces output that other resources in the deployment can use. You can then look up information from an external system or provide data based on the current state of your environment to affect the rest of the deployment.

## How deployment scripts work

A `deploymentScripts` resource takes a user-provided script (either from the template or by URI) and possibly some supporting scripts, and runs them in an [Azure container instance](/azure/container-instances). That container instance is assigned the managed identity that you provide. The scripts and their output are stored in a [file share for an Azure storage account](/azure/storage/files/storage-files-introduction).

When the template deployment runs, it checks whether there's an existing `deploymentScripts` resource in the targeted resource group. If so, it compares the properties. If everything matches, nothing new happens. If the resource doesn't exist or has been changed, Azure Resource Manager creates a new container instance and runs the deployment scripts inside that container instance. Any defined output will be passed back to Azure Resource Manager for use later in the deployment.

## Deployment script structure

To add a custom behavior to an ARM template, you start with the `deploymentScripts` resource. At a minimum, you need to provide common details like:

- A `name` for the `deploymentScripts` resource.
- The `type` and `apiVersion` values.
- The location (`location` value) where the supporting resources will be created.
- An empty `properties` object. You'll get to that shortly.

Two `deploymentScripts`-specific values are required:

- `kind`: The type of script to run (either `AzurePowerShell` or `AzureCLI`).

  ::: zone pivot="jsoncli,jsonpowershell"

  :::code language="json" source="code/2-example-template.json" range="9-19,30-31" highlight="6" :::

  ::: zone-end

  ::: zone pivot="bicepcli,biceppowershell"

  :::code language="bicep" source="code/2-example-template.bicep" range="1-10,21" highlight="4" :::

  ::: zone-end

- `identity`: The managed identity that the container instance will use. You can create the managed identity ahead of time and specify it like the following example, or you can create it in the template and reference it there (which is what you'll do in the next exercise).

  ::: zone pivot="jsoncli,jsonpowershell"

  :::code language="json" source="code/2-example-template.json" range="9-19,30-31" highlight="7-10" :::

  ::: zone-end

  ::: zone pivot="bicepcli,biceppowershell"

  :::code language="bicep" source="code/2-example-template.bicep" range="1-10,21" highlight="5-10" :::

  ::: zone-end

After you set those elements, you can move into the `properties` section of the `deploymentScripts` resource. The main part of this is the `scriptContent`, which specifies the actual script to execute:

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/2-example-template.json" range="21, 23-28, 30" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/2-example-template.bicep" range="11, 13-18, 20" :::

Notice that the `scriptContent` uses a multi-line string. In Bicep, you can specify a multi-line string by using three quotes together (`'''`) before and after your string.

::: zone-end

It's common for a deployment script to pass outputs back to the deployment. For example, if you're using a script to look up some information from an API, you might pass the information back to the deployment as an output. Other resources in the deployment could then use the information in their own definitions.

For a PowerShell script, you pass outputs back by creating a variable named `$DeploymentScriptOutputs`, which needs to be a hash table. The example script initializes the hash table and then creates an output called `text`, which takes its value from the `$output` local variable:

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/2-example-template.json" range="24-27" highlight="3-4" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/2-example-template.bicep" range="14-17" highlight="3-4" :::

::: zone-end

> [!TIP]
> You can also write deployment scripts in Bash. To create outputs from a Bash script, you need to create a JSON file in a location specified by the `AZ_SCRIPTS_OUTPUT_PATH` environment variable.

Within the `properties` section, you also define the various options that `deploymentScripts` can take. In this module, we'll keep it simple and add just enough to get the script to run. At a minimum, you need to provide the version of Azure PowerShell or the Azure CLI to use, a script to run, and a retention interval.

The retention interval is how long the results should be kept if you want to keep the resources. By default, the results are removed after you run the script.

  ::: zone pivot="jsoncli,jsonpowershell"

  :::code language="json" source="code/2-example-template.json" range="21-30" highlight="9" :::

  ::: zone-end

  ::: zone pivot="bicepcli,biceppowershell"

  :::code language="bicep" source="code/2-example-template.bicep" range="11-20" highlight="9" :::

  ::: zone-end

Our full template would look something like:

  ::: zone pivot="jsoncli,jsonpowershell"

  :::code language="json" source="code/2-example-template.json" :::

  ::: zone-end

  ::: zone pivot="bicepcli,biceppowershell"

  :::code language="bicep" source="code/2-example-template.bicep" :::

  ::: zone-end

::: zone pivot="bicepcli,biceppowershell"

## Include script files

Embedding scripts inline in templates can be cumbersome, hard to read and understand, and difficult to change. Bicep uses the `loadTextContent()` function to embed an external text file in your deployment. When Bicep transpiles your template into JSON, it embeds the external file into the template it emits.

Let's say you have a PowerShell file named *myscript.ps1* in the same folder as your Bicep template. You can tell Bicep to embed the file like this:

:::code language="bicep" source="code/2-example-template-external.bicep" range="11-15" highlight="3" :::

::: zone-end

You can find all the properties for the `deploymentScripts` resource in the [ARM template reference documentation](/azure/templates/microsoft.resources/deploymentscripts).
