In your toy company, you've been publishing your Bicep modules into a registry. You've been running the publishing process manually from your own computer. Now, you want to create a workflow to handle the publishing process.

In this exercise, you'll:

> [!div class="checklist"]
>
> - Create a container registry for your Bicep modules.
> - Add a lint job to the workflow.
> - Add a workflow job to publish the module to your registry.
> - Verify that your workflow runs successfully.
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

1. Review the settings displays **Validation passed** and then select **Create**.

   Wait for the deployment to finish, which usually takes 1-2 minutes.

1. When the **Deployment succeeded** message appears, select **Go to resource** to open the container registry.

   :::image type="content" source="../media/6-registry-created.png" alt-text="Screenshot of the Azure portal that shows the container registry deployment, with the button for going to a resource highlighted.":::

1. In the container registry's **Overview** area, note the value of the **Login server** setting. The name is like _yourregistryname.azurecr.io_.

   :::image type="content" source="../media/6-registry-login-server.png" alt-text="Screenshot of the Azure portal that shows the container registry's details, with the login server highlighted.":::

   You'll need this value shortly.

## Add a module metadata file

In the preceding unit, you learned about the importance of having a versioning strategy for your modules. You also learned how to use module metadata files to specify the major and minor version number of your module within a workflow. Here, you add a metadata file for your storage account module.

1. In Visual Studio Code, expand the _modules_ folder in the root of your repository. Then, expand the _storage-account_ folder.

1. Create a new file named _metadata.json_.

   :::image type="content" source="../media/6-visual-studio-code-metadata-json.png" alt-text="Screenshot of Visual Studio Code that shows the location of the metadata dot J S O N file.":::

1. Add the following content to the file:

   :::code language="json" source="code/6-metadata.json" :::

   Notice that in the metadata file, you separately define the major and minor version numbers. Your workflow combines these numbers with the workflow's run number, into a complete version number, each time the workflow runs.

1. Save your changes to the file.

## Update your workflow definition and add a lint job

Your repository contains a draft of a workflow that you can use as a starting point.

1. In Visual Studio Code, expand the _.github_ folder in the root of the repository. Then, expand the _workflows_ folder.

1. Open the _module-storage-account.yml_ file.

   :::image type="content" source="../media/6-visual-studio-code-workflow.png" alt-text="Screenshot of Visual Studio Code that shows the location of the workflow definition file.":::

1. Update the value of the `MODULE_REGISTRY_SERVER` environment variable to your container registry's server name. You copied that name earlier in this exercise.

   For example, if your registry's login server is _yourregistryname.azurecr.io_, your code is like this example:

   :::code language="yaml" source="code/6-workflow.yml" range="16-20" highlight="3" :::

1. At the bottom of the file, for the **To be added** comment, add the following lint job definition:

   :::code language="yaml" source="code/6-workflow.yml" range="22-28" :::

## Add a publish job to your workflow

Now, you can add a second job to publish the module to your container registry.

1. At the bottom of the _module-storage-account.yml_ file, add the first part of the publish job's definition.

   :::code language="yaml" source="code/6-workflow.yml" range="30-40" :::

   The steps check out the code from your repository and sign in to Azure.

1. Below the code that you just added, add a step to read the version number from your module's _metadata.json_ file and set it as an environment variable.

   :::code language="yaml" source="code/6-workflow.yml" range="41-45" :::

   The step runs a script that uses the jq command-line application to parse the JSON file.

1. After the step that you created, add a step to publish the module to the registry.

   :::code language="yaml" source="code/6-workflow.yml" range="46-52" :::

   Notice that this step constructs the value of the `--target` argument dynamically. It combines the value of the registry server, the module name, and the version number.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your _module-storage-account.yml_ file looks like the following example:

   :::code language="yaml" source="code/6-workflow.yml" highlight="18, 23-52" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish jobs to storage account module workflow"
   git push
   ```

## Trigger the workflow

1. In your browser, go to your GitHub repository and select the **Actions** tab.

1. Select the **module-storage-account** workflow.

   Notice that a workflow run is already in progress. The push trigger fired because you modified the _metadata.json_ file within the module's folder.

1. Select the latest run in the list.

   :::image type="content" source="../media/6-workflow-runs-list.png" alt-text="Screenshot of GitHub that highlights the latest run of the module's workflow.":::

   Wait for the workflow run to finish. The Bicep module is published to your container registry.

   Note the workflow's run number, which is probably **3**.

## Review the module in the registry

You can also view the published module in the Azure portal.

1. In your browser, go to the [Azure portal](https://portal.azure.com).

1. Go to the **ToyReusable** resource group.

1. Select the container registry that you created previously.

1. Select the **Repositories** pane from the menu. Then, select the **modules\storage-account** repository, which represents the module that your workflow published.

   :::image type="content" source="../media/6-registry-portal.png" alt-text="Screenshot of the Azure portal that shows a Bicep module in the container registry.":::

   Notice that there's a single _tag_, which matches the version number of the module that your workflow published. The major version (1) and minor version (2) match the version numbers that you defined in the _metadata.json_ file. The revision number (3) matches the workflow's run number.

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

You can also remove the GitHub secrets and repository, and the Azure workload identities.

- GitHub secrets
  1. From the GitHub repository, go to **Settings** > **Secrets and variables** > **Actions**.
  1. Select **Remove secret** for each repository secret and follow the prompts.

- GitHub repository
  1. Go to **Settings** > **General**
  1. Select **Delete this repository** and follow the prompts.

- Azure App registration's federated credentials and service principal.
  1. From the portal home page, search for _Azure Active Directory_ and select it from the list of **Services**.
  1. Go to **Manage** > **App registrations**.
  1. In **Owned applications** select **toy-reusable**.
  1. Select **Delete** and follow the prompts.
  1. Select **Deleted applications** to permanently delete the app registration.

  > [!IMPORTANT]
  > It's possible to have duplicate App registration and service principal names. It's recommended to verify the application ID to make sure you're deleting the correct resource.
