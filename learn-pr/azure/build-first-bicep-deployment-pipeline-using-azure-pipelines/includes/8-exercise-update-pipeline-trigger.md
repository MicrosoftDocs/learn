Your colleague has asked you to configure the website to enable the App Service Always On feature, which keeps the website app always running.

In this exercise, you'll update the pipeline you previously created to run automatically whenever a file changes on your **main** branch. You'll use the updated pipeline to deploy the configuration change.

During the process, you'll:

> [!div class="checklist"]
> * Update your pipeline so that it triggers automatically whenever files change in the _deploy_ folder and on the **main** branch.
> * Make a change to your Bicep file.
> * Verify that the pipeline runs automatically.

## Update the trigger to be branch-based

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Remove the manual trigger on the first line.

1. Add the following trigger definition in its place:

   :::code language="yaml" source="code/8-pipeline.yml" range="1-4" :::

1. Save the changes to the file.

1. Commit your changes, but don't push yet. You'll push them shortly.

   ```bash
   git add .
   git commit -m 'Add branch trigger'
   ```

## Update your Bicep file

1. In Visual Studio Code, open the _main.bicep_ file.

1. Within the `appServiceApp` resource definition's `siteConfig` property, add the `alwaysOn` property with a value of `true`:

   :::code language="bicep" source="code/8-main-broken.bicep" range="59-75" highlight="8" :::

1. Save your changes to the file.

1. Commit your changes and push both of your commits by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m 'Configure app Always On setting'
   git push
   ```

## Verify the pipeline fails

1. In Azure DevOps, select the **Pipelines** menu, and select your pipeline. Select the most recent run.

1. Notice the pipeline automatically ran. This is because you pushed your changes to a branch that the branch trigger monitors. If the pipeline is still running, wait a minute and refresh it. The pipeline run is displayed.

   :::image type="content" source="../media/8-failed.png" alt-text="Screenshot of the Azure DevOps interface showing the failed pipeline run." border="true":::

   Notice that the pipeline run failed.

1. To diagnose the failure, select the **Job**, and select the failed **AzureCLI** task. Scroll across to see the full error message. Notice that it includes the following text:

   > There was a conflict. AlwaysOn cannot be set for this site as the plan does not allow it. For more information on pricing and features, please see: https://aka.ms/appservicepricingdetails

   This error message indicates that the deployment failed because the App Service app is deployed using the _F1_ free tier, which doesn't support the Always On feature.

   > [!IMPORTANT]
   > This illustrates how it's important to test your Bicep files, including all of the parameter values you use. It's easy for subtle errors to creep into your resource configuration or other code. You  might not discover the issues until your pipeline deploys the code. In a future module, you'll learn some strategies to verify and test your Bicep code.

## Fix the Bicep file and see the pipeline triggered again

You speak to your colleague about the failed deployment. You decide together that the Always On setting only needs to be applied for your production environment. Here, you fix the issue that caused your deployment failure by applying the new rule you've decided on.

1. In Visual Studio Code, add new properties for each environment type to the `environmentConfigurationMap` variable:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="23-56" highlight="3-5, 19-21" :::

1. Change the application's `alwaysOn` setting to use the appropriate configuration map value for the environment type:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="65-81" highlight="8" :::

1. Save the changes to the file.

1. Use the Visual Studio Code terminal to commit your changes and push them:

   ```bash
   git add .
   git commit -m 'Enable App Service Always On for production environments only'
   git push
   ```

## Verify the pipeline succeeds

In Azure DevOps, return to the **Pipelines** list and select your pipeline, then select the most recent run. If the pipeline is still running, wait a minute and refresh it. The pipeline run is displayed.

:::image type="content" source="../media/8-success.png" alt-text="Screenshot of the Azure DevOps interface showing the successful pipeline run." border="true":::

Notice that the pipeline run succeeded, because you now have a valid Bicep file.
