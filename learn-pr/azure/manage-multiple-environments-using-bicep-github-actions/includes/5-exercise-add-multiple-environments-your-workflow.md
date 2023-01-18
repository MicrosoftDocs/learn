Now you're ready to update your workflow to deploy to both your test and production environments. In this unit, you'll update your workflow to use called workflows so that you can reuse the jobs across the environments.

During the process, you'll: 

> [!div class="checklist"]
> * Add a reusable workflow for the lint job.
> * Add a reusable workflow that defines the jobs required to deploy to any environment.
> * Update your workflow to use the called workflows.
> * Run your workflow and view the results.

## Add a reusable workflow for the lint job

The lint job happens only once during the workflow run, regardless of how many environments the workflow deploys to. So, you don't really need to use a called workflow for the lint job. But to keep your main workflow definition file simple and easy to read, you decide to define the lint job in a separate workflow file.

1. In Visual Studio Code, create a new file in the *.github/workflows* folder named *lint.yml*.

   :::image type="content" source="../media/5-visual-studio-code-lint-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the dot github and workflows folders and the lint dot Y M L file.":::

1. Paste the following workflow definition into the file:

   :::code language="yaml" source="code/5-lint.yml" :::

   The lint job is the same as the lint job already in the workflow, but now it's in a separate workflow file.

1. Close the file and save your changes.

## Add a reusable workflow for deployment

Create a reusable workflow that defines all of the jobs required to deploy each of your environments. You'll use inputs and secrets to specify the settings that might differ between environments.

1. Create a new file in the *.github/workflows* folder named *deploy.yml*.

   :::image type="content" source="../media/5-visual-studio-code-deploy-yml-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the dot github and workflows folders and the deploy dot Y M L file.":::

   This file will represent all of the deployment activities that run for each of your environments.

1. Paste the following workflow name, trigger, inputs, and secrets into the file:

   :::code language="yaml" source="code/5-deploy.yml" range="1-18" :::

   > [!NOTE]
   > When you start to work with your YAML file in Visual Studio Code, you might see some red squiggly lines telling you there's a problem. This is because the Visual Studio Code extension for YAML files sometimes incorrectly guesses the file's schema.
   >
   > You can ignore the problems that the extension reports. Or if you prefer, you can add the following code to the top of the file to suppress the extension's guessing:
   >
   > ```yaml
   > # yaml-language-server: $schema=./deploy.yml
   > ```

1. Below the secrets, paste the definition of the validation job:

   :::code language="yaml" source="code/5-deploy.yml" range="20-50" :::

   Notice that a condition is applied to the jobs. The preflight validation runs only for non-production environments. The what-if operation runs only for the production environment. In the previous module in the learning path, you used separate jobs for these operations, but here you combine them to simplify the workflow.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

1. Below the validation job, paste the definition of the deploy job:

   :::code language="yaml" source="code/5-deploy.yml" range="52-75" :::

1. Below the deploy job, paste the definition of the smoke test job:

   :::code language="yaml" source="code/5-deploy.yml" range="77-90" :::

1. Verify that your *deploy.yml* file now looks like the following example:

   :::code language="yaml" source="code/5-deploy.yml" :::

1. Save your changes to the file.

## Update the workflow definition to use the templates

1. Open the *workflow.yml* file in the *.github/workflows* folder.

1. Remove the contents of the `env:` section, including the two environment variables. You'll replace these with environment-specific variables soon.

1. Remove the contents of the `lint:` job definition and replace it with the following code to use the *lint.yml* file you created earlier:

   :::code language="yaml" source="code/5-workflow.yml" range="14-18" highlight="5" :::

1. Delete everything in the file below the lint job that you just updated.

1. At the bottom of the file, add the following code to deploy to the test environment:

   :::code language="yaml" source="code/5-workflow.yml" range="20-30" :::

1. Below the code you just added, add the following code to deploy to the production environment:

   :::code language="yaml" source="code/5-workflow.yml" range="32-42" :::

   Now, the workflow runs the lint job once. Then it uses the *deploy.yml* called workflow twice: once per environment. This keeps the workflow definition clear and easy to understand. Also, the comments help explain what's happening.

1. Verify that your *workflow.yml* file looks like the following:

   :::code language="yaml" source="code/5-workflow.yml" :::

1. Save your changes.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add reusable workflows"
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You may need to sign in to GitHub again. Select **Authorize**.

## View the workflow run

1. In your browser, go to **Actions**.

   The first run of your workflow, labeled *Initial commit*, is shown as a failure. GitHub automatically ran the workflow when you created the repository. It failed because the secrets weren't ready at that time. You can ignore this failure.

1. Select the **deploy-toy-website-environments** workflow.

1. Select the most recent run of your workflow.

   Notice that the workflow run now shows all the jobs that you defined in the YAML files.

   Some warnings are listed in the **Annotations** panel. All of these warnings are because of the way Bicep writes informational messages to the workflow log. You can ignore these warnings.

1. Wait for the workflow to pause before the **deploy-production / deploy** job. It might take a few minutes for the workflow to reach this point.

   :::image type="content" source="../media/5-waiting-approval.png" alt-text="Screenshot of GitHub that shows the workflow run paused for approval.":::

1. Approve the deployment to the production environment by selecting the **Review deployments** button.

1. Select the **Production** environment, then select the **Approve and deploy** button.

   :::image type="content" source="../media/5-approve.png" alt-text="Screenshot of the GitHub interface that shows the workflow approval page and the Approve and deploy button.":::

   Wait for the workflow to finish running. The workflow completes successfully.

1. Select **Code**.

1. Select the **Production** environment.

   :::image type="content" source="../media/5-code-environment.png" alt-text="Screenshot of GitHub that shows the Code page environment, with the production environment highlighted.":::

1. Notice that on the deployment screen, you see an overview of the production environment's deployment history.

   :::image type="content" source="../media/5-environment-production.png" alt-text="Screenshot of GitHub that shows the production environment, with the deployment history showing a single deployment.":::

1. Select the commit identifier.

   Notice that GitHub shows you the list of commits included in the deployment. This helps you to see exactly what has changed in your environment over time.

   :::image type="content" source="../media/5-environment-commits.png" alt-text="Screenshot of GitHub that shows the production environment's deployment details, with a list of commits.":::

1. In your browser, go to the [Azure portal](https://portal.azure.com?azure-portal=true). 

1. Go to the **ToyWebsiteProduction** resource group.

1. In the list of resources, open the Azure App Service app.

   :::image type="content" source="../media/5-app-service-production.png" alt-text="Screenshot of the Azure portal that shows the production App Service app and the App Service plan SKU details.":::

   Notice that the type of App Service plan is **S1**.

1. Go to the App Service app in the **ToyWebsiteTest** resource group.

   Notice that the type of App Service plan is **F1**. The two environments use different settings, as you defined in your Bicep file.
