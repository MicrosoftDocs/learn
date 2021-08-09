Recently, your company acquired a smaller competitor. This company deployed its Azure resources using JSON ARM templates and the Azure portal. You've recently completed a project converting the JSON ARM templates and manually deployed resources to Bicep. Before using these converted templates to deploy resources, you want to verify what changes will be made to your deployed Azure resources. You want to use the ARM template deployment what-if operation to confirm any changes resulting from a template redeployment. You also want to learn about any documentation resources that may help increase the fidelity of your converted templates.

## What is the ARM template deployment what-if operation?

When you deploy new resources or modify existing resources, it's possible to introduce breaking changes to your environments. Your deployment could modify or delete existing resources, create incorrectly configured new resources, or impact the overall functionality of your application.

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
| Ignore | The resource exists but isn't defined in the template. | The resource won't be deployed or modified. This situation happens when you use incremental mode, which is the default deployment mode. If you deploy by using complete mode, the resource will be deleted. |
| NoChange | The resource exists and is defined in the template. | The resource will be redeployed, but the properties of the resource won't change. This change type is returned when the result format is set to `FullResourcePayloads`, which is the default result format. |
| Modify | The resource exists and is defined in the template. | The resource will be redeployed, and the properties of the resource will change. This change type is returned when the result format is set to `FullResourcePayloads`, which is the default result format. |
| Deploy | The resource exists and is defined in the template. | The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when the result format is set to `ResourceIdOnly`. |

If you don't need to know all of the change types, you can use the `-WhatIfExcludeChangeType` argument to omit the types you're not interested in.

### What-if example

TODO: Create an example.

```azurecli
az deployment group what-if \
  --resource-group ToyStorage \
  --template-file $templateFile \
  --result-format FullResourcePayloads
```

```azurecli
show the output
```

> [!NOTE]
> The what-if operation sometimes shows that a resource will change when actually no change will happen. We're working to reduce these problems, but we need your help. [Please report these problems](https://aka.ms/whatifissues).

### Limitations of the what-if operation

The what-if operation may list some resource properties as deleted, when in reality they won't change. It's possible that properties can be reported as deleted when the don't exist in the template. These same properties can bet set automatically during deployment using default values. These results are considered _noise_ in the response from what-if. When the resource is deployed, the appropriate values for the properties will be set. As the what-if operation matures, these properties will be filtered out of the results.

The what-if operation is unable to resolve the reference function in a template. When you set a resource property to an expression that uses the reference function, what-if will report that the property will change. When what-if compares the current property value with the expression, the values will not match. When you deploy the template, the resource property will only change when the template expression resolves to a different value.

## Recommended workflow for converting and exporting templates to Bicep

To help your templates align with best practices, you can follow a recommended workflow when converting and exporting your templates to Bicep. This workflow is broken down into five phases:

- Convert
- Migrate
- Refactor
- Test
- Deploy

This unit will focus on the last two phases: test and deploy.

> [!NOTE]
> Many of the steps outlined below were discussed in a previous unit. For details on these steps, please refer to Unit 2 - "Convert JSON templates to Bicep" and Unit 4 - "Export resource definitions to Bicep".

### Convert phase

In the convert phase of converting your templates to Bicep, the goal is to capture the initial representation of your Azure resources. Take a look at the following steps for this phase.

:::image type="content" source="../media/3-export.png" alt-text="Diagram of converting a JSON template to Bicep." border="false":::

1. **Export the JSON ARM template**

2. **Decompile the source JSON ARM template**

### Migrate phase

In the migrate phase of converting your templates to Bicep, the goal is to create an initial Bicep file that includes all of your Azure resources. Take a look at the following steps for this phase.

:::image type="content" source="../media/2-migrate.png" alt-text="Diagram of migrating a template to Bicep." border="false":::

1. **Create a new Bicep file**

1. **Copy the resources from converted Bicep file to new Bicep file**

2. **Re-create any resources that were not exported**

3. **Create parameters for each environment**

### Refactor phase

In the refactor phase of converting your templates to Bicep, the goal is to improve the quality of your Bicep code. Take a look at the following steps for this phase.

:::image type="content" source="../media/2-refactor.png" alt-text="Diagram of refactoring a Bicep template." border="false":::

1. **Review resource API versions**

2. **Review the linter suggestions in your new Bicep file**

3. **Revise parameters, variables, and symbolic names**

4. **Simplify expressions**

5. **Review child and extension resources**

6. **Modularize**

7. **Add comments**

8. **Follow Bicep best practices**

### Test phase

TODO: Intro paragraph

TODO: Image

1. **Run the ARM template deployment what-if operation** - TODO: Insert text here.

1. **Perform a test deployment** - Before introducing your converted Bicep template to production, consider running multiple test deployments. If you have multiple environments (prod, dev, test), you may want to try deploying your template to one of your non-production environments first.

    > [!NOTE]
    > If you're going to use the converted template in a pipeline, such as Azure DevOps or GitHub Actions, consider running the deployment from your local machine first. It is better to verify the functionality of the template before adding it to your production pipeline.

### Deploy phase

TODO: Intro paragraph

TODO: Image

1. **Prepare a rollback plan** - TODO: Insert text here.

1. **Run the what-if operation against production** - TODO: Insert text here.

1. **Deploy manually** - TODO: Insert text here.

1. **Run smoke tests** - TODO: Insert text here.

Once you've successfully deployed your production environment through your Bicep code, you're done! Now go use a pipeline and automated deployments.
