You want to add an extra stage to your pipeline so you can check what changes will be made to your Azure environment. During the process you will: 

During the process, you'll: 

> [!div class="checklist"]
> * Add an environment to Azure Pipelines.
> * Configure the environment to require an approval.
> * Update the pipeline YAML file to add a new preview stage.
> * View the what-if results and approve a pipeline run.

## Add an environment

1. In your browser, navigate to **Pipelines** > **Environments**.

1. Select **New environment**.

1. Enter the environment name **Website**.

   Don't enter a description. For the **Resource**, select **None**.

   > [!NOTE]
   > TODO explain what the other resource types mean

1. Select **Create**.

## Add an approval check to the environment

1. Near the top-right of the page, select the button with three dots and select **Approvals and checks** from the popup menu.

   :::image type="content" source="../media/6-three-dots.png" alt-text="Screenshot of the Azure DevOps interface, Environments detail screen, with the three dots button and Approvals and checks menu item highlighted." border="false":::

1. Select **Approvals**.

   :::image type="content" source="../media/6-approvals-and-checks.png" alt-text="Screenshot of the Azure DevOps interface, Approvals and checks screen, with the Approvals option highlighted." border="false":::

1. Enter own user name in the **Approvers** textbox.

1. Select the down arrow button next to **Advanced**.

   Notice that, by default, approvers are allowed to approve the runs they've triggered. Leave this checkbox selected.

   :::image type="content" source="../media/6-Approvals.png" alt-text="Screenshot of the Azure DevOps interface, Approvals flyout, with the Approvers textbox, the Advanced dropdown and the Allow approvers to approve their own runs checkbox highlighted." border="false":::

1. Select **Create**.

   :::image type="content" source="../media/6-Approval-create.png" alt-text="Screenshot of the Azure DevOps interface, Approvers flyout, with the Create button highlighted." border="false":::

## Update the pipeline definition to add a preview stage

1. In Visual Studio Code, open the *deploy/azure-pipelines.yaml* file.

1. Between the **Validate** and **Deploy** stages, add the following definition for the **Preview** stage:

   :::code language="yaml" source="code/7-pipeline.yml" range="34-48" :::

## Update the pipeline definition to require an environment and approval

Here, you configure the **Deploy** stage to run against the **Website** environment you created previously. You convert the **Deploy** stage to run a deployment job instead of a standard job, and configure it to deploy to the environment.

1. Update the **Deploy** stage definition to the following:

   :::code language="yaml" source="code/7-pipeline.yml" range="50-70" :::

   > [!NOTE]
   > TODO note the checkout step

1. Save the file.

## Verify and commit your pipeline definition

1. Verify that your *azure-pipelines.yml* file looks like the following:

   :::code language="yaml" source="code/7-pipeline.yml" highlight="34-48, 52-70" :::

   If it doesn't, update it to match this example, then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add preview stage"
   git push
   ```

## Run the pipeline and review the what-if outputs

1. In your browser, navigate to your pipeline runs. 

<!-- TODO here down -->

1. You will notice that your pipeline is now running multiple stages one after the other. At the **Deploy** stage execution will halt and a message will be shown asking you to **Review** the changes.  It might be that you need to refresh your page to see this message. You will also receive an email in your mailbox for this approval. 

   :::image type="content" source="../media/4-approve.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run screen, with the halted Deploy stage and the Review message highlighted." border="false":::

1. Select the **Preview** stage. 

   :::image type="content" source="../media/4-what-if.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run screen, with the WhatIf stage highlighted." border="false":::

1. Select the **Run what-if** step.

   Inspect the changes that the what-if command reports on. 

   :::image type="content" source="../media/4-what-if-checks.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run details screen, with the Run what-if checks section highlighted." border="false":::

   <!-- TODO note what the output means -->

## Approve the pipeline run

1. Navigate to the pipeline run details screen. 

   :::image type="content" source="../media/4-run-details.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run output screen, with the run details link highlighted." border="false":::

1. Select the **Review** button.

   :::image type="content" source="../media/4-review.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run details screen, with the Review button highlighted." border="false":::

1. Select **Approve**.

   :::image type="content" source="../media/4-approve.png" alt-text="Screenshot of the Azure DevOps interface, Approval flyout, with the Approve button highlighted." border="false":::

## Observe the successful deployment

1. After you've approved the pipeline run, notice the **Deploy** stage starting execution. Wait for the stage to complete.

   :::image type="content" source="../media/4-deploy.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run details screen, with the running Deploy stage highlighted." border="false":::

1. Notice that the pipeline run completes successfully.
