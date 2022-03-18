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

<!-- TODO do we need to add an extra status check? -->

## Update the pull request workflow to deploy an ephemeral environment

As a first step, you need to update your *pr-validation* workflow to create an ephemeral environment.

1. In the Visual Studio Code terminal, check out the main branch of the repository.

   ```bash
   git checkout main
   ```

1. Open the *.github/workflows/pr-validation.yml* file.

1. Near the top of the file, under the `on` section that defines triggers, add an environment variable named `resourceGroupLocation`:

   :::code language="yaml" source="code/6-pr-validation.yml" range="1-6" highlight="5-6" :::

   All Azure resource groups need to be created in an Azure region. You'll use this environment variable to deploy all of your ephemeral environments into the West US 3 region.

1. Add the following job at the bottom of the file:

   :::code language="yaml" source="code/6-pr-validation.yml" range="12-19" :::

   The steps in this job first checks out all the code onto the GitHub runner, and then signs into your Azure environment.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

1. At the bottom of the file, add another step to determine the name of the resource group to create:

   :::code language="yaml" source="code/6-pr-validation.yml" range="20-26" :::

   > [!NOTE]
   > The `github.ref` variable's value looks like `refs/pull/123/merge`. The script above splits the string up based on the slash (`/`) characters, and then finds the segment that contains the pull request number, like `123`. The script then creates a resource group name that includes the pull request number, and finally it creates a step output so that subsequent steps can access the resource group name.
   <!-- TODO does this work instead? pull_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH") -->

1. As a next step in the file add the step to create the resource group with the name determined in the previous step:

   :::code language="yaml" source="code/6-pr-validation.yml" range="27-33" :::

1. Now that the resource group is created, add a step to deploy the Bicep file to the resource group:

   :::code language="yaml" source="code/6-pr-validation.yml" range="34-43" :::

1. Save your changes.

1. Verify that your *pr-validation.yml* file looks like the following:
   
   :::code language="yaml" source="code/6-pr-validation.yml" :::

   If it doesn't, update it to match this example, and then save it.

1. In the Visual Studio Code terminal, commit your changes. You won't push them to the remote repository just yet.

   ```bash
   git add .
   git commit -m "Update pull request validation workflow to deploy an ephemeral environment"
   ```

## Add a pull request deletion workflow

You've created a workflow that automatically deploys the changes in each pull request to an ephemeral resource group. Now, you'll configure a second workflow to delete the ephemeral environments when they're no longer needed.

1. Create a new file named *pr-closed.yml* in the *.github/workflows* folder.

1. At the top of the file, name the workflow and configure it to run whenever a pull request is closed:

   :::code language="yaml" source="code/6-pr-closed.yml" range="1-5" :::

1. Add a new job named **remove**, and configure it to sign in to Azure:

   :::code language="yaml" source="code/6-pr-closed.yml" range="7-14" :::

1. Similarly to the pull request validation workflow, define a step to determine the name of the resource group associated with this pull request:

   :::code language="yaml" source="code/6-pr-closed.yml" range="15-21" :::

   > [!NOTE]
   > Notice that for branch deletion we use the `${{ github.head_ref}}` context variable. On pull request closure, this variable has the value of *feature/name*. We use this to delete the resource group in the last step. 
   <!-- TODO can we use PR ID from above? -->

1. Add a step to delete the resource group by using the Azure CLI, and confirm the deletion by using the `--yes` argument:

   :::code language="yaml" source="code/6-pr-closed.yml" range="22-28" :::

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

1. In your browser, navigate to the *change2* branch.

1. Select *Contribute* and *Open pull request* to open a new pull request.

1. Leave all the defaults and select *Create pull request*.

## Watch the ephemeral environment get created

1. In your browser, navigate to **Actions**.

1. You should see your new workflow started running.

   > [!NOTE]
   > It might be that you need to give it some time for the workflow to start running. Refresh your browser window until you see the workflow started running.

1. Select the running workflow to go to its detail.

1. Select the **deploy** stage to see its detail.

1. Select the **create resource group name** step to see its detail. In the log output you will notice that a resource group named **rg*f*4** will be created.

1. In your browser, navigate to the Azure portal.

1. In the top search bar, search for the **rg*f*4** resource group and select the resource group to open it.

1. In the resource group detail you will see the resources from the Bicep file got created.

## Approve the PR

You have now created a pull request that as a next step can be merged into the main branch.

1. Select **Merge pull request**. This will merge the feature4 branch into main.

1. Select **Confirm merge**.

## Watch the ephemeral environment be deleted

Closing the pull request also triggered the *delete*feature*rg* workflow.

1. In the browser, navigate to **Actions**.

1. You should notice the delete workflow got triggered.

1. Select the workflow and inspect the output.

1. Navigate to the Azure portal and refresh the **Resource group overview**. After a while you will see that the **rg*f*4** resource group got deleted.
