In this exercise walkthrough, you'll investigate Release Gates.

## Steps

Let's now look at when our release pipeline needs to do automated checks for issues like code quality before continuing with the deployments. That automated approval phase is achieved by using Release Gates.

First, we need to make sure that Release Gates can execute work item queries.

1.  On the **Boards** &gt; **Queries** page, click **All** to see all the queries (not just favorites).
2.  Click the ellipsis for **Shared Queries** and choose **Security**.
3.  Add a user **ProjectName Build Service (CompanyName)** if they aren't already present, and choose to **Allow** for Read permissions.

Now let's look at configuring a release gate.

1.  Click the lightning icon on the **Development** stage to open the pre-deployment conditions settings.

    :::image type="content" source="../media/open-pre-deployment-conditions-fcb0bd73.png" alt-text="Open pre-deployment conditions.":::


2.  In the Pre-deployment conditions pane, click the **Disabled** button beside **Gates** to enable them.

    :::image type="content" source="../media/enabling-gates-4e22c843.png" alt-text="Enabling gates.":::


3.  Click **+Add** to see the available types of gates, then click **Query work items**.

    :::image type="content" source="../media/available-gate-types-5db4b4c9.png" alt-text="Available gate types.":::


We'll use the **Query work items** gate to check if any outstanding bugs need to be dealt with. It does this by running a work item query. This is an example of what is commonly called a **Quality Gate**.

4.  Set **Display name** to **No critical bugs allowed**, and from the **Query** drop-down list, choose **Critical Bugs**. Leave the **Upper threshold** set to zero because we don't want to allow any bugs at all.

    :::image type="content" source="../media/no-critical-bugs-357f6eae.png" alt-text="No critical bugs.":::


5.  Click the drop-down beside **Evaluation options** to see what can be configured. While 15 minutes is a reasonable value in production, change **The time between re-evaluation of gates** to **5 minutes for our testing**.

    :::image type="content" source="../media/evaluation-options-718ee4ae.png" alt-text="Evaluation options.":::


The release gate doesn't just fail or pass a single time. It can keep evaluating the status of the gate. It might fail the first time, but it might then pass after re-evaluation if the underlying issue has been corrected.

6.  Close the pane and click **Save** and **OK** to save the work.
7.  Click **Create release** to start a new release, and in the **Create a new release** pane, click **Create**.

    :::image type="content" source="../media/create-release-c6fa3909.png" alt-text="Create release.":::


8.  Click on the release number to see how the release is proceeding.

    :::image type="content" source="../media/click-release-number-e57d674b.png" alt-text="Click release number.":::


9.  If it's waiting for approval, click **Approve** to allow it to continue, and in the **Development** pane, click **Approve**.

    :::image type="content" source="../media/pending-approval-6be14410.png" alt-text="Pending approval.":::


    After a short while, you should see the release continuing and then enter the phase where the gates will process.

    :::image type="content" source="../media/05-09-processing-gates-b2c24934.png" alt-text="Processing gates.":::


10. In the **Development** pane, click **Gates** to see the status of the release gates.

    :::image type="content" source="../media/gates-status-ac1fcc7a.png" alt-text="Gates status.":::


You'll notice that the gate failed the first time it was checked. It will be stuck in the processing gates stage as there's a critical bug. Let's look at that bug and resolve it.

11. Close the pane and click **Save,** then **OK** to save the work.
12. In the main menu, click **Boards,** then click **Queries**.

    :::image type="content" source="../media/boards-and-queries-257a4319.png" alt-text="Boards and queries.":::


13. In the **Queries** window, click **All** to see all the available queries.

    :::image type="content" source="../media/queries-choose-all-5c502459.png" alt-text="Queries.":::


14. From the list of queries, click **Critical bugs**.

    :::image type="content" source="../media/critical-bugs-1191cf45.png" alt-text="Critical bugs.":::


    You'll see that there's one critical bug that needs to be resolved.

    :::image type="content" source="../media/05-13-one-critical-bug-92f59f48.png" alt-text="One critical bug.":::


15. In the properties pane for the bug, change the **State** to **Done**, then click **Save**.

    :::image type="content" source="../media/resolve-bug-9ad58382.png" alt-text="Resolve bug.":::


16. Click **Run query** to re-execute the work item query.

    :::image type="content" source="../media/run-query-again-1091be0a.png" alt-text="Run query again.":::


There are now no critical bugs that will stop the release.

17. Return to the release by clicking **Pipelines,** then **Releases** in the main menu, then clicking the name of the latest release.

    :::image type="content" source="../media/return-environments-89c5b5ce.png" alt-text="Release to all environments.":::


18. When the release gate is checked next time, the release should continue and complete successfully.

    :::image type="content" source="../media/all-succeeded-150d65cc.png" alt-text="All succeeded.":::


Gates are a potent automated approval mechanism.

## Clean up

To avoid excessive wait time in later walkthroughs, we'll disable the release gates.

19. In the main menu, click **Pipelines**, click **Releases**, and click **Edit** to open the release pipeline editor.
20. Click the **Pre-deployment conditions** icon (that is, the lightning bolt) on the **Development** task, and in the **Pre-deployment conditions** pane, click the switch beside **Gates** to disable release gates.
21. Click **Save**, then click **OK**.
