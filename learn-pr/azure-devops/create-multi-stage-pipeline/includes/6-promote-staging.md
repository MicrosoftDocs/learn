Your release pipeline now has three stages: *Build*, *Dev*, and *Test*. You and the Tailspin team have one more stage to implement: *Staging*.

In this part, you'll:

> [!div class="checklist"]
> - Create the **staging** environment in Azure Pipelines, and assign yourself as an approver.
> - Define the *Staging* stage, which runs only after an approver verifies the results of the *Test* stage.

## Create the staging environment

Here, you create an environment in Azure Pipelines for *Staging*. For learning purposes, you assign yourself as the approver. In practice, you would assign the users who are required to approve changes before those changes move to the next stage. For the Tailspin team, Amita approves changes so that they can be promoted from *Test* to *Staging*.

Earlier in this module, you specified `environment` settings for both *Dev* and *Test* stages. Here's an example for the *Dev* stage.

[!code-yml[](code/2-azure-pipelines.yml?highlight=8)]

You can define an environment through Azure Pipelines that includes specific criteria for your release. This criteria can include the pipelines that are authorized to deploy to the environment. You can also specify the human approvals that are needed to promote the release from one stage to the next. Here, you specify those approvals.

To create the **staging** environment:

1. From Azure Pipelines, select **Environments**.

    :::image type="content" source="../../shared/media/pipelines-environments.png" alt-text="A screenshot of Azure Pipelines showing the location of the Environments menu option.":::

1. Select **New environment**.
1. Under **Name**, enter *staging*.
1. Leave the remaining fields at their default values.
1. Select **Create**.
1. On the **staging** environment page, open the dropdown, and then select **Approvals and checks**.

    :::image type="content" source="../../shared/media/pipeline-add-check-to-environment.png" alt-text="A screenshot of Azure Pipelines, showing the location of the approvals and checks menu item.":::

1. Select **Approvals**.
1. Under **Approvers**, select **Add users and groups**, and then select your account.
1. Under **Instructions to approvers**, enter *Approve this change when it's ready for staging*.
1. Select **Create**.

## Promote changes to Staging

Here you modify your pipeline configuration to deploy the build to the *Staging* stage.

1. In Visual Studio Code, modify *azure-pipelines.yml* as follows:

    [!code-yml[](code/6-azure-pipelines.yml?highlight=130-151)]

    This code adds the *Staging* stage. The stage deploys to the **staging** environment, which includes a release approval.

    > [!TIP]
    > You probably noticed that all three of your deployment stages follow similar steps. You can use *templates* to define common build tasks one time and reuse them multiple times. You already used this technique in the [Create a build pipeline with Azure Pipelines](/training/modules/create-a-build-pipeline/8-build-multiple-configurations?azure-portal=true) module. For learning purposes, we repeat the steps in each stage.

1. From the integrated terminal, add *azure-pipelines.yml* to the index. Next, commit the change and push it up to GitHub.

    > [!TIP]
    > Before you run these Git commands, save *azure-pipelines.yml*.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Deploy to Staging"
    git push origin release
    ```

1. In Azure Pipelines, go to the build. Trace the build as it runs.

    When the build reaches *Staging*, you see that the pipeline waits for all checks to pass. In this case, there's one check - the manual release approval.

    :::image type="content" source="../media/7-pipeline-review.png" alt-text="A screenshot of Azure Pipelines showing the Staging stage, which requires manual approval.":::

    You can configure Azure DevOps to send you an email notification when the build requires approval. Here's an example:

    :::image type="content" source="../media/6-email-notification.png" alt-text="A screenshot of a portion of a build approval email notification.":::

1. Select **Review** > **Approve**.

    In practice, to verify that they meet your requirements, you would inspect the changes.

1. After the build finishes, open a web browser. Go to the URL associated with the App Service instance for your **staging** environment.

    If you still have the browser tab open, refresh the page. If you don't remember the URL, find it in the Azure portal, on the **App Service details** page.

    You see that the *Space Game* website is deployed to App Service and is running.

    :::image type="content" source="../media/6-app-service-staging.png" alt-text="A screenshot of web browser showing the Space Game website in the Staging environment.":::

1. As an optional step, in Azure Pipelines, select **Environments**. Next, select the **staging** environment.

    Azure Pipelines records your deployment history, which enables you to trace changes in the environment back to code commits and work items.

    :::image type="content" source="../media/6-environment-staging.png" alt-text="A screenshot of Azure Pipelines showing the deployment history. The history shows one successful deployment.":::

The Tailspin team gathers to discuss their progress. Amita approves changes in the *Test* stage while the others watch.

**Tim:** To tell you the truth, at first I was a little nervous about automated release pipelines. But I really like this now that I see it working. Each stage can have its own environment, associated tests, and approvers. The pipeline automates many things that we had to do manually. But we still have control where we need it.

**Amita:** I could imagine us doing something similar to promote changes from *Staging* to *Production*. Speaking of...when do we add a **production** environment?

**Andy:** Shortly. I think we still need to fill in a few pieces here first before we add that.
