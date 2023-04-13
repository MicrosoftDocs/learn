
When deploying your resources, you specify that the deployment is either an incremental update or a complete update. The difference between these two modes is how Resource Manager handles existing resources in the resource group that aren't in the template. The default mode is incremental.

For both modes, Resource Manager tries to create all resources specified in the template. If the resource already exists in the resource group and its settings are unchanged, no operation is taken for that resource. If you change the property values for a resource, the resource is updated with those new values. If you try to update the location or type of an existing resource, the deployment fails with an error. Instead, deploy a new resource with the location or type that you need.

## Complete mode

In complete mode, Resource Manager **deletes** resources that exist in the resource group that aren't specified in the template.

If your template includes a resource that isn't deployed because `condition` evaluates to false, the result depends on which REST API version you use to deploy the template. If you use a version earlier than 2019-05-10, the resource **isn't deleted**. With 2019-05-10 or later, the resource **is deleted**. The latest versions of Azure PowerShell and Azure CLI delete the resource.

Be careful using complete mode with `copy loops`. Any resources that aren't specified in the template after resolving the copy loop are deleted.

## Incremental mode

In incremental mode, Resource Manager **leaves unchanged** resources that exist in the resource group but aren't specified in the template.

However, when redeploying an existing resource in incremental mode, the outcome is different. Specify all properties for the resource, not just the ones you're updating. A common misunderstanding is to think properties that aren't specified are left unchanged. If you don't specify certain properties, Resource Manager interprets the update as overwriting those values.

## Example result

To illustrate the difference between incremental and complete modes, consider the following table.

| **Resource Group** contains | **Template** contains | Incremental result | Complete result |
|--|--|--|--|
| Resource A<br/>Resource B<br/>Resource C<br/> | Resource A<br/>Resource B<br/>Resource D | Resource A<br/>Resource B<br/>Resource C<br/>Resource D | Resource A<br/>Resource B<br/>Resource D |

When deployed in **incremental** mode, Resource D is added to the existing resource group. When deployed in **complete** mode, Resource D is added and Resource C is deleted. 

## Set deployment mode

To set the deployment mode when deploying with PowerShell, use the `Mode` parameter.

```powershell
New-AzResourceGroupDeployment `
  -Mode Complete `
  -Name ExampleDeployment `
  -ResourceGroupName ExampleResourceGroup `
  -TemplateFile c:\MyTemplates\storage.json
```

To set the deployment mode when deploying with Azure CLI, use the `mode` parameter.

```azurecli
az deployment group create \
  --mode Complete \
  --name ExampleDeployment \
  --resource-group ExampleResourceGroup \
  --template-file storage.json
```
