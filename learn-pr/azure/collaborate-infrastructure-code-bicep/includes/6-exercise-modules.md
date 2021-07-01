Code refactoring is an important task that will help accomplish our main goal: improve our Bicep code to make it more flexible and reusable.

In this exercise, we'll apply all the practices we learned in previous units. We will refactor the original template into a collection of code artifacts that follow recommended practices.

## Challenge yourself

There's rarely only one correct solution and each engineer has their own style and preferences. Instead of giving you a step-by-step guide, we'll present you with clear goals, allowing you to work independently. When you're finished, you can compare your results with a "possible" solution. Don't worry, this exercise also includes the guide, if you're not up for the challenge.

### Goals

This mission, should you choose to accept it, requires you to:

- initialize a new Git repo in your computer
- copy the original template from 'Review existing template' unit into a single `mainTemplate.bicep` file
- make your first commit to the `main` branch. This branch will represent the "current state".
- create a new "feature" branch and add commits there when introducing changes to your Bicep files
- create two Bicep modules for application front-end and back-end, as recommended in the 'Modules' unit. Extract relevant code from the main template to the modules. Ensure there are clear contracts declared for both.
- modify the main template to consume the modules
- restructure your templates based on one of the styles, introduced in 'Template structure' unit
- consider applying the 'known-configuration' pattern, instead of 'free-form configuration'
- unify the naming convention for all identifiers and resources
- ensure that all parameters use decorators as input validators
- ensure that "implicit dependency" is used in your declarations
- modify child resources to use `parent` property correctly
- make sure that complex expressions are declared as variables
- limit the number of hard-coded values

If you accept the challenge, stop reading now. Try to work on your own and meet all the goals. When you're done, come back here and compare the results and the workflow we used with yours!

## A possible solution

This section contains a step-by-step guide of the workflow used to meet all the goals. It also includes several tips for using VS Code and its extensions in a productive way.

> [!NOTE]
> Please note this is a possible, not the only correct solution. There are multiple ways to achieving the goals.

### Create a feature branch

All the change we'll be making should be separate from our "working code", so we'll create a "short-lived" **feature branch** and make all changes there.

1. Use **Ctrl - Shift - P** to open the Command palette. Start typing `git branch` and select **Git: Create Branch** from the drop-down menu.
2. Write `refactoring` in the dialogue box and hit Enter.
3. You've created a new Git branched and VS Code switched you to it automatically.

### Add two modules

Now it's time to introduce two modules in our code base and follow instructions from the "Modularize your Bicep code" unit.

1. Select **View - Explorer** from the menu.
2. Use **Ctrl - Shift - P** to open the Command palette again. Start typing `file folder` and select **File: New Folder** from the drop-down menu.
3. A new folder will appear in the Explorer view, prompting you to enter a name. Type `modules` and press Enter.
4. Hover over the new folder, right-click, and select **New file** from the drop-down menu. A new file will appear, prompting you to enter a name. Type `azSqlBackend.bicep` and press Enter.
5. Use **Ctrl - Tab** to switch back to your main template. Select lines 34-62, use **Ctrl - X** to cut the code, use **Ctrl - Tab** again to switch to your new module and use **Ctrl - V** to paste the code from your clipboard.
6. You should see many red "squiggly lines". This is IntelliSense, informing you about missing declarations in your template. When we carved out those three resource declarations from the main template, we left behind several important parameters and variables.

   :::image type="content" source="../media/5-vscode-module-intellisense.png" alt-text="VS Code showing IntelliSense hints about missing identifiers.":::

7. Switch to your main template window. Use **Ctrl - X** to cut **lines 31-32** from the main template (containing `sqlserverName` and `databaseName` variables). Switch back to your module and paste the content of your clipboard at the top of the file.
8. Add a new line at the top of the file and add the following code snippet:

   ```bicep
   param location string
   param sqlAdministratorLogin string

   @secure()
   param sqlAdministratorLoginPassword string
   ```

   If you did it correctly, all squiggly lines should disappear.

9. Now let's add our first module to the main template. Switch back to the editor window with `mainTemplate.bicep`, scroll to the bottom, add a new line, and start typing `module azBackend 'modules/azSqlBackend.bicep' =`. IntelliSense should give you a few options (similar to the screenshot below). Select "required-properties".

   :::image type="content" source="../media/5-vscode-module-reqprop.png" alt-text="VS Code showing IntelliSense hints for modules.":::

10. Populate both `name` and all `params` properties with values. Use parameters and variables declared in the main template.

   > [!TIP]
   > Notice that all parameters without a default value were automatically added. You can use the **Tab** key to jump from one property to another and add missing information.

   This is how your declaration should look like in the end:

   ```bicep
   module azBackend 'modules/azSqlBackend.bicep' = {
   name: 'backend-deployment'
   params: {
      location: location
      sqlAdministratorLogin: sqlAdministratorLogin
      sqlAdministratorLoginPassword: sqlAdministratorLogin
      }
   }
   ```

<!--
- create two Bicep modules for application front-end and back-end, as recommended in the 'Modules' unit. Extract relevant code from the main template to the modules. Ensure there are clear contracts declared for both.
- modify the main template to consume the modules
- restructure your templates based on one of the styles, introduced in 'Template structure' unit
- consider applying the 'known-configuration' pattern, instead of 'free-form configuration'
- unify the naming convention for all identifiers and resources
- ensure that all parameters use decorators as input validators
- ensure that "implicit dependency" is used in your declarations
- modify child resources to use `parent` property correctly
- make sure that complex expressions are declared as variables
- limit the number of hard-coded values
 -->

<!-- //TODO: Rename `sku`-related parameters to `hostingPlanSkuName` and `hostingPlanSkuCapacity` -->


<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "## Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->


TODO naming

| Line  | Description  | Old name  | New name  |
|---------|---------|---------|---------|
| 17     | Parameter for SQL Server SKU name       | `skuName`        | `sqlServerSkuName`        |
| 20     | Parameter for SQL Server SKU capacity        | `skuCapacity`        | `sqlServerSkuCapacity`        |
| 56     | Symbolic name for SQL firewall rule(s)        | `sqlserverName_AllowAllWindowsAzureIps`        | `sqlServerAllowAllIps`        |
| 106     | Symbolic name for Role assignment        | `roleassignment`        | `roleAssignment`        |
| 116     | Symbolic name for Application Insights        | `AppInsights_webSiteName`        | `appInsights`        |
