You've started the process of migrating your Azure resources to Bicep, and you want to start with converting and migrating your JSON templates to Bicep templates using the native tooling. You want to learn more about how to use the Bicep decompiler to convert your templates and how to migrate these converted templates to a new Bicep file. You want to accomplish these tasks following a recommended workflow.

## Convert and Migrate

The first two phases of the recommended workflow for migrating your JSON ARM template and Azure resource to Bicep are the _convert_ phase and the _migrate_ phase. The main focus for these two phases is to prepare a new Bicep file prior to refactoring and testing.

:::image type="content" source="../media/2-convert-migrate.png" alt-text="Diagram of the convert and migrate phases of the recommended workflow for migrating Azure resources to Bicep." border="true":::

## Convert phase

In the _convert_ phase of converting your templates to Bicep, the goal is to capture the initial representation of your Azure resources. This phase includes converting your source JSON ARM template to a Bicep template using the Bicep decompiler. The source template can be from an existing template library, or from a resource exported from the Azure portal.

:::image type="content" source="../media/2-convert.png" alt-text="Diagram of converting a JSON template to Bicep." border="true":::

### Selecting your source JSON ARM template

The first step in migrating your Azure resources to Bicep is to select your source JSON ARM template. This template can be from an existing template library or repo, or it can be exported from an existing resource in Azure.

#### How Azure represents resources

Azure Resource Manager is the service that's used to deploy and manage resources in Azure. All resources deployed to Azure are tracked by Resource Manager, regardless of the method used to deploy the resource. You can use the Azure portal, Azure CLI, Azure PowerShell, the REST API, and SDKs to interact with Resource Manager

Information about each resource is made available in JSON format by Resource Manager. When you ask for a copy of the JSON representation of a resource, you are _exporting_ the resource.

The Azure portal, Azure CLI, and Azure PowerShell cmdlets can all be used to export your Azure resources and resource groups to JSON ARM templates. Later in this module, you'll practice exporting JSON ARM templates yourself.

> [!NOTE]
> The export template feature is unable to export more than 200 resources from a resource group at one time. If your resource group contains more than 200 resources, you'll need to export multiple times to capture all resources.

#### Export resources using the Azure portal

The Azure portal provides multiple methods of exporting Azure resources to a template. You can export single resources, multiple resources, and entire resource groups. Additionally, you have the option of exporting templates before and after a deployment. Consider treating these exported templates as a starting point and use them as inspiration for your final template.

#### Export template from a single resource, multiple resources, or a resource group

Single resources can be exported to template from either the resource group blade, or from the resource blade itself. Both methods will provide you with the same exported template. Multiple resources can also be exported to template from the resource group blade. All resources in a resource group can be exported to template from the resource group blade.

There are a few things that you need to consider when exporting your templates using this method.

- The exported template is a snapshot of that resource, resources,  or resource group's current state. It will include all changes made to the resources since initial deployment.

- The exported template may include some default resource properties that are normally not specified in a standard deployment. You'll need to consider removing these properties before redeployment.

- The exported template may not include all of the parameters you'll need to make the template reusable. Many of these parameters may be hard-coded into the template.

#### Export template from a deployment

The Azure portal allows you to export a template of a resource before its initial deployment or from its deployment history.

If you've ever deployed a resource manually from the Azure portal, you may have noticed the option to **Download a template for automation** before the deployment of the resource. This option exports a JSON ARM template based on the names and properties you've set while building the resource in the portal.

:::image type="content" source="../media/4-download-template-for-automation.png" alt-text="Download template for automation option when deploying a new resource." border="true":::

You can also export a JSON ARM template based on its deployment history. As mentioned before, Resource Manager tracks all resources and resource deployments. You can access these deployments from the corresponding resource group blade. Each deployment provides the option to download the deployment template.

There are a few things that you need to consider when exporting your templates using this method.

- The exported template shows the state of the resource(s) at the time of deployment. It won't include any changes made after deployment.

- You won't be able to select specific resources from a multi-resource deployment. This option will download all resources that were part of the initial deployment.

- The template will only include resource properties needed for deployment.

- The template will include parameters that will allow you to redeploy the template in multiple environments.

> [!TIP]
> When you export a template from a deployment, you might be able to use it as-is, since it probably won't include extraneous properties. You should still check that the template includes everything you expect.

#### Export resources using a script

Similar to the Azure portal, the Azure CLI and Azure PowerShell can be used to export resources and resource groups to JSON templates. The process is similar for both command-line utilities. Both the Azure CLI and Azure PowerShell can export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group.

::: zone pivot="cli"

You can use the Azure CLI to export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group using the `az group export` command. The export will display the JSON in the terminal window.

To export all resources in a specific resource group, you can use the `az group export` command as shown below:

```azurecli
az group export --name rg-app-prod-truckline
```

To export a single resource from the resource group, you need to pass the resource ID to the `az group export` command as shown below:

```azurecli
virtualMachineResourceId=$(az resource show \
   --resource-group 'rg-app-prod-truckline' \
   --name 'vm-prod-001' \
   --resource-type 'Microsoft.Compute/virtualMachines' \
   --query id \
   --output tsv)
az group export \
   --resource-group 'rg-app-prod-truckline' \
   --resource-ids virtualMachineResourceId
```

To export multiple resources from the resource group, you need to pass the resource IDs, separated by a space, to the `az group export` command as shown below:

```azurecli
az group export \
   --resource-group 'rg-app-prod-truckline' \
   --resource-ids $resource1Id $resource2Id $resource3Id
```

::: zone-end

::: zone pivot="powershell"

You can use Azure PowerShell to export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group using the `Export-Az-ResourceGroup` command. The export will save the JSON template in the root of the directory where you're running the command from.

To export all resources in a specific resource group, you can use the `Export-Az-ResourceGroup` command as shown below:

```azurepowershell
Export-AzResourceGroup -ResourceGroupName 'rg-app-prod-truckline'
```

To export a single resource from the resource group, you need to pass the resource ID to the `Export-Az-ResourceGroup` command as shown below:

```azurepowershell
$virtualMachine = Get-AzResource `
   -ResourceGroupName 'rg-app-prod-truckline' `
   -ResourceName 'vm-prod-001' `
   -ResourceType 'Microsoft.Compute/virtualMachines'
Export-AzResourceGroup `
   -ResourceGroupName 'rg-app-prod-truckline' `
   -Resource $virtualMachine.ResourceId
```

To export multiple resources from the resource group, you need to pass the resource IDs in an array to the `Export-Az-ResourceGroup` command as shown below:

```azurepowershell
Export-AzResourceGroup `
   -ResourceGroupName 'rg-app-prod-truckline' `
   -Resource @($resource1.ResourceId, $resource3.ResourceId, $resource3.ResourceId,)
```

::: zone-end

### Decompile the source JSON ARM template

The second step in migrating your Azure resources to Bicep is converting your JSON ARM templates and Azure resources to Bicep templates. The Bicep tooling includes the `decompile` command to accomplish this. You can invoke the `decompile` command from either the AZ CLI, or from the Bicep CLI.

The decompilation process is a best-effort process and doesn't guarantee a full mapping from JSON to Bicep. You may need to revise the generated Bicep file to meet your template best practices before using the file to deploy resources. Later in this module, you'll learn how to fix any issues encountered in the decompilation process.

#### Bicep's relationship with Azure Resource Manager

Bicep is a Azure Resource Manager template language that's used to declaratively deploy Azure resources. It's a domain-specific language, which means it's designed for a specific scenario or "domain." Bicep isn't meant to be used as a programming language for applications. Bicep is only used to create Resource Manager templates.

When you submit a Bicep template for deployment to Resource Manager, the tooling converts your Bicep template into a JSON template. This process is known as _transpilation_, which essentially treats the ARM template as an intermediate language. The conversion happens automatically when you submit your deployment, or you can do it manually.

> [!NOTE]
> Transpilation is the process of converting source code written in one language into another language.

#### Decompile an JSON ARM template to Bicep

To decompile an JSON ARM template to Bicep with the Azure CLI, use:

```azurecli
az bicep decompile --file main.json
```

To decompile an JSON ARM template to Bicep with the Bicep tooling, use:

```bicep
bicep decompile --file main.json
```

Both commands will create a file named main.bicep in the same directory as the original JSON template.

> [!NOTE]
> The [Bicep playground](https://bicepdemo.z22.web.core.windows.net/) is an online tool that compares JSON templates and Bicep templates side by side. You can choose an Azure quickstart template or upload your own template by clicking the `Decompile` button.

## Migrate phase

In the _migrate_ phase of converting your templates to Bicep, the goal is to create an initial Bicep file that includes all of your Azure resources.

:::image type="content" source="../media/2-migrate.png" alt-text="Diagram of migrating a template to Bicep." border="true":::

### Create a new Bicep file

Using [Visual Studio Code](https://code.visualstudio.com/), create a new Bicep file. This new file will become the main template file for your converted template. Open this file side-by-side with your decompiled Bicep file.

### Copy resources to the new Bicep file

For each defined resource in your original JSON template, copy it from the converted Bicep file to the new Bicep file. Consider copying the resources individually, so that you can resolve any issues on a per resource basis.

### Re-create unsupported resources

Not all Azure resource types can be exported through the Azure portal, Azure CLI, or Azure PowerShell. For example, virtual machine extensions such as the DependencyAgentWindows and MMAExtension (Microsoft Monitoring Agent) aren't supported resource types for export.

When you attempt to export a resource through the Azure portal, Azure CLI, or Azure PowerShell, and it includes an unsupported resource type, a detailed error message is generated.

For any resource that wasn't exported, such as virtual machine extensions, you'll need to re-create those resources in your new Bicep file. Consider using the [Azure Resource Explorer](azure/azure-resource-manager/templates/view-resources#use-resource-explorer), the [Azure ARM Template Reference](azure/templates/) documentation, or [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) to help re-create these resources.

#### What is Azure Resource Explorer?

[Azure Resource Explorer](azure/azure-resource-manager/templates/view-resources#use-resource-explorer) is a tool embedded into the Azure portal that allows you to view a JSON representation of your deployed resources. While you may not be able to export certain resource types from Azure, the Resource Explorer can provide a JSON representation of those resources. This will help you to re-create any unsupported resources. You can find Resource Explorer in the Azure portal by searching for the tool in the search bar as shown below:

:::image type="content" source="../media/2-resource-explorer-1.png" alt-text="A screenshot of the Resource Explorer from the Azure portal." border="true":::

Once you are in the tool, you can expand the hierarchy on the left hand side of the screen. Here you can view registered resource providers and any resource, resource group, and subscription that you have permission to view. You can drill down to a specific resource to view it's JSON representation as shown below:

:::image type="content" source="../media/2-resource-explorer-2.png" alt-text="A screenshot of the Azure Resource Explorer from the Azure portal." border="true":::

By clicking on the `DependencyAgentWindows` resource, `[Microsoft.Compute/virtualMachines/extensions] vm-prod-001/DependencyAgentWindows`, you can view the JSON representation as shown below:

```JSON
{
    "name": "DependencyAgentWindows",
    "id": "/subscriptions/{subscriptionId}/resourceGroups/rg-app-prod-truckline/providers/Microsoft.Compute/virtualMachines/vm-prod-001/extensions/DependencyAgentWindows",
    "type": "Microsoft.Compute/virtualMachines/extensions",
    "location": "eastus",
    "properties": {
        "autoUpgradeMinorVersion": true,
        "provisioningState": "Succeeded",
        "publisher": "Microsoft.Azure.Monitoring.DependencyAgent",
        "type": "DependencyAgentWindows",
        "typeHandlerVersion": "9.10"
    }
}
```

#### What is the Azure ARM Template Reference documentation?

The [Azure ARM Template Reference](azure/templates/) documentation is a source of information for ARM template structure, resource types, API versions, and property definitions for Azure resources. Both JSON and Bicep examples are included.

It allows you to choose specific resource providers, such as `Microsoft.Web/serverFarms` and their API versions. When you specify an API version, you can review  which resource properties are required and which are optional.

Take a look at an example of an App Service Plan using the latest API version.

```bicep
resource symbolicname 'Microsoft.Web/serverFarms@2020-12-01' = {
  name: 'string'
  kind: 'string'
  location: 'string'
  tags: {}
  properties: {
    workerTierName: 'string'
    hostingEnvironmentProfile: {
      id: 'string'
    }
    perSiteScaling: bool
    maximumElasticWorkerCount: int
    isSpot: bool
    spotExpirationTime: 'string'
    freeOfferExpirationTime: 'string'
    reserved: bool
    isXenon: bool
    hyperV: bool
    targetWorkerCount: int
    targetWorkerSizeId: int
    kubeEnvironmentProfile: {
      id: 'string'
    }
  }
  sku: {
    name: 'string'
    tier: 'string'
    size: 'string'
    family: 'string'
    capacity: int
    skuCapacity: {
      minimum: int
      maximum: int
      elasticMaximum: int
      default: int
      scaleType: 'string'
    }
    locations: [
      'string'
    ]
    capabilities: [
      {
        name: 'string'
        value: 'string'
        reason: 'string'
      }
    ]
  }
}
```

#### What are the Azure Quickstart Templates?

The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) repository is a collection of community contributed templates. This database of searchable templates provides examples of many Azure resources and solutions. In some quickstarts, both a JSON ARM template and a Bicep ARM template are available to view. These templates can be used as a reference point to help you build and verify your templates for deployment.

For example, suppose you want to find a template that builds an App Service Plan and an App Service. In the repository, you'll notice each quickstart template gives you the option to deploy the template directly to Azure, or browse the template on GitHub.

:::image type="content" source="../media/5-azure-quickstart-template.png" alt-text="Azure PowerShell error message about resources that cannot be exported.." border="true":::

Keep in mind that the Azure quickstart templates are community contributions. Some of the examples can be out of date as features are added to Azure services regularly. The examples can also include resources and properties that are unnecessary for your templates.

### Create environment parameters

If your infrastructure supports multiple environments, such as production and development, create parameters that support these environments. A good parameter naming convention will make it easy to customize your deployments per environment.