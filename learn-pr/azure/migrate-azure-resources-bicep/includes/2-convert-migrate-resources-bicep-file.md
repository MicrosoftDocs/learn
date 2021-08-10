When you start the process of migrating to Bicep, it's important to follow a structured process to ensure your Bicep file describes your Azure resources correctly. You want to make sure that it follows best practices, and that it's fully tested and safe to use for subsequent deployments. In this unit, you learn about the first two phases for your Bicep migration: the  _convert_ phase and the _migrate_ phase.

:::image type="content" source="../media/2-convert-migrate-phases.png" alt-text="Diagram of the convert and migrate phases of the recommended workflow for migrating Azure resources to Bicep." border="false":::

The main focus for these two phases is to prepare a new Bicep file before you later refactor and test it.

## Convert phase

In the _convert_ phase of converting your templates to Bicep, the goal is to capture an initial representation of your Azure resources. The Bicep file you create in this phase isn't complete, and it's not ready to be used. However, the file gives you a starting point for your migration.

The convert phase consists of two steps:

1. Capture a JSON representation of your Azure resources.
2. Convert the JSON representation to Bicep using the _decompile_ command.

:::image type="content" source="../media/2-convert.png" alt-text="Diagram that shows a JSON template decompiled to JSON, and Azure resources that are exported to a JSON template, which is then decompiled." border="false":::

If you have an existing JSON template that you're converting to Bicep, the first step is easy - you already have your source template. You'll learn how to decompile it to Bicep shortly.

If you're converting Azure resources deployed through the portal or another tool, you need to export the resource definitions and then convert them to Bicep.

### How Azure represents resources

Azure Resource Manager is the service that's used to deploy and manage resources in Azure. All resources deployed to Azure are tracked by Resource Manager, regardless of the method used to deploy the resource. You can use the Azure portal, Azure CLI, Azure PowerShell, the Resource Manager REST API, and Azure SDKs to interact with Resource Manager.

:::image type="content" source="../../includes/media/azure-resource-manager.png" alt-text="Diagram showing Azure Resource Manager accepting requests from all Azure clients and libraries." border="false":::

Regardless of how each resource was created, information about the resource is made available in JSON format by Resource Manager. When you ask for a copy of the JSON representation of a resource, you're _exporting_ the resource. The JSON file that you export can be decompiled into Bicep.

The Azure portal, Azure CLI, and Azure PowerShell cmdlets can all be used to export your Azure resources and resource groups to JSON ARM templates. Later in this module, you'll practice exporting JSON ARM templates yourself.

> [!NOTE]
> The export feature is unable to export more than 200 resources from a resource group at one time. If your resource group contains more than 200 resources, you'll need to export multiple times to capture all resources.

### Export resources

Azure provides multiple methods of exporting Azure resources to a template. You can export single resources, multiple resources, and entire resource groups. Additionally, the Azure portal gives you the option of viewing the template for a resource before you create it.

There are a few things that you need to consider when exporting a resource:

- The exported resource definition is a snapshot of that resource's current state. It will include all changes made to the resource since its initial deployment.
- The exported template may include some default resource properties that are normally omitted from a Bicep definition. For example, it might include read-only properties that Azure sets automatically. Consider removing these properties from the resource definitions when you migrate to Bicep, to keep your Bicep files free of unnecessary code that might cause confusion.
- The exported template likely won't include all of the parameters you'll need to make the template reusable. When you export a template, many of the properties will be hard-coded into the template.
- Some resources can't be exported using this approach, and you need to define them manually in your Bicep file. You'll learn how to recreate these resources later in this unit.

> [!NOTE]
> However you export a template, treat it as a starting point and don't use it directly. Instead, use it as inspiration for your final template.

#### Export a single resource

A single resource's definition can be exported to a JSON template by using the Azure portal. After you open a resource, select the **Export template** menu item to view the template:

:::image type="content" source="../media/2-export-single-resource.png" alt-text="Screenshot of the Azure portal showing a storage account, with the Export template menu item highlighted.":::

::: zone pivot="cli"

Alternatively, you can export a resource's definition through a script by using the `az group export` command and by specifying the resource ID:

```azurecli
virtualMachineResourceId=$(az resource show \
   --resource-group 'rg-app-prod-truckline' \
   --name 'vm-prod-001' \
   --resource-type 'Microsoft.Compute/virtualMachines' \
   --query id \
   --output tsv)
az group export \
   --resource-group 'rg-app-prod-truckline' \
   --resource-ids $virtualMachineResourceId
```

::: zone-end

::: zone pivot="powershell"

Alternatively, you can export a resource's definition through a script by using the `Export-AzResourceGroup` cmdlet and by specifying the resource ID:

```azurepowershell
$virtualMachine = Get-AzResource `
   -ResourceGroupName 'rg-app-prod-truckline' `
   -ResourceName 'vm-prod-001' `
   -ResourceType 'Microsoft.Compute/virtualMachines'
Export-AzResourceGroup `
   -ResourceGroupName 'rg-app-prod-truckline' `
   -Resource $virtualMachine.ResourceId
```

::: zone-end

#### Export multiple resources

You can export all of the resources in a resource group by using the Azure portal by opening up the resource group blade and selecting **Export template**:

:::image type="content" source="../media/2-export-resource-group.png" alt-text="Screenshot of the Azure portal showing a resource group, with the Export template menu item highlighted.":::

::: zone pivot="cli"

To use the Azure CLI to export all of the resources in a resource group, you use the `az group export` command and specify the resource group name:

```azurecli
az group export --name 'rg-app-prod-truckline'
```

::: zone-end

::: zone pivot="powershell"

To use Azure PowerShell to export all of the resources in a resource group, you use the `Export-AzResourceGroup` cmdlet and specify the resource group name:

```azurepowershell
Export-AzResourceGroup -ResourceGroupName 'rg-app-prod-truckline'
```

::: zone-end

Sometimes, you might want to export multiple resources from a resource group, but not everything. In the resource group view, check the resources you want to export, and then select the **Export template** menu item:

:::image type="content" source="../media/2-export-multiple-resources.png" alt-text="Screenshot of the Azure portal showing a resource group, with two resources checked and the Export template menu item highlighted.":::

::: zone pivot="cli"

To export multiple resources by using the Azure CLI, you need to pass the resource IDs, separated by a space, to the `az group export` command:

```azurecli
az group export \
   --resource-group 'rg-app-prod-truckline' \
   --resource-ids $resource1Id $resource2Id $resource3Id
```

::: zone-end

::: zone pivot="powershell"

To export multiple resources by using Azure PowerShell, you need to pass the resource IDs in an array to the `Export-Az-ResourceGroup` command:

```azurepowershell
Export-AzResourceGroup `
   -ResourceGroupName 'rg-app-prod-truckline' `
   -Resource @($resource1.ResourceId, $resource3.ResourceId, $resource3.ResourceId,)
```

::: zone-end

#### Use the Azure portal to view a template before you create a resource

If you've ever deployed a resource manually from the Azure portal, you may have noticed the option to **Download a template for automation** before the deployment of the resource. This option exports a JSON ARM template based on the names and properties you've set while building the resource in the portal:

:::image type="content" source="../media/2-download-template-automation.png" alt-text="Screenshot of the Azure portal showing the deployment of a new resource, with the 'Download template for automation' button highlighted." border="true":::

#### View the template for a previous deployment

Resource Manager tracks all resources and resource deployments. If the deployments were created using a compatible tool, you can access the deployment template from the resource group's deployment history.

> [!IMPORTANT]
> Some methods of creating resources don't create deployments, so this option might not be available for all of your Azure resources.

There are a few things that you need to consider when exporting your templates using this method.

- The exported template shows the state of the resources at the time of deployment. It won't include any changes made after deployment.
- You can't select specific resources from a multi-resource deployment. This option will download all resources that were part of the initial deployment.
- The template will only include resource properties needed for deployment.
- The template will include parameters that will allow you to redeploy the template in multiple environments.

> [!TIP]
> When you copy a template from a deployment, it probably won't include extraneous properties. You should still check that the template includes everything you expect, though.

To view a deployment and its template from the Azure portal, open a resource group and select **Deployments**, then select the deployment you want to export. Select **Template** to view and copy the template.

:::image type="content" source="../media/2-deployment-template.png" alt-text="Screenshot of the Azure portal showing a resource group deployment, with the Template menu item highlighted.":::

::: zone pivot="cli"

> [!NOTE]
> You can also export a deployment from the Azure CLI by using the `az deployment group export` command.

::: zone-end

::: zone pivot="powershell"

> [!NOTE]
> You can also export a deployment from Azure PowerShell by using the `Save-AzResourceGroupDeploymentTemplate` cmdlet.

::: zone-end

### Decompile the source JSON ARM template

The second step in migrating your Azure resources to Bicep is converting your JSON ARM templates and Azure resources to Bicep templates. The Bicep tooling includes the `decompile` command to convert templates. You can invoke the `decompile` command from either the Azure CLI, or from the Bicep CLI.

The decompilation process is a best-effort process and doesn't guarantee a full mapping from JSON to Bicep. You may need to revise the generated Bicep file to meet your template best practices before using the file to deploy resources. Consider this the starting point for your migration. Later in this module, you'll learn how to fix any issues you come across in the decompilation process.

Once you decompile your template, you've completed the _convert_ phase and you have a valid Bicep file to start from. However, the file you create isn't ready to use yet - it's just a reference point.

## Migrate phase

In the _migrate_ phase of converting your templates to Bicep, the goal is to create the first draft of your final Bicep file, and to ensure it defines all of the Azure resources that are in scope for the migration. In this phase, you do the following steps:

1. Create a new empty Bicep file.
1. Copy each resource from your decompiled template.
1. Identify and recreate any missing resources.
1. Add parameters to make your Bicep file reusable.

:::image type="content" source="../media/2-migrate.png" alt-text="Diagram of migrating a template to Bicep." border="false":::

### Create a new Bicep file

It's good practice to create a brand new Bicep file. The file you created in the _convert_ phase is a reference point for you to look at, but you shouldn't treat it as final or deploy it as-is.

> [!TIP]
> When you start the migrate phase, it can be helpful to use Visual Studio Code's split editor to open your newly created blank Bicep file side by side with your decompiled Bicep file.

### Copy resources to the new Bicep file

Copy each resource individually from the converted Bicep file to the new Bicep file. This process helps you resolve any issues on a per-resource basis and to avoid any confusion as your template grows in size.

### Recreate unsupported resources

Not all Azure resource types can be exported through the Azure portal, Azure CLI, or Azure PowerShell. For example, virtual machine extensions such as the DependencyAgentWindows and MMAExtension (Microsoft Monitoring Agent) aren't supported resource types for export.

When you attempt to export a resource through the Azure portal, Azure CLI, or Azure PowerShell, and it includes an unsupported resource type, a detailed error message is generated.

For any resource that wasn't exported, such as virtual machine extensions, you'll need to recreate those resources in your new Bicep file. There are several tools and approaches you can use to recreate resources, including Azure Resource Explorer, the ARM template reference documentation, and the Azure Quickstart Templates site.

#### Azure Resource Explorer

[Azure Resource Explorer](/azure/azure-resource-manager/templates/view-resources#use-resource-explorer) is a tool embedded into the Azure portal that allows you to view a JSON representation of your deployed resources. The portal doesn't show certain resource types, but Resource Explorer can provide a JSON representation of those resources. You can find Resource Explorer in the Azure portal by searching for the tool in the search bar as shown below:

:::image type="content" source="../media/2-resource-explorer-1.png" alt-text="Screenshot of Azure portal showing the search box with 'resource explorer' entered.":::

Once you are in the tool, expand the hierarchy on the left-hand side of the screen. This is a list of the registered resource providers for your subscription, and details of any resource, resource group, and subscription that you have permission to view. Drill down to a specific resource to view its JSON representation as shown below:

:::image type="content" source="../media/2-resource-explorer-2.png" alt-text="Screenshot of the Azure portal showing the Azure Resource Explorer." border="true":::

By selecting a resource, you can view the JSON representation, like in this example:

```json
{
    "name": "DependencyAgentWindows",
    "id": "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/rg-app-prod-truckline/providers/Microsoft.Compute/virtualMachines/vm-prod-001/extensions/DependencyAgentWindows",
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

You can use this JSON representation to define a Bicep resource yourself, like this:

```bicep
resource dependencyAgentWindows 'Microsoft.Compute/virtualMachines/extensions@2021-03-01' = {
  parent: virtualMachine
  name: 'DependencyAgentWindows'
  location: 'eastus'
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Azure.Monitoring.DependencyAgent'
    type: 'DependencyAgentWindows'
    typeHandlerVersion: '9.10'
  }
}
```

> [!NOTE]
> Notice that the JSON representation includes a property named `provisioningState`, but this isn't included in the Bicep resource definition. This is because the `provisioningState` property is read-only, and it's automatically set by Azure.

> [!TIP]
> The Bicep extension for Visual Studio Code helps you to define these resources. For example, notice that the Bicep representation of the resource includes an API version, but the exported JSON version doesn't. When you start to type the resource type into Visual Studio Code, it automatically suggests an API version for you.

#### ARM template reference documentation

The [ARM template reference documentation](/azure/templates/) is a source of information for ARM template structure, resource types, API versions, and property definitions for Azure resources. Both JSON and Bicep examples are included.

It allows you to choose specific resource providers and resource types, such as `Microsoft.Web/serverFarms` and their API versions. You can review which resource properties are required and which are optional. Most properties include documentation to help you understand what they do.

#### Azure Quickstart Templates

The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) repository is a collection of community-contributed templates. This repository of searchable templates provides examples of many Azure resources and solutions. In some quickstarts, both a JSON ARM template and a Bicep ARM template are available to view. These templates can be used as a reference point to help you build and verify your templates for deployment.

For example, suppose you want to find a template that builds an App Service plan and app. In the repository, you'll notice each quickstart template gives you the option to deploy the template directly to Azure, or browse the template on GitHub.

:::image type="content" source="../media/5-azure-quickstart-template.png" alt-text="Azure PowerShell error message about resources that cannot be exported.." border="true":::

Keep in mind that the Azure quickstart templates are community contributions. Some of the examples can be out of date as features are added to Azure services regularly. The examples can also include resources and properties that are unnecessary for your templates. However, it's a useful resource to help you understand how to deploy your resources using ARM templates.

### Create environment parameters

If your infrastructure supports multiple environments, such as production and development, create parameters that support these environments. A good parameter naming convention will make it easy to customize your deployments per environment.
