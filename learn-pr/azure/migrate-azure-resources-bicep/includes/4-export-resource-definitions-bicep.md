Recently, your company acquired a smaller competitor. This company deployed its Azure resources using JSON ARM templates and the Azure portal. You've already started the process of converting the JSON templates to Bicep, but now you need to address the resources deployed manually through the Azure portal and command line. You start by focusing on a series of resources that support an application for a line of toy trucks. You want to learn about the different methods of exporting Azure resources to templates and the limitations of this process, while following recommended workflow.

## Export Azure resources to a template

Azure Resource Manager is the service that's used to deploy and manage resources in Azure. All resources deployed to Azure are tracked by Azure Resource Manager, regardless of the method used to deploy the resource. Information about each resource is made available in JSON format by Azure Resource Manager. 

:::image type="content" source="../media/4-azure-resource-manager.png" alt-text="Diagram of Azure Resource Manager." border="true":::

You can use the Azure portal, Azure CLI, Azure PowerShell, the REST API, and SDKs to interact with Azure Resource Manager. These tools can also be used to export your Azure resources and resource groups to JSON ARM templates. This is one of the first steps in migrating your Azure resources to Bicep. Later in this module, you'll practice exporting JSON ARM templates.

> [!NOTE]
> The export template feature is unable to export more than 200 resources from a resource group at one time. If your resource group contains more than 200 resources, you'll need to export multiple times to capture all resources.

### Export resources using the Azure portal

The Azure portal provides multiple methods of exporting Azure resources to a template. You can export single resources, multiple resources, and entire resource groups. There are multiple places within the Azure portal to accomplish these tasks. Additionally, you have the option of exporting templates before and after a deployment.

#### Export a single resource, multiple resources, or a resource group

Single resources can be exported to template from either the resource group blade, or from the resource blade itself. Both methods will provide you with the same exported template. Multiple resources can also be exported to template from the resource group blade.

Exporting a template for a single resource or multiple resources from the resource group blade can be accomplished by selecting the checkboxs next to the resources you want to export, and selecting **Export template**. Another blade will open, allowing you to download the template.

:::image type="content" source="../media/4-export-template-resource-resource-group.png" alt-text="Resource group blade toolbar highlighting the export template function." border="true":::

Exporting a template for a single resource from the resource blade can be accomplished by selecting **Export template** under the **Automation** section. Another blade will open, allowing you to download the template.

:::image type="content" source="../media/4-export-template-resource.png" alt-text="Resource blade export template function under the automation section." border="true":::

All resources in a resource group can be exported to template from the resource group blade. You can select the checkbox next to all of the resources and select **Export template** from the top of the window. You can also select **Export template** under the **Automation** section. Another blade will open, allowing you to download the template.

:::image type="content" source="../media/4-export-template-resource-group.png" alt-text="Resource group export template function under the automation section." border="true":::

There are a few things that you need to consider when exporting your templates using this method.

1. The exported template is a snapshot of that resource, resources,  or resource group's current state. It will include all changes made to the resources since initial deployment.

2. The exported template may include some default resource properties that are normally not specified in a standard deployment. You'll need to consider removing these properties before redeployment.

3. The exported template may not include all of the parameters you'll need to make the template reusable. Many of these parameters may be hard-coded into the template.

#### Export template from a deployment

The Azure portal allows you export a template of a resource before its initial deployment or from its deployment history.

If you've ever deployed a resource manually from the Azure portal, you may have noticed the option to **Download a template for automation** before the deployment of the resource. This option exports a JSON ARM template based on the names and properties you've set while building the resource in the portal.

:::image type="content" source="../media/4-download-template-for-automation.png" alt-text="Download template for automation option when deploying a new resource." border="true":::

You can also export a JSON ARM template based on its deployment history. As mentioned before, Azure Resource Manager tracks all resources and resource deployments. To export a resource template from its deployment history, click **Deployments** from the resource group blade. You may see multiple deployments listed. Click the name of the deployment that you want to export, click **Template** on the deployment blade, and click **Download** to save a copy of the template.

:::image type="content" source="../media/4-export-template-deployment-history.png" alt-text="Download template from deployment history." border="true":::

There are a few things that you need to consider when exporting your templates using this method.

1. The exported template shows the state of the resource(s) at the time of deployment. It won't include any changes made after deployment.

2. You won't be able to select specific resources from a multi-resource deployment. This option will download all resources that were part of the initial deployment.

3. The template will only include resource properties needed for deployment. In most cases, you can consider this template ready to use.

4. The template will include parameters that will allow you to redeploy the template in multiple environments.

### Export resources using Azure CLI and Azure PowerShell

Similar to the Azure portal, the Azure CLI and Azure PowerShell can also be used to export resources and resource groups to JSON templates. The process is similar for both command-line utilities. Both the Azure CLI and Azure PowerShell can export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group.

::: zone pivot="cli"

#### Azure CLI

You can use the Azure CLI to export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group using the `az group export` command. The export will display the JSON in the terminal window.

To export all resources in a specific resource group, you can use the `az group export` command as shown below:

```azurecli
az group export --name rg-app-prod-truckline
```

To export a single resource from the resource group, you need to pass the resource ID to the `az group export` command as shown below:

```azurecli
$virtualMachine=az resource show --resource-group rg-app-prod-truckline --name vm-prod-001 --resource-type Microsoft.Compute/virtualMachines --query id --output tsv
az group export --resource-group rg-app-prod-truckline --resource-ids $virtualMachine
```

To export multiple resources from the resource group, you need to pass the resource IDs, separated by a space, to the `az group export` command as shown below:

```azurecli
az group export --resource-group rg-app-prod-truckline --resource-ids $resource1Id $resource2Id $resource3Id
```

::: zone-end

::: zone pivot="powershell"

#### Azure PowerShell

You can use Azure PowerShell to export all resources in a resource group, single resources from a resource group, and multiple resources from a resource group using the `Export-Az-ResourceGroup` command. The export will save the JSON template in the root of the directory where you're running the command from.

To export all resources in a specific resource group, you can use the `Export-Az-ResourceGroup` command as shown below:

```Azure PowerShell
Export-AzResourceGroup -ResourceGroupName rg-app-prod-truckline
```

To export a single resource from the resource group, you need to pass the resource ID to the `Export-Az-ResourceGroup` command as shown below:

```Azure PowerShell
$virtualMachine = Get-AzResource -ResourceGroupName rg-app-prod-truckline -ResourceName vm-prod-001 -ResourceType Microsoft.Compute/virtualMachines
Export-AzResourceGroup -ResourceGroupName rg-app-prod-truckline -Resource $virtualMachine.ResourceId
```

To export multiple resources from the resource group, you need to pass the resource IDs in an array to the `Export-Az-ResourceGroup` command as shown below:

```Azure PowerShell
Export-AzResourceGroup -ResourceGroupName rg-app-prod-truckline -Resource @($resource1.ResourceId, $resource3.ResourceId, $resource3.ResourceId,)
```

::: zone-end

## Which resources can be exported?

Not all Azure resource types can be exported through the Azure portal, Azure CLI, or Azure PowerShell. For example, virtual machine extensions such as the DependencyAgentWindows and MMAExtension (Microsoft Monitoring Agent) aren't supported resource types for export. Consider treating these exported templates as a starting point and use them as inspiration for your final template.

When you attempt to export resources from the Azure portal and it includes unsupported resource types, you'll see a warning banner as shown below:

:::image type="content" source="../media/4-export-error-banner.png" alt-text="Error message about resources that cannot be exported." border="true":::

Clicking on **See error details** in the warning banner will open up additional information about the unsupported resource types. In the screenshot below, you'll notice that the DependencyAgentWindows and the MicrosoftMonitoringAgent aren't able to be exported.

:::image type="content" source="../media/4-export-error-details.png" alt-text="Details of the error for the resources that cannot be exported." border="true":::

When you attempt to export resources using Azure CLI or Azure PowerShell and it includes unsupported resource types, an error message will be generated as shown below:

Azure CLI

:::image type="content" source="../media/4-export-error-azcli.png" alt-text="Azure CLI error message about resources that cannot be exported.." border="true":::

Azure PowerShell

:::image type="content" source="../media/4-export-error-powershell.png" alt-text="Azure PowerShell error message about resources that cannot be exported.." border="true":::

## Recommended workflow for exporting templates to Bicep

You've exported your resource and resource group templates using one of the available methods, and now it's time to convert those templates to Bicep. In the previous unit, you learned about a recommended workflow for converting templates. You can follow the same workflow when exporting templates, with only a few changes.

1. **Create a new Bicep file** - Using [Visual Studio Code](https://code.visualstudio.com/), create a new Bicep file. This new file will become the main template file for your converted template.

2. **Export the JSON ARM template** - Using the Azure portal, Azure CLI, Azure PowerShell, or the REST API, export the resource or resource group template. Make note of any error messages about resource types that cannot be exported.

3. **Review resource API version** - When exporting Azure resources, the exported template may not have the latest API version for a resource type. If there are specific properties that you need for future deployments, update the API to the appropriate version. It's good practice to review the API versions for each exported resource.

4. **Decompile the source JSON ARM template** - From a terminal window, run either the `az bicep decompile` or the `bicep decompile` command against your source JSON template to convert the file to a Bicep template. Using Visual Studio Code, open your new Bicep file and the decompiled JSON file side by side.

5. **Copy the resources from converted Bicep file to new Bicep file** - For each defined resource in your original JSON template, copy it from the converted Bicep file to the new Bicep file. Consider copying the resources individually, so that you can resolve any issues on a per resource basis.

6. **Re-create any resources that were not exported** - For any resource that wasn't exported, such as virtual machine extensions, you'll need to re-create those resources in your new Bicep file. Consider using the [Azure Resource Explorer](azure/azure-resource-manager/templates/view-resources#use-resource-explorer), the [Azure ARM Template Reference](azure/templates/) documentation, or [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) to help re-create these resources.

7. **Review the linter suggestions in your new Bicep file** - When creating Bicep files using the [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep), the linter runs automatically and highlights suggestions and errors in your code. Many of the suggestions and errors include an option to apply a quick fix of the issue. Review these recommendations and adjust your Bicep file.

8. **Revise parameters, variables, and symbolic names** - It's possible that the names of parameters, variables, and symbolic names generated by the decompiler won't match your standard naming convention. Review the generated names and make adjustments as necessary.

9. **Simplify expressions** - The decompile process may not always take advantage of some of Biceps features. Review any expressions generated in the conversion and simplify them. The result may include a concat function that could be simplified using string interpolation. Review any suggestions from the linter and make adjustments as necessary.

10. **Review child and extension resources** - With Bicep, there are multiple ways to declare child and extension resources. Consider reviewing these resources after decompilation and make sure that the structure meets your standards. For example, Subnets can either be referenced as properties of a Virtual Network, or as a separate resource. Make any necessary changes to child and extension resources.

11. **Modularize** - If you're converting a template that has many resources, consider breaking the individual resource types into modules for simplicity. Bicep modules help to reduce the complexity of your template deployments.

    > [!NOTE]
    > It's possible to use your JSON templates as modules in a Bicep deployment. Bicep has the ability to recognize JSON modules and reference them the same way as Bicep modules.

12. **Add comments** - Good Bicep code is _self-documenting_! Bicep allows you to add comments to your code that help you document your infrastructure. These comments can help your teammates understand the code, and increase confidence when changes are made. Comments are ignored when the Bicep file is deployed to Azure.

13. **Follow Bicep best practices** - Make sure that your Bicep file is following the recommended best practices. Review the [Bicep best practices](/azure/azure-resource-manager/bicep/best-practices) reference document for anything you might have missed.

14. **Perform a test deployment** - Before introducing your converted Bicep template to production, consider running multiple test deployments. If you have multiple environments (prod, dev, test), you may want to try deploying your template to one of your non-production environments first.

    > [!NOTE]
    > If you're going to use the converted template in a pipeline, such as Azure DevOps or GitHub Actions, consider running the deployment from your local machine first. It's better to verify the functionality of the template before adding it to your production pipeline.
