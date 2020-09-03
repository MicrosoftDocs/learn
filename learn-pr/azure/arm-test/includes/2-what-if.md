There are always questions on the mind of anyone deploying or modifying resources in an existing environment.

- Will I break something?
- How will this deployment affect existing resources?
- Can I validate that what we are thinking will happen is actually what will happen deployment before hitting the deploy button?

Deploying and hoping for the best is not a good approach. A better approach is using the "what-if" operation. The operation helps you anticipate what consequences a new deployment will have, were it to be attempted.

Azure Resource Manager now provides the *what-if* operation to highlight the changes when you deploy a template. The *what-if* operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed at a resource group and subscription level.

> [!NOTE]
> The *what-if* operation is currently in preview. As a preview release, the results may sometimes show that a resource will change when actually no change will happen. We're working to reduce these issues, but we need your help. Please report these issues at https://aka.ms/whatifissues?azure-portal=true.
>

Using the *what-if* operation allows you to run your code in a *dry-run* context that will allow you to validate your template before actually deploying said template. The *what-if* operation confirms if the changes made by your template match your expectations *without* applying those changes to real resources or to the state of those resources.

One more benefit of this operation is that, unlike some of the other tools out there, the *what-if* operation actually compares your template with the target environment, not against a state file maintained outside of the target environment. Therefore making it simpler to test against multiple environments (Dev, Test, Prod...)

## Change types

When using the *what-if* operation, it will list six different types of changes:

- **Create**. The resource doesn't currently exist but is defined in the template. The resource will be created.
- **Delete**. This change type only applies when using complete mode for deployment. The resource exists, but isn't defined in the template. With *complete mode*, the resource will be deleted. Only resources that support *complete mode* deletion are included in this change type.
- **Ignore**. The resource exists, but isn't defined in the template. The resource won't be deployed or modified.
- **NoChange**. The resource exists, and is defined in the template. The resource will be redeployed, but the properties of the resource won't change. This change type is returned when *ResultFormat* is set to *FullResourcePayloads*, which is the default value.
- **Modify**. The resource exists, and is defined in the template. The resource will be redeployed, and the properties of the resource will change. This change type is returned when *ResultFormat* is set to *FullResourcePayloads*, which is the default value.
- **Deploy**. The resource exists, and is defined in the template. The resource will be redeployed. The properties of the resource may or may not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You only see this condition when *ResultFormat* is set to *ResourceIdOnly*.

## Result format

You maintain the control of how much information you want to see from the *what-if* operation.  There are two levels of detail that can be returned about the predicted changes:

1. **FullResourcePayloads**. This mode returns a list of resources that will change and details about all the properties that will change as per the template.
1. **ResourceIdOnly**. This mode returns a list of resources that will change, but not all the details.

For example, when changing the storage type in a template that deploys a single storage account to an existing environment.

The PowerShell command parameter "-WhatIfResultFormat FullResourcePayloads" will produce the following results:

:::image type="content" source="../media/whatif-fullresourcepayloads.png" alt-text="Results from executing a deployment with -WhatIfResultFormat FullResourcePayloads parameter in PowerShell." border="true":::

And, the PowerShell command parameter "-WhatIfResultFormat ResourceIdOnly " will produce the following results:

:::image type="content" source="../media/whatif-resourceIdonly.png" alt-text="Results from executing a deployment with -WhatIfResultFormat ResourceIdOnly parameter in PowerShell." border="true":::

## Removal or deletion of resources and deployment modes

There are times where you'll want to confirm the removal or deletion of resources as you deploy the template.

To that end, the *what-if* operation supports using *deployment mode*. The default deployment mode is *Incremental*. In *incremental mode*, the Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are added to the resource group.

When set to *complete mode*, resources not in the template are deleted.

To preview changes before deploying a template, use the *confirm switch* parameter with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to complete.

## Deployment naming

A deployment needs a name. For every deployment, you need a *deployment name*. You have two options:

- **Provide a name when deploying**. You can provide the name as an argument when calling the deployment tool.
- **Use default** if you don't provide a name for the deployment, the name of the template file is used by default. For example, if you deploy a template named **azuredeploy.json** and don't specify a deployment name, the deployment will be named **azuredeploy**.  

Good naming matters. Using unique meaningful deployment names for each deployment provides you with additional simplicity when reviewing deployments and troubleshooting events and maintain unique entries in the deployment history.  

Reusing the same name means something. Every time you run a deployment, an entry is added to the resource group's deployment history with the deployment name. If you run another deployment and give it the same name, the previous entry is replaced with the current deployment. A benefit to specifying a unique name for each deployment is that you can run them concurrently without conflict.
