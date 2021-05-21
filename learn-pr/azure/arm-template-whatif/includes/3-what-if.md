Questions are always on the mind of anyone who's deploying or modifying resources in an environment:

- Will I break something?
- How will this deployment affect existing resources?
- Can I validate that what we're thinking will happen is actually what will happen in the deployment, before I hit the deploy button?

Deploying and hoping for the best is not a good approach. A better approach is using the *what-if* operation. This operation helps you anticipate what consequences a new deployment will have, if you attempt it.

Azure Resource Manager provides the what-if operation to highlight the changes when you deploy a template. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

Using the what-if operation allows you to estimate what would happen if you were to deploy, by comparing the current state model to the desired state model. The what-if operation confirms if the changes made by your template match your expectations *without* applying those changes to real resources or to the state of those resources.

A benefit to using a state file is that you can do some work disconnected and possibly avoid some round trips to the server - allowing for a tighter development cycle. Reliance on an external API puts you at the mercy of a network connection for the development cycle, so having the what-if operation can end up saving you a lot of time.

## Change types

When you use the what-if operation, it lists six types of changes:

- **Create**. The resource doesn't currently exist but is defined in the template. The resource will be created.
- **Delete**. This change type applies only when you're using *complete mode* for deployment. The resource exists but isn't defined in the template. With complete mode, the resource will be deleted. This change type includes only resources that support deletion through complete mode.
- **Ignore**. The resource exists but isn't defined in the template. The resource won't be deployed or modified.
- **NoChange**. The resource exists and is defined in the template. The resource will be redeployed, but the properties of the resource won't change. This change type is returned when **WhatIfResultFormat** is set to **FullResourcePayloads**, which is the default value.
- **Modify**. The resource exists and is defined in the template. The resource will be redeployed, and the properties of the resource will change. This change type is returned when **WhatIfResultFormat** is set to **FullResourcePayloads**, which is the default value.
- **Deploy**. The resource exists and is defined in the template. The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when **WhatIfResultFormat** is set to **ResourceIdOnly**.

## Result format

::: zone pivot="jsonpowershell,biceppowershell"

The PowerShell cmdlet **New-AzResourceGroupDeployment** creates a new deployment on a resource group. When you add the what-if operation as a parameter to this command, the command switches from carrying out the deployment to merely reporting a *preview* of what will happen if you carry it out.

You can control the amount of text output of the what-if operation by using one of these two parameters:

- **FullResourcePayloads**. By including this parameter, you get a *verbose* output that consists of a list of resources that will change. The output also shows details about all the properties that will change in accordance with the template.
- **ResourceIdOnly**. This mode returns a list of resources that will change, but not all the details.

For example, assume that you're changing the storage type in a template that deploys a single storage account to an existing environment.

You might execute the following PowerShell code and ask for Resource Manager to give you the full resource payloads:

:::code language="azurepowershell" source="3-whatif-fullresourcepayloads.ps1" highlight="7" :::

The above command produces the following results:

```output
Resource and property changes are indicated with this symbol:
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/54a522b6-6cd7-4325-b4e6-566f9d921835/resourceGroups/What-if

  ~ Microsoft.Storage/storageAccounts/whatifbszktl3jpcqrc [2019-06-01]

Resource changes: 1 to modify
```

You might then re-execute the PowerShell code but just ask for the resource IDs:

:::code language="azurepowershell" source="3-whatif-resourceidonly.ps1" highlight="7" :::

The above command produces the following results:

```output
Resource and property changes are indicated with this symbol:
   ! Deploy

The deployment will update the following scope:

Scope: /subscriptions/54a522b6-6cd7-4325-b4e6-566f9d921835/resourceGroups/What-if

  ! Microsoft.Storage/storageAccounts/whatifbszktl3jpcqrc
```

::: zone-end

## Removal or deletion of resources and deployment modes

There are times when you'll want to confirm the removal or deletion of resources as you deploy the template. To that end, the what-if operation TODO complete vs. incremental

### Confirmation

To preview changes before deploying a template, use the *confirm switch* parameter with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to finish.

> [!TIP]
> We highly recommend that you run any deployment commands with confirm switch, especially if you're running in complete mode. If you use confirm switch, you have a chance to stop the operation if you don't like the proposed changes.
