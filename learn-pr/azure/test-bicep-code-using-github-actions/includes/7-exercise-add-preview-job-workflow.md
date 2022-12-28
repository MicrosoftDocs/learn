You want to add an extra job to your workflow so you can check what changes will be made to your Azure environment.

During the process, you'll do the following tasks:

> [!div class="checklist"]
>
> - Update the workflow YAML file to add a new preview job.
> - Add an environment to your GitHub repository.
> - Configure the environment to require a review.
> - Update the workflow YAML file to use the environment for the deployment job.
> - View the what-if results and approve a workflow run.

## Update the workflow definition to add a preview job

Here, you add a new job to your workflow that runs the what-if operation.

1. In Visual Studio Code, open the _workflow.yml_ file in the _.github/workflows_ folder.

1. Between the **validate** and **deploy** jobs, add the following definition for the **preview** job:

   :::code language="yaml" source="code/7-workflow.yml" range="44-63" :::

   Notice that the **preview** job depends on the successful completion of the **validate** and **lint** jobs.

1. Update the **deploy** job to make it depend on the **preview** job:

   :::code language="yaml" source="code/7-workflow.yml" range="65-66, 68-84" highlight="3" :::

1. Save your changes to the file.

## Add an environment

1. In your browser, go to **Settings** > **Environments**.

1. Select **New environment**.

   :::image type="content" source="../media/7-environments-new.png" alt-text="Screenshot of the GitHub interface that shows the Environments page, with the button for creating an environment highlighted.":::

1. Enter **Website** as the environment name.

1. Select **Configure environment**.

   :::image type="content" source="../media/7-environments-new-details.png" alt-text="Screenshot of the GitHub page for a new environment, with the details completed and the Configure environment button highlighted.":::

In the setup steps for this module, you already created a federated credential for your workflow to use when it deploys to the environment.

## Add required reviewer protection rule to the environment

1. Select the **Required reviewers** box.

1. Add your own GitHub username to the reviewer list.

   :::image type="content" source="../media/7-add-reviewers.png" alt-text="Screenshot of the GitHub interface that shows the Website environment, with the required reviewers checkbox and textbox highlighted.":::

1. Select **Save protection rules**.
1. Select **Environments** to exit the configuration.

## Update the workflow definition to require an environment and reviewer

Here, you configure the **deploy** job to run against the **Website** environment that you created previously.

1. Open the _workflow.yml_ file in Visual Studio Code.

1. Add the `environment` parameter to the **deploy** job. Set the value to `Website`, to match the name of the environment you created:

   :::code language="yaml" source="code/7-workflow.yml" range="65-84" highlight="3" :::

1. Save the file.

## Verify and commit your workflow definition

1. Verify that your _workflow.yml_ file looks like the following code:

   :::code language="yaml" source="code/7-workflow.yml" highlight="44-63, 67-68" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add preview job"
   git push
   ```

## Run the workflow and review the what-if outputs

1. In your browser, go to your workflow runs.

1. Select the most recent run of your workflow.

   Wait until the workflow completes the **lint**, **validate**, and **preview** jobs. Although GitHub automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that the workflow prompts you for a review. Dependent upon how you've set up your GitHub account, you'll receive an email or web notification with a request to review the workflow.

   :::image type="content" source="../media/7-workflow-run-review-required.png" alt-text="Screenshot of the GitHub interface that shows the workflow run, with the review requirement highlighted.":::

   Before you approve the continuation of the workflow, you'll review the what-if results to ensure that they match your expectations.

1. Select the **preview** job.

1. Select the **Run what-if** step to inspect the changes that the what-if command reports on.

1. Notice that the workflow log provides what-if results similar to the following code:

   :::code language="output" source="code/7-what-if-output.txt" :::

   The what-if operation has detected a change to the log analytics workspace and website resources. However, the changes that it has detected are noise. They don't represent real changes to your resource. Over time, the Azure team works to reduce noise. In the meantime, you can ignore the detected changes.

   You might also see an item in the what-if output for the resource type `microsoft.alertsmanagement/smartDetectorAlertRules/Failure Anomalies - toywebsite`. This is a resource that Application Insights creates automatically. The what-if command detects that no change will be made to the resource.

## Approve the workflow run

1. Select the Summary to return to the overview for the workflow run.

   :::image type="content" source="../media/7-workflow-run-log-summary.png" alt-text="Screenshot of the GitHub interface that shows the Summary menu, with the back arrow highlighted.":::

1. Select the **Review deployments** button on the review panel.

1. In the **Review pending deployments** pop-up, select the **Website** environment. In the **Leave a comment** box, enter _Reviewed what-if results_.

1. Select **Approve and deploy**.

   :::image type="content" source="../media/7-workflow-run-approve.png" alt-text="Screenshot of the GitHub interface that shows the workflow approval page, with the Approve button highlighted.":::

## Observe the successful deployment

1. After you've approved the workflow run, notice that the **deploy** job starts running.

   Wait for the job to finish.

1. Notice that the workflow run finishes successfully.
