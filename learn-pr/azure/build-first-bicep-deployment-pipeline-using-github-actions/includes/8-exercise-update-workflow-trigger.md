A colleague asks you to turn on the App Service Always On feature on the company website, so the website app is always running.

In this exercise, you'll update the workflow you created to run automatically whenever a file changes on your *main* branch. You'll use the updated workflow to deploy the requested configuration change to the website.

During the process, you'll:

> [!div class="checklist"]
> * Update your workflow so that it triggers automatically whenever files change in the *deploy* folder and on the *main* branch.
> * Make a change to your Bicep file.
> * Verify that the workflow runs automatically.

## Update the trigger to be branch-based

1. In Visual Studio Code, open the *.github/workflows/workflow.yml* file.

1. Remove the manual trigger on the second line.

1. Add the following event trigger definition in its place:

   :::code language="yaml" source="code/8-workflow.yml" range="2-7" :::

1. Save the changes to the file.

1. Commit your changes, but don't push yet. You'll push them shortly.

   ```bash
   git add .
   git commit -m 'Add branch trigger'
   ```

## Update your Bicep file

1. In Visual Studio Code, open the *main.bicep* file.

1. Within the `appServiceApp` resource definition's `siteConfig` property, add the `alwaysOn` property with a value of `true`:

   :::code language="bicep" source="code/8-main-broken.bicep" range="59-75" highlight="8" :::

1. Save your changes to the file.

1. Commit your changes and push both of your commits by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m 'Configure app Always On setting'
   git push
   ```

## Verify the workflow fails

1. In GitHub, select the **Actions** menu, and select your workflow. Select the most recent run.

1. Notice the workflow automatically ran. This is because you pushed your changes to a branch that the branch trigger monitors. If the workflow is still running, wait a minute and refresh it. The workflow run is displayed.

   :::image type="content" source="../media/8-failed.png" alt-text="Screenshot of the GitHub interface showing the failed workflow run." border="true":::

   Notice that the workflow run failed.

2. To diagnose the failure, select the **deploy** Job, and select the failed **arm-deploy** task. Notice that it includes the following text:

   > There was a conflict. AlwaysOn cannot be set for this site as the plan does not allow it. For more information on pricing and features, please see: https://aka.ms/appservicepricingdetails

   This error message indicates that the deployment failed because the App Service app is deployed using the _F1_ free tier, which doesn't support the Always On feature.

   > [!IMPORTANT]
   > This illustrates how it's important to test your Bicep files, including all of the parameter values you use. It's easy for subtle errors to creep into your resource configuration or other code. You  might not discover the issues until your workflow deploys the code. In a future module, you'll learn some strategies to verify and test your Bicep code.

## Fix the Bicep file and see the workflow triggered again

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

## Verify the workflow succeeds

In GitHub, return to the **workflows** list and select your workflow, then select the most recent run. If the workflow is still running, wait a minute and refresh it. The workflow run is displayed.

:::image type="content" source="../media/8-success.png" alt-text="Screenshot of the GitHub interface showing the successful workflow run." border="true":::

Notice that the workflow run succeeded, because you now have a valid Bicep file.