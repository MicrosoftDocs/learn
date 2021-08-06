Bicep gives you a lot of flexibility to decide how you structure your code. In this unit, you'll learn about the ways you can structure your Bicep code, and the importance of a consistent style and clear, understandable Bicep code.

## What order should your Bicep code follow?

Your Bicep templates can contain many elements, including parameters, variables, resources, modules, outputs, and a `targetScope` for the entire template. Bicep doesn't enforce an order for your elements to be in. However, it's important you think about the order of your elements to make sure your template is clear and understandable.

There are two main approaches to ordering. You and your team should agree on one and use it consistently.

### Group elements together by element type

You can group all elements of the same type together. So, all of your parameters would go in one place, usually at the top of the file, followed by variables, and then resources and modules, with outputs at the bottom. For example, you might have a Bicep file that deploys an Azure SQL database and a storage account. When you group your elements together by type, they might look like this:

:::image type="content" source="../media/4-group-element-type.png" alt-text="Diagram showing elements grouped by element type. Parameters are grouped together, then variables, then resources, then outputs." border="false":::

> [!TIP]
> If you follow this convention, consider putting the `targetScope` at the top of the file.

This ordering makes sense when you're used to other infrastructure as code languages, like JSON ARM templates. It also can make your template easy to understand because it's clear where you need to look for specific types of elements. However, in longer templates, it can be challenging to navigate and jump between the elements of your template.

You still have to decide how to order the elements within these categories. It's a good idea to group related parameters together - so for example, all of the parameters that are about a storage account belong together, and within that, the parameters about the storage account's SKU would also belong together. Similarly, group related resources together too. This helps anyone who uses your template to quickly navigate around, and to understand the important parts of the template.

Sometimes, you create a template that deploys a primary resource, with a number of secondary supporting resources. For example, you might create a template to deploy a website hosted on Azure App Service. The primary resource is the App Service app. Secondary resources in the same template might include the App Service plan, storage account, Application Insights instance, and others. When you have a template like this, it's a good idea to put the primary resource or resources at the top of the resource section of the template, so that anyone who opens the template can quickly identify the purpose of the template and can find the important resources.

### Group elements together by resource

Alternative, you can group your elements based on the type of the resources being deployed. Continuing the example from above, you could put all of the parameters, variables, resources, and outputs that relate to the Azure SQL database resources together, then put the parameters, variables, resources, and outputs for the storage account, like this:

:::image type="content" source="../media/4-group-resource.png" alt-text="Diagram showing elements grouped by resource. Storage account elements are grouped together, then Azure SQL database elements." border="false":::

This approach can make it easy to read your template, since all of the elements you need for a specific resource are together. But it makes it harder to quickly check how specific element types are declared, like if you want to review all of your parameters.

You also need to consider how to handle parameters and variables that are common to multiple resources, like an `environmentType` parameter when you use a configuration map. Common parameters and variables should be placed together, usually at the top of the Bicep file.

> [!TIP]
> Consider whether it might make more sense to create _modules_ for groups of related resources, and then use a simpler template to combine the modules together. Bicep modules are covered in more detail throughout the Bicep learning paths.

## How do you add meaningful whitespace?

Blank lines, or _whitespace_, can help you to structure your template. By using whitespace thoughtfully, you can clarify the relationships between resources, and you logically group the sections of your Bicep code together. Consider adding a blank line between the sections of your template, regardless of the grouping style you prefer.

## How do you define several similar resources?

Bicep enables you to use loops to deploy similar resources from a single definition. By using the `for` keyword to define resource loops, you can make your Bicep code cleaner and reduce unnecessary duplication of resource definitions. In future, when you need to change the definition of your resources, you just update one place. By default, when Azure Resource Manager deploys your resources, it deploys all of the resources in the loop at the same time, so your deployment is as efficient as possible.

Look for places where you define multiple resources that are identical, or that have a few differences in their properties. Then, add a variable to list the resources to create along with the properties that differ from the other resources. The example below uses a loop to define a set of Azure Cosmos DB containers, each of which has its own name and partition key:

::: code language="bicep" source="code/4-loop.bicep" range="7-21, 48-64" highlight="16, 18, 21, 25" :::

## How do you deploy resources only to certain environments?

Sometimes, you define resources that should only be deployed to specific environments or under certain conditions. The `if` keyword enables you to selectively deploy resources based on a parameter value, a configuration map variable, or another condition. This example uses a configuration map to deploy logging resources for production environments, but not for test environments:

::: code language="bicep" source="code/4-condition.bicep" range="17-25, 39-51" highlight="10, 15" :::

## How do you express dependencies between your resources?

In any complex Bicep template, you need to express _dependencies_ between your resources. When Bicep understands the dependencies between your resources, it deploys them in the correct order.

Bicep allows you to explicitly specify a dependency by using the `dependsOn` property. However, in most cases, it's possible to let Bicep automatically detect dependencies. When you use the symbolic name of one resource within a property of another, Bicep detects the relationship. It's better to let Bicep manage these itself whenever you can. That way, when you change your template, Bicep will make sure the dependencies are always correct, and you won't add unnecessary code that makes your template more cumbersome and harder to read.

## How do you express parent-child relationships?

Azure Resource Manager and Bicep have the concept of _child resources_, which only make sense to deploy within the context of their parent. For example, an Azure SQL database is a child of a SQL server. There are several ways to define child resources, but in most cases, it's a good idea to use the `parent` property. This helps Bicep to understand the relationship so it can provide validation in Visual Studio Code, and it makes the relationship clear to anyone else who reads the template too.

## How do you set resource properties?

You need to specify the values for resource properties in your Bicep files. It's a good idea to be thoughtful when hard-coding values into your resource definitions. If you know they won't change, hard-coding values might be better than using another parameter that makes your template harder to test and harder to work with. But, if the value might change, consider defining values as parameter or variables to make your Bicep code more dynamic and reusable.

When you do hard-code values, it's good to make sure the values are understandable to others. For example, if a property has to be set to a specific value otherwise the resource won't behave correctly for your solution, then consider creating a well-named variable that provides an explanation, and then assign the value by using the variable. For situations where a variable name doesn't tell the whole story, consider adding a comment - you'll learn more about comments later in this module.

For some resource properties, you need to create complex expressions that include functions and string interpolation to construct values automatically. Your Bicep code is usually clearer when you declare variables and reference them in the resource code blocks.

## How do you effectively use version control?

Version control systems like Git can help a lot when you're refactoring code.

Because version control systems are designed to keep track of the changes to your files, you can use them to easily return to an older version of your code if you make a mistake. It's a good idea to commit your work often so that you can go back to the exact point in time that you need.

Version control also helps you to avoid keeping old code in your Bicep files. Imagine your Bicep code includes a resource definition that you don't need anymore. You might feel like there's a chance you could need the resource definition again in the future. It's tempting to comment out the resource definition so you keep it in the file. But really, this just clutters up your Bicep file and makes it hard for anyone else to understand what's going on and why the commented-out resources are still there. It's also easy for someone to accidentally uncomment the definition in future, leading to unpredictable results. Instead, when you use a version control system, you can simply remove the old resource definition. If you need to see it again in the future, you can always go back to the history of the file.
