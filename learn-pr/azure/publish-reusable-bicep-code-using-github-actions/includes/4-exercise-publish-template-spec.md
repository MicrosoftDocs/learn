You are determined to support internal DevOps teams at your toy company and publish several security-hardened template specs that are compliant with the new governance model. Those published artifacts provide a guarantee that resource deployments referencing them won't be blocked by Azure policies.

You selected a subscription and a resource group to deploy the template spec to. This will be your _deployment target_ in the publishing pipeline we are about to create.

Now that your environment is configured to work with GitHub Actions and your Azure subscription, you will extend an existing workflow that was part of the template repository and publish a template spec to Azure.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a lint job to the workflow
> * Add a publish job to the workflow
> * Verify that your workflow is working
> * Check the published template spec in Azure

## Add a lint job to your workflow

Your repository contains a draft of a workflow that you can use as a starting point.

<!-- TODO decide on starting point -->

1. Open Visual Studio Code.

1. Create a folder named `.github` in the root of the repository, and within that folder, create a folder named `workflows`.

1. Create a file named `template-spec.yml` within the `workflows` folder.

   <!-- TODO sshot -->

1. Add the following content into the `template-spec.yml` file:

   :::code language="yaml" source="code/4-workflow.yml" range="18-23" :::

## Add a publish job to your workflow

Now, you can add a second job to publish the template spec to Azure.

1. Add the following code at the end of the `template-spec.yml` file:

   :::code language="yaml" source="code/4-workflow.yml" range="25-44" :::

   This job checks out the code from your repository, signs in to Azure by using GitHub secret you created earlier, and runs the `az ts create` command to publish the template spec to Azure.

   > [!TIP]
   > To keep things simple, your workflow uses the workflow's *number* as the template spec's version number. In the next unit, you'll learn about a more complex versioning scheme.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your *template-specs-workflow.yml* file looks like the following:

   :::code language="yaml" source="code/4-workflow.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish steps to template spec workflow."
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You may need to sign in to GitHub again. Select **Authorize**.

   Immediately after you push, GitHub Actions starts a new workflow run.

## View the workflow run

You can view the workflow run in the GitHub Actions web interface.

1. In your browser, select the **Actions** tab.

    :::image type="content" source="../media/4-action-run.png" alt-text="A screenshot showing the result of an Azure Actions workflow run.":::

1. Select the latest run in the list.

    :::image type="content" source="../media/4-action-run-details.png" alt-text="A screenshot of a specific workflow run in GitHub Actions.":::

   Wait for the workflow run to finish. The template spec is published to Azure.

   Note the workflow's run number.

## Review the template spec in Azure

You can also view the published template spec in the Azure portal.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Navigate to the `ToysReusable` resource group.

1. Select the `appService` template spec.

    :::image type="content" source="../media/4-portal-template-spec.png" alt-text="A screenshot of the Azure Portal with a template spec.":::

   Notice that the version number corresponds with the GitHub Actions workflow's run number.
