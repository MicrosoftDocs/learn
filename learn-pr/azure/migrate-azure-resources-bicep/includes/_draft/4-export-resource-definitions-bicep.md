Recently, your company acquired a smaller competitor. This company deployed its Azure resources using JSON ARM templates and the Azure portal. You've already started the process of converting the JSON templates to Bicep, but now you need to address the resources deployed manually through the Azure portal and command line. You start by focusing on a series of resources that support an application for a line of toy trucks. You want to learn about the different methods of exporting Azure resources to templates and the limitations of this process. while following recommended workflow.

## How Azure represents resources

Azure Resource Manager is the service that's used to deploy and manage resources in Azure. All resources deployed to Azure are tracked by Resource Manager, regardless of the method used to deploy the resource. You can use the Azure portal, Azure CLI, Azure PowerShell, the REST API, and SDKs to interact with Resource Manager:

:::image type="content" source="../media/4-azure-resource-manager.png" alt-text="Diagram of Resource Manager." border="true":::

TODO: Introduce Azure Resource Explorer

## Export Azure resources to a template

TODO: When you want to export a resource...

Information about each resource is made available in JSON format by Resource Manager. When you ask for a copy of the JSON representation of a resource, you are _exporting_ the resource.

The Azure portal, Azure CLI, and Azure PowerShell cmdlets can all be used to export your Azure resources and resource groups to JSON ARM templates. This is one of the first steps in migrating your Azure resources to Bicep. Later in this module, you'll practice exporting JSON ARM templates yourself.

> [!NOTE]
> The export template feature is unable to export more than 200 resources from a resource group at one time. If your resource group contains more than 200 resources, you'll need to export multiple times to capture all resources.

### Export resources using the Azure portal

The Azure portal provides multiple methods of exporting Azure resources to a template. You can export single resources, multiple resources, and entire resource groups. Additionally, you have the option of exporting templates before and after a deployment.

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

### Export resources using a script

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

## Which resources can be exported?

Not all Azure resource types can be exported through the Azure portal, Azure CLI, or Azure PowerShell. For example, virtual machine extensions such as the DependencyAgentWindows and MMAExtension (Microsoft Monitoring Agent) aren't supported resource types for export. Consider treating these exported templates as a starting point and use them as inspiration for your final template.

When you attempt to export a resource through the Azure portal, Azure CLI, or Azure PowerShell, and it includes an unsupported resource type, a detailed error message is generated.

You can use this error message and the [Azure Resource Explorer](/azure/azure-resource-manager/templates/view-resources#use-resource-explorer?azure-portal=true) to help re-create these resources in your exported template. While the export template feature won't generate the appropriate JSON, you can reference it using the Azure Resource Explorer.

## Recommended workflow for exporting templates to Bicep

To help your templates align with best practices, you can follow a recommended workflow when converting and exporting your templates to Bicep. This workflow consists of five phases: convert, migrate, refactor, test, and deploy. In this unit, we focus on the first three phases: convert, migrate, and refactor. Later in this module, you'll learn how to test and deploy your Bicep template.

> [!NOTE]
> Many of the steps outlined below were discussed in a previous unit. For details on these steps, please refer to Unit 2 - "Convert JSON templates to Bicep".

### Convert phase

In the _convert_ phase of converting your templates to Bicep, the goal is to capture the initial representation of your Azure resources.

:::image type="content" source="../media/3-export.png" alt-text="Diagram of converting a JSON template to Bicep." border="true":::

1. **Export the JSON ARM template** - Using the Azure portal, Azure CLI, Azure PowerShell, or the REST API, export the resource or resource group template. Make note of any error messages about resource types that cannot be exported.

1. **Decompile the source JSON ARM template**

### Migrate phase

In the _migrate_ phase of converting your templates to Bicep, the goal is to create an initial Bicep file that includes all of your Azure resources.

:::image type="content" source="../media/2-migrate.png" alt-text="Diagram of migrating a template to Bicep." border="true":::

1. **Create a new Bicep file**

1. **Copy the resources from converted Bicep file to new Bicep file**

1. **Re-create any resources that were not exported** - For any resource that wasn't exported, such as virtual machine extensions, you'll need to re-create those resources in your new Bicep file. Consider using the [Azure Resource Explorer](azure/azure-resource-manager/templates/view-resources#use-resource-explorer), the [Azure ARM Template Reference](azure/templates/) documentation, or [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) to help re-create these resources.

1. **Create parameters for each environment**

### Refactor phase

In the _refactor_ phase of converting your templates to Bicep, the goal is to improve the quality of your Bicep code.

:::image type="content" source="../media/2-refactor.png" alt-text="Diagram of refactoring a Bicep template." border="true":::

1. **Review resource API versions** - When exporting Azure resources, the exported template may not have the latest API version for a resource type. If there are specific properties that you need for future deployments, update the API to the appropriate version. It's good practice to review the API versions for each exported resource.

1. **Review the linter suggestions in your new Bicep file**

1. **Revise parameters, variables, and symbolic names**

1. **Simplify expressions**

1. **Review child and extension resources**

1. **Modularize**

1. **Add comments**

1. **Follow Bicep best practices**

## Verify your templates with documentation

One step in the migrate phase is recreating any resources that were not exported successfully. There are multiple documentation resources such as the [Azure ARM Template Reference](azure/templates/) documentation and the [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) repository that can assist you in recreating these resources. Theses resources can also help to improve the fidelity of your templates.

### ARM template reference

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

### Azure quickstart templates

The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) repository is a collection of community contributed templates. This database of searchable templates provides examples of many Azure resources and solutions. In some quickstarts, both a JSON ARM template and a Bicep ARM template are available to view. These templates can be used as a reference point to help you build and verify your templates for deployment.

For example, suppose you want to find a template that builds an App Service Plan and an App Service. In the repository, you'll notice each quickstart template gives you the option to deploy the template directly to Azure, or browse the template on GitHub.

:::image type="content" source="../media/5-azure-quickstart-template.png" alt-text="Azure PowerShell error message about resources that cannot be exported.." border="true":::

Keep in mind that the Azure quickstart templates are community contributions. Some of the examples can be out of date as features are added to Azure services regularly. The examples can also include resources and properties that are unnecessary for your templates.
