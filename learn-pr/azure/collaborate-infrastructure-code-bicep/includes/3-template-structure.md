Bicep gives you a lot of flexibility to decide how you structure your code. You can organize your template in the way you like and apply your own style.

In this unit, you'll learn about the way you style your Bicep code, and the importance of a consistent style and clear, understandable Bicep code. You'll also start to think about how to improve the Bicep file that you saw earlier.

## How are your resources named?

In Bicep, it's important that you give your resources meaningful names. Resources in Bicep have two names:

- The symbolic name is only used within the Bicep file and doesn't appear in Azure. This helps anyone who reads or modifies your template to understand the purpose of the resource and its configuration, so they can make an informed decision about whether to change it.
- The resource name is the name of the resource that's created in Azure. Many resources have constraints on their names, and may require unique names.

### Symbolic names

It's important to think about the symbolic names you apply to your resources. Imagine that a colleague will need to modify the template - will they understand what each resource does?

For example, imagine you're defining a storage account. The storage account will contain product manuals for users to download from your website. You could name give the resource a symbolic name of  `storageAccount`, but if it's in a Bicep file that contains lots of other resources - and maybe even other storage accounts - then that name isn't very descriptive. So you could instead give it a symbolic name that includes a bit of information about its purpose - like perhaps `productManualStorageAccount`.

### Capitalization

In Bicep, you typically use _camel case_ for the names of parameters, variables, and resource symbolic names. This means use a lowercase first letter for the first word, and then capitalize the first letter of subsequent words - like in `productManualStorageAccount`.

You're not required to use camel case. If you choose to use a different style, it's important to agree on one standard within your team and use it consistently.

> [!NOTE]
> Other capitalization styles include:
> - Pascal case (`ProductManualStorageAccount`)
> - Snake case (`product_manual_storage_account`)
> - Flat case (`productmanualstorageaccount`)
> - Train case (`Product-Manual-StorageAccount`)

### Change symbolic names in Visual Studio Code

When you rename identifiers, you need to make sure you rename them consistently in all parts of your template. This is especially important for parameters, variables, and resources that you refer to throughout your template.

Visual Studio Code offers a convenient way to rename symbols: select the identifier you want to rename, press <kbd>F2</kbd>, enter a new name, and press <kbd>Enter</kbd>:

:::image type="content" source="../media/4-rename-symbol.png" alt-text="Screenshot from Visual Studio Code showing how to rename a symbol." border="true":::

This renames the identifier, and all of the references to it as well.

### Resource names

Every Azure resource has a name. Names make up a part of the resource's identifier. In many cases, they also are represented as the hostnames that you use to access the resource. For example, when you create an App Service app named `myapp`, the hostname you use to access the app will be `myapp.azurewebsites.net`. Resources can't be renamed once they're deployed.

It's important to consider how you name your Azure resources. Many organizations define their own resource naming convention. [The Azure Cloud Adoption framework has specific guidance](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging?azure-portal=true) that can help you define yours. The purpose of a resource naming convention is to help everyone in your organization understand what each resource is for.

Additionally, every Azure resource has certain naming [rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules). For example, there are restrictions around the length of names, the characters they can include, and whether names have to be globally unique or just unique within a resource group.

It can be complex to follow all of the naming conventions for your organization as well as the naming requirements for Azure. A well-written Bicep template should hide this complexity from its users and determine the names for resources automatically. A good approach to follow is:

- Add a parameter that is used to create a _uniqueness suffix_. This helps to ensure that your resources have unique names. It's a good idea to use the `uniqueString()` function to generate a default value. Someone who deploys your template can override this with a specific value if they want to have a meaningful name.
- Use variables to construct resource names dynamically. Your Bicep code can ensure the names it generates follow your organization's naming convention as well as Azure's requirements. Include the uniqueness suffix as part of the resource name.

> [!TIP]
> It's better to use uniqueness suffixes rather than prefixes. This approach makes it easier to sort and to quickly scan your resource names. Also, some Azure resources have restrictions about the first character of the name, and randomly generated names can sometimes violate these restrictions.

<!-- TODO -->

> [!WARNING]
> I haven't updated the rest of this section yet.

In our template, there are several variables used to generate resource names, for example the `hostingPlanName` variable used for the `serverfarms` resource name:

```bicep
var hostingPlanName = 'hostingplan${uniqueString(resourceGroup().id)}'
```

> [!IMPORTANT]
> You should always check what rules apply to resources you have in your templates and ensure incorrect names won't break the deployment.

In this specific example, the `serverfarms` resource [requires](/azure/azure-resource-manager/management/resource-name-rules) its name must be:

- unique within the resource group,
- the length can be between 1-40 alphanumeric characters (with an option to use hyphens).

The variable above is a concatenation of `hostingplan` string and an autogenerated, [unique](/azure/azure-resource-manager/templates/template-functions-string), 13 characters long string, that is derived from the Resource Group ID.

Since the only dynamic part is the unique string, we're certain that it will always match the rules. If we wanted to allow users to influence how the final name looks like, we could introduce a new parameter for name prefix. We would use the `@maxLenght()` decorator to ensure the prefix won't exceed 27 characters and add the `@description()` decorator to provide additional information.

```bicep
@maxLength(27)
@description('Naming prefix for web farm resource. Only alphanumeric characters and hyphen are allowed. Max size is 27 characters.')
param hostingPlanNamePrefix string = 'hostingplan'

var hostingPlanName = '${hostingPlanNamePrefix}${uniqueString(resourceGroup().id)}'
```

TODO END

## How understandable are the parameters?

Parameters help to make Bicep files reusable and flexible. However, it's important that the purpose of each parameter is clear. Most of the time, when yuo your colleagues work with your template they'll use parameters to change the behavior of their deployment, so it's critical that parameters are clearly named.

Default values are an important way to make your template usable by others. It's important to use default values where they make sense.

Bicep can also help to validate the input that the user provides when they deploy the template. Your Bicep files use _parameter decorators_ to help Bicep and the user understand what values are permitted for each parameter.

## How do you express dependencies between your resources?

In any complex Bicep template, you need to have _dependencies_ between your resources. When Bicep understands the dependencies between your resources, it deploys them in the correct order.

Bicep allows you to explicitly specify a dependency by using the `dependsOn` property. However, in most cases, it's possible to let Bicep automatically detect dependencies. When you use the symbolic name of one resource within a property of another, Bicep detects the relationship. It's better to let Bicep manage these itself whenever you can. That way, when you change your template, Bicep will make sure the dependencies are always correct, and you won't add unnecessary code that makes your template more cumbersome and harder to read.

## How do you express parent-child relationships?

Azure Resource Manager and Bicep have the concept of _child resources_, which only make sense to deploy within the context of their parent. For example, a SQL database is a child of a SQL server. There are several ways to define child resources, but in most cases, it's a good idea to use the `parent` property. This helps Bicep to understand the relationship, and it makes it clear to anyone else who reads the template too.

## How do you set resource properties?

You need to specify the values for resource properties in your Bicep files. It's a good idea to avoid hard-coding values directly, unless you know they won't change. This makes your Bicep template more dynamic and reusable. When you do hard-code values, it's good to make sure the values are understandable to others. For example, if you have to include a specific value for your resource to do what you need, consider creating a well-named variable and assigning the value using that. Or, consider adding a comment - you'll learn more about comments soon.

For some resource properties, you need to create complex expressions, and then use functions and string interpolation to construct values automatically. Your Bicep code is usually clearer when you declare variables and reference them in the resource code blocks.

## What order should your Bicep code follow?

Your Bicep templates can contain many elements, including parameters, variables, resources, modules, outputs, and a `targetScope` for the entire template. Bicep doesn't enforce an order for your elements to be in. However, it's important you think about the order of your elements to make sure your template is clear and understandable.

There are two main authoring styles used in the community. You and your team should agree on one and use it consistently.

### Group elements together by element type

You can group all elements of the same type together. So, all of your parameters would go in one place, usually at the top of the file, followed by variables, and then resources and modules, with outputs at the bottom. If you follow this convention, consider putting the `targetScope` at the top of the file.

This ordering makes some intuitive sense when you're used to other infrastructure as code languages, like JSON ARM templates. It also can make your template easy to understand because it's clear where you need to look for specific types of elements. However, in longer templates, it can be challenging to navigate and jump between the elements of your template.

> [!TIP]
> Consider using Visual Studio Code's features to navigate around your template:
> - Go to Definition
> - Find All References
> - Peek Definition

You still have to decide how to order the elements within these categories. It's a good idea to group related parameters together - so for example, all of the parameters that are about a storage account belong together, and within that, the parameters about the storage account's SKU would also belong together. Similarly, group related resources together too. This helps anyone who uses your template to quickly navigate around, and to understand the important parts of the template.

Sometimes, you create a template that has deploys a primary resource, with a number of secondary supporting resources. For example, you might create a template to deploy a website hosted on Azure App Service. The primary resource is the App Service app. Secondary resources in the same template would include the App Service plan, storage account, Application Insights instance, and others. When you have a template like this, it's a good idea to put the primary resource or resources at the top of the resource section of the template, so that anyone who opens the template can quickly identify the purpose of the template and can find the important resources.

### Group elements together by resource type

Alternative, you can group your elements based on the type of the resources being deployed. For example, you might have a Bicep file that deploys an Azure SQL database server and database, as well as a storage account and a Log Analytics workspace. You could put all of the parameters, variables, and resources that relate to the Azure SQL resources together, then put the parameters, variables and resources for the storage account, and finally the elements for the Log Analytics workspace.

This approach can make it easy to read your template, since all of the elements you need for a specific resource are together. But it makes it harder to quickly check how specific element types are declared, like if you want to review all of your parameters.

You also need to consider how to handle parameters and variables that are common to multiple resources, like a `location` parameter that tells Bicep the Azure region to deploy all of your resources to. These common elements should be placed together, ideally at the top of the Bicep file.

> [!TIP]
> If you find yourself using this approach, consider whether it might make more sense to create _modules_ for groups of related resources, and then use a simpler template to combine the modules together. Bicep modules are covered in more detail later in this Learn module.

## How flexible should a Bicep file be?

One of the goals of defining your infrastructure as code is to make your templates reusable and flexible. You don't want to create single-purpose templates that have hard-coded configuration. On the other hand, it doesn't make sense to expose all resource properties as parameters: you create templates that work for your specific business problem or solution, not generic templates that need to work for every situation. You also don't want to have so many unnecessary parameters that it takes a long time for anyone to deploy your template. This is particularly important when you configure the SKUs and instance counts of resources.

When you're planning a template, consider how you'll balance flexibility with simplicity. There are two common approaches to providing parameters in templates: providing free-form configuration options, and using known sets of configuration. Let's consider an example Bicep that deploys a storage account and an App Service plan.

### Provide free-form configuration options

You might consider creating a set of parameters to control each of the SKUs and instance counts for the resources:

::: code language="bicep" source="code/3-multiple-parameters.bicep" :::

This provides the most flexibility, since anyone who uses the template can specify any combination of parameter values they want. However, as you add more resources, you need more parameters - and your template becomes more complicated as a result. Also, you might need to restrict certain combinations of parameters, or ensure that when a specific resource is deployed using one SKU, another resource needs to be deployed using another specific SKU. It's hard to enforce these rules when you provide so many individual parameters.

> [!TIP]
> Think about anyone who will use or work with your template. If they open it and see dozens of parameters, it could be overwhelming. You might be able to reduce the number of parameters by grouping related parameters together in form of a parameter object. However, this reduces your ability to validate the parameter values.

### Use known configuration sets

Alternatively, you could provide a single parameter with a list of allowed values, like a list of environment types. When someone deploys your template, they only need to select a value for this one parameter:

::: code language="bicep" source="code/3-configuration-map.bicep" range="4-9" :::

> [!NOTE]
> This approach is sometimes called _t-shirt sizing_. When you buy a t-shirt, you don't get lots of options for its length, width, sleeves, and so forth - you simply choose between small, medium, and large sizes.

Configuration sets offer lower flexibility, since anyone who deploys your template can't specify specific sizes for individual resources. But, it means you can validate each set of configurations and ensure they fit your requirements. It reduces the need for your template's users to understand all of the different options available for each resource, and it becomes easier to support, test, and troubleshoot your templates.

When you work with configuration sets, it's often useful to create a _map_ variable, which you use to determine the specific properties you set on different resources based on the parameter:

::: code language="bicep" source="code/3-configuration-map.bicep" range="13-36" :::

Your resource definitions then use the configuration map to define the resource properties:

::: code language="bicep" source="code/3-configuration-map.bicep" range="38-42" highlight="4" :::

## Use version control effectively

Version control systems like Git can help a lot when you're refactoring code.

Since version control systems are designed to keep track of the changes to your files, you can use them to easily return to an older version of your code if you make a mistake. It's a good idea to commit your work often so that you can go back to the exact point in time that you need.

Version control also helps you to avoid keeping old code in your Bicep files. Imagine that your Bicep code includes a resource definition that you don't need anymore. But, you might feel like there's a chance you could need the resource definition again in the future. It might be tempting to comment out the resource definition so you keep it in the file. This actually just clutters up your Bicep files, and makes it hard for anyone else to understand what's going on and the commented-out resources are there. It's also easy for someone to accidentally uncomment the definition in future, leading to unpredictable results. Instead, when you use a version control system, you can simply remove the old resource definition. If you need to see it again in the future, you can always go back to the history of the file.
