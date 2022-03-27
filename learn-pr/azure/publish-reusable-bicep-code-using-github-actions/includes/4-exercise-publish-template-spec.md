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

The template repository, you used to create your own repo in the previous exercise, contains a draft of a workflow that you can use as a starting point.

On the GitHub site, navigate to the `.github/workflows/` directory, open the existing `publish-template-specs-workflow.yml` file and copy and paste the following content at the end of the file:

   :::code language="yaml" source="code/4-workflow.yml" range="20-25" :::

## Add a publish job to your workflow

We will now add a second job that will publish the template spec to Azure. To keep things simple, we will be using the versioning scheme with a single version number derived from the _workflow run number_.

Copy the following code snippet and paste it at the end of your workflow file:

   :::code language="yaml" source="code/4-workflow.yml" range="27-44" :::

This job will checkout the code from your repository, sign in to Azure using GitHub secret you created earlier, and run the `az ts create` command to publish the template spec to Azure.

## Verify and commit your workflow definition

1. Verify that your *publish-template-specs-workflow.yml* file looks like the following:

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

You can view the workflow run in the GitHub Actions UI.

1. Click the **Actions** tab.

    :::image type="content" source="../media/4-action-run.png" alt-text="A screenshot showing the result of an Azure Actions workflow run.":::

1. Click the last run in the list.

    :::image type="content" source="../media/4-action-run-details.png" alt-text="A screenshot of a specific workflow run in GitHub Actions.":::

## Review the template spec in Azure

You can also view the published template spec in the Azure Portal:

1. In the [Azure Portal](https://portal.azure.com), navigate to the `ToysReusable` Resource Group and click on the `appService` template spec.

    :::image type="content" source="../media/4-azure-portal.png" alt-text="A screenshot of the Azure Portal with a template spec.":::

1. Check the version number in the `version` field and validate, if it corresponds with the workflow run in GitHub Actions.
