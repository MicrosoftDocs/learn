At your toy company, your website development team has committed the latest version of the website to your Git repository. Now, you're ready to update your pipeline to build the website, and to deploy it to Azure App Service.

In the process, you'll do the following tasks:

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

1. In the _deploy/pipeline-templates_ folder, create a new file named _build.yml_.

   :::image type="content" source="../media/5-visual-studio-code-build-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the pipeline-templates folder and the build dot YML file shown.":::

1. Add the following content to the _build.yml_ pipeline template file:

   :::code language="yaml" source="code/5-build.yml" :::

   The job runs a build step to turn the website application's source code into a compiled file that's ready to run in Azure. The job then copies the compiled artifact to a temporary staging folder and publishes it as a pipeline artifact.

1. Save your changes to the file.

## Rename the first pipeline stage, and add a build job

1. Open the _azure-pipelines.yml_ file in the _deploy_ folder.

1. Modify the _Lint_ stage. Rename it to _Build_, and add a build job that uses the _build.yml_ pipeline template that you created:

   :::code language="yaml" source="code/5-pipeline.yml" highlight="12-18" :::

1. Save your changes to the file.

## Update the smoke test file

The website developers have added a health endpoint to the website. This endpoint checks that the website is online and that it can reach the database. Here, you add a new smoke test to invoke the health check from your deployment pipeline.

1. Open the _Website.Tests.ps1_ file in the _deploy_ folder.

1. Add a new test case that invokes the health check. The test case fails if the response code isn't 200, which indicates success:

   :::code language="powershell" source="code/5-website-tests.ps1" highlight="23-28" :::

1. Save your changes to the file.

## Add output to Bicep file

You'll soon add a deployment step that publishes your website to Azure App Service. The publish step requires the name of the App Service app. Here, you expose the app name as an output from your Bicep file.

1. Open the _main.bicep_ file in the _deploy_ folder.

1. At the end of the file contents, add the App Service app's name as an output:

   :::code language="bicep" source="code/5-main.bicep" range="117-118" highlight="1" :::

1. Save your changes to the file.

## Update deployment stage

1. Open the _deploy.yml_ file in the _deploy/pipeline-templates_ folder.

1. In the definition of the _Deploy_ stage's deployment job (near Line 59) configure the job to use the Windows hosted agent pool:

   :::code language="yaml" source="code/5-deploy.yml" range="57-67" highlight="6-7" :::

   Some of the pipeline steps that you'll add later to work with your database require the Windows operating system to run. You can use different agent pools for different jobs in your pipeline, so the other jobs continue to use the Ubuntu Linux pipeline agent pool.

1. In the _Deploy_ job's _SaveDeploymentOutputs_ step, add a new pipeline variable with the value of the app name from the Bicep deployment's output:

   :::code language="yaml" source="code/5-deploy.yml" range="88-94" highlight="2" :::

   Notice that the `appServiceAppHostName` variable has the `isOutput=true` property applied to it, because that variable is used in the smoke test stage. The `appServiceAppName` is used in the same pipeline stage and job that it's set within, so it doesn't need the `isOutput=true` setting.

1. At the end of the _Deploy_ job contents, add a new step to deploy the app to Azure App Service:

   :::code language="yaml" source="code/5-deploy.yml" range="70-105" highlight="27-37" :::

   > [!NOTE]
   > Be careful with the indentation of the YAML file, ensuring that the new deployment step is indented at the same level as the `DeployBicepFile` step. If you're not sure, copy the whole _deploy.yml_ file contents from the example in the next step.

   Notice that you didn't explicitly download the artifact in the pipeline definition. Because you use a deployment job, Azure Pipelines automatically downloads the artifact for you.

## Verify the deploy.yml file contents, and commit your changes

1. Verify that your _deploy.yml_ file looks like the following example:

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

   Wait until the _Build_ stage finishes successfully.

   The pipeline pauses before it runs the _Validate (Test Environment)_ stage because the pipeline needs permission to use the variable group that the stage refers to. You need to approve the pipeline's access to the variable group, because it's the first time you've run the pipeline in this project. When you run the pipeline again, you won't need to approve access to the same variable group.

1. Select **View**.

   :::image type="content" source="../media/5-pipeline-run-validate-permission.png" alt-text="Screenshot of Azure DevOps showing the pipeline run paused at the Validate stage. Permission is required to continue. The View button is highlighted.":::

1. Select **Permit**.

   :::image type="content" source="../media/5-pipeline-run-validate-approve-1.png" alt-text="Screenshot of Azure DevOps showing that the pipeline needs permission to use the ToyWebsiteTest variable group. The Permit button is highlighted.":::

1. Select **Permit**.

   :::image type="content" source="../media/5-pipeline-run-validate-approve-2.png" alt-text="Screenshot of Azure DevOps showing the permission confirmation interface. The Permit button is highlighted.":::

   The _Validate (Test Environment)_ stage finishes successfully.

   The pipeline continues and the _Deploy (Test Environment)_ stage finishes successfully. The pipeline then runs the _Smoke Test (Test Environment)_ stage, but the smoke test stage fails.

1. Select the **Smoke Test (Test Environment)** stage to open the pipeline log.

   :::image type="content" source="../media/5-smoke-test-failure.png" alt-text="Screenshot of Azure DevOps showing the pipeline run's Smoke Test stage for the test environment. The status shows that the stage has failed.":::

1. Select the **Run smoke tests** step to view the associated section of the pipeline log.

   :::image type="content" source="../media/5-smoke-test-failure-log.png" alt-text="Screenshot of Azure DevOps showing the pipeline run log, with the output of the smoke test displayed. The JSON health test result is highlighted.":::

   Notice that the pipeline log includes the health check response. The response indicates that there's a problem with the application's communication with Azure SQL Database. You haven't yet deployed or configured a database, which is why the website can't access it. You'll fix this configuration issue soon.
