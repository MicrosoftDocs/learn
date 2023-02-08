Now that your workflow deploys to both of your environments, you're ready to integrate with the third-party API for product reviews. 

Your website team has provided you with the API keys and URLs that your website should use to access the service. There are different values for your test and production environments to use. In this unit, you'll update your workflow to configure each of your environments with the correct settings for the product review API.

During the process, you'll:

> [!div class="checklist"]
> * Create secrets for the review API keys for each of your environments.
> * Update the workflow with the correct input and secret values for each environment.
> * Update your Bicep file to propagate the settings that you need for the product review API.
> * Review the workflow results and the changes to your Azure environment.

## Add secrets

You decide to store the API keys in GitHub secrets, to ensure they're protected appropriately.

1. In your browser, go to **Settings** > **Secrets** > **Actions**.

   :::image type="content" source="../media/7-secrets.png" alt-text="Screenshot of GitHub that shows the Secrets menu item under the Settings category.":::

1. Select the **New repository secret** button.

1. Enter *REVIEW_API_KEY_TEST* as the secret name, and *sandboxsecretkey* as the value.

   :::image type="content" source="../media/7-secrets-new-test.png" alt-text="Screenshot of GitHub showing a new secret.":::

1. Select **Add secret**.

1. Repeat the process to add another secret named *REVIEW_API_KEY_PRODUCTION* as the secret name, and *productionsecretkey* as the value. Select **Add secret**.

## Update the deploy.yml file to use the new settings

1. In Visual Studio Code, open the *deploy.yml* file.

1. Update the workflow trigger to include new values for the `inputs` and `secrets` settings:

   :::code language="yaml" source="code/7-deploy.yml" range="3-23" highlight="10-12, 20-21" :::

   Notice that you include the API URLs as inputs. These aren't secret values.

1. In the `validate` job, update the steps to include the new deployment parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="25-59" highlight="21-22, 33-34" :::

1. Update the `deploy` job to include the new deployment parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="61-86" highlight="25-26" :::

1. Save your changes to the file.

## Update the workflow.yml file to provide the new settings

1. In Visual Studio Code, open the *workflow.yml* file.

1. Add the `reviewApiUrl` inputs, and the `reviewApiKey` secrets, for each environment:

   :::code language="yaml" source="code/7-workflow.yml" highlight="27, 32, 41, 46" :::

1. Save your changes to the file.

## Update the Bicep file

1. Open the *main.bicep* file.

1. Below the parameters that are already in the file, add the following parameters for the new review API:

   :::code language="bicep" source="code/7-main.bicep" range="15-20" :::

1. Update the `appServiceApp` resource definition to provide the review API URL and key to the application, so that your website's code can use them:

   :::code language="bicep" source="code/7-main.bicep" range="63-90" highlight="17-24" :::

1. Save your changes to the file.

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "Add new review API settings to Bicep file and workflow"
   git push
   ```

## Review the deployment results

1. In your browser, go to your workflow runs.

1. Select the most recent run.

1. Select the most recent run of your workflow.

   Wait for the workflow to pause before the **deploy-production / deploy** job. It might take a few minutes for the workflow to reach this point.

1. Approve the deployment to the production environment by selecting **Review deployments**, then selecting **Production** and selecting **Approve and deploy**.

   Wait for the workflow to finish running.

1. Select **Code** and then select the **Production** environment.

   Notice that you now see multiple deployments in the environment's history.

1. In your browser, go to the [Azure portal](https://portal.azure.com?azure-portal=true). 

1. Go to the **ToyWebsiteProduction** resource group.

1. In the list of resources, open the Azure App Service app.

   Select **Configuration**.

   :::image type="content" source="../media/7-app-service-configuration.png" alt-text="Screenshot of the Azure portal that shows the App Service app and the Configuration menu item.":::

1. Select **Show values**.

   :::image type="content" source="../media/7-app-service-show-values.png" alt-text="Screenshot of the Azure portal that shows the App Service app settings and the button for showing values.":::

1. Notice that the values for the **ReviewApiKey** and **ReviewApiUrl** settings are set to the values that you configured for the production environment.

   :::image type="content" source="../media/7-app-service-settings.png" alt-text="Screenshot of the Azure portal that shows the App Service app settings and the configuration settings.":::

1. Compare the current values to the configuration settings for the App Service app in the **ToyWebsiteTest** resource group. Notice that the values are different.

## Clean up the resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code terminal, run the following commands:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyWebsiteTest --yes --no-wait
az group delete --resource-group ToyWebsiteProduction --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyWebsiteTest -Force
Remove-AzResourceGroup -Name ToyWebsiteProduction -Force
```

::: zone-end
