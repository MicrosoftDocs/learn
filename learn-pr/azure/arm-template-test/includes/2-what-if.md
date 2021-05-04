Questions are always on the mind of anyone who's deploying or modifying resources in an environment:

- Will I break something?
- How will this deployment affect existing resources?
- Can I validate that what we're thinking will happen is actually what will happen in the deployment, before I hit the deploy button?

Deploying and hoping for the best is not a good approach. A better approach is using the *what-if* operation. This operation helps you anticipate what consequences a new deployment will have, if you attempt it.

Azure Resource Manager provides the what-if operation to highlight the changes when you deploy a template. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

> [!NOTE]
> The what-if operation is currently in preview. As a preview release, the results might sometimes show that a resource will change when actually no change will happen. We're working to reduce these issues, but we need your help. Please [report these issues](https://aka.ms/whatifissues?azure-portal=true).
>

Using the what-if operation allows you to estimate what would happen if you were to deploy, by comparing the current state model to the desired state model. The what-if operation confirms if the changes made by your template match your expectations *without* applying those changes to real resources or to the state of those resources.

A benefit to using a state file is that you can do some work disconnected and possibly avoid some round trips to the server - allowing for a tighter development cycle. Reliance on an external API puts you at the mercy of a network connection for the development cycle, so having the what-if operation can end up saving you a lot of time.

## Change types

When you use the what-if operation, it lists six types of changes:

- **Create**. The resource doesn't currently exist but is defined in the template. The resource will be created.
- **Delete**. This change type applies only when you're using *complete mode* for deployment. The resource exists but isn't defined in the template. With complete mode, the resource will be deleted. This change type includes only resources that support deletion through complete mode.
- **Ignore**. The resource exists but isn't defined in the template. The resource won't be deployed or modified.
- **NoChange**. The resource exists and is defined in the template. The resource will be redeployed, but the properties of the resource won't change. This change type is returned when **ResultFormat** is set to **FullResourcePayloads**, which is the default value.
- **Modify**. The resource exists and is defined in the template. The resource will be redeployed, and the properties of the resource will change. This change type is returned when **ResultFormat** is set to **FullResourcePayloads**, which is the default value.
- **Deploy**. The resource exists and is defined in the template. The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when **ResultFormat** is set to **ResourceIdOnly**.

## Result format

The PowerShell cmdlet **New-AzResourceGroupDeployment** creates a new deployment on a resource group. When you add the what-if operation as a parameter to this command, the command switches from carrying out the deployment to merely reporting a *preview* of what will happen if you carry it out. 

You can control the amount of text output of the what-if operation by using one of these two parameters:

- **FullResourcePayloads**. By including this parameter, you get a *verbose* output that consists of a list of resources that will change. The output also shows details about all the properties that will change in accordance with the template.
- **ResourceIdOnly**. This mode returns a list of resources that will change, but not all the details.

For example, assume that you're changing the storage type in a template that deploys a single storage account to an existing environment. The PowerShell command parameter **-WhatIfResultFormat FullResourcePayloads** will produce the following results:

```output
PS > New-AzResourceGroupDeployment `
>> -Name $deploymentName `
>> -ResourceGroupName What-If `
>> -TemplateFile $templateFile `
>> storagePrefix whatif `
>> -WhatIfResultFormat FullResourcePayloads `
>> -Whatif

Note: As What-If is currently in preview, the result may contain false positive predictions (noise). You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with this symbol:
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/54a522b6-6cd7-4325-b4e6-566f9d921835/resourceGroups/What-if

  ~ Microsoft.Storage/storageAccounts/whatifbszktl3jpcqrc [2019-06-01]

Resource changes: 1 to modify
```

The PowerShell command parameter `-WhatIfResultFormat ResourceIdOnly` will produce the following results:

```output
PS > Nw-AzureResourceGroupDeployment `
>> -Name $deploymentName `
>> -ResourceGroupName What-if `
>> -TemplateFile $templateFile
>> -storagePrefix whatif `
>> -storageSKU Standard_LRS `
>> -WhatIfResultFormat ResourceIdOnly `
>> -Whatif

Note: As What-If is currently in preview, the result may contain false positive predictions (noise). You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with this symbol:
   ! Deploy

The deployment will update the following scope:

Scope: /subscriptions/54a522b6-6cd7-4325-b4e6-566f9d921835/resourceGroups/What-if

  ! Microsoft.Storage/storageAccounts/whatifbszktl3jpcqrc
```

## Removal or deletion of resources and deployment modes

There are times when you'll want to confirm the removal or deletion of resources as you deploy the template. To that end, the what-if operation supports using *deployment mode*. There are two deployment modes:

- **Incremental mode**. The default deployment mode is incremental. In this mode, Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are *added* to the resource group.
- **Complete mode**. When you use this mode, resources not specified in the template are *deleted*. If you know for sure that what's in the template file constitutes the full state of your deployment, then go ahead and use this mode. If you use tools like the Azure CLI or PowerShell to update your state gradually, then incremental mode is the way to go.

   > [!CAUTION]
   > When you run the command in complete mode, whatever resources you have will be removed if they're not mentioned in the template file.

### Confirmation

To preview changes before deploying a template, use the *confirm switch* parameter with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to finish.

> [!TIP]
> We highly recommend that you run any deployment commands with confirm switch, especially if you're running in complete mode. If you use confirm switch, you have a chance to stop the operation if you don't like the proposed changes.
