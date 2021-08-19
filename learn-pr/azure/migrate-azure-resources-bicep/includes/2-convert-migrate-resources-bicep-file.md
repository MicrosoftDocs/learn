When you start the process of migrating to Bicep, it's important to follow a structured process to ensure your Bicep file describes your Azure resources correctly. You want to make sure that your Bicep code follows best practices, and that it's fully tested and safe to use for subsequent deployments. In this unit, you learn about the first two phases for your Bicep migration: the  _convert_ phase and the _migrate_ phase.

:::image type="content" source="../media/2-convert-migrate-phases.png" alt-text="Diagram of the convert and migrate phases of the recommended workflow for migrating Azure resources to Bicep." border="false":::

The main focus for these two phases is to prepare a new Bicep file before you later refactor and test it.

## Convert phase

In the _convert_ phase of migrating your resources to Bicep, the goal is to capture an initial representation of your Azure resources. The Bicep file you create in this phase isn't complete, and it's not ready to be used. However, the file gives you a starting point for your migration.

The convert phase consists of two steps, which you complete in sequence:

1. Capture a JSON representation of your Azure resources.
2. Convert the JSON representation to Bicep using the _decompile_ command.

:::image type="content" source="../media/2-convert.png" alt-text="Diagram that shows a JSON template decompiled to JSON, and Azure resources that are exported to a JSON template, which is then decompiled." border="false":::

If you have an existing JSON template that you're converting to Bicep, the first step is easy - you already have your source template. You'll learn how to decompile it to Bicep shortly.

If you're converting Azure resources deployed through the portal or another tool, you need to export the resource definitions and then convert them to Bicep.

### How Azure represents resources

Azure Resource Manager is the service that's used to deploy and manage resources in Azure. All resources deployed to Azure are tracked by Resource Manager, regardless of the method used to deploy the resource. You can use the Azure portal, Azure CLI, Azure PowerShell, the Resource Manager REST API, and Azure SDKs to interact with Resource Manager.

:::image type="content" source="../../includes/media/azure-resource-manager.png" alt-text="Diagram showing Azure Resource Manager accepting requests from all Azure clients and libraries." border="false":::

There are two types of operations in Azure: control plane operations and data plane operations. Control plane operations are used to manage the resources in your subscription, while data plane operations are used to access features that are exposed by a resource. For example, you use a control plane operation to create a virtual machine, but you use a data plane operation to connect to the virtual machine by using Remote Desktop Protocol (RDP).

### Export Resources

Regardless of how your Azure resources are created, information about each resource is made available in JSON format by Resource Manager. When you ask for a copy of the JSON representation of a resource, you're _exporting_ the resource. The JSON file that you export can be decompiled into Bicep. The export process is a control plane operation, meaning it is only exporting the configuration of the Azure resources. For example, when exporting a virtual machine, the data on a virtual machine's hard drive is not part of the export process, and when exporting a storage account, the blobs and other contents of the storage account aren't included in the export process either.

Resource manager provides multiple ways to export Azure resources to a template. You can use the Azure portal, Azure CLI, and Azure PowerShell cmdlets to export single resources, multiple resources, and entire resource groups. Additionally, the Azure portal allows you to export deployments, both prior to and after their execution.

> [!NOTE]
> However you export a template, either from existing resources or deployments, treat it as a starting point and don't use it directly. Instead, use it as inspiration for your final template.

#### Exporting existing resources

There are a few things that you need to consider when exporting existing resources:

- The exported resource definition is a snapshot of that resource's current state. It will include all changes made to the resource since its initial deployment.
- The exported template may include some default resource properties that are normally omitted from a Bicep definition. For example, it might include read-only properties that Azure sets automatically. Consider removing these properties from the resource definitions when you migrate to Bicep, to keep your Bicep files free of unnecessary code that might cause confusion.
- The exported template likely won't include all of the parameters you'll need to make the template reusable. When you export a template, many of the properties will be hard-coded into the template.
- Some resources can't be exported using this approach, and you need to define them manually in your Bicep file. You'll learn how to recreate these resources later in this unit.

> [!NOTE]
> The export feature is unable to export more than 200 resources from a resource group at one time. If your resource group contains more than 200 resources, you'll need to export multiple times to capture all resources.

#### Exporting deployments

If you've ever deployed a resource manually from the Azure portal, you may have noticed the option to **Download a template for automation** on the **Review + create** page. This option exports a JSON ARM template based on the names and properties you've set while building the resource in the portal.

Resource Manager tracks all resources and resource deployments. If the deployments were created using a compatible tool, you can access the deployment template from the resource group's deployment history.

> [!IMPORTANT]
> Some methods of creating resources don't create deployments, so this option might not be available for all of your Azure resources.

There are a few things that you need to consider when exporting your templates using this method.

- The exported template shows the state of the resources at the time of deployment. It won't include any changes made after deployment.
- You can't select specific resources from a multi-resource deployment. This option will download all resources that were part of the initial deployment.
- The template will only include resource properties needed for deployment.
- The template might include parameters that you can use to redeploy the template in multiple environments.
- The template probably won't include extraneous properties, but you should still check that the template includes everything that you expect.

> [!NOTE]
> You can also export a deployment from the Azure CLI by using the `az deployment group export` command or from Azure PowerShell by using the `Save-AzResourceGroupDeploymentTemplate` cmdlet.

### Decompile the source JSON ARM template

The second step in migrating your Azure resources to Bicep is converting your JSON ARM templates and Azure resources to Bicep templates. The Bicep tooling includes the `decompile` command to convert templates. You can invoke the `decompile` command from either the Azure CLI, or from the Bicep CLI.

The decompilation process is a best-effort process and doesn't guarantee a full mapping from JSON to Bicep. You may need to revise the generated Bicep file to meet your template best practices before using the file to deploy resources. Consider this the starting point for your migration. Later in this module, you'll learn how to fix any issues you come across in the decompilation process.

Once you decompile your template, you've completed the _convert_ phase and you have a valid Bicep file to start from. However, the file you create isn't ready to use yet - it's just a reference point.

## Migrate phase

In the _migrate_ phase of migrating your resources to Bicep, the goal is to create the first draft of your deployable Bicep file, and to ensure it defines all of the Azure resources that are in scope for the migration.

The migrate phase consists of three steps, which you complete in sequence:

1. Create a new empty Bicep file.
2. Copy each resource from your decompiled template.
3. Identify and recreate any missing resources.

:::image type="content" source="../media/2-migrate.png" alt-text="Diagram of migrating a template to Bicep." border="false":::

### Create a new Bicep file

It's good practice to create a brand new Bicep file. The file you created in the _convert_ phase is a reference point for you to look at, but you shouldn't treat it as final or deploy it as-is.

### Copy resources to the new Bicep file

Copy each resource individually from the converted Bicep file to the new Bicep file. This process helps you resolve any issues on a per-resource basis and to avoid any confusion as your template grows in size.

### Recreate unsupported resources

Not all Azure resource types can be exported through the Azure portal, Azure CLI, or Azure PowerShell. For example, virtual machine extensions such as the DependencyAgentWindows and MMAExtension (Microsoft Monitoring Agent) aren't supported resource types for export.

When you attempt to export a resource through the Azure portal, Azure CLI, or Azure PowerShell, and it includes an unsupported resource type, a detailed error message is generated.

For any resource that wasn't exported, such as virtual machine extensions, you'll need to recreate those resources in your new Bicep file. There are several tools and approaches you can use to recreate resources, including Azure Resource Explorer, the ARM template reference documentation, and the Azure Quickstart Templates site.

#### Azure Resource Explorer

[Azure Resource Explorer](/azure/azure-resource-manager/templates/view-resources?azure-portal=true#use-resource-explorer) is a tool embedded into the Azure portal that allows you to view a JSON representation of your deployed resources. The portal doesn't show certain resource types, but Resource Explorer can provide a JSON representation of those resources. You can find Resource Explorer in the Azure portal by searching for the tool in the search bar as shown below:

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

The [ARM template reference documentation](/azure/templates/?azure-portal=true) is a source of information for ARM template structure, resource types, API versions, and property definitions for Azure resources. Both JSON and Bicep examples are included.

It allows you to choose specific resource providers and resource types, such as `Microsoft.Web/serverFarms` and their API versions. You can review which resource properties are required and which are optional. Most properties include documentation to help you understand what they do.

#### Azure Quickstart Templates

The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates?azure-portal=true) repository is a collection of community-contributed templates. This repository of searchable templates provides examples of many Azure resources and solutions. In some quickstarts, both a JSON ARM template and a Bicep ARM template are available to view. These templates can be used as a reference point to help you build and verify your templates for deployment.

For example, suppose you want to find a template that builds an App Service plan and app. In the repository, you'll notice each quickstart template gives you the option to deploy the template directly to Azure, or browse the template on GitHub.

:::image type="content" source="../media/2-azure-quickstart-template.png" alt-text="Graphical example of an Azure Quickstart Template for deploying a basic Linux web app." border="true":::

Keep in mind that the Azure quickstart templates are community contributions. Some of the examples can be out of date as features are added to Azure services regularly. The examples can also include resources and properties that are unnecessary for your templates. However, it's a useful resource to help you understand how to deploy your resources using ARM templates.
