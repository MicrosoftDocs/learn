In the previous exercise, you refactored your Bicep file so that it was clearer and more consistent. This helped your colleague to work with the template and to understand how to use it. Now that they know what it's doing, they've asked if you can make it reusable for some other projects they are working on. In this exercise, you modularize your Bicep template.

## Your task

Look at the Bicep template you've refactored. There are several resources defined. How would you decide which resources belong in modules?

1. Open Visual Studio Code's **Explorer**.

1. Select and hold (or right-click) the _main.bicep_ file.

1. Select **Open Visualizer**.

   The Bicep visualizer displays a graphical representation of your template.

   Do you see any resources that belong together and where it would make sense to put them into separate modules?

## Suggested division

Let's divide the template into two modules:

- a _web_ module, with the Azure App Service components that host your application.
- a _database_ module, with Azure SQL components, where you store your data.

:::image type="content" source="../media/8-visualize-parts.png" alt-text="A diagram showing two clusters of resources in the Bicep visualizer.":::

## Move the SQL components into a module

Think about how you would refactor the Bicep template so that the Azure SQL components are in their own module. How would you structure the new module file?

Try moving the Azure SQL resources and the associated parameters and variables to a new module.

> [!TIP]
> When you move the elements of your template into the module, look at how Visual Studio Code can help you. It displays red squiggles underneath properties and other code that isn't valid, and it displays unused parameters and variables in a different shade. Use these clues to check what you might need to copy or move as you refactor your template.

## Move the App Service components into a module

Now do the same for your template's App Service components.

How will you handle the connection string? Remember it's not a secure practice to pass a connection string as an output from a module or template. How can the App Service module securely get access to the connection string?

## Suggested modules solution

Here's an example of how you might refactor the template into modules. Your Bicep files might not look exactly like these, since you may have a different style.

**main.bicep**:

::: code language="bicep" source="code/8-template.bicep" :::

**modules/app-service.bicep**:

::: code language="bicep" source="code/8-module-app-service.bicep" :::

**modules/sql.bicep**:

::: code language="bicep" source="code/8-module-sql.bicep" :::

Notice a few things about this suggested solution:

- The SQL database connection string is generated in the parent template. The parent template has all of the information that it needs to construct the connection string, and it can pass it securely to the _app-service_ module by using a secure parameter.
- The parent template contains the configuration map. The modules include parameters to specify the SKUs to use, which the parent template takes from the configuration map.
- The modules don't have default values on their parameters, but the template parameters do include default values.
- The modules define the resource names for each resource. It's usually a good practice to have modules define their own resource names. These can be emitted as outputs if the parent template needs to know the names of resources that have been deployed.

## Make the firewall rule optional

Suppose your toy company's security team has come to you and told you they want to only deploy the Azure SQL firewall rule in non-production environments. In production environments, they have a different approach they want to consider, which you'll work on another time.

How would you modify the module and your parent template to meet this requirement?

### Suggested solution

**main.bicep**:

::: code language="bicep" source="code/8-template-sql-condition.bicep" highlight="45-47, 61-63, 73" :::

**modules/sql.bicep**:

::: code language="bicep" source="code/8-module-sql-condition.bicep" highlight="18-19, 47" :::
