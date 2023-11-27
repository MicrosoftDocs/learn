You've learned how you can use copy loops to deploy multiple instances of resources and how to set the properties of a resource by using loops. In Bicep, you can also use loops with variables and outputs.

For your toy company, you need to deploy virtual networks with the same subnet configuration across multiple Azure regions. You expect that you'll need to add additional subnets to your virtual networks in the future, so you want to have the flexibility in your Bicep templates to modify the subnet configuration.

Because you'll also be deploying multiple storage accounts in your Azure environment, you need to provide the endpoints for each storage account as output so that your deployment pipelines can use this information.

In this unit, you'll learn how to use loops with variables and outputs.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## Variable loops

By using variable loops, you can create an array, which you can then use through your Bicep file. As you do with other loops, you use the `for` keyword to create a variable loop:

```bicep
var items = [for i in range(1, 5): 'item${i}']
```

The preceding example creates an array that contains the values `item1`, `item2`, `item3`, `item4`, and `item5`.

You'd ordinarily use variable loops to create more complex objects that you could then use within a resource declaration. Here's how to use variable loops to create a `subnets` property:

::: code language="bicep" source="code/7-loop-variable.bicep" highlight="13-18" :::

This example illustrates an effective use for variable loops: turning a parameter that has simple, easy-to-understand values into a more complex object that corresponds to the Azure resource's required definition. You can use variable loops to enable parameters to specify only the key information that will change for each item in the list. You can then use Bicep expressions or default values to set other required properties for the resource.

## Output loops

You can use Bicep outputs to provide information from your deployments back to the user or tool that started the deployment. Output loops give you the flexibility and power of loops within your outputs.

As you do with other loops, use the `for` keyword to specify an output loop:

::: code language="bicep" source="code/7-loop-output-simple.bicep" highlight="9" :::

You'll ordinarily use output loops in conjunction with other loops within your template. For example, let's look at a Bicep file that deploys a set of storage accounts to Azure regions that are specified by the `locations` parameter:

::: code language="bicep" source="code/7-loop-output-complex.bicep" range="1-14" :::

You'll probably need to return information about each storage account that you've created, such as its name and the endpoints that can be used to access it. By using an output loop, you can retrieve this information within your Bicep file.

> [!NOTE]
> Currently, Bicep doesn't support directly referencing resources that have been created within a loop from within an output loop. This means that you need to use array indexers to access the resources, as shown in the next example.

::: code language="bicep" source="code/7-loop-output-complex.bicep" range="16-21" :::

> [!CAUTION]
> Don't use outputs to return secrets, such as access keys or passwords. Outputs are logged, and they aren't designed for handling secure data.
