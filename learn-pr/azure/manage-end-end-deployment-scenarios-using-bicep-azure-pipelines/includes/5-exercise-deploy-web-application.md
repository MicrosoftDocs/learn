TODO

## Add pipeline template for build job

Here, you add a new job definition that contains the steps required to build the website application.

1. Open Visual Studio Code.

1. In the *deploy/pipeline-templates* folder, create a new file named *build.yml*.

   :::image type="content" source="../media/5-visual-studio-code-build-yml-file.png" alt-text="TODO":::

1. Add the following content to the *build.yml* pipeline template file.

   :::code language="yaml" source="code/5-build.yml" :::

   The job runs a build step to turn the website application's source code into a compiled file that's ready to run in Azure. Then, the job copies the compiled artifact to a temporary staging folder and publishes it as a pipeline artifact.

1. Save your changes to the file.

## Rename first pipeline stage, and add build job

1. Open the *azure-pipelines.yml* file in the *deploy* folder.

1. Modify the *Lint* stage. Rename it to *Build*, and add a build job that uses the pipeline template that you just created:

   :::code language="yaml" source="code/5-azure-pipelines.yml" highlight="11-17" :::

1. Save your changes to the file.

## Update smoke test file

The website developers have added a health endpoint to the website. This endpoint checks that the website is online, and that it can reach the database. Here, you add a new smoke test to invoke the health check from your deployment pipeline.

1. Open the *Website.Tests.ps1* file in the *deploy* folder.

1. Add a new test case that invokes the health check. The test case fails if the response code isn't 200, which indicates success:

   :::code language="powershell" source="code/5-website-tests.ps1" highlight="23-28" :::

1. Save your changes to the file.

## Add output to Bicep file

You'll soon add a deployment step that publishes your website to Azure App Service. The publish step requires the name of the App Service app. Here, you expose the app name as an output from your Bicep file.

1. Open the *main.bicep* file inside the *deploy* folder.

1. At the bottom of the file, add the App Service app's name as an output: 

   :::code language="bicep" source="code/5-main.bicep" range="102-103" highlight="1" :::

1. Save your changes to the file.

## Update deployment stage

1. Open the *deploy.yml* file in the *deploy/pipeline-templates* folder.

1. In the definition of the *Deploy* stage's deployment job, configure the job to use the Windows hosted agent pool:

   :::code language="yaml" source="code/5-deploy.yml" range="55-64" highlight="6-7" :::

   Some of the steps you'll add to the job require the Windows operating system to run. You can use different agent pools for different jobs in your pipeline, so the other jobs continue to use the Ubuntu Linux pipeline agent pool.

1. In the *Deploy* job's *DeployBicepFile* step, add a new pipeline variable with the value of the app name from the Bicep output:

   :::code language="yaml" source="code/5-deploy.yml" range="78-90" highlight="10, 12" :::

1. At the bottom of the *Deploy* job, add a new step to deploy the app to Azure App Service:

   :::code language="yaml" source="code/5-deploy.yml" range="92-101" :::

   <!-- TODO watch indentation -->

1. Verify that your *deploy.yml* file looks like the following:

   :::code language="yaml" source="code/5-deploy.yml" highlight="60-61, 87, 89, 92-101" :::

1. Save your changes to the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Build and deploy website application"
   git push
   ```

## Run pipeline and see smoke test fail

1. In your browser, navigate to **Pipelines**.

1. Select the most recent run of your pipeline.

   The *Build* stage completes successfully. Then, the pipeline pauses before it runs the *Validate (Test Environment)* stage. This is because the pipeline needs permission to use the variable group that the stage refers to. You need to approve the pipeline's access to the variable group because this is the first time you've run the pipeline in this project. When you run the pipeline again, you won't need to approve access to the same variable group.

1. Select **View**.

   :::image type="content" source="../media/5-pipeline-run-validate-permission.png" alt-text="TODO":::

1. Select **Permit**.

   :::image type="content" source="../media/5-pipeline-run-validate-approve-1.png" alt-text="TODO":::

1. Select **Permit**.

   :::image type="content" source="../media/5-pipeline-run-validate-approve-2.png" alt-text="TODO":::

   The *Validate (Test Environment)* stage completes successfully. Then, the pipeline pauses again - this time before the *Deploy (Test Environment)* stage.

1. Select **View**, then select **Permit** > **Permit**.

   :::image type="content" source="../media/5-pipeline-run-deploy-permission.png" alt-text="TODO":::

   The *Deploy (Test Environment)* stage completes successfully. The pipeline then runs the *Smoke Test (Test Environment)* stage, but the smoke test stage fails:

   :::image type="content" source="../media/5-smoke-test-failure.png" alt-text="TODO":::

1. Select the **Smoke Test (Test Environment)** stage to open the pipeline log.

1. Select the **Run smoke tests** step to view the appropriate part of the pipeline log:

   :::image type="content" source="../media/5-smoke-test-failure-log.png" alt-text="TODO":::

   Notice that the pipeline log includes the health check response. The response indicates that there's a problem with the application's communication with Azure SQL Database. You haven't yet configured the database, so the website can't access it. You'll fix this soon.
