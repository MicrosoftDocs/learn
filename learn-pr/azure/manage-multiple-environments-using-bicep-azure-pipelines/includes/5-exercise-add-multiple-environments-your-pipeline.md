Now you're ready to update your pipeline to deploy to both your test and production environments. In this unit, you update your pipeline to use templates so that you can reuse the stages across the environments.

During the process, you'll:

> [!div class="checklist"]
>
> - Add a pipeline template for the lint stage.
> - Add a pipeline template that defines the stages required to deploy to any environment.
> - Update your pipeline to use the templates.
> - Run your pipeline and view the results.

## Add a pipeline template for the lint stage

The lint stage happens only once during the pipeline run, regardless of how many environments the pipeline deploys to. So, you don't really need to use templates for the lint stage. But to keep your main pipeline definition file simple and easy to read, you decide to define the lint stage in a template.

1. In Visual Studio Code, create a new folder named _pipeline-templates_ inside the _deploy_ folder.

1. Create a new file in the _pipeline-templates_ folder named _lint.yml_.

   :::image type="content" source="../media/5-visual-studio-code-lint-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the pipeline-templates folder and the lint dot Y M L file.":::

1. Paste the following pipeline template definition into the file:

   :::code language="yaml" source="code/5-lint.yml" :::

   The lint stage is the same as the lint stage already in the pipeline, but now it's in a separate pipeline template file.

1. Save your changes and close the file.

## Add a pipeline template for deployment

Create a pipeline template that defines all of the stages required to deploy each of your environments. You use template parameters to specify the settings that might differ between environments.

1. Create a new file in the _pipeline-templates_ folder named _deploy.yml_.

   :::image type="content" source="../media/5-visual-studio-code-deploy-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the pipeline-templates folder and the deploy dot YML file.":::

   This file represents all of the deployment activities that run for each of your environments.

1. Paste the following pipeline template parameters into the file:

   :::code language="yaml" source="code/5-deploy.yml" range="1-10" :::

   > [!NOTE]
   > When you start to work with your YAML file in Visual Studio Code, you might see some red squiggly lines telling you there's a problem. This is because the Visual Studio Code extension for YAML files sometimes incorrectly guesses the file's schema.
   >
   > You can ignore the problems that the extension reports. Or if you prefer, you can add the following code to the top of the file to suppress the extension's guessing:
   >
   > ```yaml
   > # yaml-language-server: $schema=./deploy.yml
   > ```

1. Below the parameters, paste the definition of the validation stage:

   :::code language="yaml" source="code/5-deploy.yml" range="12-31" :::

   Notice that a condition is applied to this stage. It runs only for non-production environments.

   Also notice that the stage identifier includes the value of the `environmentType` parameter. This parameter ensures that every stage in your pipeline has a unique identifier. The stage also has a `displayName` property to create a well-formatted name for you to read.

1. Below the validation stage, paste the definition of the preview stage:

   :::code language="yaml" source="code/5-deploy.yml" range="33-51" :::

   Notice that this stage has a condition applied too, but it's the opposite of the validation stage's condition. The preview stage runs only for the production environment.

1. Below the preview stage, paste the definition of the deploy stage:

   :::code language="yaml" source="code/5-deploy.yml" range="53-83" :::

1. Below the deploy stage, paste the definition of the smoke test stage:

   :::code language="yaml" source="code/5-deploy.yml" range="85-112" :::

   Notice that the `appServiceAppHostName` variable definition incorporates the `environmentType` parameter when it refers to the stage that published the host name. This parameter ensures that each smoke test stage runs against the correct environment.

1. Verify that your _deploy.yml_ file now looks like the following example:

   :::code language="yaml" source="code/5-deploy.yml" :::

1. Save your changes to the file.

## Update the pipeline definition to use the templates

1. Open the _azure-pipelines.yml_ file.

1. Update the file to use the new templates by replacing the contents with the following code:

   :::code language="yaml" source="code/5-pipeline.yml" :::

   This pipeline runs the lint stage once. Then it uses the _deploy.yml_ template file twice: once per environment. This keeps the pipeline definition clear and easy to understand. Also, the comments help explain what's happening.

1. Save your changes.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add pipeline templates"
   git push
   ```

## View the pipeline run

1. In your browser, go to **Pipelines**.

1. Select the most recent run of your pipeline.

   Notice that the pipeline run now shows all the stages that you defined in the YAML file. You might need to scroll horizontally to see them all.

   :::image type="content" source="../media/5-stages.png" alt-text="Screenshot of Azure Pipelines that shows the pipeline run stages.":::

1. Wait for the pipeline to pause before the **Deploy (Production Environment)** stage. It might take a few minutes for the pipeline to reach this point.

   :::image type="content" source="../media/5-waiting-approval.png" alt-text="Screenshot of Azure Pipelines that shows the pipeline run paused for approval.":::

1. Approve the deployment to the production environment by selecting the **Review** button.

1. Select the **Approve** button.

   :::image type="content" source="../media/5-approve.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline approval page and the Approve button.":::

   Wait for the pipeline to finish running.

1. Select the **Tests** tab to show the test results from this pipeline run.

   Notice that there are now four test results. The smoke test runs on both the test and production environments, so you see the results for both sets of tests.

   :::image type="content" source="../media/5-tests.png" alt-text="Screenshot of Azure Pipelines that shows the page for pipeline run tests, with four test results.":::

1. Select **Pipelines** > **Environments**.

1. Select the **Production** environment.

1. Notice that on the environment details screen, you see an overview of the production environment's deployment history.

   :::image type="content" source="../media/5-environment-production.png" alt-text="Screenshot of Azure Pipelines that shows the production environment, with the deployment history showing a single deployment.":::

1. Select the deployment, and select the **Changes** tab.

   Notice that **Changes** tab shows you the list of commits included in the deployment. This information helps you to see exactly what has changed in your environment over time.

   :::image type="content" source="../media/5-environment-commits.png" alt-text="Screenshot of Azure Pipelines that shows the production environment's deployment details, with a list of commits.":::

1. In your browser, go to the [Azure portal](https://portal.azure.com).

1. Go to the **ToyWebsiteProduction** resource group.

1. In the list of resources, open the Azure App Service app.

   :::image type="content" source="../media/5-app-service-production.png" alt-text="Screenshot of the Azure portal that shows the production App Service app and the App Service plan SKU details.":::

   Notice that the type of App Service plan is **S1**.

1. Go to the App Service app in the **ToyWebsiteTest** resource group.

   Notice that the type of App Service plan is **F1**. The two environments use different settings, as you defined in your Bicep file.
