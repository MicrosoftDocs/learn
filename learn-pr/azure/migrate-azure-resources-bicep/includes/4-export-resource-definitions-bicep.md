Recently, your company acquired a smaller competitor. This company deployed its Azure resources using ARM JSON templates and the Azure portal. You've already started the process of converting the JSON templates to Bicep, but now you need to address the resources deployed manually through the Azure portal. You want to learn about the different methods of exporting Azure resources to templates and the limitations of this process, while following recommended workflow.

## Export resources from the Azure portal

The Azure portal provides multiple methods of exporting Azure resources to a template. You can export single resources, multiple resources, and entire resource groups, and there are multiple places within the Azure portal to accomplish the task. Additionally, you have the option of exporting templates before and after a deployment.

### Export a template from a resource

There are multiple ways to export a single resource to a template within the Azure portal. You can export a resource from its resource group or from the resource itself. Both methods will provide you with the same exported template.

To export a template from the resource group from the Azure portal:

1. Navigate to the resource group that contains the resource you want to export.

2. Place a checkbox next to the resource that you want to export.

3. Select **Export template** from the top of the window.

   :::image type="content" source="../media/4-export-resource-rg1.png" alt-text="Screenshot." border="true":::

4. From the **Export resource group template** blade, click **Download** to save a copy of the template.

   :::image type="content" source="../media/4-export-resource-rg2.png" alt-text="Screenshot." border="true":::

To export a template from the resource from the Azure portal:

1. Navigate to the resource group that contains the resource you want to export.

2. In the list of resources in the resource group, click the resource you want to export. The resource blade will open up.

3. From the resource blade under the **Automation** section, select **Export template**, and then click **Download** as shown in the image below. A download will automatically begin and will include both the main JSON template and the parameters JSON file.

   :::image type="content" source="../media/4-export-resource.png" alt-text="Screenshot." border="true":::

### Export from resource group

The export a template from the resource group from the Azure portal:

1. Navigate to the resource group that contains the resource you want to export.

2. From the resource group blade under the **Automation** section, select **Export template**, and then click **Download** as shown in the image below. A download will automatically begin and will include both the main JSON template and the parameters JSON file.

   :::image type="content" source="../media/4-export-resource-group.png" alt-text="Screenshot." border="true":::

## Export resources using Azure CLI and Azure PowerShell

Similar to the Azure portal, the Azure CLI and Azure PowerShell can also be used to export resources and resource groups to JSON templates. The process is similar for both command-line utilities. Both the Azure CLI and Azure PowerShell can export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group.

### Azure CLI

You can use the Azure CLI to export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group using the `az group export` command. The export will display the JSON in the terminal window.

To export all resources in a specific resource group, you can use the `az group export` command as shown below:

```azurecli
az group export --name mslearn_bicep
```

To export a single resource from the resource group, you need to pass the resource ID to the `az group export` command as shown below:

```azurecli
$virtualMachine=az resource show --resource-group mslearn_bicep --name vm-prod-001 --resource-type Microsoft.Compute/virtualMachines --query id --output tsv
az group export --resource-group mslearn_bicep --resource-ids $virtualMachine
```

To export multiple resources from the resource group, you need to pass the resource IDs, separated by a space, to the `az group export` command as shown below:

```azurecli
az group export --resource-group mslearn_bicep --resource-ids $resource1Id $resource2Id $resource3Id
```

### Azure PowerShell

You can use Azure PowerShell to export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group using the `Export-Az-ResourceGroup` command. The export will save the JSON template in the root of the directory where you're running the command from.

To export all resources in a specific resource group, you can use the `Export-Az-ResourceGroup` command as shown below:

```Azure PowerShell
Export-AzResourceGroup -ResourceGroupName mslearn_bicep
```

To export a single resource from the resource group, you need to pass the resource ID to the `Export-Az-ResourceGroup` command as shown below:

```Azure PowerShell
$virtualMachine = Get-AzResource -ResourceGroupName mslearn_bicep -ResourceName vm-prod-001 -ResourceType Microsoft.Compute/virtualMachines
Export-AzResourceGroup -ResourceGroupName mslearn_bicep -Resource $virtualMachine.ResourceId
```

To export multiple resources from the resource group, you need to pass the resource IDs in an array to the `Export-Az-ResourceGroup` command as shown below:

```Azure PowerShell
Export-AzResourceGroup -ResourceGroupName mslearn_bicep -Resource @($resource1.ResourceId, $resource3.ResourceId, $resource3.ResourceId,)
```

## Limitations

Insert text here.

- Not all Azure resource types can be exported through the Azure portal, Azure CLI, or Azure PowerShell. For example, virtual machine extensions such as the DependencyAgentWindows and MMAExtension (Microsoft Monitoring Agent) aren't supported resource types for export. Consider treating these exported templates as a starting point and use them as inspiration for your final template. Other reference material such as the [Azure Resource Explorer](azure/azure-resource-manager/templates/view-resources#use-resource-explorer), the [Azure ARM Template Reference](azure/templates/) documentation, or [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) are needed to help complete your template deployments.

  When you attempt to export resources from the Azure portal and it includes unsupported resource types, you'll see a warning banner as shown below:

  :::image type="content" source="../media/4-export-error-banner.png" alt-text="Screenshot of the banner message." border="true":::

  Clicking on **See error details** in the warning banner will open up additional information about the unsupported resource types. In the screenshot below, you'll notice that the DependencyAgentWindows and the MicrosoftMonitoringAgent aren't able to be exported.

  :::image type="content" source="../media/4-export-error-details.png" alt-text="Screenshot." border="true":::

  When you attempt to export resources using Azure CLI and it includes unsupported resource types, an error message will be generated as shown below:

  :::image type="content" source="../media/4-export-error-azcli.png" alt-text="Screenshot." border="true":::

  When you attempt to export resources using Azure PowerShell and it includes unsupported resource types, an error message is as shown below:

  :::image type="content" source="../media/4-export-error-powershell.png" alt-text="Screenshot." border="true":::

- When exporting Azure resources, the exported template may not have the latest API version for a resource type. If there are specific properties that you need for future deployments, update the API to the appropriate version. It's good practice to review the API versions for each exported resource.

- The export template feature is unable to export more than 200 resources from a resource group at one time. If your resource group contains more than 200 resources, you'll need to export multiple times to capture all resources. The error message `Export template is not supported for resource groups more than 200 resources` is shown if you attempt to export more than 200 resources.

- If your environment contains any resources deployed through the Azure classic deployment model, those resources need to be migrated to the Resource Manager deployment model first.

## Recommended workflow for exporting templates to Bicep

You've exported your resource and resource group templates using one of the available methods, and now it's time to convert those templates to Bicep. In the previous unit, you learned about a recommended workflow for converting templates. You can follow the same workflow when exporting templates, with only a few changes.

1. **Create a new Bicep file** - Using [Visual Studio Code](https://code.visualstudio.com/), create a new Bicep file. This new file will become the main template file for your converted template.

2. **Export the ARM JSON template** - Using the Azure portal, Azure CLI, Azure PowerShell, or the REST API, export the resource or resource group template. Make note of any error messages about resource types that cannot be exported.

3. **Decompile the source ARM JSON template** - From a terminal window, run either the `az bicep decompile` or the `bicep decompile` command against your source JSON template to convert the file to a Bicep template. Using Visual Studio Code, open your new Bicep file and the decompiled JSON file side by side.

4. **Copy the resources from converted Bicep file to new Bicep file** - For each defined resource in your original JSON template, copy it from the converted Bicep file to the new Bicep file. Consider copying the resources individually, so that you can resolve any issues on a per resource basis.

5. **Re-create any resources that were not exported** - For any resource that wasn't exported, such as virtual machine extensions, you'll need to re-create those resources in your new Bicep file. Consider using the [Azure Resource Explorer](azure/azure-resource-manager/templates/view-resources#use-resource-explorer), the [Azure ARM Template Reference](azure/templates/) documentation, or [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) to help re-create these resources.

6. **Review the linter suggestions in your new Bicep file** - When creating Bicep files using the [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), the linter runs automatically and highlights suggestions and errors in your code. Many of the suggestions and errors include an option to apply a quick fix of the issue. Review these recommendations and adjust your Bicep file.

7. **Revise parameters, variables, and symbolic names** - It's possible that the names of parameters, variables, and symbolic names generated by the decompiler won't match your standard naming convention. Review the generated names and make adjustments as necessary.

8. **Simplify expressions** - The decompile process may not always take advantage of some of Biceps features. Review any expressions generated in the conversion and simplify them. The result may include a concat function that could be simplified using string interpolation. Review any suggestions from the linter and make adjustments as necessary.

9. **Review child and extension resources** - With Bicep, there are multiple ways to declare child and extension resources. Consider reviewing these resources after decompilation and make sure that the structure meets your standards. For example, Subnets can either be referenced as properties of a Virtual Network, or as a separate resource. Make any necessary changes to child and extension resources.

10. **Modularize** - If you're converting a template that has many resources, consider breaking the individual resource types into modules for simplicity. Bicep modules help to reduce the complexity of your template deployments.

    > [!NOTE]
    > It's possible to use your JSON templates as modules in a Bicep deployment. Bicep has the ability to recognize JSON modules and reference them the same way as Bicep modules.

11. **Add comments** - Good Bicep code is _self-documenting_! Bicep allows you to add comments to your code that help you document your infrastructure. These comments can help your teammates understand the code, and increase confidence when changes are made. Comments are ignored when the Bicep file is deployed to Azure.

12. **Perform a test deployment** - Before introducing your converted Bicep template to production, consider running multiple test deployments. If you have multiple environments (prod, dev, test), you may want to try deploying your template to one of your non-production environments first.

    > [!NOTE]
    > If you're going to use the converted template in a pipeline, such as Azure DevOps or GitHub Actions, consider running the deployment from your local machine first. It's better to verify the functionality of the template before adding it to your production pipeline.
