Your team has built some security-hardened Bicep files that are compliant with your company's new governance model. One of the hardened Bicep files deploys a Linux-based Azure App Service app. In this exercise, you'll use a deployment pipeline to publish the Bicep file as a template spec.

During the process, you'll:

> [!div class="checklist"]
>
> - Add a lint stage to the pipeline.
> - Add a pipeline stage to publish the template spec.
> - Verify that the pipeline starts and finishes successfully.
> - Check the published template spec in Azure.

## Add a lint stage to your pipeline

Your repository contains a draft of a pipeline definition that you can use as a starting point.

1. In Visual Studio Code, expand the _template-specs/linux-app-service_ folder in the root of the repository.

1. Open the _pipeline.yml_ file.

   :::image type="content" source="../media/4-visual-studio-code-pipeline.png" alt-text="Screenshot of Visual Studio Code that shows the location of the pipeline definition file.":::

1. At the bottom of the file, replace `# To be added` with the following lint stage definition:

   :::code language="yaml" source="code/4-pipeline.yml" range="25-35" highlight="3-11" :::

   Your repository has a _bicepconfig.json_ file that configures the linter to emit errors instead of warnings. Any failures during the lint stage will cause the pipeline to fail.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML pipeline definition so that you can verify that your file matches.

## Add a publish stage to your pipeline

Now, you can add a second stage to publish the template spec to Azure.

1. Add the following code at the end of the _pipeline.yml_ file:

   :::code language="yaml" source="code/4-pipeline.yml" range="37-55" :::

   This stage checks out the code from your repository and signs in to Azure using the service connection that you created. It then runs the `az ts create` command to publish the template spec to Azure.

   > [!TIP]
   > To keep things simple, your pipeline uses the pipeline's _build number_ as the template spec's version number. In the next unit, you'll learn about a more complex versioning scheme.

1. Save your changes to the file.

## Verify and commit your pipeline definition

1. Verify that your _pipeline.yml_ file looks like the following example:

   :::code language="yaml" source="code/4-pipeline.yml" highlight="27-55" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish stages to Linux App Service template spec pipeline"
   git push
   ```

   Immediately after you push, Azure Pipelines starts a new pipeline run.

## Monitor the pipeline

1. In your browser, select **Pipelines** > **Pipelines**.

   :::image type="content" source="../media/4-pipelines.png" alt-text="Screenshot of Azure Pipelines that shows the Pipelines menu item.":::

1. Select the active pipeline run.

1. The pipeline run is displayed.

   Wait for the pipeline run to finish. When it does, the template spec is published to Azure.

   :::image type="content" source="../media/4-run-success.png" alt-text="Screenshot of Azure Pipelines that shows a successful pipeline run and highlights the build number.":::

1. Note the pipeline's build number, which includes today's date and a unique revision number. In the example screenshot, the build number is **20230407.1**.

## Review the template spec in Azure

You can also view the published template spec in the Azure portal.

1. In your browser, go to the [Azure portal](https://portal.azure.com).

1. Go to the **ToyReusable** resource group, and select the **linux-app-service** template spec.

   :::image type="content" source="../media/4-template-spec-portal.png" alt-text="Screenshot of the Azure portal that shows the resource group, with the template spec highlighted.":::

1. Examine the details of the template spec.

   :::image type="content" source="../media/4-template-spec-details-portal.png" alt-text="Screenshot of the Azure portal that shows the template spec details.":::

   Notice that the **Latest version** and **Version** number is the same as the pipeline's build number. Your pipeline uses the build number for the template spec's version number.
