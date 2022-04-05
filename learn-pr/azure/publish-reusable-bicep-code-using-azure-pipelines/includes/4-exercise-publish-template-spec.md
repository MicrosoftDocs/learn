Your team has built some security-hardened Bicep files that are compliant with your company's new governance model. One of the hardened Bicep files deploys a Linux-based Azure App Service app. In this exercise, you'll use a deployment pipeline to publish the Bicep file as a template spec.

During the process, you'll:

> [!div class="checklist"]
> * Add a lint job to the pipeline.
> * Add a pipeline job to publish the template spec.
> * Verify that the pipeline starts and finishes successfully.
> * Check the published template spec in Azure.

## Add a lint job to your pipeline

Your repository contains a draft of a pipeline definition that you can use as a starting point.

1. In Visual Studio Code, expand the *template-specs* folder in the root of the repository. Then, expand the *linux-app-service* folder.

1. Open the *pipeline.yml* file.

   :::image type="content" source="../media/4-visual-studio-code-pipeline.png" alt-text="Screenshot of Visual Studio Code that shows the location of the pipeline definition file.":::

1. At the bottom of the file, where you see a comment that says **To be added**, add the following lint job definition:

   :::code language="yaml" source="code/4-pipeline.yml" range="18-24" highlight="2-7" :::

   Your repository has a *bicepconfig.json* file that configures the linter to emit errors instead of warnings. Any failures during the lint job will cause the pipeline to fail.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML pipeline definition so that you can verify that your file matches.

## Add a publish job to your pipeline

Now, you can add a second job to publish the template spec to Azure.

1. Add the following code at the end of the *pipeline* file:

   :::code language="yaml" source="code/4-pipeline.yml" range="26-45" :::

   This job checks out the code from your repository and signs in to Azure by using service connection that you created earlier. It then runs the `az ts create` command to publish the template spec to Azure.

   > [!TIP]
   > To keep things simple, your pipeline uses the pipeline's *run number* as the template spec's version number. In the next unit, you'll learn about a more complex versioning scheme.

1. Save your changes to the file.

## Verify and commit your pipeline definition

1. Verify that your *pipeline.yml* file looks like the following example:

   :::code language="yaml" source="code/4-pipeline.yml" highlight="19-45" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish jobs to Linux App Service template spec pipeline"
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate by using a web browser, and then select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You might need to sign in to GitHub again. Select **Authorize**.

## Monitor the pipeline

<!-- TODO -->

1. In your browser, select the **Actions** tab.

   :::image type="content" source="../media/4-actions.png" alt-text="Screenshot of GitHub that shows the Actions tab.":::

   Failed workflow runs are listed already, but you don't need to worry about them. They failed because the workflow definitions weren't yet completed.

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

1. In your browser, go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Go to the **ToyReusable** resource group, and select the **linux-app-service** template spec.

   :::image type="content" source="../media/4-template-spec-portal.png" alt-text="Screenshot of the Azure portal that shows the resource group, with the template spec highlighted.":::

1. Examine the details of the template spec.

   :::image type="content" source="../media/4-template-spec-details-portal.png" alt-text="Screenshot of the Azure portal that shows the template spec details.":::

   Notice that the **Latest version** and **Version** number is the same as the workflow's run number. Your workflow uses the run number for the template spec's version number.
