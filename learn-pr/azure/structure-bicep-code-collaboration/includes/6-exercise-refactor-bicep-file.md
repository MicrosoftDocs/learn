After reviewing your template with your colleagues, you decide to refactor the file to make it easier for them to work with. In this exercise, you apply the best practices you learned in the preceding units.

## Your task

Review the Bicep template that you saved earlier. Think about the advice you read about how to structure your templates. Try to update your template to make it easier for your colleagues to understand.

In the next sections, there are some pointers to specific parts of the template and some hints about things you might want to change. We provide a suggested solution, but your template might look different, which is perfectly OK!

> [!TIP]
> As you work through the refactoring process, it's good to ensure that your Bicep file is valid and that you don't accidentally introduce any errors. The Bicep extension for Visual Studio Code helps with this effort. Watch out for any red or yellow squiggly lines below your code, because they indicate an error or a warning. You can also view a list of the problems in your file by selecting **View** > **Problems**.

## Update the parameters

1. Some parameters in your template aren't clear. For example, consider these parameters:

   ::: code language="bicep" source="code/2-template.bicep" range="3-20" :::

   What are they used for?

   > [!TIP]
   > If you have a parameter that you're trying to understand, Visual Studio Code can help. Select and hold (or right-click) a parameter name anywhere in your file and select **Find All References**.

   Does the template need to specify the list of allowed values for the `skuName` parameter? What resources are affected by choosing different values for these parameters? Are there better names that you can give the parameters?

   [!include[Tip - How to use Visual Studio Code to rename Bicep symbols](../../includes/azure-template-bicep-tip-rename.md)]

1. The `managedIdentityName` parameter doesn't have a default value. Could you fix that or, better yet, create the name automatically within the template?

1. Look at the `roleDefinitionId` parameter definition:

   ::: code language="bicep" source="code/2-template.bicep" range="27" :::

   Why is there a default value of `b24988ac-6180-42a0-ab88-20f7382dd24c`? What does that long identifier mean? How would someone else know whether to use the default value or override it? What could you do to improve the identifier? Does it even make sense to have this parameter?

   > [!TIP]
   > That identifier is the *Contributor* role definition ID for Azure. How can you use that information to improve the template?

1. When someone deploys the template, how do they know what each parameter is for? Can you add some descriptions to help your template's users?

## Add a configuration set

1. After speaking to your colleagues, you decide to use specific stock keeping units (SKUs) for each resource, depending on the environment being deployed. You decide on these SKUs for each of your resources:

   | Resource | SKU for production | SKU for nonproduction |
   |-|-|-|
   | App Service plan | S1, two instances | F1, one instance |
   | Storage account | GRS | LRS |
   | SQL database | S1 | Basic |

1. Can you use a configuration set to simplify the parameter definitions?

## Update the symbolic names

Take a look at the symbolic names for the resources in the template. What could you do to improve them?

1. Your Bicep template contains resources with various capitalization styles for their symbolic names, such as:

   - `storageAccount` and `webSite`, which use camelCase capitalization.
   - `roleassignment` and `sqlserver`, which use flat case capitalization.
   - `sqlserverName_databaseName` and `AppInsights_webSiteName`, which use snake case capitalization.

   Can you fix these resource names to use one style consistently?

1. Look at this role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="145-153" :::

   Is the symbolic name descriptive enough to help someone else work with this template?

   > [!TIP]
   > The reason the identity needs a role assignment is that the web app uses its managed identity to connect to the database server. Does that help you to clarify this name in the template?

1. A few resources have symbolic names that don't reflect the current names of Azure resources:

   ```bicep
   resource hostingPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
     // ...
   }
   resource webSite 'Microsoft.Web/sites@2023-12-01' = {
     // ...
   }
   resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
     // ...
   }
   ```

   Managed identities used to be called *MSIs*, App Service plans used to be called *hosting plans*, and App Service apps used to be called *websites*.

   Can you update these names to the latest resource names to avoid confusion in the future?

## Simplify the blob container definitions

1. Look at how the blob containers are defined:

   ::: code language="bicep" source="code/2-template.bicep" range="52-56, 91-93" :::

   One of them uses the `parent` property, and the other doesn't. Can you fix these definitions so they're consistent?

1. The blob container names don't change between environments. Do you think the names need to be specified by using parameters?

1. There are two blob containers. Could they be deployed by using a loop?

## Update the resource names

1. You have some parameters that explicitly set resource names:

   ::: code language="bicep" source="code/2-template.bicep" range="26-30" :::

   Could the names be set another way?

   > [!CAUTION]
   > Remember that resources can't be renamed once they're deployed. When you modify templates that are already in use, be careful when you change the way the template creates resource names. If the template is redeployed and the resource has a new name, Azure creates another resource. It might even delete the old resource if you deploy it in *Complete* mode.
   >
   > You don't need to worry about that situation here, because it's only an example.

1. Your SQL logical server's resource name is set using a variable, even though it needs a globally unique name:

   ::: code language="bicep" source="code/2-template.bicep" range="33" :::

   How could you improve the way the name is set?

## Update dependencies and child resources

1. Here's one of your resources, which includes a `dependsOn` property. Does it really need it?

   ::: code language="bicep" source="code/2-template.bicep" range="80-89" highlight="7-9" :::

1. Notice how these child resources are declared in your template:

   ::: code language="bicep" source="code/2-template.bicep" range="68-89" highlight="2, 14" :::

   How could you modify how these resources are declared? Are there any other resources in the template that should be updated too?

## Update property values

1. Take a look at the SQL database resource properties:

   ::: code language="bicep" source="code/2-template.bicep" range="68-78" highlight="5, 8-9" :::

   Does it make sense to hard-code the SKU's `name` property value? And what are those weird-looking values for the `collation` and `maxSizeBytes` properties?

   > [!TIP]
   > The `collation` and `maxSizeBytes` properties are set to the default values. If you don't specify the values yourself, the default values are used. Does that help you to decide what to do with them?

1. Can you change the way the storage connection string is set so that the complex expression isn't defined inline with the resource?

   ::: code language="bicep" source="code/2-template.bicep" range="103-127" highlight="14" :::

## Order of elements

1. Are you happy with the order of the elements in the file? How could you improve the file's readability by moving the elements around?

1. Take a look at the `databaseName` variable. Does it belong at that spot in the order?

   ::: code language="bicep" source="code/2-template.bicep" range="67-78" highlight="1" :::

1. Did you notice the commented-out resource, `webSiteConnectionStrings`? Do you think that needs to be in the file?

## Add comments, tags, and other metadata

Think about anything in the template that might not be obvious, or that needs more explanation. Can you add comments to make it clearer for others who might open the file in the future?

1. Take a look at the `webSite` resource's `identity` property:

   ::: code language="bicep" source="code/2-template.bicep" range="103-127" highlight="22" :::

   That syntax is strange, isn't it? Do you think this needs a comment to help clarify it?

1. Look at the role assignment resource:

   ::: code language="bicep" source="code/2-template.bicep" range="145-153" highlight="2" :::

   The resource name uses the `guid()` function. Would it help to explain why?

1. Can you add a description to the role assignment?

1. Can you add a set of tags to each resource?

## Suggested solution

Here's an example of how you might refactor the template. Your template might not look exactly like this, because your style might be different.

::: code language="bicep" source="code/6-template.bicep" :::

> [!TIP]
> If you're working with your colleagues using GitHub or Azure Repos, it would be a great time to submit a *pull request* to integrate your changes into the main branch. It's a good idea to submit pull requests after you do a piece of refactoring work.
