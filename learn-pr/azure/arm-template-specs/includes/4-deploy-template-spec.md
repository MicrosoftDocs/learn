After you've created and published your template spec, you can deploy it. In this unit, you learn about the ways to deploy a template spec.

## Create a deployment by using a template spec

::: zone pivot="biceppowershell,jsonpowershell"

To deploy a template spec to a resource group, you use the same `New-AzResourceGroupDeployment` cmdlet that you're used to. Instead of specifying a template file, you specify a template spec's resource ID, as shown in this example:

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateSpecId '/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/SharedTemplates/providers/Microsoft.Resources/templateSpecs/StorageWithoutSAS'
```

Although template specs have to be created within a resource group, you can deploy them to subscriptions, management groups, or even tenants by using these cmdlets:

| To deploy at this scope: | Use this PowerShell cmdlet: |
|-|-|
| Resource group | `New-AzResourceGroupDeployment` |
| Subscription | `New-AzSubscriptionDeployment` |
| Management group | `New-AzManagementGroupDeployment` |
| Tenant | `New-AzTenantDeployment` |
| | |

Each of these cmdlets accepts the `-TemplateSpecId` parameter to initiate a template spec deployment at one of these scopes.

::: zone-end

::: zone pivot="bicepcli,jsoncli"

To deploy a template spec to a resource group, you use the same `az deployment group create` command that you're used to. Instead of specifying a template file, you specify a template spec's resource ID, as shown in this example:

```azurecli
az deployment group create \
  --template-spec "/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/SharedTemplates/providers/Microsoft.Resources/templateSpecs/StorageWithoutSAS"
```

Although template specs have to be created within a resource group, you can deploy them to subscriptions, management groups, or even tenants by using these commands:

| To deploy at this scope: | Run this Azure CLI command: |
|-|-|
| Resource group | `az deployment group create` |
| Subscription | `az deployment sub create` |
| Management group | `az deployment mg create` |
| Tenant | `az deployment tenant create` |
| | |

Each of these commands accepts the `--template-spec` argument to initiate a template spec deployment at one of these scopes.

::: zone-end

::: zone pivot="jsonpowershell,jsoncli"

## Use a template spec as a linked deployment

To use a template spec from within another Azure Resource Manager template (ARM template), you create a deployment that uses that template spec. This is called a _linked deployment_ because you're linking to a deployment template specified externally.

In Azure, a deployment is a resource that has the resource type `Microsoft.Resources/deployments`. When you deploy an ARM template, you're creating a deployment resource. The same concept applies when you deploy a template spec, like this:

:::code language="json" source="code/4-template.json" range="15-22, 28-30" highlight="7-9" :::

When you have parameters to provide to the template spec deployment, you use the `parameters` property:

:::code language="json" source="code/4-template.json" range="15-30" highlight="10-14" :::

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

## Use a template spec within a Bicep file

To use a template spec from within a Bicep file, you create a reference to the template spec, and then you create a deployment that uses that reference. Let's take a look at how to do this.

First, you use the `existing` keyword to create a reference to the template spec, and to the version of the template spec that you're using:

:::code language="bicep" source="code/4-template.bicep" range="6-12" :::

Now that you have a reference to the template spec, you can create a deployment. In Azure, a deployment is a resource that has the resource type `Microsoft.Resources/deployments`. When you deploy a Bicep file, you're creating a deployment resource. The same concept applies when you deploy a template spec, like this:

:::code language="bicep" source="code/4-template.bicep" range="14-20, 26-27" highlight="5-7" :::

Notice that the deployment includes a reference to the template spec version. It uses the child resource accessor operator (`::`) to refer to the version, because the template spec version is a child resource of the template spec resource.

When you have parameters to provide to the template spec deployment, you use the `parameters` property:

:::code language="bicep" source="code/4-template.bicep" range="14-27" highlight="8-12" :::

::: zone-end

Each parameter is specified as an object, with a `value` property that specifies the value to use.

> [!NOTE]
> You can deploy the resources in the template spec to a different resource group by using the `resourceGroup` and `subscriptionId` properties on the deployment resource.
