Some team members have told you they appreciate getting the automated Bicep linter feedback on their code changes before they send them to other team members to review. Now, you've decided to give your contributors and reviewers the ability to deploy and review their code in an ephemeral environment.

In this exercise, you'll update your pull request workflow to deploy an ephemeral environment whenever a pull request is opened, and redeploy it when code is pushed to the pull request branch. You'll also create another workflow to automatically delete the environment when the pull request is closed. You'll test your changes by creating a pull request for your website to use a Docker container image.

During the process, you'll:

> [!div class="checklist"]
> * Update the pull request workflow to deploy an ephemeral environment.
> * Create a pull request deletion workflow to delete the ephemeral environment.
> * Create a pull request and watch the ephemeral environment get created.
> * Approve the pull request and watch the ephemeral environment get deleted.

## Update the pull request workflow to deploy an ephemeral environment

To begin, you need to update your *pr-validation* workflow to create an ephemeral environment.

1. In the Visual Studio Code terminal, check out the main branch of the repository.

   ```bash
   git checkout main
   ```

1. Pull the latest version of the code from GitHub, which includes the changes you merged in an earlier exercise.

   ```bash
   git pull
   ```

1. Open the *.github/workflows/pr-validation.yml* file in Visual Studio Code.

1. Near the top of the file, below the `name` setting, add a `concurrency` setting:

   :::code language="yaml" source="code/6-pr-validation.yml" range="1-2" highlight="2" :::

   This setting prevents multiple workflows for the same pull request from running at the same time, which might cause unpredictable results when you deploy resources to Azure.

1. Near the top of the file, under the `on` section that defines the trigger, add two new environment variables:

   :::code language="yaml" source="code/6-pr-validation.yml" range="1-8" highlight="6-8" :::

   The `resourceGroupName` environment variable specifies the name of the resource group that should be used for each ephemeral environment. Each resource group will be named `pr_123`, where `123` is the unique pull request number.

   The `resourceGroupLocation` environment variable specifies that your ephemeral environments should all be deployed into the West US 3 Azure region.

1. Define a new job named `deploy`, below the `lint` job:

   :::code language="yaml" source="code/6-pr-validation.yml" range="10-21" highlight="5-12" :::

   The job first checks out all the code onto the GitHub runner, and then signs in to your Azure environment.

   > [!NOTE]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

1. Add a step to create the resource group with the name defined in the environment variable:

   :::code language="yaml" source="code/6-pr-validation.yml" range="22-28" :::

1. After the resource group creation step, add a step to deploy the Bicep file to the resource group:

   :::code language="yaml" source="code/6-pr-validation.yml" range="29-38" :::

1. After the deployment step, add a step to display the ephemeral environment's website address in the workflow log:

   :::code language="yaml" source="code/6-pr-validation.yml" range="39-41" :::

1. Save your changes.

1. Verify that your *pr-validation.yml* file looks like the following:
   
   :::code language="yaml" source="code/6-pr-validation.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. In the Visual Studio Code terminal, commit your changes. You won't push them to the remote repository yet.

   ```bash
   git add .
   git commit -m "Update pull request validation workflow to deploy an ephemeral environment"
   ```

## Add a pull request deletion workflow

You've created a workflow that automatically deploys the changes in each pull request to an ephemeral resource group. Now, you'll configure a second workflow to delete the ephemeral environments when they're no longer needed.

1. Create a new file named *pr-closed.yml* in the *.github/workflows* folder.

   :::image type="content" source="../media/6-visual-studio-code-workflow.png" alt-text="Screenshot of Visual Studio Code that shows the P R closed dot Y M L file within the workflows folder.":::

1. At the top of the file, name the workflow, configure the same concurrency key that you used in the pull request validation workflow, and configure the workflow to run whenever a pull request is closed:

   :::code language="yaml" source="code/6-pr-closed.yml" range="1-6" :::

1. Below the code you just entered, define an environment variable for the name of the resource group that's associated with the pull request's ephemeral environment:

   :::code language="yaml" source="code/6-pr-closed.yml" range="8-9" :::

   The resource group name is the same as the one you used for the pull request validation workflow.

1. Below the code you added, define a new job named `remove`, and configure it to sign in to Azure:

   :::code language="yaml" source="code/6-pr-closed.yml" range="11-18" :::

1. Within the `remove` job, define a step to delete the resource group by using the Azure CLI, and confirm the deletion by using the `--yes` argument:

   :::code language="yaml" source="code/6-pr-closed.yml" range="19-25" :::

1. Save your changes.

1. Verify that your *pr-closed.yml* file looks like the following:
   
   :::code language="yaml" source="code/6-pr-closed.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. In the Visual Studio Code terminal, commit your changes and push them to the remote repository:

   ```bash
   git add .
   git commit -m 'Add pull request closed workflow'
   git push
   ```

## Update the Bicep file

Next, update your Bicep file to use a Docker container image for your website's application.

1. In the Visual Studio Code terminal, create a new branch for your changes by running the following command:

   ```bash
   git checkout -b feature/container-app
   ```

1. Open the *main.bicep* file in the *deploy* folder.

1. Update the value of the `appServiceAppLinuxFrameworkVersion` variable:

   :::code language="bicep" source="code/6-main.bicep" range="20" :::

1. Save your changes.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Use container image for website"
   git push origin feature/container-app
   ```

## Create a pull request

You've defined workflows to create and manage ephemeral environments automatically in pull requests. Now, you'll create another pull request for your Bicep changes.

1. In your browser, select **Code**, and then select **3 branches**.

   :::image type="content" source="../media/6-branches.png" alt-text="Screenshot of GitHub that shows the repository's branch list.":::

1. Under **Your branches**, next to **feature/container-app**, select **New pull request**.

   :::image type="content" source="../media/6-create-pull-request.png" alt-text="Screenshot of GitHub that shows the link to create a pull request for the feature slash container app branch.":::

1. Select **Create pull request**.

## Watch the ephemeral environment get created

1. On the pull request details page, wait for the status check items to appear.

1. In the list, next to the **deploy** job, select **Details**.

   :::image type="content" source="../media/6-deploy-details.png" alt-text="Screenshot of the GitHub pull request that shows the status check items. The 'Details' link for the 'deploy' job is highlighted.":::

   Wait for the deployment to finish.

1. Select **Show website hostname**.

1. Select the URL in the log.

   :::image type="content" source="../media/6-website-address.png" alt-text="Screenshot of the GitHub Actions deployment log. The website U R L in the 'Show website hostname' step is highlighted.":::

   The website loads. It displays a message, *Hello Docker!*, which indicates that the website is running from the container that's defined in the pull request change.

   :::image type="content" source="../media/6-website.png" alt-text="Screenshot of the website homepage after the deployment is complete.":::

1. Optionally, open the [Azure portal](https://portal.azure.com/azure-portal=true) and go to the ephemeral environment's resource group.

   Review the resources that were deployed.

## Merge the pull request

Now that you've tested the pull request, you can merge it into the *main* branch.

1. Select **Pull requests**, and select the **Use container image for website** pull request.

   :::image type="content" source="../media/6-reopen-pull-request.png" alt-text="Screenshot of GitHub showing the list of open pull requests in the repository.":::

   The status checks have passed.

   :::image type="content" source="../media/6-status-checks-passed.png" alt-text="Screenshot of the GitHub pull request showing that the two status checks have passed.":::

1. Select **Merge pull request**.

1. Select **Confirm merge**.

## Review the deletion of the resource group

1. In the browser, select **Actions** and then, on the left pane, select the **pr-closed** workflow.

   You can see that the workflow has been invoked automatically because a pull request was closed.

   :::image type="content" source="../media/6-pull-request-closed-workflow.png" alt-text="Screenshot of the GitHub Actions pane showing that the P R closed workflow is running.":::

1. Select the workflow to review the log.

   It might take a few minutes for the workflow to finish deleting the resource group in Azure.

   > [!IMPORTANT]
   > You don't need to wait for the workflow run to finish. But be sure to open the Azure portal later, both to verify that the ephemeral environment's resource group has been deleted successfully and to avoid incurring costs for the Azure resources.
