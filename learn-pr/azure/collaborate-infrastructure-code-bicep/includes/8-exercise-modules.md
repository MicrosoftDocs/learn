TODO scenario. In this exercise, you modularize your Bicep template.

## Your task

Look at the Bicep template you've refactored. There are several resources defined. How would you decide which resources belong in modules?

## Identify clusters of resources

1. Open Visual Studio Code's **Explorer**.
1. Select and hold (or right-click) the _main.bicep_ file.
1. Select **Open Visualizer**.

   The Bicep visualizer displays a graphical representation of your template.

   Do you see any resources that belong together and where it would make sense to put them into separate modules?

   The template could be divided into two main parts:

   - a _web_ module, with the Azure App Service components that host your application.
   - a _database_ module, with Azure SQL components, where you store your data.

   :::image type="content" source="../media/3-visualize-parts.png" alt-text="A diagram showing two clusters of resources in the Bicep visualizer.":::

## Move the SQL components into a module

Think about how you would refactor the Bicep template so that the Azure SQL components are in their own module. How would you structure the new module file?

Try moving the Azure SQL resources and the associated parameters and variables to a new module.

> [!TIP]
> TODO look at Bicep linter clues, e.g. red squiggles and greyed out elements

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

## Make the firewall rule optional

Suppose your toy company's security team has come to you and told you they want to only deploy the Azure SQL firewall rule in non-production environments. In production environments, they have a different approach they want to consider, which you'll work on another time.

How would you modify the module and your parent template to meet this requirement?

### Suggested solution

TODO

<!--
Adjust config map to use different firewall rules for test and prod
-->
