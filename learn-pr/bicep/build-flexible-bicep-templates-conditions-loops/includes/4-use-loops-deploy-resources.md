Often, you need to deploy multiple resources that are very similar. By adding loops to your Bicep files, you can avoid having to repeat resource definitions. Instead, you can dynamically set the number of instances of a resource you want to deploy. You can even customize the properties for each instance.

For your toy company, you need to deploy back-end infrastructure, including some SQL server instances, to support the launch of the new smart teddy bear. You need to deploy a dedicated SQL server instance to each country where the toy will be available, so that you're in compliance with each country's data protection laws. 

Apart from their locations, all servers will be configured in the same way. You want to use Bicep code to deploy your server instances, and a parameter should allow you to specify the regions into which the servers should be deployed.

In this unit, you'll learn how to deploy multiple instances of resources by using _copy loops_.

## Use copy loops

When you define a resource or a module in a Bicep template, you can use the `for` keyword to create a loop. Place the `for` keyword in the resource declaration, and then specify how you want Bicep to identify each item in the loop. Typically, you loop over an array of objects to create multiple instances of a resource. The following example deploys multiple storage accounts, and their names are specified as parameter values:

::: code language="plaintext" source="code/4-loop-simple.bicep" highlight="7-8, 14" :::

In this example, the loop iterates through each item in the `storageAccountNames` array. Each time Bicep goes through the loop, it puts the current value into a special variable called `storageAccountName`, and it's used as the value of the `name` property. Notice that Bicep requires you put an opening bracket (`[`) character before the `for` keyword, and a closing bracket (`]`) character after the resource definition.

If you deploy this Bicep file, you'll see that three storage accounts are created, with their names specified by the corresponding items in the `storageAccountNames` array.

## Loop based on a count

You might sometimes need to loop to create a specific number of resources, and not use an array as the source. Bicep provides the `range()` function, which creates an array of numbers. For example, if you need to create four storage accounts, `sa1` through `sa4`, you could use a resource definition like this:

::: code language="plaintext" source="code/4-loop-range.bicep" highlight="1" :::

When you use the `range()` function, you specify its start value and the number of values you want to create. For example, if you want to create storage accounts with the names `sa0`, `sa1`, and `sa2`, you would use the function `range(0,3)`.

> [!NOTE]
> In this example, we've named the index variable `i`. This is the standard convention in Bicep. However, you can use any name you want.

## Access the iteration index

With Bicep, you can iterate through arrays and retrieve the index of the current element in the array. For example, let's say you want to create a SQL server instance in each location that's specified by an array, and you want the names of the servers to be `sqlserver-1`, `sqlserver-2`, and so on. You could achieve this by using the following Bicep code:

::: code language="plaintext" source="code/4-loop-index.bicep" highlight="7-8" :::

Notice that the `name` property includes the expression `i+1`. The first value of the `i` index variable is zero, so you need to add `+1` to it if you want your server names to start with `1`.

## Filter items with loops

In some situations, you might want to deploy resources by using copy loops combined with conditions. You can do this by combining the `if` and `for` keywords.

In the following example, the code uses an array parameter to define a set of SQL server instances. A condition is used with the copy loop to deploy the servers only when the `environmentName` property of the loop object equals `Production`:

::: code language="plaintext" source="code/4-loop-condition.bicep" highlight="19" :::

If you deploy the preceding example, you would see two SQL server instances, `sqlserver-we` and `sqlserver-eas`, but not `sqlserver-eus2`, because that object's `environmentName` property doesn't match `Production`.
