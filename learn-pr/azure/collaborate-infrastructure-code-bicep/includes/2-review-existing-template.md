You have an existing template that has been working for you so far. It deploys correctly all resources the project needs. You sit down with another team member to talk over the template and some planned changes for the next phase of the project.

As you work your way through the template, you and your colleague start to notice a few issues. Take a look at the template now, and see how many issues you can spot. You're seeing the template for the first time - do you understand what everything's doing? What could be done to improve the template?

::: code language="bicep" source="code/2-template.bicep" :::

Throughout this module, you'll improve the template to follow best practices and to make it clearer, more understandable, and easier for your colleagues to work with. Before you change the file, you need to add it to a Git repository so you can track changes to it.

-- TODO MOVE OUT BELOW

### Naming conventions

There's an old saying in the tech community that naming conventions are one of the hardest problems to solve in the industry. Whatever language you use, you should define one convention and then use it consistently.

In Bicep, it's important that you give your resources meaningful names. Resources in Bicep have two names:

- The symbolic name is only used within the Bicep file and doesn't appear in Azure. This helps anyone who reads or modifies your template to understand the purpose of the resource and its configuration, so they can make an informed decision about whether to change it.
- The resource name is the name of the resource that's created in Azure. Many resources have constraints on their names, and may require unique names.

In the Bicep template above, your template resources have symbolic names with several different naming styles, such as:

- `webSite` and `webSiteConnectionStrings`, which use camel case.
- `roleassignment` and `sqlserver`, which are all in lowercase.
- `sqlserverName_databaseName` and `AppInsights_webSiteName`, which use underscores to separate parts of their names, and a mixture of capitalization styles.

The same considerations apply to parameters. 

### How usable are the parameters?

Your template has several parameters. Parameters help to make Bicep files reusable and flexible. However, it's important that the purpose of each parameter is clear. There are some parameters here that aren't clear:

- `skuName` and `skuCapacity`: What sort of SKU do they refer to? What resources are affected by choosing different values for these parameters?
- `roleDefinitionId`: What role definition are you assigning and why?

Default values are an important way to make your template usable by others. It's important to use default values where they make sense. In your template, the `managedIdentityName` parameter doesn't have a default value - could you change that, or better yet, create the name automatically? And look at the `roleDefinitionId` parameter. Why is there a default value of `b24988ac-6180-42a0-ab88-20f7382dd24c`? What does that big long identifier mean? How would someone else know whether to use the default value or override it? What could you do to help this?

Bicep can also help to validate the input that the user provides when they deploy the template. The template uses a few _parameter decorators_ to help Bicep and the user understand what values are permitted for each parameter, but there's plenty of room for improvement!

### Resource dependencies

In any complex Bicep template, you need to have _dependencies_ between your resources. When Bicep understands the dependencies between your resources, it deploys them in the correct order.

Bicep allows you to explicitly specify a dependency by using the `dependsOn` property. However, in most cases, it's possible to let Bicep automatically detect dependencies. When you use the symbolic name of one resource within a property of another, Bicep detects the relationship. It's better to let Bicep manage these itself whenever you can. That way, when you change your template, Bicep will make sure the dependencies are always correct, and you won't add unnecessary code that makes your template more cumbersome and harder to read.

Here's one of your resources, which includes a `dependsOn` property - does it really need it?

::: code language="bicep" source="code/2-template.bicep" range="56-65" highlight="7-9" :::

### Child resources

Azure Resource Manager and Bicep have the concept of child resources, which only make sense to deploy within the context of their parent. For example, a SQL database is a child of a SQL server.

There are several ways to define child resources, but in most cases, it's a good idea to use the `parent` property. This helps Bicep to understand the relationship, and it makes it clear to anyone else who reads the template too.

Notice how this child resource was declared in your template:

::: code language="bicep" source="code/2-template.bicep" range="44-54" highlight="2" :::

How could you modify how this resource is declared?

### Property values

You need to specify the values for resource properties in your Bicep files. It's a good idea to avoid hard-coding values directly, unless you know they won't change. This makes your Bicep template more dynamic and reusable. When you do hard-code values, it's good to make sure the values are understandable to others. For example, take a look at the properties of the SQL database resource:

::: code language="bicep" source="code/2-template.bicep" range="44-54" highlight="5, 8-9" :::

Does the SKU `name` property really make sense to hard-code? And what are those weird-looking values for the `collation` and `maxSizeBytes` properties?

For some resource properties, you need to create complex expressions, and use functions and string interpolation to construct values automatically. Your Bicep code is usually clearer when you declare variables and reference them in the resource code blocks. Can you spot any room for improvement in the following code block from the template?

::: code language="bicep" source="code/2-template.bicep" range="94-102" highlight="98" :::

### Documentation

Have you noticed there are no comments that would make it easier to understand what the template does? It's important to have a clear understanding of the template within our team! It's something we aim to improve as well.
