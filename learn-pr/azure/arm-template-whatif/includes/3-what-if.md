Questions are always on the mind of anyone who's deploying or modifying resources in an environment:

- Will I break something?
- Am I going to delete anything?
- How will this deployment affect existing resources?
- Can I validate that what I expect will happen is actually what will happen in the deployment, before I hit the deploy button?

Deploying and hoping for the best is not a good approach. A better approach is using the *what-if* operation. This operation helps you anticipate what consequences a new deployment will have, if you attempt it.

Azure Resource Manager provides the what-if operation to highlight the changes when you deploy a template. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

Using the what-if operation allows you to estimate what would happen if you were to deploy, by comparing the current state model to the desired state model. The what-if operation confirms if the changes made by your template match your expectations *without* applying those changes to real resources or to the state of those resources.

## Types of changes detected by what-if

When you use the what-if operation, it lists six types of changes:

- **Create**. The resource doesn't currently exist but is defined in the template. The resource will be created.
- **Delete**. This change type applies only when you're using *complete mode* for deployment. The resource exists but isn't defined in the template. With complete mode, the resource will be deleted. This change type includes only resources that support deletion through complete mode.
- **Ignore**. The resource exists but isn't defined in the template. The resource won't be deployed or modified. <!-- TODO Will Ignore only happen for incremental mode deployments? -->
- **NoChange**. The resource exists and is defined in the template. The resource will be redeployed, but the properties of the resource won't change. This change type is returned when **WhatIfResultFormat** is set to **FullResourcePayloads**, which is the default value. <!-- TODO What's a situation where NoChange would happen? -->
- **Modify**. The resource exists and is defined in the template. The resource will be redeployed, and the properties of the resource will change. This change type is returned when **WhatIfResultFormat** is set to **FullResourcePayloads**, which is the default value.
- **Deploy**. The resource exists and is defined in the template. The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when **WhatIfResultFormat** is set to **ResourceIdOnly**.

## Control the format of what-if results

::: zone pivot="jsonpowershell,biceppowershell"

The `New-AzResourceGroupDeployment` Azure PowerShell cmdlet creates a new deployment to a resource group. When you add the `-Whatif` parameter to this command, the command switches from carrying out the deployment to merely reporting a *preview* of what will happen if you carry it out.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

The `az deployment group what-if` command gives you a preview of what will happen if you carry out a deployment.

::: zone-end

You can control the amount of text output of the what-if operation by using one of these two result formats:

- **FullResourcePayloads**. By including this parameter, you get a *verbose* output that consists of a list of resources that will change. The output also shows details about all the properties that will change in accordance with the template.
- **ResourceIdOnly**. This mode returns a list of resources that will change, but not all the details.

For example, assume that you're changing the storage type in a template that deploys a single storage account to an existing environment.

::: zone pivot="jsonpowershell,biceppowershell"

You might execute the following PowerShell code and ask for Resource Manager to give you the full resource payloads:

:::code language="azurepowershell" source="code/3-whatif-fullresourcepayloads.ps1" highlight="5" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

:::code language="azurecli" source="code/3-whatif-fullresourcepayloads.sh" highlight="4" :::

::: zone-end

The above command produces the following results:

```output
Resource and property changes are indicated with this symbol:
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/WhatIfTest1

  ~ Microsoft.Storage/storageAccounts/bz64gjjpidbuvi [2019-06-01]
    ~ sku.name: "Standard_LRS" => "Standard_GRS"

Resource changes: 1 to modify.
```

You might then re-execute the command but just ask for the resource IDs:

::: zone pivot="jsonpowershell,biceppowershell"

:::code language="azurepowershell" source="code/3-whatif-resourceidonly.ps1" highlight="5" :::

::: zone-end

::: zone pivot="jsoncli,bicepcli"

:::code language="azurecli" source="code/3-whatif-resourceidonly.sh" highlight="4" :::

::: zone-end

The above command produces the following results:

```output
Resource and property changes are indicated with this symbol:
  ! Deploy

The deployment will update the following scope:

Scope: /subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/WhatIfTest1

  ! Microsoft.Storage/storageAccounts/bz64gjjpidbuvi

Resource changes: 1 to deploy.
```

### Use what-if results in a script

You might want to use the output from the what-if operation within a script or as part of an automated deployment process.

::: zone pivot="jsonpowershell,biceppowershell"

You can get the results by using the `Get-AzResourceGroupDeploymentWhatIfResult` cmdlet. Then, your script can parse the results and perform any custom logic you might need.

::: zone-end

::: zone pivot="jsoncli,bicepcli"

You can get the raw JSON results by appending the `--no-pretty-print` argument to your CLI command. Then, your script can parse the results and perform any custom logic you might need.

::: zone-end

## Deployment modes and deletion of resources

There are times when you'll want to confirm the deletion of resources as you deploy the template. To that end, the what-if operation accounts for the deployment mode you use. If you use the *Complete* deployment mode, Resource Manager will report the resources it'll delete because they aren't defined in your deployment.

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

<!-- TODO mention excluding change types -->