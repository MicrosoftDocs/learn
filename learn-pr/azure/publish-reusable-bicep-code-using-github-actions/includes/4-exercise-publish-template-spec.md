Your team has built some security-hardened Bicep files that are compliant with your company's new governance model. One of the hardened Bicep files deploys a Linux-based Azure App Service app. In this exercise, you'll use a deployment workflow to publish the Bicep file as a template spec.

During the process, you'll:

> [!div class="checklist"]
>
> - Add a lint job to the workflow.
> - Add a workflow job to publish the template spec.
> - Manually run the workflow and verify that it finishes successfully.
> - Check the published template spec in Azure.

## Add a lint job to your workflow

Your repository contains a draft of a workflow that you can use as a starting point.

1. In Visual Studio Code, expand the _.github/workflows_ folder in the root of the repository.

1. Open the _template-spec-linux-app-service.yml_ file.

   :::image type="content" source="../media/4-visual-studio-code-workflow.png" alt-text="Screenshot of Visual Studio Code that shows the location of the workflow definition file.":::

   The workflow definition includes two triggers. In this exercise, you don't modify the Bicep file for the template spec, so the `push` trigger never fires. To try out your workflow, you manually invoke it by using the `workflow_dispatch` trigger.

1. At the bottom of the file, where you see a comment that says **To be added**, add the following lint job definition:

   :::code language="yaml" source="code/4-workflow.yml" range="22-28" highlight="2-7" :::

   Your repository has a _bicepconfig.json_ file that configures the linter to emit errors instead of warnings. Any failures during the lint job will cause the workflow to fail.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

## Add a publish job to your workflow

Now, you can add a second job to publish the template spec to Azure.

1. Add the following code at the end of the _template-spec-linux-app-service.yml_ file:

   :::code language="yaml" source="code/4-workflow.yml" range="30-51" :::

   This job checks out the code from your repository and signs in to Azure using the GitHub secrets that you created. It then runs the `az ts create` command to publish the template spec to Azure.

   > [!TIP]
   > To keep things simple, your workflow uses the workflow's _run number_ as the template spec's version number. In the next unit, you'll learn about a more complex versioning scheme.

1. Save your changes to the file.

## Verify and commit your workflow definition

1. Verify that your _template-spec-linux-app-service.yml_ file looks like the following example:

   :::code language="yaml" source="code/4-workflow.yml" highlight="23-51" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish jobs to Linux App Service template spec workflow"
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate by using a web browser, and then select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You might need to sign in to GitHub again. Select **Authorize**.

## Trigger the workflow

1. In your browser, select the **Actions** tab.

   :::image type="content" source="../media/4-actions.png" alt-text="Screenshot of GitHub that shows the Actions tab.":::

   Failed workflow runs are listed already, but you don't need to worry about them. They failed because the workflow definitions weren't yet completed when you created the repository.

1. Select the **template-spec-linux-app-service** workflow, select the **Run workflow** button, and then select **Run workflow**.

   :::image type="content" source="../media/4-workflow-run.png" alt-text="Screenshot of GitHub that shows selections for running the template spec's workflow.":::

   GitHub starts a new workflow run. You might need to refresh your browser window to see the run appear.

1. Select the latest run in the list.

   :::image type="content" source="../media/4-workflow-runs-list.png" alt-text="Screenshot of GitHub that highlights the latest run of the template spec's workflow.":::

   Wait for the workflow run to finish. When it does, the template spec is published to Azure.

1. Note the workflow's run number, which is probably **2**.

   :::image type="content" source="../media/4-run-success.png" alt-text="Screenshot of GitHub that shows a successful workflow run and highlights the run number.":::

## Review the template spec in Azure

You can also view the published template spec in the Azure portal.

1. In your browser, go to the [Azure portal](https://portal.azure.com).

1. Go to the **ToyReusable** resource group, and select the **linux-app-service** template spec.

   :::image type="content" source="../media/4-template-spec-portal.png" alt-text="Screenshot of the Azure portal that shows the resource group, with the template spec highlighted.":::

1. Examine the details of the template spec.

   :::image type="content" source="../media/4-template-spec-details-portal.png" alt-text="Screenshot of the Azure portal that shows the template spec details.":::

   Notice that the **Latest version** and **Version** number is the same as the workflow's run number. Your workflow uses the run number for the template spec's version number.
