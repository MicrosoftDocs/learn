Often, you need to deploy multiple resources that are very similar. By adding loops to your Bicep files, you can avoid the need to repeat resource definitions. Instead, you can dynamically set the number of instances of a resource you want to deploy. You can even customize the properties for each instance.

For your toy company, you need to deploy backend infrastructure, including some Azure SQL logical servers, to support the launch of the new smart teddy bear. You need to deploy a dedicated SQL server into each country where the toy is going to be available, so that you can comply with data protection laws for each country. Apart from their locations, each server will be configured the same way as all the other servers. You want to use Bicep code to deploy your servers, and a parameter should allow you to specify the regions into which the SQL servers should be deployed.

In this unit, you will learn how to deploy multiple instances of resources by using _copy loops_.

## Use copy loops

When you define a resource or a module in Bicep template, you can use the `for` keyword to create a loop. Place the `for` keyword in the resource declaration and then specify how you want Bicep to identify each item in the loop. Typically, you loop over an array of objects to create multiple instances of a resource. The following example deploys multiple storage accounts, and their names are specified as parameter values:

::: code language="plaintext" source="code/4-loop-simple.bicep" highlight="7-8, 14" :::

In this example, the loop iterates through each item in the `storageAccountNames` array. Each time Bicep goes through the loop, it puts the current value into a special variable called `storageAccountName`, and this is used as the value of the `name` property. Notice that Bicep requires you put an opening `[` character before the `for` keyword, and a closing `]` character after the resource definition.

If you deployed this Bicep file you'd see three storage accounts created, with the names specified by the corresponding items in the `storageAccountNames` array.

## Loop based on a count

Sometimes you may need to loop to create a specific number of resources, and not use an array as the source. Bicep provides the `range()` function, which creates an array of numbers. For example, if you need to create four storage accounts named `sa1` through `sa4`, you could use a resource definition like this:

::: code language="plaintext" source="code/4-loop-range.bicep" highlight="1" :::

When you use the `range()` function you specify its start value and the number of values you want to create. For example, if you wanted to create storage accounts with the names `sa0`, `sa1`, and `sa2`, you'd use the function `range(0,3)`.

> [!NOTE]
> When you use the `range()` function, you provide two arguments. The first specifies the starting value, and the second tells Bicep the number of values you want. For example, if you use `range(3,4)` then Bicep will return the values `3`, `4`, `5`, and `6`. Be careful to ensure you're requesting the right number of values, especially when you use a starting value of 0.

> [!TIP]
> In this example, we've named the index variable `i`. This is the standard convention in Bicep. However, you can use any name you want.

## Access the iteration index

Bicep allows you to iterate through arrays and also retrieve the index of the current element in the array. For example, let's say you wanted to create a SQL servers in each location specified by an array, but you want the names of the servers to just be `sqlserver-1`, `sqlserver-2`, and so on. Here's Bicep code that you could use to achieve this:

::: code language="plaintext" source="code/4-loop-index.bicep" highlight="7-8" :::

Notice that the `name` property includes the expression `i+1`. The first value of the `i` index variable is zero, so you need to add one to it if you want your server names to start with `1`.

## Filter items with loops

You may come across situations where you would want to use copy loops together with conditions to deploy resources. You can do this by combining the `if` and `for` keywords.

In the following example, an array parameter is used to define a set of SQL servers. A condition is used with the copy loop to only deploy SQL servers when the `environmentName` property of the loop object equals `Production`:

::: code language="plaintext" source="code/4-loop-condition.bicep" highlight="19" :::

If you deploy the example above, you'd see two SQL servers created named `sqlserver-we` and `sqlserver-eas`, but not `sqlserver-eus2` since that object's `environmentName` property didn't match `Production`.
