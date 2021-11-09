At your toy company, your website development team has committed the latest version of the website to your Git repository. Now, you're ready to update your workflow to build the website, and to deploy it to Azure App Service.

In the process, you'll:

> [!div class="checklist"]
> * Add a new called workflow for the build job.
> * Update the workflow to include the build job.
> * Add a new smoke test.
> * Update the deployment job to deploy the application.
> * Run the workflow.

## Add a reusable workflow for the build job

Here, you add a new job definition that contains the steps required to build the website application.

1. Open Visual Studio Code.

1. In the *.github/workflows* folder, create a new file named *build.yml*.

   :::image type="content" source="../media/5-visual-studio-code-build-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the dot github and workflows folders and the build dot Y M L file shown.":::

1. Add the following content to the *build.yml* workflow file:

   :::code language="yaml" source="code/5-build.yml" :::

   The job installs the .NET Core SDK to build the solution. Then, it runs a build step to turn the website application's source code into a compiled file that's ready to run in Azure. The job then compresses the compiled artifact and uploads it as a workflow artifact.

1. Save your changes to the file.

## Add the build job to the workflow

1. Open the *workflow.yml* file.

1. Below the *jobs:* line, add a new job named *build* that uses the reusable workflow you just defined:

   :::code language="yaml" source="code/5-workflow.yml" range="1-16" highlight="12-13" :::

   <!-- TODO ensure you replace user and repo name -->

1. Update the *deploy-test* job to depend on the new *build* job: <!-- TODO should we make prod depned too, for consistency -->

   :::code language="yaml" source="code/5-workflow.yml" range="18-27" highlight="3" :::

1. Save your changes to the file.

## Update the smoke test file

The website developers have added a health endpoint to the website. This endpoint checks that the website is online and that it can reach the database. Here, you add a new smoke test to invoke the health check from your deployment workflow.

1. Open the *Website.Tests.ps1* file in the *deploy* folder.

1. Add a new test case that invokes the health check. The test case fails if the response code isn't 200, which indicates success:

   :::code language="powershell" source="code/5-website-tests.ps1" highlight="23-28" :::

1. Save your changes to the file.

## Add output to Bicep file

You'll soon add a deployment step that publishes your website to Azure App Service. The publish step requires the name of the App Service app. Here, you expose the app name as an output from your Bicep file.

1. Open the *main.bicep* file in the *deploy* folder.

1. At the end of the file contents, add the App Service app's name as an output: 

   :::code language="bicep" source="code/5-main.bicep" range="102-103" highlight="1" :::

1. Save your changes to the file.

## Update deployment job to propagate the output

TODO explain

1. Open the *deploy.yml* file in the *.github/workflows* folder.

1. In the *deploy* job's definition, add a new output for the `appServiceAppName`:

   :::code language="yaml" source="code/5-deploy.yml" range="55-62" highlight="6" :::

## Add a job to deploy the website

1. Below the *deploy* job definition, and above the *smoke-test* job definition, define a new job to deploy the website to App Service:

   :::code language="yaml" source="code/5-deploy.yml" range="81-95" :::

   > [!NOTE]
   > Be careful with the indentation of the YAML file, ensuring that the new job is indented at the same level as the `deploy` job. If you're not sure, copy the whole *deploy.yml* file contents from the example in the next step.

   Notice that the job depends on the *deploy* job by using the `needs` keyword. This ensure the website isn't deployed until the infrastructure is ready. It also enables the job to access the `appServiceAppName` output from the *deploy* job.

   Also, notice that this job includes steps to download the workflow artifacts and to sign in to Azure. The job runs on a separate runner to the *deploy* job, so it needs to be self-contained.

1. Save your changes to the file.

## Verify the deploy.yml file contents, and commit your changes

1. Verify that your *deploy.yml* file looks like the following:

   :::code language="yaml" source="code/5-deploy.yml" highlight="60, 81-95" :::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, commit and push your changes to your Git repository by running the following commands:

   ```bash
   git add .
   git commit -m "Build and deploy website application"
   git push
   ```

## Run the workflow

1. In your browser, go to **Actions**.

1. Select the **toy-company-end-to-end** workflow. <!-- TODO check name -->

1. Select the most recent run of your workflow.

1. Wait until the *build* job finishes successfully.

   :::image type="content" source="../media/5-jobs.png" alt-text="Screenshot of GitHub that shows the workflow run jobs.":::

   <!-- TODO look at artifacts -->

1. Wait for the *deploy-test / deploy* job to finish successfully.

   Some warnings are listed in the **Annotations** panel. All of these warnings are because of the way Bicep writes informational messages to the workflow log. You can ignore these warnings.

1. The workflow then runs the *deploy-test / smoke-test* job, but the smoke test fails:

   :::image type="content" source="../media/5-smoke-test-failure.png" alt-text="Screenshot of GitHub that shows the workflow run's smoke test job for the test environment. The status shows that the job has failed.":::

1. Select the **deploy-test / smoke-test** job to open the workflow log.

1. Select the **Run smoke tests** step to view the associated section of the workflow log:

   :::image type="content" source="../media/5-smoke-test-failure-log.png" alt-text="Screenshot of GitHub showing the workflow run log, with the output of the smoke test displayed. The J S O N health test result is highlighted.":::

   Notice that the workflow log indicates the website and configuration isn't healthy. There's a problem with the application's communication with Azure SQL Database. You haven't yet deployed or configured a database, which is why the website can't access it. You'll fix this soon.
