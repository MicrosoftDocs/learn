Your team has built some security-hardened Bicep files that are compliant with your company's new governance model. One of the hardened Bicep files deploys a Linux-based App Service app. In this exercise, you'll use a deployment workflow to publish the Bicep file as a template spec.

During the process, you'll:

> [!div class="checklist"]
> * Add a lint job to the workflow.
> * Add a workflow job to publish the template spec.
> * Verify that your workflow runs successfully.
> * Check the published template spec in Azure.

## Add a lint job to your workflow

Your repository contains a draft of a workflow that you can use as a starting point.

1. In Visual Studio Code, expand the `.github` folder in the root of the repository. Then, expand the `workflows` folder, and the `template-specs` subfolder.

1. Open the file named `linux-app-service.yml`.

   <!-- TODO sshot -->

1. At the bottom of the file, where you see a comment saying *To be added*, add the following *lint* job definition:

   :::code language="yaml" source="code/4-workflow.yml" range="17-23" :::

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

## Add a publish job to your workflow

Now, you can add a second job to publish the template spec to Azure.

1. Add the following code at the end of the `linux-app-service.yml` file:

   :::code language="yaml" source="code/4-workflow.yml" range="25-44" :::

   This job checks out the code from your repository, signs in to Azure by using GitHub secret you created earlier, and runs the `az ts create` command to publish the template spec to Azure.

   > [!TIP]
   > To keep things simple, your workflow uses the workflow's *run number* as the template spec's version number. In the next unit, you'll learn about a more complex versioning scheme.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your *linux-app-service.yml* file looks like the following:

   :::code language="yaml" source="code/4-workflow.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish steps to Linux App Service template spec workflow"
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You might need to sign in to GitHub again. Select **Authorize**.

## Trigger the workflow

1. In your browser, select the **Actions** tab.

    :::image type="content" source="../media/4-action-run.png" alt-text="A screenshot showing the result of an Azure Actions workflow run.":::

1. Select the **module-storage-account** workflow, then select the **Run workflow** button, and select **Run workflow**.

   <!-- TODO -->

   GitHub starts a new workflow run. You might need to refresh your browser window to see the run appear.

1. Select the latest run in the list.

   :::image type="content" source="../media/4-action-run-details.png" alt-text="A screenshot of a specific workflow run in GitHub Actions.":::

   Wait for the workflow run to finish. The template spec is published to Azure.

   Note the workflow's run number.

## Review the template spec in Azure

You can also view the published template spec in the Azure portal.

1. In your browser, navigate to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Navigate to the `ToysReusable` resource group.

1. Select the `linux-app-service` template spec.

    :::image type="content" source="../media/4-portal-template-spec.png" alt-text="A screenshot of the Azure Portal with a template spec.":::

   Notice that the version number corresponds with the GitHub Actions workflow's run number.
