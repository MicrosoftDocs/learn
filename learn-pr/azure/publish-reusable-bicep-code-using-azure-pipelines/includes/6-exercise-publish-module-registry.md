In your toy company, you've been publishing your Bicep modules into a registry. You've been running the publishing process manually from your own computer. Now, you want to create a pipeline to handle the publishing process.

In this exercise, you'll:

> [!div class="checklist"]
>
> - Create a container registry for your Bicep modules.
> - Add a lint stage to the pipeline.
> - Add a pipeline stage to publish the module to your registry.
> - Verify that your pipeline runs successfully.
> - Check the published module in your registry.

## Create a container registry

Before you can publish modules, you need to create a registry for your organization to use. Here, you use the Azure portal to create a registry.

1. In your browser, [create a new container registry within the Azure portal](https://portal.azure.com/#create/Microsoft.ContainerRegistry).

1. On the **Basics** tab, select your target subscription and the **ToyReusable** resource group that you created earlier.

1. Enter a name for your registry and a location that's close to you.

    > [!IMPORTANT]
    > The registry name must be unique within Azure and contain 5-50 alphanumeric characters. A check mark next to the registry name indicates that the name you chose is available.

1. For **SKU**, select **Basic**.

   Leave the default values for the other configuration settings.

1. Select **Review + create**.

   :::image type="content" source="../media/6-create-registry.png" alt-text="Screenshot of the Azure portal that shows the container registry creation page.":::

1. Review the settings show **Validation passed** and then select **Create**.

   Wait for the deployment to finish, which usually takes 1-2 minutes.

1. When the **Deployment succeeded** message appears, select **Go to resource** to open the container registry.

   :::image type="content" source="../media/6-registry-created.png" alt-text="Screenshot of the Azure portal that shows the container registry deployment, with the button for going to a resource highlighted.":::

1. In the container registry's **Overview** area, note the value of the **Login server** setting. It will look like _yourregistryname.azurecr.io_.

   :::image type="content" source="../media/6-registry-login-server.png" alt-text="Screenshot of the Azure portal that shows the container registry's details, with the login server highlighted.":::

   You'll need this value shortly.

## Add a module metadata file

In the preceding unit, you learned about the importance of having a versioning strategy for your modules. You also learned how to use module metadata files to specify the major and minor version number of your module within a pipeline. Here, you add a metadata file for your storage account module.

1. In Visual Studio Code, expand the _modules/storage-account_ folder in the root of your repository.

1. Create a new file named _metadata.json_.

   :::image type="content" source="../media/6-visual-studio-code-metadata-json.png" alt-text="Screenshot of Visual Studio Code that shows the location of the metadata dot JSON file.":::

1. Add the following content to the file:

   :::code language="json" source="code/6-metadata.json" :::

   Notice that in the metadata file, you separately define the major and minor version numbers. Your pipeline combines these numbers, along with the pipeline's build number, into a complete version number each time the pipeline runs.

1. Save your changes to the file.

## Update your pipeline definition and add a lint stage

Your repository contains a draft of a pipeline that you can use as a starting point.

1. Open the _pipeline.yml_ file in the _modules/storage-account_ folder.

1. Update the value of the `ModuleRegistryServer` environment variable to your container registry's server name. You copied that name earlier in this exercise.

   For example, if your registry's login server is _yourregistryname.azurecr.io_, it will look like this:

   :::code language="yaml" source="code/6-pipeline.yml" range="15-16" highlight="2" :::

1. At the bottom of the file, for the `# To be added` comment with the following lint stage definition:

   :::code language="yaml" source="code/6-pipeline.yml" range="25-35" highlight="3-11" :::

## Add a publish stage to your pipeline

Now, you can add a second stage to publish the module to your container registry.

1. At the bottom of the _pipeline.yml_ file, define the _Publish_ stage, and add a step to read the version number from your module's _metadata.json_ file and set it as a pipeline variable.

   :::code language="yaml" source="code/6-pipeline.yml" range="37-46" :::

   The step runs a script that uses the jq command-line application to parse the JSON file.

1. Below the step that you created, add a step to publish the module to the registry.

   :::code language="yaml" source="code/6-pipeline.yml" range="47-57" :::

   Notice that this step constructs the value of the `--target` argument dynamically. It combines the value of the registry server, the module name, and the version number.

1. Save your changes to the file.

## Verify and commit your pipeline definition

1. Verify that your _storage_account_module.yml_ file looks like the following example:

   :::code language="yaml" source="code/6-pipeline.yml" highlight="16, 27-57" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish stages to storage account module pipeline"
   git push
   ```

   Immediately after you push, Azure Pipelines starts a new pipeline run.

## Monitor the pipeline

1. In your browser, select **Pipelines** > **Pipelines**.

1. Select the active pipeline run.

1. The pipeline run is displayed.

   Wait for the pipeline run to finish. The Bicep module is published to your container registry.

1. Note the pipeline's build number, which includes today's date and a unique revision number.

## Review the module in the registry

You can also view the published module in the Azure portal.

1. In your browser, go to the [Azure portal](https://portal.azure.com).

1. Go to the **ToyReusable** resource group.

1. Select the container registry that you created previously.

1. Select the **Repositories** pane from the menu. Then, select the **modules\storage-account** repository, which represents the module that your pipeline published.

   :::image type="content" source="../media/6-registry-portal.png" alt-text="Screenshot of the Azure portal that shows a Bicep module in the container registry.":::

   Notice that there's a single _tag_, which matches the version number of the module that your pipeline published. The major version (1) and minor version (2) match the version numbers that you defined in the _metadata.json_ file. The revision number (20230407.3) matches the pipeline's build number.

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

You can also remove the service connection and Azure DevOps project.

- Service connection

  1. From the Azure DevOps project, select **Project settings** > **Service connections**.
  1. Select **ToyReusable**.
  1. In the upper-right corner, select the three dots for **More actions**.
  1. Select **Delete** and confirm the deletion.

- Azure App registration

  1. From the portal home page, search for _Azure Active Directory_ and select it from the list of **Services**.
  1. Go to **Manage** > **App registrations**.
  1. In **Deleted applications** select **toy-reusable**.
  1. Select **Delete permanently** and follow the prompts.

- Azure DevOps project

  1. From the Azure DevOps project, select **Project settings** > **Overview**.
  1. From **Delete project** select **Delete**.
  1. Enter the project name and confirm the deletion.
