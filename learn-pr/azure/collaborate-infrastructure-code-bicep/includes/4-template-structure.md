Bicep gives you a lot of flexibility to decide how you structure your code. In this unit, you'll learn about the ways you can structure your Bicep code, and the importance of a consistent style and clear, understandable Bicep code.

## What order should your Bicep code follow?

Your Bicep templates can contain many elements, including parameters, variables, resources, modules, outputs, and a `targetScope` for the entire template. Bicep doesn't enforce an order for your elements to be in. However, it's important you think about the order of your elements to make sure your template is clear and understandable.

There are two main approaches to ordering. You and your team should agree on one and use it consistently.

### Group elements together by element type

You can group all elements of the same type together. So, all of your parameters would go in one place, usually at the top of the file, followed by variables, and then resources and modules, with outputs at the bottom.

:::image type="content" source="../media/4-group-element-type.png" alt-text="Diagram showing elements grouped by element type. Parameters are grouped together, then variables, then resources, then outputs." border="false":::

> [!TIP]
> If you follow this convention, consider putting the `targetScope` at the top of the file.

This ordering makes sense when you're used to other infrastructure as code languages, like JSON ARM templates. It also can make your template easy to understand because it's clear where you need to look for specific types of elements. However, in longer templates, it can be challenging to navigate and jump between the elements of your template.

You still have to decide how to order the elements within these categories. It's a good idea to group related parameters together - so for example, all of the parameters that are about a storage account belong together, and within that, the parameters about the storage account's SKU would also belong together. Similarly, group related resources together too. This helps anyone who uses your template to quickly navigate around, and to understand the important parts of the template.

Sometimes, you create a template that has deploys a primary resource, with a number of secondary supporting resources. For example, you might create a template to deploy a website hosted on Azure App Service. The primary resource is the App Service app. Secondary resources in the same template would include the App Service plan, storage account, Application Insights instance, and others. When you have a template like this, it's a good idea to put the primary resource or resources at the top of the resource section of the template, so that anyone who opens the template can quickly identify the purpose of the template and can find the important resources.

### Group elements together by resource type

Alternative, you can group your elements based on the type of the resources being deployed. For example, you might have a Bicep file that deploys an Azure SQL database and a storage account. You could put all of the parameters, variables, resources, and outputs that relate to the Azure SQL database resources together, then put the parameters, variables, resources, and outputs for the storage account, like this:

:::image type="content" source="../media/4-group-resource-type.png" alt-text="Diagram showing elements grouped by resource type. Storage account elements are grouped together, then Azure SQL database elements." border="false":::

This approach can make it easy to read your template, since all of the elements you need for a specific resource are together. But it makes it harder to quickly check how specific element types are declared, like if you want to review all of your parameters.

You also need to consider how to handle parameters and variables that are common to multiple resources, like an `environmentType` parameter when you use a configuration map. Common parameters and variables should be placed together, usually at the top of the Bicep file.

> [!TIP]
> Consider whether it might make more sense to create _modules_ for groups of related resources, and then use a simpler template to combine the modules together. Bicep modules are covered in more detail later in this Learn module.

## How do you add meaningful whitespace?

Blank lines, or _whitespace_, can help you to structure your template. By using whitespace thoughtfully, you can clarify the relationships between resources and logically group sections of your Bicep code together. Consider adding a blank line between the sections of your template, regardless of which grouping style you prefer.

## How do you express dependencies between your resources?

In any complex Bicep template, you need to express _dependencies_ between your resources. When Bicep understands the dependencies between your resources, it deploys them in the correct order.

Bicep allows you to explicitly specify a dependency by using the `dependsOn` property. However, in most cases, it's possible to let Bicep automatically detect dependencies. When you use the symbolic name of one resource within a property of another, Bicep detects the relationship. It's better to let Bicep manage these itself whenever you can. That way, when you change your template, Bicep will make sure the dependencies are always correct, and you won't add unnecessary code that makes your template more cumbersome and harder to read.

## How do you express parent-child relationships?

Azure Resource Manager and Bicep have the concept of _child resources_, which only make sense to deploy within the context of their parent. For example, a SQL database is a child of a SQL server. There are several ways to define child resources, but in most cases, it's a good idea to use the `parent` property. This helps Bicep to understand the relationship so it can provide validation in Visual Studio Code, and it makes the relationship clear to anyone else who reads the template too.

## How do you set resource properties?

You need to specify the values for resource properties in your Bicep files. It's a good idea to avoid hard-coding values directly, unless you know they won't change. This makes your Bicep template more dynamic and reusable. When you do hard-code values, it's good to make sure the values are understandable to others. For example, if you have to include a specific value for your resource to do what you need, consider creating a well-named variable and assigning the value using that. For situations where a variable name doesn't tell the whole story, consider adding a comment - you'll learn more about comments later in this module.

For some resource properties, you need to create complex expressions, and then use functions and string interpolation to construct values automatically. Your Bicep code is usually clearer when you declare variables and reference them in the resource code blocks.

## How do you effectively use version control?

Version control systems like Git can help a lot when you're refactoring code.

Since version control systems are designed to keep track of the changes to your files, you can use them to easily return to an older version of your code if you make a mistake. It's a good idea to commit your work often so that you can go back to the exact point in time that you need.

Version control also helps you to avoid keeping old code in your Bicep files. Imagine that your Bicep code includes a resource definition that you don't need anymore. But, you might feel like there's a chance you could need the resource definition again in the future. It might be tempting to comment out the resource definition so you keep it in the file. This actually just clutters up your Bicep files, and makes it hard for anyone else to understand what's going on and the commented-out resources are there. It's also easy for someone to accidentally uncomment the definition in future, leading to unpredictable results. Instead, when you use a version control system, you can simply remove the old resource definition. If you need to see it again in the future, you can always go back to the history of the file.
