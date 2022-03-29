Your team has been using Bicep modules as reusable components for some time. You started with sharing them in a single private GitHub repository. Later on, you were publishing those modules into a _private registry_ but the publishing was done manually. You want to enable your development teams and share your modules within the organization. This time, you want to create a workflow to handle the publishing. <!-- TODO edit -->

In this exercise, you'll:

> [!div class="checklist"]
> * Create a container registry for your Bicep modules.
> * Add a lint job to the workflow.
> * Add a workflow job to publish the module to your registry.
> * Verify that your workflow runs successfully.
> * Check the published module in your registry.

## Create a container registry

Before you can publish modules, you need to create a registry for your organization to use. Here, you use the Azure portal to create a registry.

1. In your browser, [create a new container registry within the Azure portal](https://portal.azure.com/#create/Microsoft.ContainerRegistry).

1. In the **Basics** tab, select your target subscription and the **ToyReusable** resource group you created earlier.

1. Enter a name for your registry, and a location that's close to you.

    > [!IMPORTANT]
    > The registry name must be unique within Azure, and contain 5-50 alphanumeric characters. You should see a checkmark next to the registry name indicating that the name you chose is available.

1. For **SKU**, select 'Basic'.

   Leave the default values for the other configuration settings.

   <!-- TODO sshot -->

1. Select **Review + create**. Review the settings, then select **Create**.

   Wait for the deployment to complete, which usually takes 1-2 minutes.

1. When the **Deployment succeeded** message appears, select the container registry.

   <!-- TODO sshot -->

1. In the **Overview** page, note the value of the *Login server* setting. It will look like *yourregistryname.azurecr.io*. You'll need this value shortly.

## Add a module metadata file

In the precending unit, you learned about the importance of having a versioning strategy for your modules. You also learned how to use module metadata files to specify the major and minor version number of your module. Here, you add a metadata file for your storage account's module.

1. In Visual Studio Code, expand the `modules` folder in the root of your repository. Then, expand the `storage-account` folder.

1. Create a new file here called `metadata.json`.

   <!-- TODO sshot -->

1. Add the following content to the file:

   :::code language="json" source="code/6-metadata.json" :::

   Notice that you separately define the major and minor version numbers. Your workflow will combine these, along with the workflow's run number, into a complete version number for the module.

1. Save your changes to the file.

## Update your workflow definition and add a lint job

Your repository contains a draft of a workflow that you can use as a starting point.

1. In Visual Studio Code, expand the `.github` folder in the root of the repository. Then, expand the `workflows` folder, and the `modules` subfolder.

1. Open the file named `storage-account.yml`.

   <!-- TODO sshot -->

1. On line 14, update the value of the `MODULE_REGISTRY_SERVER` environment variable to your container registry's server name, which you copied earlier in this exercise. 

   For example, if your registry's login server is *yourregistryname.azurecr.io*, line 14 would look like the below:

   :::code language="yaml" source="code/6-workflow.yml" range="12-16" highlight="3" :::

1. At the bottom of the file, where you see a comment saying _To be added_, add the following *lint* job definition:

   :::code language="yaml" source="code/6-workflow.yml" range="17-23" :::

## Add a publish job to your workflow

Now, you can add a second job to publish the module to your container registry.

1. At the bottom of the *storage-account.yml* file, add the first part of the job definition for the *publish* job:

   :::code language="yaml" source="code/6-workflow.yml" range="26-34" :::

   The steps check out the code from your repository and sign in to Azure.

1. Below the code you just added, add a step to read the version number from your module's *metadata.json* file and set it as an environment variable:

   :::code language="yaml" source="code/6-workflow.yml" range="35-39" :::

   The step uses the jq command-line application, which parses JSON files.

1. Below the step you just created, add a step to publish the module to the registry:

   :::code language="yaml" source="code/6-workflow.yml" range="40-47" :::

   Notice that this step constructs the value of the `--target` argument dynamically. It combines the value of the registry server, the module name, and the version number.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your *storage_account_module.yml* file looks like the following:

   :::code language="yaml" source="code/6-workflow.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish steps to storage account module workflow"
   git push
   ```

## Trigger the workflow

1. In your browser, select the **Actions** tab.

    :::image type="content" source="../media/6-action-run.png" alt-text="A screenshot showing the result of an Azure Actions workflow run.":::

1. Select the **template-spec-linux-app-service** workflow, then select the **Run workflow** button, and select **Run workflow**.

   <!-- TODO sshot -->

   GitHub starts a new workflow run. You might need to refresh your browser window to see the run appear.

1. Select the latest run in the list.

    :::image type="content" source="../media/6-action-run-details.png" alt-text="A screenshot of a specific workflow run in GitHub Actions.":::

   Wait for the workflow run to finish. The Bicep module is published to your container registry.

   Note the workflow's run number.

## Review the module in the registry

You can also view the published module in the Azure portal.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Navigate to the **ToyReusable** resource group.

1. Select the container registry you created previously.

1. Select the **Repositories** blade from the menu. Then, select the **modules\storage-account** repository, which represents the module that your workflow published.

   There's one *tag*, which is the version number of the module:

   :::image type="content" source="../media/6-portal-module-registry.png" alt-text="A screenshot of the Azure Portal with a Bicep module in a container registry."::: <!-- TODO sshot -->

## Clean up the resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code terminal, run the following command:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyReusable --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyReusable -Force
```

::: zone-end
