Anyone who's deploying or modifying resources in an environment has questions like these on their mind:

- Will I break something?
- Am I going to delete anything?
- How will this deployment affect existing resources?
- Can I validate that what I expect to happen is actually what will happen in the deployment, before I hit the deploy button?

Deploying and hoping for the best isn't a good approach. A better approach is using the *what-if* operation. This operation helps you anticipate the consequences of a new deployment, if you attempt it.

Azure Resource Manager provides the what-if operation to highlight the changes when you deploy a template. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

> [!NOTE]
> The what-if operation sometimes shows that a resource will change when actually no change will happen. We're working to reduce these problems, but we need your help. [Please report these problems](https://aka.ms/whatifissues).

Using the what-if operation compares the current state model to the desired state model. The what-if operation confirms if the changes made by your template match your expectations *without* applying those changes to real resources or to the state of those resources.

## Control the format of what-if results

::: zone pivot="jsonpowershell,biceppowershell"

The `New-AzResourceGroupDeployment` Azure PowerShell cmdlet creates a new deployment to a resource group. When you add the `-Whatif` parameter to this command, the command switches from carrying out the deployment to merely reporting a *preview* of what will happen if you carry it out.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

The `az deployment group what-if` command gives you a preview of what will happen if you carry out a deployment.

::: zone-end

You can control the amount of text output of the what-if operation by using one of these result formats:

- `FullResourcePayloads`. By including this parameter, you get a *verbose* output that consists of a list of resources that will change. The output also shows details about all the properties that will change in accordance with the template.
- `ResourceIdOnly`. This mode returns a list of resources that will change, but not all the details.

For example, assume that you're changing the storage type in a template that deploys a single storage account to an existing environment.

::: zone pivot="jsonpowershell,biceppowershell"

You might run the following PowerShell code and ask for Resource Manager to give you the full resource payloads:

:::code language="azurepowershell" source="code/3-whatif-fullresourcepayloads.ps1" highlight="5" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

:::code language="azurecli" source="code/3-whatif-fullresourcepayloads.sh" highlight="4" :::

::: zone-end

The preceding command produces the following results:

```output
Resource and property changes are indicated with this symbol:
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyStorage

  ~ Microsoft.Storage/storageAccounts/bz64gjjpidbuvi [2019-06-01]
    ~ sku.name: "Standard_LRS" => "Standard_GRS"

Resource changes: 1 to modify.
```

You might then rerun the command but just ask for the resource IDs:

::: zone pivot="jsonpowershell,biceppowershell"

:::code language="azurepowershell" source="code/3-whatif-resourceidonly.ps1" highlight="5" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

:::code language="azurecli" source="code/3-whatif-resourceidonly.sh" highlight="4" :::

::: zone-end

The preceding command produces the following results:

```output
Resource and property changes are indicated with this symbol:
  ! Deploy

The deployment will update the following scope:

Scope: /subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyStorage

  ! Microsoft.Storage/storageAccounts/bz64gjjpidbuvi

Resource changes: 1 to deploy.
```

## Types of changes that what-if detects

When you use the what-if operation, it lists six types of changes:

| Type | Explanation | Effect |
|-|-|-|
| Create | The resource doesn't currently exist but is defined in the template. | The resource will be created. |
| Delete | This change type applies only when you're using complete mode for deployment. The resource exists but isn't defined in the template. | If you deploy by using incremental mode, the resource isn't deleted. If you deploy by using complete mode, the resource is deleted. This change type is returned only for resources that support deletion through complete mode. |
| Ignore | The resource exists but isn't defined in the template. | When you use incremental mode, which is the default deployment mode, the resource isn't deployed or modified. If you deploy by using complete mode, the resource will be deleted. |
| NoChange | The resource exists and is defined in the template. | The resource will be redeployed, but the properties of the resource won't change. This change type is returned when the result format is set to `FullResourcePayloads`, which is the default result format. |
| Modify | The resource exists and is defined in the template. | The resource will be redeployed, and the properties of the resource will change. This change type is returned when the result format is set to `FullResourcePayloads`, which is the default result format. |
| Deploy | The resource exists and is defined in the template. | The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when the result format is set to `ResourceIdOnly`. |

::: zone pivot="jsonpowershell,biceppowershell"

If you don't need to know all of the change types, you can use the `-WhatIfExcludeChangeType` argument to omit the types you're not interested in.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

If you don't need to know all of the change types, you can use the `--what-if-exclude-change-types` argument to omit the types you're not interested in.

::: zone-end

### Use what-if results in a script

You might want to use the output from the what-if operation within a script or as part of an automated deployment process.

::: zone pivot="jsonpowershell,biceppowershell"

You can get the results by using the `Get-AzResourceGroupDeploymentWhatIfResult` cmdlet. Then, your script can parse the results and perform any custom logic you might need.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

You can get the raw JSON results by appending the `--no-pretty-print` argument to your CLI command. Then, your script can parse the results and perform any custom logic you might need.

::: zone-end

## Deployment modes and deletion of resources

There are times when you want to confirm the deletion of resources as you deploy the template. To that end, the what-if operation accounts for the deployment mode that you use. If you use the *complete* deployment mode, Resource Manager reports the resources that it will delete because they aren't defined in your deployment.

Let's look at an example of a template that updates an existing resource and is deployed in complete mode:

:::image type="content" source="../media/3-example.png" alt-text="Diagram showing change types for three resources, some of which already exist." border="false":::

Here's an explanation of what is happening in this example:

- The template is updating a storage account named `storage-1`, which is already deployed. The SKU is changing from *LRS* to *GRS*, and the `owner` tag is changing value to *Team B*. The what-if output shows a **Modify** change type for this resource.
- The template is creating a new Azure Cosmos DB account named `cosmos-db-1`, which doesn't exist in the resource group yet. The what-if output shows a **Create** change type for this resource.
- The template doesn't include the Azure SQL logical server that already exists in the resource group. Because the deployment uses complete mode, the what-if output shows a **Delete** change type for this resource. If the deployment used incremental mode instead of complete mode, the change type would be **Ignore** instead.

## Confirm your deployments

::: zone pivot="jsonpowershell,biceppowershell"

To preview changes before deploying a template, use the `-Confirm` parameter with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to finish.

> [!TIP]
> It's a good idea to run your deployment commands with the `-Confirm` switch, especially if you're deploying in complete mode. If you use the `-Confirm` switch, you have a chance to stop the operation if you don't like the proposed changes.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

To preview changes before deploying a template, use the `--confirm-with-what-if` argument with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to finish.

> [!TIP]
> It's a good idea to run your deployment commands with the `--confirm-with-what-if` argument, especially if you're deploying in complete mode. If you use the `--confirm-with-what-if` switch, you have a chance to stop the operation if you don't like the proposed changes.

::: zone-end
