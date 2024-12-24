At your toy company, your website development team committed the latest version of the website to your Git repository. Now, you're ready to update your pipeline to build the website, and to deploy it to Azure App Service.

In this process, you do the following tasks:

> [!div class="checklist"]
>
> - Add a new pipeline template for the build job.
> - Update the pipeline to include the build job.
> - Add a new smoke test.
> - Update the deployment stage to deploy the application.
> - Run the pipeline.

## Add a pipeline template for the build job

Add a new job definition that contains the steps required to build the website application.

1. Open Visual Studio Code.

1. In the *deploy/pipeline-templates* folder, create a new file named *build.yml*.

   :::image type="content" source="../media/5-visual-studio-code-build-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the pipeline-templates folder and the 'build.yml' file shown.":::

1. Add the following content to the *build.yml* pipeline template file:

   :::code language="yaml" source="code/5-build.yml" :::

   The job runs a build step to turn the website application's source code into a compiled file that's ready to run in Azure. The job then copies the compiled artifact to a temporary staging folder and publishes it as a pipeline artifact.

1. Save your changes to the file.

## Rename the first pipeline stage, and add a build job

1. Open the *azure-pipelines.yml* file in the *deploy* folder.

1. Modify the *Lint* stage. Rename it to *Build*, and add a build job that uses the *build.yml* pipeline template that you created.

   :::code language="yaml" source="code/5-pipeline.yml" highlight="12-18" :::

1. Save your changes to the file.

## Update the smoke test file

The website developers added a health endpoint to the website. This endpoint checks that the website is online and that it can reach the database. Here, you add a new smoke test to invoke the health check from your deployment pipeline.

1. Open the *Website.Tests.ps1* file in the *deploy* folder.

1. Add a new test case that invokes the health check. The test case fails if the response code isn't 200, which indicates success.

   :::code language="powershell" source="code/5-website-tests.ps1" highlight="23-28" :::

1. Save your changes to the file.

## Add output to Bicep file

You want to add a deployment step that publishes your website to Azure App Service, but the publish step requires the name of the App Service app. Here, you expose the app name as an output from your Bicep file.

1. Open the *main.bicep* file in the *deploy* folder.

1. At the end of the file contents, add the App Service app's name as an output.

   :::code language="bicep" source="code/5-main.bicep" range="117-118" highlight="1" :::

1. Save your changes to the file.

## Update deployment stage

1. Open the *deploy.yml* file in the *deploy/pipeline-templates* folder.

1. In the definition of the *Deploy* stage's deployment job (near Line 59) configure the job to use the Windows hosted agent pool:

   :::code language="yaml" source="code/5-deploy.yml" range="57-67" highlight="6-7" :::

   Some of the pipeline steps you add later to work with your database require the Windows operating system to run. You can use different agent pools for different jobs in your pipeline, so the other jobs continue to use the Ubuntu Linux pipeline agent pool.

1. In the *Deploy* job's *SaveDeploymentOutputs* step, add a new pipeline variable with the value of the app name from the Bicep deployment's output:

   :::code language="yaml" source="code/5-deploy.yml" range="88-94" highlight="2" :::

   Notice that the `appServiceAppHostName` variable has the `isOutput=true` property applied to it, because that variable is used in the smoke test stage. The `appServiceAppName` variable is set and used in the same pipeline stage and job. So, it doesn't need the `isOutput=true` setting.

1. At the end of the *Deploy* job contents, add a new step to deploy the app to Azure App Service:

   :::code language="yaml" source="code/5-deploy.yml" range="70-105" highlight="27-37" :::

   > [!NOTE]
   > Be careful with the indentation of the YAML file, ensuring that the new deployment step is indented at the same level as the `DeployBicepFile` step. If you're not sure, copy the whole *deploy.yml* file contents from the example in the next step.

   Notice that you didn't explicitly download the artifact in the pipeline definition. Because you use a deployment job, Azure Pipelines automatically downloads the artifact for you.

## Verify the deploy.yml file contents, and commit your changes

1. Verify that your *deploy.yml* file looks like the following example:

   :::code language="yaml" source="code/5-deploy.yml" highlight="62-63, 89, 96-106" :::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, commit and push your changes to your Git repository by running the following commands:

   ```bash
   git add .
   git commit -m "Build and deploy website application"
   git push
   ```

## Run the pipeline

1. In your browser, go to **Pipelines**.

1. Select the most recent run of your pipeline.

   :::image type="content" source="../media/5-pipeline-runs.png" alt-text="Screenshot of Azure DevOps showing the pipeline run list. The latest pipeline run is highlighted.":::

   Wait until the *Build* stage finishes successfully.

   The pipeline pauses before it runs the *Validate (Test Environment)* stage because the pipeline needs permission to use the variable group that the stage refers to. You need to approve the pipeline's access to the variable group, because you're running the pipeline in this project for the first time. When you run the pipeline again, you don't need to approve access to the same variable group.

1. Select **View**.

   :::image type="content" source="../media/5-pipeline-run-validate-permission.png" alt-text="Screenshot of Azure DevOps showing the pipeline run paused at the Validate stage. Permission is required to continue. The View button is highlighted.":::

1. Select **Permit**.

   :::image type="content" source="../media/5-pipeline-run-validate-approve-1.png" alt-text="Screenshot of Azure DevOps showing that the pipeline needs permission to use the ToyWebsiteTest variable group. The Permit button is highlighted.":::

1. Select **Permit**.

   :::image type="content" source="../media/5-pipeline-run-validate-approve-2.png" alt-text="Screenshot of Azure DevOps showing the permission confirmation interface. The Permit button is highlighted.":::

   The *Validate (Test Environment)* stage finishes successfully.

   The pipeline continues and the *Deploy (Test Environment)* stage finishes successfully. The pipeline then runs the *Smoke Test (Test Environment)* stage, but the smoke test stage fails.

1. Select the **Smoke Test (Test Environment)** stage to open the pipeline log.

   :::image type="content" source="../media/5-smoke-test-failure.png" alt-text="Screenshot of Azure DevOps showing the pipeline run's Smoke Test stage for the test environment. The status shows that the stage failed.":::

1. Select the **Run smoke tests** step to view the associated section of the pipeline log.

   :::image type="content" source="../media/5-smoke-test-failure-log.png" alt-text="Screenshot of Azure DevOps showing the pipeline run log, with the output of the smoke test displayed. The JSON health test result is highlighted.":::

   Notice that the pipeline log includes the health check response. The response indicates that there's a problem with the application's communication with Azure SQL Database. The database isn't deployed or configured yet, which is why the website can't access it. In the next exercise, you fix this configuration issue.
