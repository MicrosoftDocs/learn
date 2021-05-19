You've learned how you can use copy loops to deploy multiple instances of resources, and how to set the properties of a resource using loops. In Bicep, loops can be also used with variables and outputs.

In your toy company, you need to deploy virtual networks with the same subnet configuration across multiple Azure regions. You expect that you will need to add additional subnets to your virtual networks in the future, so you want to have flexibility in your Bicep templates to modify subnet configuration. Since you will also be deploying multiple storage accounts in your Azure environment, you need to provide the endpoints for each storage account as output so that your deployment pipelines can use this information.

In this unit, you learn how you can use loops with variables and outputs.

## Variable loops

Variable loops enable you to create an array, which you can use through your Bicep file. Like other loops, you use the `for` keyword to create a variable loop:

```bicep
var items = [for i in range(1, 5): 'item${i}']
```

The example above creates an array containing the values `item1`, `item2`, `item3`, `item4`, and `item5`.

Typically, you would use variable loops to create more complex objects that you could use within a resource declaration. Here's how you can use variable loops to create a `subnets` property:

::: code language="plaintext" source="code/7-loop-variable.bicep" highlight="13-18" :::

This example illustrates a good use for variable loops: turning a parameter that has simple, easy-to-understand values into a more complex object that corresponds to what the Azure resource needs to be defined. You can use variable loops to enable your parameters to just specify the key information that will change for each item in the list, and then you can use Bicep expressions or default values to set other properties.

## Output loops

Bicep outputs enable you to provide information from your deployments back to the user or tool that started the deployment. Output loops give you the flexibility and power of loops within your outputs.

Like other loops, you use the `for` keyword to specify an output loop:

::: code language="plaintext" source="code/7-loop-output-simple.bicep" highlight="9" :::

Typically you'll use output loops in conjunction with other loops within your template. For example, let's look at a Bicep file that deploys a set of storage accounts into Azure regions specified by the `locations` parameter:

::: code language="bicep" source="code/7-loop-output-complex.bicep" range="1-14" :::

You'll probably need to return information about each storage account that's been created, like its name and the endpoints that can be used to access it. By using an output loop, you can retrieve this information within your Bicep file.

> [!NOTE]
> Currently, Bicep doesn't support directly referencing resources that have been created within a loop from within an output loop. This means that you need to use array indexers to access resources, like in the example below.

::: code language="bicep" source="code/7-loop-output-complex.bicep" range="16-21" :::

> [!CAUTION]
> Make sure you don't use outputs to return secrets, like access keys or passwords. Outputs are logged, and they aren't designed for handling secure data.
