At your toy company, your website-development team has committed the latest version of the website to your Git repository. Now, you're ready to update your workflow to build the website, and to deploy it to Azure App Service.

In the process, you'll:

> [!div class="checklist"]
>
> - Add a new called workflow for the build job.
> - Update the workflow to include the build job.
> - Add a new smoke test.
> - Update the deployment job to deploy the application.
> - Run the workflow.

## Add a reusable workflow for the build job

Here, you add a new job definition that contains the steps required to build the website application.

1. Open Visual Studio Code.

1. In the _.github/workflows_ folder, create a new file named _build.yml_.

   :::image type="content" source="../media/5-visual-studio-code-build-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the dot github and workflows folders and the build dot YML file shown.":::

1. Add the following content to the _build.yml_ workflow file:

   :::code language="yaml" source="code/5-build.yml" :::

   The job installs the .NET SDK to build the solution. Then, it runs a build step to turn the website application's source code into a compiled file that's ready to run in Azure. The job then compresses the compiled artifact and uploads it as a workflow artifact.

1. Save your changes to the file.

## Add the build job to the workflow

1. Open the _workflow.yml_ file.

1. Below the _jobs:_ line, before the _lint_ job, add a new job named _build_ that uses the reusable workflow you just defined:

   :::code language="yaml" source="code/5-workflow.yml" range="1-22" highlight="16-18" :::

1. Update the _deploy-test_ job to depend on the new _build_ job:

   :::code language="yaml" source="code/5-workflow.yml" range="24-36" highlight="4" :::

1. Update the _deploy-production_ job to also depend on the _build_ and _lint_ jobs.

   :::code language="yaml" source="code/5-workflow.yml" range="38-53" highlight="4-7" :::

   Because the production deployment depends on the test deployment, you don't strictly need to specify the dependencies. But, it's a good practice to be explicit, to avoid your workflow running incorrectly if you reorder or remove your jobs or environments.

   Notice you're specifying the `needs` list in two different ways -  your test environment deployment's dependencies are listed on a single line, and your production environment's by using a multiline list. The two approaches are equivalent.

1. Save your changes to the file.

## Update the smoke test file

The website developers have added a health endpoint to the website. This endpoint checks that the website is online and that it can reach the database. Here, you add a new smoke test to invoke the health check from your deployment workflow.

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

## Update the deployment job to propagate the output

Now, you need to update your _deploy_ job to take the value of the output from the Bicep deployment and make it available to the rest of the workflow.

1. Open the _deploy.yml_ file in the _.github/workflows_ folder.

1. In the _deploy_ job's definition, add a new output for the `appServiceAppName`:

   :::code language="yaml" source="code/5-deploy.yml" range="61-68" highlight="6" :::

   > [!NOTE]
   > When you start to work with your YAML file in Visual Studio Code, you might see some red squiggly lines telling you there's a problem. This is because the Visual Studio Code extension for YAML files sometimes incorrectly guesses the file's schema.
   >
   > You can ignore the problems that the extension reports. Or if you prefer, you can add the following code to the top of the file to suppress the extension's guessing:
   >
   > ```yaml
   > # yaml-language-server: $schema=./deploy.yml
   > ```

## Add a job to deploy the website

1. Below the _deploy_ job definition, and above the _smoke-test_ job definition, define a new job to deploy the website to App Service:

   :::code language="yaml" source="code/5-deploy.yml" range="89-105" :::

   > [!NOTE]
   > Be careful with the indentation of the YAML file, ensuring that the new job is indented at the same level as the `deploy` job. If you're not sure, copy the whole _deploy.yml_ file contents from the example in the next step.

   Notice that the job depends on the _deploy_ job by using the `needs` keyword. This dependency ensures the website isn't deployed until the infrastructure is ready. It also enables the job to access the `appServiceAppName` output from the _deploy_ job.

   Also, notice that this job includes steps to download the workflow artifacts and to sign in to Azure. Each job runs on its own runner, so it needs to be self-contained.

1. Save your changes to the file.

## Verify the deploy.yml file contents, and commit your changes

1. Verify that your _deploy.yml_ file looks like the following example:

   :::code language="yaml" source="code/5-deploy.yml" highlight="66, 89-105" :::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, commit and push your changes to your Git repository by running the following commands:

   ```bash
   git add .
   git commit -m "Build and deploy website application"
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You may need to sign in to GitHub again. Select **Authorize**.

## Run the workflow

1. In your browser, go to **Actions**.

   The first run of your workflow, labeled _Initial commit_, is shown as a failure. GitHub automatically ran the workflow when you created the repository. It failed because the secrets weren't ready at that time. You can ignore this failure.

1. Select the **deploy-toy-website-end-to-end** workflow.

1. Select the most recent run of your workflow.

1. Wait until the _build_ job finishes successfully.

   :::image type="content" source="../media/5-jobs.png" alt-text="Screenshot of GitHub that shows the workflow run jobs.":::

1. Wait for the _deploy-test / deploy_ job to finish successfully.

   Some warnings are listed in the **Annotations** panel. All of these warnings are because of the way Bicep writes informational messages to the workflow log. You can ignore these warnings.

1. The workflow then runs the _deploy-test / smoke-test_ job, but the smoke test fails:

   :::image type="content" source="../media/5-smoke-test-failure.png" alt-text="Screenshot of GitHub that shows the workflow run's smoke test job for the test environment. The status shows that the job has failed.":::

1. Select the **deploy-test / smoke-test** job to open the workflow log.

1. Select the **Run smoke tests** step to view the associated section of the workflow log:

   :::image type="content" source="../media/5-smoke-test-failure-log.png" alt-text="Screenshot of GitHub showing the workflow run log, with the output of the smoke test displayed. The JSON health test result is highlighted.":::

   Notice that the workflow log indicates the website and configuration isn't healthy. There's a problem with the application's communication with Azure SQL Database. You haven't yet deployed or configured a database, which is why the website can't access it. You'll fix this problem soon.
