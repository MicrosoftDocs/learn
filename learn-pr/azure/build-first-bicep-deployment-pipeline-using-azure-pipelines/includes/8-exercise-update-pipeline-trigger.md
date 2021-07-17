You have a pipeline that can execute a Bicep deployment to your Azure environment. We will now make this pipeline run automatically. In this exercise you will: 

In this exercise, you'll:

> [!div class="checklist"]
> * Update your pipeline so that it triggers automatically whenever files change in the _deploy_ folder and on the **main** branch.
> * Make a change to your Bicep file.
> * Verify that the pipeline runs automatically.

## Update the trigger to be branch-based

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Remove the manual trigger on the first line.

1. Add the following trigger definition in its place:

   :::code language="yaml" source="code/8-pipeline.yaml" range="1-4" :::

1. Save the changes to the file.

1. Commit your changes. You'll push them shortly.

   ```bash
   git add .
   git commit -m 'Add branch trigger'
   ```

## Update your Bicep file

1. In Visual Studio Code, open the _main.bicep_ file.

1. Within the `appServiceApp` resource definition's `siteConfig` property, add the `alwaysOn` property with a value of `true`:

   :::code language="bicep" source="code/8-main-broken.bicep" range="66" :::

1. Save your changes to the file.

1. Commit your changes and push both of your commits by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m 'Add Application Insights instance to Bicep file'
   git push
   ```

## Verify the pipeline fails

1. In Azure DevOps, (TODO need to confirm exact instructions for where the user is)

1. Notice that the pipeline run failed. This is because the App Service app is deployed using the _F1_ free tier, which doesn't support the Always On feature.

<!-- TODO mention this shows how subtle issues can creep in, and that multiple environments can make it hard to test everything -->

## Fix the Bicep file and see the pipeline triggered again

1. In Visual Studio Code, add new properties for each environment type to the `environmentConfigurationMap` variable:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="23-56" highlight="3-5, 19-21" :::

1. Change the application's `alwaysOn` setting to use the appropriate configuration map value for the environment type:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="72" :::

1. Save the changes to the file.

1. Use the Visual Studio Code terminal to commit your changes and push them:

   ```cmd
   git add -A
   git commit -m 'Fix Always On property'
   git push
   ```

## Verify the pipeline succeeds

1. In Azure DevOps, (TODO need to confirm exact instructions for where the user is)

1. Notice that the pipeline run succeeded, because you now have a valid Bicep file.
