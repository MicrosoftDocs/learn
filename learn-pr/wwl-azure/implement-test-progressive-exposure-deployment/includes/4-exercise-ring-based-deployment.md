In this exercise, you'll investigate ring-based deployment.

> [!NOTE]
> *Before starting this exercise, make sure you've done the steps in the prerequisites section and the previous exercises.*

## Steps

Let's now look at how a release pipeline can stage features using ring-based deployments.

When I have a new feature, I might want to release it to a few users at first, just in case something goes wrong.

I could do it in authenticated systems by having those users as members of a security group and letting members of that group use the new features.

However, on a public website, I might not have logged-in users. Instead, I might want to direct a small percentage of the traffic to use the new features.

Let's see how that's configured.

We'll create a new release pipeline that isn't triggered by code changes but manually when we slowly release a new feature.

We start by assuming that a new feature has already been deployed to the Green site (that is, the staging slot).

1.  In the main menu for the **PU Hosted** project, click **Pipelines**, then click **Release**, click **+New**, then click **New release pipeline**.
2.  When prompted to select a template, click **Empty job** from the top of the pane.
3.  Click on the **Stage 1** stage and rename it to **Ring 0 (Canary)**.

    :::image type="content" source="../media/12-03-ring-0-canary-fa04a22e.png" alt-text="Ring 0 canary.":::


4.  Hover over the **New release pipeline** name at the top of the page, and when a pencil appears, click it, and change the pipeline name to **Ring-based Deployment**.

    :::image type="content" source="../media/12-01-ring-based-deployment-name-03333c5e.png" alt-text="Ring-based deployment name.":::


5.  From the **Tasks** drop-down list, select the **Ring 0 (Canary)** stage. Click the **+** to add a new task, and from the list of tasks, hover of **Azure CLI** and when the **Add** button appears, click it, then click to select the **Azure CLI** task in the task list for the stage.

    :::image type="content" source="../media/12-04-new-azure-cli-c7ef54f6.png" alt-text="New Azure CLI.":::


6.  In the **Azure CLI** settings pane, select your **Azure subscription**, set **Script Location** to **Inline script**, set the **Inline Script** to the following, then click **Save** and **OK**.

    Az webapp traffic-routing set --resource-group $(ResourceGroupName) --name $(WebsiteName) --distribution staging=10

    This distribution will cause 10% of the web traffic to be sent to the new feature Site (that is, currently the staging slot).

7.  From the menu above the task list, click **Variables**. Create two new variables as shown. (Make sure to use your correct website name).

    :::image type="content" source="../media/12-05-variables-f0ddd488.png" alt-text="Variables.":::


8.  From the menu above the variables, click **Pipeline** to return to editing the pipeline. Hover over the **Ring 0 (Canary)** stage and click the **Clone** icon when it appears. Select the new stage and rename it to **Ring 1 (Early Adopters)**.

    :::image type="content" source="../media/12-02-early-adopters-stage-f1adbd24.png" alt-text="Early adopters stage.":::


9.  Select the **Ring 1 (Early Adopters)** stage from the Tasks drop-down list and select the **Azure CLI** task. Modify the script by changing the value of **10** to **30** to cause 30% of the traffic to go to the new feature site.

    :::image type="content" source="../media/12-06-thirty-percent-e756e7af.png" alt-text="Thirty percent":::


    `Az webapp traffic -routing set --resource-group $(ResourceGroupName) --name $(WebsiteName) --distribution staging=30`

    It allows us to move the new feature into broader distribution if it works ok in smaller users.

10. From the menu above the tasks, click **Pipeline** to return to editing the release pipeline. Hover over the **Ring 1 (Early Adopters)** stage and when the **Clone** icon appears, click it. Click to select the new stage and rename it to **Public**. Click **Save** and **OK**.

    :::image type="content" source="../media/12-07-public-stage-35c0bddd.png" alt-text="Public stage.":::


11. Click the **Pre-deployment conditions** icon for the **Ring 1 (Early Adopters)** stage and add yourself as a pre-deployment approver. Do the same for the **Public** stage—Click **Save** and **OK**.

    :::image type="content" source="../media/12-08-approvers-configured-69ebca5a.png" alt-text="Approvers configured.":::


    The first step in releasing the new code to the public is to swap the new feature site (that is, the staging site) with the production so that production is now running the new code.

12. From the **Tasks** drop-down list, select the **Public** stage. Select the **Azure CLI** task, change the **Display name** to **Swap sites** and change the **Inline Script** to the following command:

    az webapp deployment slot swap -g $(ResourceGroupName) -n $(WebsiteName) --slot staging --target-slot production

    :::image type="content" source="../media/12-09-new-inline-script-81aae274.png" alt-text="New inline script.":::


    az webapp deployment slot swap -g $(ResourceGroupName) -n $(WebsiteName) --slot staging --target-slot production

    Next, we need to remove any traffic from the staging site.

13. Right-click the **Swap sites** task and click **Clone tasks(s)**. Select the **Swap sites copy** task, change its **Display name** to **Stop staging traffic**, and set the **Inline Script** to the following:

az webapp traffic-routing set --resource-group $(ResourceGroupName) --name $(WebsiteName) --distribution staging=0

14. Click **Save** then **OK** to save your work.
15. Click **Create release** and **Create** to start a release. Click the release link to see the progress.

    :::image type="content" source="../media/12-10-release-link-location-0672fc09.png" alt-text="Release link location.":::


    Wait until Ring 0 (Canary) has succeeded.

    :::image type="content" source="../media/12-11-ring-0-succeeded-b8ecf76d.png" alt-text="Ring 0 succeeded.":::


    At this point, 10% of the traffic will be going to the new feature site.

16. Click **Approve** on the **Ring 1 (Early Adopters)** stage, and then **Approve**.

    When this stage completes, 30% of the traffic will be going to the early adopters in ring 1.

    :::image type="content" source="../media/12-12-ring-1-succeeded-b5df0da6.png" alt-text="Ring 1 succeeded.":::


17. Click **Approve** on the **Public** stage, and then **Approve**.

    When this stage completes, all the traffic will be going to the swapped production site, running the new code.

    :::image type="content" source="../media/12-13-public-succeeded-73e56390.png" alt-text="Public succeeded.":::


The new feature has been fully deployed.
