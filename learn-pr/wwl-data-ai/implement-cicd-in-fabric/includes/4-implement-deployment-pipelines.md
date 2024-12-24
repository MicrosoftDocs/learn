Pipelines enable a continuous integration/continuous deployment (CI/CD) approach that ensures content is updated, tested, and regularly refreshed. Pipelines are an efficient and durable way to automate the movement of content through the development, test, and production stages of the content development lifecycle.

## What is deployment pipelines

Fabric deployment pipelines help you deploy your Fabric items across different environments like development, test, and production. They let you develop and test content in Fabric before it reaches end users.

## Create a deployment pipeline 
Deployment pipelines can be created using two different methods:
- Using the **Workspaces** icon on the left navigation pane in Fabric.
- Using the **Create deployment pipeline** icon at the top of a workspace

Follow these steps to create a deployment pipeline: 

1. Select the **Workspaces** icon on the left navigation pane, then **Deployment pipelines.**

2. Select **New pipeline**. Then name the pipeline and select **Next**.
3. Define, and name the stages in your pipeline. Then select **Create.**

    :::image type="content" source="../media/create-stages.png" alt-text="Screenshot of pipeline stage selector." :::
4. Assign a workspace to a stage.  

    :::image type="content" source="../media/assign-workspace.png" alt-text="Screenshot of workspace assignment interface." :::
5. Now you're ready to deploy content to the pipeline.

    :::image type="content" source="../media/pipeline-setup.png" alt-text="Screenshot of pipeline without content." :::

## Deploy content to a pipeline stage
The deployment process lets you clone content from one stage in the pipeline to another, typically from development to test, and from test to production.

To deploy content between stages, select the stage to deploy from, and then select the **Deploy** button. The deployment process copies all of the workspace content into the target stage. In the following image, there's a data pipeline that only exists in the development stage that will be moved to the test stage when **Deploy** is selected in the development stage.

:::image type="content" source="../media/deploy-content.png" alt-text="Screenshot of content deployment interface." :::

## Use deployment pipelines with Git
Deployment pipelines can be used with Git branches. This would be used to promote content between development, test, and production environments when content for each environment resides in different Git repositories or branches. 

To use deployment pipelines with Git branches:
1. Follow the instructions in the section on this page entitled "Create a deployment pipeline" to create a deployment pipeline and assign each stage to a workspace.
2. Assign each workspace in the deployment pipeline to a Git repository and branch in **Git integration** in **Workspace settings**.

    :::image type="content" source="../media/connect-git.png" alt-text="Screenshot of workspace to Git provider connection interface." :::

3. Promote content between staging environments using the deploy button in the pipeline as described in the **Deploy content to a pipeline stage** section on this page. This moves content between environments in Fabric but the Git repository won't be updated until you manually update from the workspace.

    In the image below, we see that a data pipeline item exists in all three staging environments of the deployment pipeline *in Fabric* and that the Fabric stages are synchronized.

    :::image type="content" source="../media/pipeline-presync.png" alt-text="Screenshot of pipeline before files are synced with Git." :::

    When we select **Source control** from either the Test or Production workspaces that are part of the deployment pipeline, we see that the pipeline hasn't been synchronized with the Git repository.  

    :::image type="content" source="../media/git-not-updated.png" alt-text="Screenshot of workspace showing uncommitted items and showing the source control box where files aren't yet synced with Git." :::

4. To synchronize the repository with the Test workspace, select the **Commit** button in the **Source control** window shown in the preceding image.
