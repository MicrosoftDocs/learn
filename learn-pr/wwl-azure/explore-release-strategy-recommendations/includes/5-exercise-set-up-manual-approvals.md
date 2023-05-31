In this exercise, you'll investigate Manual Approval.

## Steps

Let's now look at when our release pipeline needs manual approval before deployment of a stage starts or manual approval that the deployment is completed as expected.

While DevOps is all about automation, manual approvals are still helpful. There are many scenarios where they're needed. For example, a product owner might want to sign out a release before it moves to production.

Or the scrum team wants to make sure that no new software is deployed to the test environment before someone signs off on it because they might need to find an appropriate time if it's constantly in use.

This can help to gain trust in the DevOps processes within the business.

Even if the process is later automated, people might still want manual control until they become comfortable with the processes. Explicit manual approvals can be a great way to achieve that.

Let's try one.

1.  Click the pre-deployment conditions icon for the **Development** stage to open the settings.

    :::image type="content" source="../media/pre-deployment-conditions-9bf2a1cc.png" alt-text="Pre-deployment conditions icon.":::


2.  Click the **Disabled** button in the Pre-deployment approvals section to enable it.

    :::image type="content" source="../media/approvals-section-69d04801.png" alt-text="Approvals section.":::


3.  In the **Approvers** list, find your name and select it. Then set the **Timeout** to **1 Day**.

    :::image type="content" source="../media/select-approvers-timeout-b8adf78d.png" alt-text="Select approvers and timeout.":::


> [!NOTE]
> *Approvers is a list, not just a single value. If you add more than one person to the list, you can also choose if they need to approve in sequence or if either or both approvals are required.*

4.  Take record of the approver policy options that are available:

    :::image type="content" source="../media/approver-policies-14f8d9ac.png" alt-text="Approver Policies":::


It's prevalent not to allow a user who requests a release or deployment also to approve it.

In this case, we're the only approver, so that we'll leave that unchecked.

5.  Close the Pre-deployment conditions pane and notice that a checkmark has appeared beside the person in the icon.

    :::image type="content" source="../media/development-phase-39387ccc.png" alt-text="Development phase.":::


## Test the approval

Now it's time to see what happens when approval is required.

6.  Click **Save** to save the work, and **OK** on the popup window.
7.  Click **Create release** to start the release process.

    :::image type="content" source="../media/create-release-c6fa3909.png" alt-text="Create release.":::


8.  In the **Create a new release** pane, see the available options, then click **Create**.

    :::image type="content" source="../media/create-release-options-4f5f16e1.png" alt-text="Create release options.":::


9.  In the upper left of the screen, you can see that a release has been created.

    :::image type="content" source="../media/release-1-created-23c51fd3.png" alt-text="Release 1 created.":::


10. At this point, an email should have been received, indicating that approval is required.

    :::image type="content" source="../media/email-received-ed570c30.png" alt-text="Email received.":::


At this point, you could click the link in the email, but instead, we'll navigate within Azure DevOps to see what's needed.

11. Click on the **Release 1 Created** link (or whatever number it is for you) in the area we looked at in Step 9. We're then taken to a screen that shows the status of the release.

    :::image type="content" source="../media/release-status-eb79a060.png" alt-text="Release status.":::


You can see that a release has been manually triggered and that the Development stage is waiting for approval. As an approver, you can now do that approval.

12. Hover over the **Development** stage and click the **Approve** icon that appears.

    :::image type="content" source="../media/click-approve-a52c2402.png" alt-text="Click approve.":::


> [!NOTE]
> *Options to cancel the deployment or to view the logs are also provided at this point.*

13. In the Development approvals window, add a comment and click **Approve**.

    :::image type="content" source="../media/development-approval-e17c67bf.png" alt-text="Development approval.":::


    The deployment stage will then continue. Watch as each stage proceeds and succeeds.

    :::image type="content" source="../media/all-succeeded-150d65cc.png" alt-text="All succeeded stages.":::
