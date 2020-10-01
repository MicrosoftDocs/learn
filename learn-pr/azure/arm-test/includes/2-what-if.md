There are always questions on the mind of anyone deploying or modifying resources in an existing environment.

- Will I break something?
- How will this deployment affect existing resources?
- Can I validate that what we are thinking will happen is actually what will happen deployment before hitting the deploy button?

Deploying and hoping for the best is not a good approach. A better approach is using the what-if operation. The operation helps you anticipate what consequences a new deployment will have, were it to be attempted.

Azure Resource Manager now provides the what-if operation to highlight the changes when you deploy a template. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

> [!NOTE]
> The *what-if* operation is currently in preview. As a preview release, the results may sometimes show that a resource will change when actually no change will happen. We're working to reduce these issues, but we need your help. Please report these issues at https://aka.ms/whatifissues?azure-portal=true.
>

Using the *what-if* operation allows you to estimate what would happen were you to deploy by comparing the current stat model to our desired state model. The *what-if* operation confirms if the changes made by your template match your expectations *without* applying those changes to real resources or to the state of those resources.

A benefit to using a state file, is that I can do some work disconnected and possibly avoid some round trips to the server - allowing for a tighter development cycle. Reliance on an external API puts me at the mercy of my network connection for my dev cycle so having the *what-if* operation can end up saving you a lot of time.

## Change types

When using the *what-if* operation, it will list six different types of changes:

- **Create**. The resource doesn't currently exist but is defined in the template. The resource will be created.
- **Delete**. This change type only applies when using complete mode for deployment. The resource exists, but isn't defined in the template. With *complete mode*, the resource will be deleted. Only resources that support *complete mode* deletion are included in this change type.
- **Ignore**. The resource exists, but isn't defined in the template. The resource won't be deployed or modified.
- **NoChange**. The resource exists, and is defined in the template. The resource will be redeployed, but the properties of the resource won't change. This change type is returned when *ResultFormat* is set to *FullResourcePayloads*, which is the default value.
- **Modify**. The resource exists, and is defined in the template. The resource will be redeployed, and the properties of the resource will change. This change type is returned when *ResultFormat* is set to *FullResourcePayloads*, which is the default value.
- **Deploy**. The resource exists, and is defined in the template. The resource will be redeployed. The properties of the resource may or may not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You only see this condition when *ResultFormat* is set to *ResourceIdOnly*.

## Result format

The PowerShell cmdlet `New-AzResourceGroupDeployment` creates a new the deployment on a resource group. By adding the *what-if* operation as a parameter to this command, the command switches from carrying out the deployment to merely report a *preview* of what will happen, were you to carry it out. Additionally you can control the amount of textual output of the *what-if* operation by using one of two parameters. The parameters are:

1. **FullResourcePayloads**. By including this parameter you get a *verbose* output consisting of a list of resources, that will change, and details about all the properties that will change as per the template.
1. **ResourceIdOnly**. This mode returns *only* a list of resources that will change, but not all the details.

For example, when changing the storage type in a template that deploys a single storage account to an existing environment.

The PowerShell command parameter `-WhatIfResultFormat FullResourcePayloads` will produce the following results:

```output
PS > New-AzResourceGroupDeployment `
>> -Name $deploymentName `
>> -ResourceGroupName What-If `
>> -TemplateFile $templateFile `
>> storagePrefix whatif `
>> -WhatIfResultFormat FullResourcePayloads `
>> -Whatif

Note: As What-If is currently in preview, the result may contain false positive predictions (noise). You can help us improve th accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with this symbol:
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/54a522b6-6cd7-4325-b4e6-566f9d921835/resourceGroups/What-if

  ~ Microsoft.Storage/storageAccounts/whatifbszktl3jpcqrc [2019-06-01]

Resource changes: 1 to modify
```

And, the PowerShell command parameter `-WhatIfResultFormat ResourceIdOnly` will produce the following results:

```output
PS > Nw-AzureResourceGroupDeployment `
>> -Name $deploymentName `
>> -ResourceGroupName What-if `
>> -TemplateFile $templateFile
>> -storagePrefix whatif `
>> -storageSKU Standard_LRS `
>> -WhatIfResultFormat ResourceIdOnly `
>> -Whatif

Note: As What-If is currently in preview, the result may contain false positive predictions (noise). You can help us improve th accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with this symbol:
   ! Deploy

The deployment will update the following scope:

Scope: /subscriptions/54a522b6-6cd7-4325-b4e6-566f9d921835/resourceGroups/What-if

  ! Microsoft.Storage/storageAccounts/whatifbszktl3jpcqrc
```

## Removal or deletion of resources and deployment modes

There are times where you'll want to confirm the removal or deletion of resources as you deploy the template.

To that end, the *what-if* operation supports using *deployment mode*. There are two different deployment modes:

- **Incremental mode**. The default deployment mode is *Incremental*. In *incremental mode*, the Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are *added* to the resource group.
- **Complete mode**. When set to *complete mode*, resources not specified in the template are *deleted*. If you know for sure that what's in the template file constitutes the full state of your deployment then go ahead and use this mode. If you use a multitude of tools like Azure CLI or PowerShell to update your state gradually, then *Incremental mode* is the way to go.

   > [!CAUTION]
   > Just to emphasize, when you run the command in *complete mode* please understand that whatever resources you have since before will be removed if it's not mentioned in the template file.

### Confirmation

To preview changes before deploying a template, use the *confirm switch* parameter with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to complete.

> [!TIP]
> It's highly recommended that you run any deployment commands with the *confirm switch*, especially if you are running in *complete mode*. If you use the *confirm switch* you have a chance to abort the operation if the proposed changes are not to your liking.
