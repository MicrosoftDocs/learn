Now that your pipeline deploys to both of your environments, you're ready to integrate with the third-party API for product reviews.

Your website team has provided you with the API keys and URLs that your website should use to access the service. There are different values for your test and production environments to use. In this unit, you'll update your pipeline to configure each of your environments with the correct settings for the product review API.

During the process, you'll:

> [!div class="checklist"]
>
> - Create variable groups for each of your environments.
> - Update the pipeline so it picks the correct variable group for each environment instead of using template parameters.
> - Update your Bicep file to propagate the settings that you need for the product review API.
> - Update the variable group and pipeline to set the values for the product review API's settings.
> - Review the pipeline results and the changes to your Azure environment.

## Add variable groups

Because you're adding more parameters that vary between each environment, you decide to move away from adding your pipeline parameters directly into your pipeline YAML files. Instead, you'll use a variable group to keep the values for each environment together.

1. In your browser, go to **Pipelines** > **Library**.

   :::image type="content" source="../media/7-library.png" alt-text="Screenshot of Azure DevOps that shows the Library menu item under the Pipelines category.":::

1. Select the **+ Variable group** button.

   :::image type="content" source="../media/7-variable-groups-new.png" alt-text="Screenshot of the Azure DevOps library page and the button for adding a variable group.":::

1. Enter **ToyWebsiteTest** as the variable group name.

1. Select the **+ Add** button to add variables to the variable group. Create two variables with the following settings:

   | Name | Value |
   |-|-|
   | EnvironmentType | Test |
   | ResourceGroupName | ToyWebsiteTest |

   Notice that you don't define the service connection name in the variable group. Service connection names have special rules about how they can be specified. In this module, you'll use pipeline template parameters.

   :::image type="content" source="../media/7-variable-group-test-v1.png" alt-text="Screenshot of the test variable group and variables.":::

1. Select **Save**.

1. Select the **Back** button in your browser to return to the list of variable groups.

1. Add another variable group named **ToyWebsiteProduction**. Create two variables with the following settings:

   | Name | Value |
   |-|-|
   | EnvironmentType | Production |
   | ResourceGroupName | ToyWebsiteProduction |

   :::image type="content" source="../media/7-variable-group-production-v1.png" alt-text="Screenshot of the production variable group and variables.":::

   Notice that the variable names are the same for both environments, but the values are different.

1. Save the production variable group.

## Update the deployment pipeline template to use the variable group

1. In Visual Studio Code, open the _deploy.yml_ file.

1. At the top of the file, remove the `resourceGroupName` and `serviceConnectionName` parameters. Don't delete the `environmentType` or `deploymentDefaultLocation` parameters.

   :::code language="yaml" source="code/7-deploy-1.yml" range="1-6" :::

1. Update the `ValidateBicepCode` job to import the variable group:

   :::code language="yaml" source="code/7-deploy-1.yml" range="10-18" highlight="7-8" :::

1. Update the `ValidateBicepCode` job to automatically infer the service connection name based on the `environmentType` parameter value:

   :::code language="yaml" source="code/7-deploy-1.yml" range="10-29" highlight="14" :::

1. Update the `ValidateBicepCode` job to use the imported variable group to set the resource group name and environment type arguments for the deployment task:

   :::code language="yaml" source="code/7-deploy-1.yml" range="10-29" highlight="17, 20" :::

1. Make the changes to the `PreviewAzureChanges` job:

   :::code language="yaml" source="code/7-deploy-1.yml" range="31-51" highlight="7-8, 14, 19, 21" :::

1. Make the same changes to the `Deploy` deployment job:

   :::code language="yaml" source="code/7-deploy-1.yml" range="53-78" highlight="6-7, 19, 22, 25" :::

1. Verify that your _deploy.yml_ file now looks like the following code:

   :::code language="yaml" source="code/7-deploy-1.yml" highlight="1-6, 16-17, 23, 26, 29, 37-38, 44, 49, 51, 58-59, 71, 74, 77" :::

1. Save your changes to the file.

## Update the pipeline definition to simplify the parameter list

1. Open the _azure-pipelines.yml_ file.

1. Update the stages that use templates to remove the `resourceGroupName` and `serviceConnectionName` parameters. Leave only the `environmentType` parameter.

   :::code language="yaml" source="code/7-pipeline.yml" highlight="19-20, 24-25" :::

1. Save your changes to the file.

1. Commit your changes to your Git repository without pushing them by using the following commands:

   ```bash
   git add .
   git commit -m "Use variable groups"
   ```

## Update the Bicep file

1. Open the _main.bicep_ file.

1. Below the parameters that are already in the file, add the following parameters for the new review API:

   :::code language="bicep" source="code/7-main.bicep" range="15-20" :::

1. Update the `appServiceApp` resource definition to provide the review API URL and key to the application, so that your website's code can use them:

   :::code language="bicep" source="code/7-main.bicep" range="63-90" highlight="17-24" :::

1. Save your changes to the file.

## Update the variable groups

1. In your browser, go to **Pipelines** > **Library**, and open the **ToyWebsiteTest** variable groups.

1. Add the following variables:

   | Name | Value |
   |-|-|
   | ReviewApiKey | sandboxsecretkey |
   | ReviewApiUrl | `https://sandbox.contoso.com/reviews` |

1. Select the padlock icon next to the **ReviewApiKey** variable. This step tells Azure Pipelines to treat the variable's value securely.

   :::image type="content" source="../media/7-variable-group-test-v2.png" alt-text="Screenshot of the test variable group and the secret variable button.":::

1. Save the variable group.

   :::image type="content" source="../media/7-variable-group-test-v3.png" alt-text="Screenshot of the test variable group with updated variables.":::

1. Update the **ToyWebsiteProduction** variable group to add a similar set of variables:

   | Name | Value |
   |-|-|
   | ReviewApiKey | productionsecretkey |
   | ReviewApiUrl | `https://api.contoso.com/reviews` |

   Remember to select the padlock icon next to the **ReviewApiKey** variable.

   :::image type="content" source="../media/7-variable-group-production-v2.png" alt-text="Screenshot of the production variable group with updated variables.":::

1. Save the variable group.

## Add the review API variables to the variable groups

1. In Visual Studio Code, open the _deploy.yml_ file.

1. In the `ValidateBicepCode` job, add the review API parameter values to the deployment task:

   :::code language="yaml" source="code/7-deploy-2.yml" range="10-31" highlight="21-22" :::

1. Make the same change to the `PreviewAzureChanges` job:

   :::code language="yaml" source="code/7-deploy-2.yml" range="33-55" highlight="21-23" :::

   > [!IMPORTANT]
   > Be sure to add the backslash (`\`) at the end of the line that sets the `environmentType` parameter value, and on the subsequent line. The `\` character indicates that further lines are part of the same Azure CLI command.

1. Make the same change to the `Deploy` job:

   :::code language="yaml" source="code/7-deploy-2.yml" range="57-84" highlight="26-27" :::

1. Verify that your _deploy.yml_ file now looks like the following code:

   :::code language="yaml" source="code/7-deploy-2.yml" highlight="30-31, 53-55, 82-83" :::

1. Commit and push your changes to your Git repository by using the following commands:

   ```bash
   git add .
   git commit -m "Add new review API settings to Bicep file and pipeline"
   git push
   ```

## Review the deployment results

1. In your browser, go to **Pipelines**.

1. Select the most recent run of your pipeline.

   Wait for the pipeline to pause before the **Deploy (Production Environment)** stage. It might take a few minutes for the pipeline to reach this point.

1. If you're asked to grant permission to access a resource, select **View** and then select **Permit**.

1. Approve the deployment to the production environment by selecting **Review** > **Approve**.

   Wait for the pipeline to finish running.

1. Select **Pipelines** > **Environments**.

1. Select the **Production** environment.

   Notice that you now see multiple deployments in the environment's history.

1. In your browser, go to the [Azure portal](https://portal.azure.com).

1. Go to the **ToyWebsiteProduction** resource group.

1. In the list of resources, open the Azure App Service app.

   Select **Configuration**.

   :::image type="content" source="../media/7-app-service-configuration.png" alt-text="Screenshot of the Azure portal that shows the App Service app and the Configuration menu item.":::

1. Select **Show values**.

   :::image type="content" source="../media/7-app-service-show-values.png" alt-text="Screenshot of the Azure portal that shows the App Service app settings and the button for showing values.":::

1. Notice that the production site's values for the **ReviewApiKey** and **ReviewApiUrl** settings are set to the values that you configured in the production variable group.

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
