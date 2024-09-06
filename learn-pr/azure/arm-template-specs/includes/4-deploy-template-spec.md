After you create and publish your template spec, you can deploy it. In this unit, you learn about the ways to deploy a template spec.

## Create a deployment by using a template spec

::: zone pivot="biceppowershell,jsonpowershell"

To deploy a template spec to a resource group, you use the same `New-AzResourceGroupDeployment` cmdlet that you're familiar with. Instead of specifying a template file, you specify a template spec's resource ID, as shown in this example:

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

To deploy a template spec to a resource group, you use the same `az deployment group create` command that you're familiar with. Instead of specifying a template file, you specify a template spec's resource ID, as shown in this example:

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

To use a template spec from within another Azure Resource Manager template (ARM template), you create a deployment that uses that template spec. This type of deployment is called a *linked deployment* because you're linking to a deployment template specified externally.

In Azure, a deployment is a resource that has the resource type `Microsoft.Resources/deployments`. When you deploy an ARM template, you're creating a deployment resource. The same concept applies when you deploy a template spec, like this:

:::code language="json" source="code/4-template.json" range="15-22, 28-30" highlight="7-9" :::

When you have parameters to provide to the template spec deployment, you use the `parameters` property:

:::code language="json" source="code/4-template.json" range="15-30" highlight="10-14" :::

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

## Use a template spec as a Bicep module

You can use a template spec as a module within a Bicep file:

:::code language="bicep" source="code/4-template.bicep" range="3-4, 8" :::

Notice that the module path uses a special format:

:::image type="content" source="../media/4-template-spec-module-path.png" alt-text="Diagram showing the components of the template spec path." border="false":::

There are three components to the module path, separated by the colon (`:`) character:

- **Scheme:** Bicep supports several types of module, which are called *schemes*. When you use a template spec as a module, you use `ts` as the scheme.
- **Subscription ID, resource group name, and template spec name:** These values should specify the location of the template spec resource that you previously published. You use forward slashes (`/`) to separate the subscription ID, resource group name, and template spec name. This section of the module path isn't the full resource ID of the template spec - it's just a few of the components of the resource ID.
- **Version:** The template spec version needs to be included.

> [!NOTE]
> You can't use variables, parameters, or string interpolation when you specify the path to a module. The full template spec path needs to be saved into your Bicep file.

When you have parameters to provide to the template spec, you use the `params` property:

:::code language="bicep" source="code/4-template.bicep" range="3-8" highlight="3-5" :::

The template spec file is downloaded and copied (*transpiled*) into your JSON ARM template when the Bicep file is built. Normally this operation happens when you deploy your Bicep file, but you can also use the Bicep tooling to transpile explicitly by running the `bicep build` command.

::: zone-end
