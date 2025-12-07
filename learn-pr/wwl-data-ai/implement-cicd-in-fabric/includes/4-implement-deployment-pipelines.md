Pipelines enable a continuous integration/continuous deployment (CI/CD) approach that ensures content is updated, tested, and regularly refreshed. Pipelines are a way to automate the movement of content through the development, test, and production stages of the content development lifecycle.

## What are deployment pipelines?

Fabric deployment pipelines help you deploy your Fabric items across different environments like development, test, and production. They let you develop and test content in Fabric before it reaches end users.

## Create a deployment pipeline 
Deployment pipelines can be created using two different methods:
- Using the **Workspaces** icon on the left navigation pane in Fabric.
- Using the **Create deployment pipeline** icon at the top of a workspace

Follow these steps to create a deployment pipeline: 

1. Select the **Workspaces** icon on the left navigation pane, then **Deployment pipelines.**

2. Select **New pipeline**. Then name the pipeline and select **Next**.
3. Define, and name the stages in your pipeline. Then select **Create and continue.**

    :::image type="content" source="../media/create-stages.png" alt-text="Screenshot of pipeline stage selector." :::
4. Assign a workspace to a stage. Then select the green check mark next to the stage. Then you're ready to deploy content to the pipeline.

    :::image type="content" source="../media/assign-workspace.png" alt-text="Screenshot of workspace assignment interface." :::

## Deploy content to a pipeline stage
The deployment process lets you clone content from one stage in the pipeline to another, typically from development to test, and from test to production.

To deploy content between stages, select the stage to deploy to, and then select the stage in the **Deploy from** drop-down box, and then select the **Deploy** button. The deployment process copies all of the workspace content into the target stage. In the following image, there's a data pipeline that only exists in the development stage that will be moved to the test stage when **Deploy** is selected in the development stage.

:::image type="content" source="../media/deploy-content.png" alt-text="Screenshot of content deployment interface." :::

## Use deployment pipelines with Git
Deployment pipelines can be used with Git integration to maintain version control and automate deployments. There are different approaches to combining these tools, depending on your workflow needs.

One common approach is to connect only the Development workspace to Git. With this approach, Git integration is used for version control during development, while deployment pipelines handle the promotion of content to Test and Production environments. This avoids potential Git synchronization conflicts when deploying content across multiple stages.

To use deployment pipelines with Git using this approach:
1. Follow the instructions in the section on this page entitled "Create a deployment pipeline" to create a deployment pipeline and assign each stage to a workspace.
2. Connect the Development workspace to a Git repository and branch in **Git integration** in **Workspace settings**. 

    :::image type="content" source="../media/connect-git.png" alt-text="Screenshot of workspace to Git provider connection interface." :::

3. Make your content changes in the Development workspace and commit them to Git using the **Source control** panel.

4. Promote content between staging environments using the deploy button in the pipeline as described in the **Deploy content to a pipeline stage** section on this page. This moves content between environments in Fabric. The deployment pipeline copies content from Development to Test and Production workspaces.

    In the image below, the checkmark in the deployment stage box indicates that a data pipeline item exists in all three staging environments of the deployment pipeline *in Fabric* and that the Fabric stages are synchronized.

    :::image type="content" source="../media/pipeline-presync.png" alt-text="Screenshot of deployment pipeline with synchronized stages." :::

> [!TIP]
> For more information about different CI/CD workflow options in Fabric, including alternative approaches for combining Git integration with deployment pipelines, see [Choose the best Fabric CI/CD workflow option for you](/fabric/cicd/manage-deployment?azure-portal=true).
