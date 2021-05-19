Copy loops are a powerful feature that enables you to create dynamic and flexible templates. It's also important to understand how you can control the way that loops execute when they create resources, and how you can use loops to set resource properties and nest loops. In this unit, you learn how to control the execution of copy loops, and how to use resource property loops and nested loops in Bicep.

## Controlling loop execution

By default, Resource Manager creates resources from loops in parallel, and in a non-deterministic order. When you created the loops in the previous exercises, both of the SQL servers were created at the same time. This helps to reduce the overall deployment time, since all of the resources within the loop will be deployed at the same time. In some cases, however, you may need to deploy resources in loop sequentially instead of in parallel, or you can have small batches of changes be deployed together in parallel. For example, if you have lots of App Service apps in your production environment, you might want to only deploy changes to a small number at a time so you can avoid the updates restarting all of your apps at the same time.

You can control the way your copy loops execute in Bicep by using the `@batchSize` decorator. Put the decorator on the resource or module declaration with the `for` keyword.

Let's look at an example Bicep definition for a set of App Service applications without the `@batchSize` decorator:

::: code language="bicep" source="code/6-loop-batchSize.bicep" range="3-6" :::

All of the resources in this loop will be deployed at the same time, in parallel:

:::image type="content" source="../media/6-batchSize-default.png" alt-text="Diagram showing time on the horizontal axis, with app1, app2, and app3 laid out vertically another." border="false":::

Now let's apply the `@batchSize` decorator with a value of `2`:

::: code language="plaintext" source="code/6-loop-batchSize.bicep" range="2-6" highlight="1" :::

When you deploy the template, Bicep will deploy in batches of two:

:::image type="content" source="../media/6-batchSize-2.png" alt-text="Diagram showing time on the horizontal axis, with app1 and app2 on top of one another, and app3 to the right." border="false":::

> [!NOTE]
> Bicep will wait for each batch to complete before moving onto the next batch. In the example above, if *app2* finished deploying before *app1*, Bicep would still wait until *app1* completed its deployment before it started to deploy *app3*.

You can also tell Bicep to execute the loop sequentially by setting the `@batchSize` to `1`:

::: code language="plaintext" source="code/6-loop-batchSize.bicep" range="1, 3-6" highlight="1" :::

When you deploy the template, Bicep will wait for each resource deployment to complete before it starts the next one:

:::image type="content" source="../media/6-batchSize-1.png" alt-text="Diagram showing time on the horizontal axis, with app1, app2, and app3 laid out horizontally." border="false":::

## Use loops with resource properties

You can use loops to help set resource properties. For example, when you deploy a virtual network, you need to specify its subnets. A subnet has to have two pieces of information: a name and an address prefix. You can use a parameter with an array of objects so that you can specify different subnets for each environment:

::: code language="plaintext" source="code/6-loop-property.bicep" highlight="15-20" :::

Notice that in this example, the `for` loop appears within the resource definition, around the `subnets` property value.

## Nested loops

Some scenarios require you to use a loop inside another loop. These are *nested loops*, and Bicep enables you to do this.

In your toy company you need to deploy virtual networks in every country where toy will be launched. Every virtual network needs a different address space and two subnets. Let's start by deploying the virtual networks in a loop:

::: code language="plaintext" source="code/6-loop-nested.bicep" range="1-17,24-25" highlight="9,10,15" :::

This loop deploys the virtual networks for each location, and it sets the `addressPrefix` for the virtual network by using the loop index to ensure each virtual network gets a different address prefix.

You can use a nested loop to deploy the subnets within each virtual network:

::: code language="plaintext" source="code/6-loop-nested.bicep" range="9-25" highlight="10-15" :::

The nested loop uses the `range()` function to create two subnets.

When you deploy the template, you get the following virtual networks and subnets:

| Virtual network name | Location     | Address prefix | Subnets                      |
|----------------------|--------------|----------------|------------------------------|
| `vnet-westeurope`    | `westeurope` | `10.0.0.0/16`  | `10.0.1.0/24`, `10.0.2.0/24` |
| `vnet-eastus2`       | `eastus2`    | `10.1.0.0/16`  | `10.1.1.0/24`, `10.1.2.0/24` |
| `vnet-eastasia`      | `eastasia`   | `10.2.0.0/16`  | `10.2.1.0/24`, `10.2.2.0/24` |
