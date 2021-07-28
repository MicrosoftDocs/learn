Recently, your company acquired a smaller competitor. This company deployed its Azure resources using JSON ARM templates and the Azure portal. You've recently completed a project converting the JSON ARM templates and manually deployed resources to Bicep. Before using these converted templates to deploy resources, you want to verify what changes will be made to your deployed Azure resources. You want to use the ARM template deployment what-if operation to confirm any changes resulting from a template redeployment. You also want to learn about any documentation resources that may help increase the fidelity of your converted templates.

## What is the ARM template deployment what-if operation?

When you deploy new resources or modify existing resources, it's possible to introduce breaking changes to your environments. Your deployment could incorrectly modify or delete existing resources, create incorrectly configured new resources, or impact the overall functionality of your application.

To help you verify your converted templates before deployment, you can use the Azure Resource Manager template deployment what-if operation. When you use the what-if operation, it compares the current state of your environment with the desired state that is defined in the template. The tool outputs the list of changes that will occur *without* applying the changes to your environment. This process can help increase your confidence level in your deployments.

The what-if operation works with Azure CLI, Azure PowerShell, and the REST API. You can also use what-if with resource group, subscription, management group, and tenant deployments. Both incremental and complete deployment modes are supported by the what-if operation.

> [!NOTE]
> The default [deployment mode](/azure/azure-resource-manager/templates/deployment-modes) is incremental. To use complete mode, use the `--mode` parameter in Azure CLI and the `-Mode` parameter in Azure PowerShell.

### Types of changes that what-if detects

When you use the what-if operation, it lists six types of changes:

| Type | Explanation | Effect |
|-|-|-|
| Create | The resource doesn't currently exist but is defined in the template. | The resource will be created. |
| Delete | This change type applies only when you're using complete mode for deployment. The resource exists but isn't defined in the template. | If you deploy by using incremental mode, the resource w0n't be deleted. If you deploy by using complete mode, the resource will be deleted. This change type is returned only for resources that support deletion through complete mode. |
| Ignore | The resource exists but isn't defined in the template. | The resource won't be deployed or modified. This happens when you use incremental mode, which is the default deployment mode. If you deploy by using complete mode, the resource will be deleted. |
| NoChange | The resource exists and is defined in the template. | The resource will be redeployed, but the properties of the resource won't change. This change type is returned when the result format is set to `FullResourcePayloads`, which is the default result format. |
| Modify | The resource exists and is defined in the template. | The resource will be redeployed, and the properties of the resource will change. This change type is returned when the result format is set to `FullResourcePayloads`, which is the default result format. |
| Deploy | The resource exists and is defined in the template. | The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when the result format is set to `ResourceIdOnly`. |

If you don't need to know all of the change types, you can use the `-WhatIfExcludeChangeType` argument to omit the types you're not interested in.

> [!NOTE]
> The what-if operation sometimes shows that a resource will change when actually no change will happen. We're working to reduce these problems, but we need your help. [Please report these problems](https://aka.ms/whatifissues).

### Limitations of the what-if operation

- Some of the properties that are listed as deleted won't actually change. Properties can be incorrectly reported as deleted when they aren't in the template, but are automatically set during deployment as default values. This result is considered "noise" in the what-if response. The final deployed resource will have the values set for the properties. As the what-if operation matures, these properties will be filtered out of the result.

- The what-if operation can't resolve the reference function. Every time you set a property to a template expression that includes the reference function, what-if reports the property will change. This behavior happens because what-if compares the current value of the property (such as true or false for a boolean value) with the unresolved template expression. Obviously, these values won't match. When you deploy the template, the property will only change when the template expression resolves to a different value.

## Documentation resources

TODO: Insert text here.

### ARM template reference

TODO: Insert text here.

The [Azure ARM Template Reference](azure/templates/) documentation.

### Azure quickstart templates

The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) repository is a collection of community contributed templates. This database of searchable templates provides examples of many Azure resources and solutions. In some quickstarts, both a JSON ARM template and a Bicep ARM template are available to view. These templates can be used as a reference point to help you build and verify your templates for deployment.

For example, suppose you want to use a quickstart template that builds an App Service Plan and an App Service as a reference for one of your templates. In the repository you'll notice each quickstart template gives you the option to deploy the template directly to Azure, or browse the template on GitHub.

:::image type="content" source="../media/5-azure-quickstart-template.png" alt-text="Azure PowerShell error message about resources that cannot be exported.." border="true":::

Keep in mind that the Azure quickstart templates are community contributions. Some of the examples can be out of date as features are added to Azure services regularly. The examples can also include resources and properties that are unnecessary for your templates.
