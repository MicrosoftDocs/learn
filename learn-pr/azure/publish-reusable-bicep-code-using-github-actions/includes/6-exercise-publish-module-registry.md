Your team has been using Bicep modules as reusable components for some time. You started with sharing them in a single private GitHub repository. Later on, you were publishing those modules into a _private registry_ but the publishing was done manually. You want to enable your development teams and share your modules within the organization. This time, you want to create a workflow to handle the publishing.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a lint job to the workflow
> * Add a workflow job to publish a module to the registry
> * Verify that your workflow is working
> * Check the published module in Azure

## Create a container registry

First, you'll need to create a container registry in Azure.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com/#create/Microsoft.ContainerRegistry). The URL contains a deep link to create a new container registry.

1. In the **Basics** tab, select your target subscription and the `ToysReusable` resource group you created earlier. Enter a name for your registry and location you prefer. For **SKU**, select 'Basic'.

    > [!IMPORTANT]
    > The registry name must be unique within Azure, and contain 5-50 alphanumeric characters. You should see a checkmark next to the registry name. It means the name you chose is available.

1. We will accept the default values for other tabs. Select **Review + create** button. After reviewing the settings, select **Create**.

1. When the **Deployment succeeded** message appears, select the container registry in the portal.

1. In the **Overview** page, note the _Login server_ in the _registry_name_.azurecr.io format. You will need this value later.

## Add a module metadata file

In one of the previous units you learned about the importance of having a versioning strategy for your modules and the role of module metadata files. For our storage account module, we need to add a metadata file to store the major and minor version numbers.

1. In Visual Studio Code, expand the `modules` folder in the root of your repository. Then, expand the `storage-account` folder.

1. Create a new file here called `metadata.json`.

1. Add the following content to the file:

    :::code language="json" source="code/6-metadata.json" :::

1. Save your changes to the file.

## Add a lint step to your workflow

Your repository contains a draft of a workflow that you can use as a starting point.

1. In Visual Studio Code, expand the `.github` folder in the root of the repository. Then, expand the `workflows` folder, and the `modules` subfolder.

1. Open the file named `storage-account.yml`.

   <!-- TODO sshot -->

1. At the bottom of the file, where you see a comment saying _To be added_, add the following job definition:

   :::code language="yaml" source="code/6-workflow.yml" range="17-23" :::

## Add a publish step to your workflow

Now, you can add a second job to publish the module to Azure Container Registry.

1. Add the following code at the end of the `storage-account.yml` file:

   :::code language="yaml" source="code/6-workflow.yml" range="25-44" :::

   This job checks out the code from your repository, signs in to Azure by using GitHub secret you created earlier, and runs the `az bicep publish` command to publish the module to the registry.

1. Update the line `22` with the registry name you created earlier.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your _storage_account_module.yml_ file looks like the following:

   :::code language="yaml" source="code/6-workflow.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish steps to Storage Account module workflow"
   git push
   ```

   Immediately after you push, GitHub Actions starts a new workflow run.

## View the workflow run

You can view the workflow run in the GitHub Actions web interface.

1. In your browser, select the **Actions** tab.

    :::image type="content" source="../media/6-action-run.png" alt-text="A screenshot showing the result of an Azure Actions workflow run.":::

1. Select the latest run in the list.

    :::image type="content" source="../media/6-action-run-details.png" alt-text="A screenshot of a specific workflow run in GitHub Actions.":::

   Wait for the workflow run to finish. The Bicep module is published to Azure Container Registry.

## Review the module in the registry

You can also view the published module in the Azure portal.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Navigate to the `ToysReusable` resource group.

1. Select the container registry you created previously.

1. Select the **Repositories** blade from the menu, where you select the `modules\storage-account` repository. You should see one _tag_, which is the version number of the module.

    :::image type="content" source="../media/6-portal-module-registry.png" alt-text="A screenshot of the Azure Portal with a Bicep module in a container registry.":::
