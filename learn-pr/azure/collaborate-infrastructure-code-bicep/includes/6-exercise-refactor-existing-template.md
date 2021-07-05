Your colleague has come back to you with some questions about your template. You decide to refactor the file to make it easier for them to work with. In this exercise, you apply the best practices you learned in the preceding units.

## Your task

Look at the Bicep template that you saved earlier. Think about the advice you've seen for how to structure your templates. Try to update your template to make it easier for your colleague to understand.

In the sections below, there are some pointers to specific parts of the template and some hints for things you might want to change. A suggested solution is provided, but your template might look different - that's OK!

## Update the parameters

1. There are some parameters in your template that aren't clear. For example, consider these parameters:

   ::: code language="bicep" source="code/2-template.bicep" range="3-20" :::

   What are they used for?

   > [!TIP]
   > If you have a parameter that you're trying to understand, Visual Studio Code can help. Select and hold (or right-click) the name of a parameter anywhere in your file and select **Find All References**.

   Does the template need to specify the list of allowed values for the `skuName` parameter? What resources are affected by choosing different values for these parameters? Is there a better name you can give the parameters?

   > [!TIP]
   > When you rename identifiers, you need to make sure you rename them consistently in all parts of your template. This is especially important for parameters, variables, and resources that you refer to throughout your template.
   >
   > Visual Studio Code offers a convenient way to rename symbols: select the identifier you want to rename, press <kbd>F2</kbd>, enter a new name, and press <kbd>Enter</kbd>:
   >
   > :::image type="content" source="../media/4-rename-symbol.png" alt-text="Screenshot from Visual Studio Code showing how to rename a symbol." border="true":::
   >
   > This renames the identifier and automatically updates all of the references to it as well.

1. The `managedIdentityName` parameter doesn't have a default value. Could you fix that, or better yet, create the name automatically within the template?

1. Look at the `roleDefinitionId` parameter definition:

   ::: code language="bicep" source="code/2-template.bicep" range="27" :::

   Why is there a default value of `b24988ac-6180-42a0-ab88-20f7382dd24c`? What does that big long identifier mean? How would someone else know whether to use the default value or override it? What could you do to improve this? Does it even make sense as a parameter?

   > [!TIP]
   > That identifier is the _Contributor_ role definition ID for Azure. How can you use that information to improve the template?

1. When someone deploys the template, how  will they know what each parameter is for? Can you add some descriptions to help your template's users?

## Add a configuration set

There are two parameters that control the App Service plan's SKU. Could you provide a configuration set to simplify the parameters?

## Update the symbolic names

Take a look at the symbolic names for the resources in the template. What could you do to improve them?

1. Your Bicep template contains resources with several different capitalization styles for their symbolic names, such as:

   - `webSite` and `webSiteConnectionStrings`, which use camel case.
   - `roleassignment` and `sqlserver`, which all use flat case.
   - `sqlserverName_databaseName` and `AppInsights_webSiteName`, which use snake case.
   
   Can you fix these to use one style consistently?

1. Look at this role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="105-113" :::

   Is the symbolic name descriptive enough to help someone else work with this template?

   > [!TIP]
   > The reason the identity needs a role assignment is that the web app uses its managed identity to connect to the database server. Does that help you to clarify this in the template?

1. There are a few resources with symbolic names that don't reflect the current names of Azure resources:

   ::: code language="bicep" source="code/2-template.bicep" range="67,74, 76,88, 100,103" :::

   Managed identities used to be called _MSIs_, App Service plans used to be called _hosting plans_, and App Service apps used to be called _websites_.

   Can you update these to the latest names, to avoid confusion in the future?

## Update the resource names

1. There are two parameters that explicitly set resource names:

   ::: code language="bicep" source="code/2-template.bicep" range="26-28" highlight="26,28" :::

   Is there another way you could do this?

1. Your SQL logical server's resource name is set using a variable, even though it needs a globally unique names:

   ::: code language="bicep" source="code/2-template.bicep" range="31" :::

   How could you improve this?

## Update dependencies and child resources

1. Here's one of your resources, which includes a `dependsOn` property - does it really need it?

   ::: code language="bicep" source="code/2-template.bicep" range="56-65" highlight="7-9" :::

1. Notice how these child resource are declared in your template:

   ::: code language="bicep" source="code/2-template.bicep" range="44-65" highlight="2, 14" :::

   How could you modify how these resources are declared? Are there any other resources in the template that should be updated too?

## Update property values

1. Take a look at the properties of the SQL database resource:

   ::: code language="bicep" source="code/2-template.bicep" range="44-54" highlight="5, 8-9" :::

   Does it make sense to hard-code the SKU's `name` property value? And what are those weird-looking values for the `collation` and `maxSizeBytes` properties?

   > [!TIP]
   > The `collation` and `maxSizeBytes` properties are the default values. Does that help you to decide what to do with them?

1. Can you change the way the connection string is set so that the complex expression isn't defined in-line with the resource?

   ::: code language="bicep" source="code/2-template.bicep" range="94-102" highlight="5" :::

## Order of elements

Are you happy with the order of the elements in the file? Take a look at the `databaseName` variable - does that belong where it is now?

::: code language="bicep" source="code/2-template.bicep" range="43-54" highlight="1" :::

## Commented-out resource

See the commented-out resource, `storageAccount`? Do you think that needs to be in the file?

## Add comments

Think about anything in the template that might not be obvious, or that needs some extra explanation. Can you add comments to make it clearer for someone else who opens the file in the future?

1. Take a look at the `webSite` resource's `identity` property:

   ::: code language="bicep" source="code/2-template.bicep" range="76-88" highlight="10" :::

   That syntax is quite strange, isn't it? Do you think this needs a comment?

1. Look at the role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="105-113" highlight="2" :::

   The name of the resource uses the `guid()` function. Would it help to explain why?

## Suggested solution

Here's an example of how you might refactor the template. Your template might not look exactly like this, since you may have a different style.

::: code language="bicep" source="code/6-template.bicep" :::
