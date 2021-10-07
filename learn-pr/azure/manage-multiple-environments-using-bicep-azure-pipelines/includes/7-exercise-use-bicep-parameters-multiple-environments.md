Now that your pipeline deploys to both of your environments, you're ready to integrate with the third-party product reviews API. Your website team has provided you with the API keys and URLs that your website should use to access the service, and there are different values for your test and production environments to use. In this unit, you'll update your pipeline to configure each of your environments with the correct product reviews API settings.

During the process you'll:

> [!div class="checklist"]
> * Create variable groups for each of your environments.
> * Update the pipeline so it picks the correct variable group for each environment instead of using template parameters.
> * Update your Bicep file to propagate the settings you need for the product review API.
> * Update the variable group and pipeline to set the values for the product review API settings.
> * Review the pipeline results and the changes to your Azure environment.

## Add variable groups

Now that you're adding more parameters that vary between each environment, it's a good idea to use a variable group to keep the values for each environment together.

1. In your browser, go to **Pipelines** > **Library**.

   :::image type="content" source="../media/7-library.png" alt-text="Screenshot of Azure DevOps showing the Library menu item under the Pipelines category.":::

1. Select the **+ Variable group** button.

   :::image type="content" source="../media/7-variable-groups-new.png" alt-text="Screenshot of the Azure DevOps library page, with the + variable group button highlighted.":::

1. Enter **ToyWebsiteTest** as the variable group name.

1. Select the **+ Add** button to add variables to the variable group. Create two variables with the following settings:

   | Name | Value |
   |-|-|
   | EnvironmentType | Test |
   | ResourceGroupName | ToyWebsiteTest |

   Notice you don't define the service connection name in the variable group. Service connection names have special rules about how they can be specified. In this module, you'll use pipeline template parameters.

   :::image type="content" source="../media/7-variable-group-test-v1.png" alt-text="Screenshot of the test variable group, with the variable group name and variables highlighted.":::

1. Select **Save**.

1. Click the **Back** button in your browser to return to the variable group list.

1. Add another variable group named **ToyWebsiteProduction**. Create two variables with the following settings:

   | Name | Value |
   |-|-|
   | EnvironmentType | Production |
   | ResourceGroupName | ToyWebsiteProduction |

   :::image type="content" source="../media/7-variable-group-production-v1.png" alt-text="Screenshot of the production variable group, with the variable group name and variables highlighted.":::

   Notice that the variable names are the same for both environments, but the values are different.

1. Save the production variable group.

## Update the deployment pipeline template to use the variable group

1. In Visual Studio Code, open the *deploy.yml* file.

1. At the top of the file, remove the `resourceGroupName` and `serviceConnectionName` parameters, and leave the `environmentType` parameter:

   :::code language="yaml" source="code/7-deploy-1.yml" range="1-3" :::

1. Update the `ValidateBicepCode` job to import the variable group:

   :::code language="yaml" source="code/7-deploy-1.yml" range="7-15" highlight="7-8" :::

1. Update the `ValidateBicepCode` job to automatically infer the service connection name based on the `environmentType` parameter value:

   :::code language="yaml" source="code/7-deploy-1.yml" range="7-21" highlight="14" :::

1. Update the `ValidateBicepCode` job to use the imported variable group to set the resource group name and environment type parameters for the Azure CLI task:

   :::code language="yaml" source="code/7-deploy-1.yml" range="7-27" highlight="19, 21" :::

1. Make the changes to the `PreviewAzureChanges` job:

   :::code language="yaml" source="code/7-deploy-1.yml" range="29-49" highlight="7-8, 19, 21" :::

1. Make the same changes to the `Deploy` deployment job:

   :::code language="yaml" source="code/7-deploy-1.yml" range="51-78" highlight="6-7, 24, 26" :::

1. Verify your *deploy.yml* file now looks like the following:

   :::code language="yaml" source="code/7-deploy-1.yml" :::

1. Save your changes to the file.

## Update the pipeline definition to simplify the parameter list

1. Open the *azure-pipelines.yml* file.

1. Update the stages that use templates to remove the `resourceGroupName` and `serviceConnectionName` parameters, leaving only the `environmentType` parameter:

   :::code language="yaml" source="code/7-pipeline.yml" highlight="18-19, 23-24" :::

1. Save your changes to the file.

1. Commit your changes to your Git repository without pushing them by using the following commands: 

   ```bash
   git add .
   git commit -m "Use variable groups"
   ```

## Update the Bicep file

1. Open the *main.bicep* file.

1. Below the parameters that are already in the file, add the following parameters for the new review API:

   :::code language="bicep" source="code/7-main.bicep" range="15-20" :::

1. Update the `appServiceApp` resource definition to provide the review API URL and key to the application, so that your website's code can use them:

   :::code language="bicep" source="code/7-main.bicep" range="53-80" highlight="17-24" :::

1. Save your changes to the file.

## Update the variable groups

1. In your browser, navigate to **Pipelines** > **Library**, and open the **ToyWebsiteTest** variable groups.

1. Add the following variables.

   | Name | Value |
   |-|-|
   | ReviewApiKey | sandboxsecretkey |
   | ReviewApiUrl | https://sandbox.contoso.com/reviews |

1. Select the padlock icon next to the **ReviewApiKey** variable. This tells Azure Pipelines to treat the variable's value securely.

   :::image type="content" source="../media/7-variable-group-test-v2.png" alt-text="Screenshot of the test variable group, with the secret variable button highlighted.":::

1. Save the variable group.

   :::image type="content" source="../media/7-variable-group-test-v3.png" alt-text="Screenshot of the test variable group, with the variable group name and updated variables highlighted.":::

1. Update the **ToyWebsiteProduction** variable group to add a similar set of variables:

   | Name | Value |
   |-|-|
   | ReviewApiKey | productionsecretkey |
   | ReviewApiUrl | https://api.contoso.com/reviews |

   Remember to select the padlock icon next to the **ReviewApiKey** variable.

   :::image type="content" source="../media/7-variable-group-production-v2.png" alt-text="Screenshot of the production variable group, with the variable group name and updated variables highlighted.":::

1. Save the variable group.

## Add the review API variables to the variable groups

1. In Visual Studio Code, open the *deploy.yml* file.

1. In the `ValidateBicepCode` job, add the review API parameter values to the Azure CLI task:

   :::code language="yaml" source="code/7-deploy-2.yml" range="7-29" highlight="21-23" :::

   > [!IMPORTANT]
   > Ensure you add the `\` at the end of the line that sets the `environmentType` parameter value, and on the subsequent line. The `\` character indicates that there are further lines that are part of the same command.

1. Make the same change to the `PreviewAzureChanges` job:

   :::code language="yaml" source="code/7-deploy-2.yml" range="31-53" highlight="21-23" :::

1. Make the same change to the `Deploy` job:

   :::code language="yaml" source="code/7-deploy-2.yml" range="55-84" highlight="26-28" :::

1. Verify your *deploy.yml* file now looks like the following:

   :::code language="yaml" source="code/7-deploy-2.yml" :::

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "Add new review API settings to Bicep file and pipeline"
   git push
   ```

## Review the deployment results

1. In your browser, navigate to **Pipelines**.

1. Select the most recent run of your pipeline.

1. Wait for the pipeline to pause before the *Deploy (Production Environment)* stage. It might take a few minutes for the pipeline to reach this point.

1. Approve the deploy to the production environment by selecting the **Review** button.

1. Select the **Approve** button.

   Wait for the pipeline to finish execution.

1. Select **Pipelines** > **Environments**.

1. Select the **Production** environment.

   Notice that you now see multiple deployments in the environment's history.

1. In your browser navigate to the [Azure portal](https://portal.azure.com?azure-portal=true). 

1. Navigate to the **ToyWebsiteProduction** resource group.

1. In the list of resources, open the App Service app.

   Select **Configuration**.

   :::image type="content" source="../media/7-app-service-configuration.png" alt-text="Screenshot of the Azure portal showing the App Service app, with the Configuration menu item highlighted.":::

1. Select **Show values**.

   :::image type="content" source="../media/7-app-service-show-values.png" alt-text="Screenshot of the Azure portal showing the App Service app settings, with the Show values button highlighted.":::

1. Notice that the production site's values for the **ReviewApiKey** and **ReviewApiUrl** settings are set to the values you configured in the production variable group.

   :::image type="content" source="../media/7-app-service-settings.png" alt-text="Screenshot of the Azure portal showing the App Service app settings, with the configuration setting values highlighted.":::

1. Compare this to the configuration settings for the App Service app in the **ToyWebsiteTest** resource group. Notice that it uses a different set of values.

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
