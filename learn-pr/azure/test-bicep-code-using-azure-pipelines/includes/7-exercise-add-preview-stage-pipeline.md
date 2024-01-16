You want to add an extra stage to your pipeline so you can check what changes will be made to your Azure environment.

During the process, you'll:

> [!div class="checklist"]
> - Update the pipeline YAML file to add a new preview stage.
> - Add an environment to Azure Pipelines.
> - Configure the environment to require an approval.
> - Update the pipeline YAML file to use the environment for the deployment stage.
> - View the what-if results and approve a pipeline run.

## Update the pipeline definition to add a preview stage

Here, you'll add a new stage to your pipeline that runs the what-if operation.

1. In Visual Studio Code, open the _azure-pipelines.yml_ file in the _deploy_ folder.

1. Between the **Validate** and **Deploy** stages, add the following definition for the **Preview** stage:

   :::code language="yaml" source="code/7-pipeline.yml" range="43-59" :::

1. Save your changes to the file.

## Add an environment

1. In your browser, go to **Pipelines** > **Environments**.

   :::image type="content" source="../media/7-environments.png" alt-text="Screenshot of the Azure DevOps interface that shows the Pipelines menu, with the Environments item highlighted.":::

1. Select **Create environment**.

   :::image type="content" source="../media/7-environments-new.png" alt-text="Screenshot of the Azure DevOps interface that shows the Environments page, with the button for creating an environment highlighted.":::

1. Enter **Website** as the environment name.

   Leave the description blank. For **Resource**, select **None**.

   > [!NOTE]
   > In Azure Pipelines, environments are used to enable deployment features. Some of these features apply only when you're deploying to Kubernetes or to virtual machines. In this module, we don't use these features and you can ignore them.

1. Select **Create**.

   :::image type="content" source="../media/7-environments-new-details.png" alt-text="Screenshot of the Azure DevOps page for a new environment, with the details completed and the Create button highlighted.":::

## Add an approval check to the environment

1. Select the **Approvals and checks** tab at the top-left of the screen.

   :::image type="content" source="../media/7-add-check.png" alt-text="Screenshot of the Azure DevOps interface that shows the Website environment, with the Approvals and checks tab highlighted.":::

1. Select **Approvals**.

   :::image type="content" source="../media/7-add-check-approval.png" alt-text="Screenshot of the Azure DevOps interface that shows the page for adding a check, with the Approvals item highlighted.":::

1. In the **Approvers** text box, type your own name and select yourself.

1. Select the arrow button next to **Advanced**.

   Notice that, by default, approvers are allowed to approve the runs that they've triggered. Because you're the only person who will work with this pipeline, leave this checkbox selected.

1. Select **Create**.

   :::image type="content" source="../media/7-add-check-approval-details.png" alt-text="Screenshot of the Azure DevOps interface that shows the page for adding an approval check, with the details completed and the Create button highlighted.":::

## Update the pipeline definition to require an environment and approval

Here, you'll configure the **Deploy** stage to run against the **Website** environment that you created previously. You'll convert the **Deploy** stage to run a deployment job instead of a standard job and configure it to deploy to the environment.

1. In the _azure-pipelines.yml_ file in Visual Studio Code, replace the **Deploy** stage definition with the following code:

   :::code language="yaml" source="code/7-pipeline.yml" range="61-82" :::

   Notice that you defined a new `checkout` step. Unlike normal jobs, deployment jobs need to be configured to check out (download) the files from your Git repository. If you don't do this step, the deployment job won't be able to read your Bicep file. You could instead consider using _pipeline artifacts_ to send files between pipeline stages. We link to more information about artifacts in the summary.

1. Save the file.

## Verify and commit your pipeline definition

1. Verify that your _azure-pipelines.yml_ file looks like the following code:

   :::code language="yaml" source="code/7-pipeline.yml" highlight="43-59, 61-83" :::

   If it doesn't, update it to match this example, then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add preview stage"
   git push
   ```

## Run the pipeline and review the what-if outputs

1. In your browser, go to your pipeline.

1. Select the most recent run of your pipeline.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. Although Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. If you're asked to grant permission to access a resource, select **View** and then select **Permit**.

1. Notice that Azure Pipelines prompts you for an approval. You also receive an email informing you that the pipeline needs your approval.

   :::image type="content" source="../media/7-pipeline-run-approval-required.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline run, with the approval requirement highlighted.":::

   Before you approve the continuation of the pipeline, you'll review the what-if results to ensure that they match your expectations.

1. Select the **Preview** stage.

1. Select the **Run what-if** step to inspect the changes that the what-if command reports on.

1. Notice that the pipeline log provides what-if results similar to the following code:

   :::code language="output" source="code/7-what-if-output.txt" :::

   The what-if operation has detected a change to the website resource. However, the changes that it has detected are noise. They don't represent real changes to your resource. Over time, the Azure team works to reduce noise. In the meantime, for these two specific properties, you can ignore the detected changes.

   You might also see an item in the what-if output for the resource type `microsoft.alertsmanagement/smartDetectorAlertRules/Failure Anomalies - toywebsite`. Application Insights creates this resource automatically. The what-if command detects that no change will be made to the resource.

## Approve the pipeline run

1. Select the left arrow to return to the details for the pipeline run.

   :::image type="content" source="../media/7-pipeline-run-log-back.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline log menu, with the back arrow highlighted.":::

1. Select the **Review** button on the approval panel.

1. In the **Comment** box, enter **Reviewed what-if results**.

1. Select **Approve**.

   :::image type="content" source="../media/7-pipeline-run-approve.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline approval page, with the Approve button highlighted.":::

## Observe the successful deployment

1. After you've approved the pipeline run, notice that the **Deploy** stage starts running.

   Wait for the stage to finish.

1. Notice that the pipeline run finishes successfully.
