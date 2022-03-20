Your team has told you they appreciate getting the automated Bicep linter feedback on their code changes before they send them to other team members to review. Now, you've decided to give your contributors and reviewers the ability to deploy and review their code in an ephemeral environment.

In this exercise, you'll update your pull request workflow to deploy an ephemeral environment whenever a pull request is opened, redeploy it when code is pushed to the pull request branch, and delete the environment when the pull request is closed.

During the process, you'll:

> [!div class="checklist"]
> * Update the pull request workflow to deploy an ephemeral environment.
> * Create a PR deletion workflow to remove the ephemeral environment.
> * Create a pull request.
> * Watch the ephemeral environment get created.
> * Approve the PR.
> * Watch the ephemeral environment be deleted

## Update the pull request workflow to deploy an ephemeral environment

As a first step, you need to update your *pr-validation* workflow to create an ephemeral environment.

1. In the Visual Studio Code terminal, check out the main branch of the repository.

   ```bash
   git checkout main
   ```

1. Open the *.github/workflows/pr-validation.yml* file.

1. Near the top of the file, below the `name` setting, add a `concurrency` setting:

   :::code language="yaml" source="code/6-pr-validation.yml" range="1-2" highlight="2" :::

   This setting prevents multiple workflows for the same pull request from running at the same time, which might cause unpredictable results when you deploy resources to Azure.

1. Near the top of the file, under the `on` section that defines triggers, add two new environment variables:

   :::code language="yaml" source="code/6-pr-validation.yml" range="1-8" highlight="6-8" :::

   The `resourceGroupName` environment variable specifies the name of the resource group that should be used for each ephemeral environment. Each resource group will be named `pr_123`, where `123` is the unique pull request number.

   The `resourceGroupLocation` environment variable specifies that your ephemeral environments should all be deployed into the West US 3 Azure region.

1. Define a new job named `deploy`, below the `lint` job:

   :::code language="yaml" source="code/6-pr-validation.yml" range="10-21" highlight="5-12" :::

   The steps in this job first check out all the code onto the GitHub runner, and then sign into your Azure environment.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

1. Add a step to create the resource group with the name defined in the environment variable:

   :::code language="yaml" source="code/6-pr-validation.yml" range="22-28" :::

1. Now that the resource group is created, add a step to deploy the Bicep file to the resource group:

   :::code language="yaml" source="code/6-pr-validation.yml" range="29-38" :::

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

1. At the top of the file, name the workflow, configure the same concurrency key that you used in the pull request validation workflow, and configure the workflow to run whenever a pull request is closed:

   :::code language="yaml" source="code/6-pr-closed.yml" range="1-6" :::

1. Below the code you just entered, define an environment variable for the name of the resource group associated with the pull request's ephemeral environment:

   :::code language="yaml" source="code/6-pr-closed.yml" range="8-9" :::

   The resource group name is the same as the one you used for the pull request validation workflow.

1. Below the code you added, define a new job named **remove**, and configure it to sign in to Azure:

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

<!-- TODO here down -->

## Create a pull request

You've defined workflows to create and manage ephemeral environments automatically in pull requests. Now, you'll create another pull request to try it out.

1. In your browser, navigate to the *feature/container-app* branch.

1. Select *Contribute* and *Open pull request* to open a new pull request.

1. Leave all the defaults and select *Create pull request*.

## Watch the ephemeral environment get created

1. In your browser, navigate to **Actions**.

1. You should see your new workflow started running.

   > [!NOTE]
   > It might be that you need to give it some time for the workflow to start running. Refresh your browser window until you see the workflow started running.

1. Select the running workflow to go to its detail.

1. Select the **deploy** stage to see its detail.

1. Select the **create resource group name** step to see its detail. In the log output you'll notice that a resource group named **pr_4** will be created.

1. In your browser, navigate to the Azure portal.

1. In the top search bar, search for the **pr_4** resource group and select the resource group to open it.

1. In the resource group detail you'll see the resources from the Bicep file got created.

   > [!NOTE]
   > As an additional step you might also make the *deploy* job mandatory before a pull request can be merged by adding this as an additional status check to the protected main branch. You do this in exactly the same way as the previous lint mandatory check you added in the previous exercise. We will leave it to you whether you want to add this extra check or not.

## Approve the PR

You have now created a pull request that as a next step can be merged into the main branch.

1. Select **Merge pull request**. This will merge the *feature/container-app* branch into *main*.

1. Select **Confirm merge**.

## Watch the ephemeral environment be deleted

Closing the pull request also triggered the *pr-closed* workflow.

1. In the browser, navigate to **Actions**.

1. You should notice the *pr-closed* workflow got triggered.

1. Select the workflow and inspect the output.

1. Navigate to the Azure portal and refresh the **Resource group overview**. After a while you'll see that the **pr_4** resource group got deleted.
