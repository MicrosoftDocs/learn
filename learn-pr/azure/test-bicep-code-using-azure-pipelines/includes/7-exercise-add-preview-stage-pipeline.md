You want to add an extra stage to your pipeline so you can check what changes will be made to your Azure environment. During the process you will: 

During the process, you'll: 

> [!div class="checklist"]
> * Add an environment to Azure Pipelines.
> * Configure the environment to require an approval.
> * Update the pipeline YAML file to add a new preview stage.
> * View the what-if results and approve a pipeline run.

## Add an environment

1. In your browser, navigate to **Pipelines** > **Environments**.

   :::image type="content" source="../media/7-environments.png" alt-text="Screenshot of the Azure DevOps interface showing the Pipelines menu, with the Environments item highlighted.":::

1. Select **Create environment**.

   :::image type="content" source="../media/7-environments-new.png" alt-text="Screenshot of the Azure DevOps interface showing the Environments page, with the 'Create environment' button highlighted.":::

1. Enter the environment name **Website**.

   Don't enter a description. For the **Resource**, select **None**.

   :::image type="content" source="../media/7-environments-new-details.png" alt-text="Screenshot of the Azure DevOps 'New environment' page with the details completed and the 'Create' button highlighted.":::

   > [!NOTE]
   > In Azure Pipelines, environments are used to enable a number of deployment features. These only apply when you're deploying to Kubernetes or to virtual machines. In this module, we don't use these features and you can ignore them.

1. Select **Create**.

## Add an approval check to the environment

1. Near the top-right of the page, select the button with three dots and select **Approvals and checks** from the popup menu.

   :::image type="content" source="../media/7-add-check.png" alt-text="Screenshot of the Azure DevOps interface showing the Website environment, with the three dots button highlighted.":::

1. Select **Approvals**.

   :::image type="content" source="../media/7-add-check-approval.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Add check' page, with the 'Approvals' item highlighted.":::

1. Select yourself in the **Approvers** textbox.

   :::image type="content" source="../media/7-add-check-approval-details.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Add approval check' page, with the details completed and the 'Create' button highlighted.":::

1. Select the down arrow button next to **Advanced**.

   Notice that, by default, approvers are allowed to approve the runs they've triggered. Leave this checkbox selected.

1. Select **Create**.

## Update the pipeline definition to add a preview stage

1. In Visual Studio Code, open the *deploy/azure-pipelines.yaml* file.

1. Between the **Validate** and **Deploy** stages, add the following definition for the **Preview** stage:

   :::code language="yaml" source="code/7-pipeline.yml" range="39-55" :::

## Update the pipeline definition to require an environment and approval

Here, you configure the **Deploy** stage to run against the **Website** environment you created previously. You convert the **Deploy** stage to run a deployment job instead of a standard job, and configure it to deploy to the environment.

1. Update the **Deploy** stage definition to the following:

   :::code language="yaml" source="code/7-pipeline.yml" range="59-79" :::

   > [!NOTE]
   > Notice that you define a new `checkout` step. Unlike normal jobs, deployment jobs need to be configured to check out (download) the files from your Git repository. If you don't do this, the deployment job won't be able to read your Bicep file.

1. Save the file.

## Verify and commit your pipeline definition

1. Verify that your *azure-pipelines.yml* file looks like the following:

   :::code language="yaml" source="code/7-pipeline.yml" highlight="39-55, 59-79" :::

   If it doesn't, update it to match this example, then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add preview stage"
   git push
   ```

## Run the pipeline and review the what-if outputs

1. In your browser, navigate to your pipeline.

1. Select the most recent run of your pipeline.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that pipeline prompts you to approve the pipeline. You also receive an email informing you that the pipeline needs your approval.

1. Select the **Preview** stage.

1. Select the **Run what-if** step to inspect the changes that the what-if command reports on.

1. Notice that the pipeline log provides what-if results similar to the following:

   :::code language="output" source="code/7-what-if-output.txt" :::

   The what-if operation has detected a change to the website resource. However, the changes it's detected are called *noise*. They don't represent real changes to your resource. Over time, the Azure team works to reduce the noise. In the meantime, for these two specific properties, you can ignore the detected changes.

   > [!NOTE]
   > You might also see an item in the what-if output for the resource type `microsoft.alertsmanagement/smartDetectorAlertRules/Failure Anomalies - toywebsite`. This is a resource that's automatically created by Application Insights. The what-if command detects no change will be made to the resource.

## Approve the pipeline run

1. Select the left arrow to return to the pipeline run details.

1. Select the **Review** button.

1. In the **Comment** field, enter *Reviewed what-if results*.

1. Select **Approve**.

## Observe the successful deployment

1. After you've approved the pipeline run, notice the **Deploy** stage starts running.

   Wait for the stage to complete.

1. Notice that the pipeline run completes successfully.
