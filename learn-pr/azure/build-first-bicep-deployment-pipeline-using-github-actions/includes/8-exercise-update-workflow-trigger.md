A colleague asks you to turn on the App Service Always On feature on the company website, so the website app is always running.

In this exercise, you'll update the workflow you created to run automatically whenever a file changes on your _main_ branch. You'll use the updated workflow to deploy the requested configuration change to the website.

During the process, you'll:

> [!div class="checklist"]
>
> - Update your workflow, so it triggers automatically whenever a file changes in the _deploy_ folder on the _main_ branch.
> - Make a change to your Bicep file.
> - Verify that the workflow runs automatically.

## Update the trigger to be branch-based

1. In Visual Studio Code, open the _.github/workflows/workflow.yml_ file.

1. At the top of the file, after the line `name: deploy-toy-website` add the following code to prevent multiple simultaneous workflows runs:

   :::code language="yaml" source="code/8-workflow.yml" range="1-2" highlight="2" :::

1. Remove the manual trigger, which is the line that currently reads `on: [workflow_dispatch]`.

1. Between `concurrency:` and `permissions:` add the following trigger definition:

   :::code language="yaml" source="code/8-workflow.yml" range="2-11" highlight="3-8":::

1. Save your changes to the file.

1. Commit your changes, but don't push them yet. You'll push the changes soon.

   ```bash
   git add .
   git commit -m 'Add branch trigger'
   ```

## Update your Bicep file

1. In Visual Studio Code, open the _main.bicep_ file.

1. In the `appServiceApp` resource definition's `siteConfig` property, add the `alwaysOn` property, with a value of `true`:

   :::code language="bicep" source="code/8-main-broken.bicep" range="56-72" highlight="8" :::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, run the following code to commit your changes and push both your commits:

   ```bash
   git add .
   git commit -m 'Configure app Always On setting'
   git push
   ```

## Verify the workflow fails

1. In your browser, select GitHub's **Actions** menu, and select your workflow.

1. Select the most recent workflow run to see that the workflow ran automatically. The workflow ran because you pushed your changes to a branch monitored by the push trigger. If the workflow is still running, wait a minute, and then refresh the page.

   :::image type="content" source="../media/8-failed.png" alt-text="Screenshot of the GitHub interface showing the failed workflow run." border="true":::

   The workflow shows a failed deployment.

1. To diagnose the failure, select the **deploy** job, and select the failed **arm-deploy** task.

   Notice that it includes the following text:

   ```Output
   There was a conflict. AlwaysOn cannot be set for this site as the plan does not allow it.
   For more information on pricing and features, please see: https://aka.ms/appservicepricingdetails
   ```

   This error message indicates that the deployment failed because the App Service app was deployed by using the F1 free tier, which doesn't support the Always On feature.

   > [!IMPORTANT]
   > This example illustrates how it's important to test your Bicep files, including all the parameter values you use. It's easy for subtle errors to be added to your resource configuration or other code. You might not discover an issue until your workflow deploys the code and it fails. In a future module, you'll learn some strategies you can use to verify and test your Bicep code.

## Fix the Bicep file and see the workflow triggered again

You speak to your colleague about the failed deployment. Together, you decide that the Always On setting needs to be applied only for your production environment. Here, you fix the issue that caused your deployment failure by applying the new rule you decide to use.

1. In Visual Studio Code, add new properties for each environment type to the `environmentConfigurationMap` variable:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="20-53" highlight="3-5, 19-21" :::

1. Change the application's `alwaysOn` setting to use the appropriate configuration map value for the environment type:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="63-79" highlight="8" :::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, commit your changes and push them:

   ```bash
   git add .
   git commit -m 'Enable App Service Always On for production environments only'
   git push
   ```

## Verify the workflow succeeds

1. In GitHub, return to the **workflows** list. select your workflow.

1. Select the most recent run. If the workflow is still running, wait a minute, and then refresh the page.

   The workflow run is displayed.

   :::image type="content" source="../media/8-success.png" alt-text="Screenshot of the GitHub interface showing the successful workflow run." border="true":::

   The workflow shows a successful deployment. It succeeded this time because you used a valid Bicep file.

## Clean up the resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code **Terminal**, run the following command:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyWebsite --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyWebsite -Force
```

::: zone-end
