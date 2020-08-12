There are always questions on the mind of anyone deploying or modifying resources in an existing environment like:

- Will I break something?
- How will this deployment affect existing resources?
- Can I validate that what we are thinking will happen when deploying, is actually what will happen *before* hitting the deploy button?

Deploying and hoping for the best is **NOT** the approach you should be taking.  The *what-if* operation is here to address this.

Azure Resource Manager now provides the *what-if* operation to highlight the changes when you deploy a template. The *what-if* operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

> [!NOTE]
> The ***what-if*** operation is currently in preview. As a preview release, the results may sometimes show that a resource will change when actually no change will happen. We're working to reduce these issues, but we need your help. Please report these issues at https://aka.ms/whatifissues.
>

If you've ever worked with [Azure Powershell](https://docs.microsoft.com/powershell/azure/?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer) you're probably already familiar with the *what-if* capabilities.  It's really a way to run your code in a *dry-run* context that will allow you to validate your template before actually deploying the said template. The *What-if* operation confirms if the changes made by your template matches your expectations without applying those changes to real resources or to the state of those resources.

One more benefits of this operation is that, unlike some of the other tools out there, the *what-if* operation discussed here actually compares your template with the target environment, not against a state file maintained outside of the target environment.  Therefore making it simpler to test against multiple environments (Dev, Test, Prod...)

## Change types

When using the *what-if* operation it will lists six different types of changes:

1. **Create**: The resource doesn't currently exist but is defined in the template. The resource will be created.
1. **Delete**: This change type only applies when using complete mode for deployment. The resource exists, but isn't defined in the template. With [complete mode](https://docs.microsoft.com/azure/azure-resource-manager/templates/deployment-modes?WT.mc_id=MSLearn-ARM-pierrer), the resource will be deleted. **Only resources that support complete mode deletion are included in this change type**.
1. **Ignore**: The resource exists, but isn't defined in the template. The resource won't be deployed or modified.
1. **NoChange** : The resource exists, and is defined in the template. The resource will be redeployed, but the properties of the resource won't change. This change type is returned when ResultFormat is set to FullResourcePayloads, which is the default value.
1. **Modify**: The resource exists, and is defined in the template. The resource will be redeployed, and the properties of the resource will change. This change type is returned when ResultFormat is set to FullResourcePayloads, which is the default value.
1. **Deploy**: The resource exists, and is defined in the template. The resource will be redeployed. The properties of the resource may or may not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You only see this condition when ResultFormat is set to ResourceIdOnly.

## Result Format

You maintain the control of how much info you want to see from the *what-if* operation.  There are two levels of detail that can be returned about the predicted changes:

1. **FullResourcePayloads** - This mode returns a list of resources that will change and details about all the properties that will change as per the template.
1. **ResourceIdOnly** - This mode returns a list of resources that will change, but not all the details.

For example, when changing the storage type in a template that deploys a single storage account to an existing environment.

The PowerShell command parameter **-WhatIfResultFormat FullResourcePayloads** will produce the following results:

:::image type="content" source="../media/whatif-fullresourcepayloads.png" alt-text="Results from executing a deployment with -WhatIfResultFormat FullResourcePayloads parameter in PowerShell." border="true":::

And, the PowerShell command parameter **-WhatIfResultFormat ResourceIdOnly** will produce the following results:

:::image type="content" source="../media/whatif-resourceIdonly.png" alt-text="Results from executing a deployment with -WhatIfResultFormat ResourceIdOnly parameter in PowerShell." border="true":::

More detailed information about the command usage can be found [here](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-deploy-what-if?tabs=azure-powershell&WT.mc_id=MSLearn-ARM-pierrer#what-if-commands)

## Removal or deletion of Resources and deployment modes

There are times where you'll want to confirm the removal of resources as you deploy the template.  maybe it's just a comfort thing - Better safe than sorry!

To that end the *what-if* operation supports using [deployment mode](https://docs.microsoft.com/azure/azure-resource-manager/templates/deployment-modes?WT.mc_id=MSLearn-ARM-pierrer). The default deployment mode is Incremental. In incremental mode, the Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are added to the resource group.

When set to *complete mode*, resources not in the template are deleted.

To preview changes before deploying a template, use the **confirm switch** parameter with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to complete.
