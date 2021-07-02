TODO scenario

## Your task

Look at the Bicep template that you saved earlier. Think about the advice you've seen for how to structure your templates. Try to update your template to resolve the issues.

In the sections below, there are some pointers to specific parts of the template and some hints for things you might want to change.

### Parameters

1. There are some parameters in your template that aren't clear. For example, consider these parameters:

   ::: code language="bicep" source="code/2-template.bicep" range="19-21" :::

   What sort of SKU do they refer to? What resources are affected by choosing different values for these parameters? Is there a better name you can give the parameters?

1. The `managedIdentityName` parameter doesn't have a default value - could you change that, or better yet, create the name automatically?

1. Look at the `roleDefinitionId` parameter:

   ::: code language="bicep" source="code/2-template.bicep" range="27" :::

   Why is there a default value of `b24988ac-6180-42a0-ab88-20f7382dd24c`? What does that big long identifier mean? How would someone else know whether to use the default value or override it? What could you do to improve this?

   > [!TIP]
   > That identifier is the _Contributor_ role definition ID for Azure. How can you use that information to improve the template?

### Symbolic names

Take a look at the symbolic names for the resources in the template. What could you do to improve them?

1. Your Bicep template contains resources with several different capitalization styles for their symbolic names, such as:

   - `webSite` and `webSiteConnectionStrings`, which use camel case.
   - `roleassignment` and `sqlserver`, which all use flat case.
   - `sqlserverName_databaseName` and `AppInsights_webSiteName`, which use snake case.
   
   Can you fix these to use one style consistently?

1. Look at this role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="109-117" :::

   Is the symbolic name descriptive enough to help someone else work with this template?

## Resource names

There are two parameters that explicitly set resource names:

::: code language="bicep" source="code/2-template.bicep" range="26-28" :::

Is there another way you could do this?

### Dependencies and child resources

1. Here's one of your resources, which includes a `dependsOn` property - does it really need it?

   ::: code language="bicep" source="code/2-template.bicep" range="56-65" highlight="7-9" :::

1. Notice how this child resource was declared in your template:

   ::: code language="bicep" source="code/2-template.bicep" range="44-54" highlight="2" :::

   How could you modify how this resource is declared?

### Property values

1. Take a look at the properties of the SQL database resource:

   ::: code language="bicep" source="code/2-template.bicep" range="44-54" highlight="5, 8-9" :::

   Does it make sense to hard-code the SKU's `name` property value? And what are those weird-looking values for the `collation` and `maxSizeBytes` properties?

1. Can you change the way the connection string is set so that the complex expression isn't defined in-line with the resource?

   ::: code language="bicep" source="code/2-template.bicep" range="94-102" highlight="5" :::

## Order of elements

Are you happy with the order of the elements in the file? Take a look at the `databaseName` variable - does that belong where it is now?

::: code language="bicep" source="code/2-template.bicep" range="43-54" :::

### Configuration set

Look at how the SKUs are set for the App Service plan.

TODO

Could you provide a configuration set to simplify the parameters?

### Comments

TODO
 - UAMI weird syntax
 - roleassignment name generation

### Commented-out resource

See the commented-out resource, `storageAccount`? Do you think that needs to be in the file?

## Suggested solution

TODO
