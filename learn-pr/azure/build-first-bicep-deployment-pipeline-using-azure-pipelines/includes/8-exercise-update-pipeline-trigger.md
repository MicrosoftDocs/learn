A colleague asks you to turn on the App Service Always On feature on the company website, so the website app is always running.

In this exercise, you'll update the pipeline you created to run automatically whenever a file changes on your _main_ branch. You'll use the updated pipeline to deploy the requested configuration change to the website.

During the process, you'll:

> [!div class="checklist"]
>
> - Update your pipeline, so it triggers automatically whenever a file changes in the _deploy_ folder on the _main_ branch.
> - Make a change to your Bicep file.
> - Verify that the pipeline runs automatically.

## Update the trigger to be branch-based

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Remove the manual trigger on the first line.

1. Add the following trigger definition on the first line:

   :::code language="yaml" source="code/8-pipeline.yml" range="1-5":::

   Notice that you also enable concurrency control, to avoid your pipeline running multiple times simultaneously.

1. Save your changes to the file.

1. Commit your changes, but don't push the changes yet. You'll push them soon.

   ```bash
   git add .
   git commit -m 'Add branch trigger'
   ```

## Update your Bicep file

1. In Visual Studio Code, open the _main.bicep_ file.

1. In the `appServiceApp` resource definition's `siteConfig` property, add the `alwaysOn` property, with a value of `true`:

   :::code language="bicep" source="code/8-main-broken.bicep" range="60-76" highlight="8":::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, run the following code to commit your changes and push both your commits:

   ```bash
   git add .
   git commit -m 'Configure app Always On setting'
   git push
   ```

## Verify that the pipeline fails

1. In your browser, select **Pipelines**, and then select your pipeline.

1. Select the most recent run to see that the pipeline ran automatically. The pipeline ran because you pushed your changes to a branch that the branch trigger monitors. If the pipeline is still running, wait a minute, and then refresh the page.

   :::image type="content" source="../media/8-failed.png" alt-text="Screenshot of Azure DevOps that shows the failed pipeline run.":::

   The pipeline shows a failed deployment.

1. To diagnose the failure, in **Jobs**, select the job, and then select the failed _AzureResourceManagerTemplateDeployment_ task. Scroll to see the full error message. The error message includes the following text:

   `There was a conflict. AlwaysOn cannot be set for this site as the plan does not allow it. For more information on pricing and features, please see: https://aka.ms/appservicepricingdetails`

   This error message indicates that the deployment failed because the App Service app was deployed by using the F1 free tier, which doesn't support the Always On feature.

   > [!IMPORTANT]
   > This example illustrates how it's important to test your Bicep files, including all the parameter values you use. It's easy for subtle errors to be added to your resource configuration or other code. You might not discover an issue until your pipeline deploys the code and it fails. In a future module, you'll learn some strategies you can use to verify and test your Bicep code.

## Fix the Bicep file and see the pipeline triggered again

You speak to your colleague about the failed deployment. Together, you decide that the Always On setting needs to be applied only for your production environment. Here, you fix the issue that caused your deployment failure by applying the new rule you decide to use.

1. In Visual Studio Code, add new properties for each environment type to the `environmentConfigurationMap` variable:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="23-56" highlight="3-5, 19-21":::

1. Change the application's `alwaysOn` setting to use the appropriate configuration map value for the environment type:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="66-82" highlight="8":::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, commit your changes and push them:

   ```bash
   git add .
   git commit -m 'Enable App Service Always On for production environments only'
   git push
   ```

## Verify that the pipeline succeeds

1. In Azure DevOps, return to the **Pipelines** list and select your pipeline.

1. Select the most recent run. If the pipeline is still running, wait a minute, and then refresh the page.

   :::image type="content" source="../media/8-success.png" alt-text="Screenshot of Azure DevOps that shows the successful pipeline run.":::

   The pipeline shows a successful deployment. It succeeded this time because you used a valid Bicep file.

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
