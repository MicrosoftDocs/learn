Access to groups and applications for employees and guests changes over time. To reduce the risk associated with stale access assignments, administrators can use Microsoft Entra ID to create access reviews for group members or application access. If you need to routinely review access, you can also create recurring access reviews.

**Watch this video to learn more about how to deploy and create access reviews.**

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MAkF]

## Prerequisites

- Microsoft Entra ID Premium P2
- Global Administrator or User Administrator

## Create one or more access reviews

1.  Sign in to the Azure portal and open the Identity Governance page.
2.  In the left menu, select **Access reviews**.
3.  Select **New access review** to create a new access review.
    
    :::image type="content" source="../media/access-reviews.png" alt-text="Screenshot of the Access reviews pane in Identity Governance.":::
    
4.  In **Step 1: Select what to review** select the resource you would like to review.
    
    :::image type="content" source="../media/select-what-review.png" alt-text="Screenshot of the Create an access review - Review name and description dialog.":::
    
5.  If you selected **Teams + Groups** in Step 1, you've two options in Step 2:
    
    
    - **All Microsoft 365 groups with guest users**. Select this option if you would like to create recurring reviews on all your guest users across all your Microsoft Teams and Microsoft 365 groups in your organization. You can choose to exclude certain groups by selecting "Select group(s) to exclude."
    - **Select teams + groups**. Select this option if you would like to specify a finite set of teams and/or groups to review. After selecting on this option, you'll see a list of groups to the right to pick from.
        
       :::image type="content" source="../media/teams-groups.png" alt-text="Screenshot of the Teams and groups settings.  Pick your groups to exclude.":::

       :::image type="content" source="../media/teams-groups-detailed.png" alt-text="Screenshot of the Teams and groups chosen in the user interface. Selected items are excluded.":::
        
6.  If you selected **Applications** in Step 1, you can then select one or more applications in Step 2.
    
    :::image type="content" source="../media/select-application-detailed.png" alt-text="Screenshot of The interface displayed if you chose applications rather than groups.":::
    
7.  Next, in Step 3 you can select a scope for the review. Your options are:
    
    
    - **Guest users only**. Selecting this option limits the access review to just the Microsoft Entra B2B guest users in your directory.
    - **Everyone**. Selecting this option scopes the access review to all user objects associated with the resource.
        
       > [!NOTE]
       > If you selected All Microsoft 365 groups with guest users in Step 2, then your only option is to review Guest users in Step 3.
8.  Select on Next: Reviews
9.  In the **Select reviewers** section, select one or more people to perform the access reviews. You can choose from:
    
    
    - **Group owner(s)** (Only available when performing a review on a team or group)
    - **Selected user(s) or groups(s)**
    - **Users review own access**
    - **(Preview) Managers of users**. If you choose either **Managers of users** or **Group owners,** you also have the option to specify a fallback reviewer. Fallback reviewers are asked to do a review when the user has no manager specified in the directory or the group doesn't have an owner.
10. In the **Specify recurrence of review** section, you can specify a frequency such as **Weekly, Monthly, Quarterly, Semi-annually, Annually**. You then specify a **Duration**, which defines how long a review will be open for input from reviewers. For example, the maximum duration that you can set for a monthly review is 27 days to avoid overlapping reviews. You might want to shorten the duration to ensure that your reviewers input is applied earlier. Next, you can select a **Start date** and **End date**.
    
    :::image type="content" source="../media/frequency.png" alt-text="Screenshot of the Choose how often the review should happen. Admins should set a reasonable timeline.":::
    
11. Select the **Next: Settings** button at the bottom of the page.
12. In the **Upon completion settings**, you can specify what happens after the review completes.
    
    :::image type="content" source="../media/upon-completion-settings-new.png" alt-text="Screenshot of the Create an access review - upon completion settings.":::
    
    
    If you want to automatically remove access for denied users, set **Auto apply results to resource** to **Enable**. If you want to manually apply the results when the review completes, set the switch to **Disable**. Use the **If reviewers don't respond** list to specify what happens for users that aren't reviewed by the reviewer within the review period. This setting doesn't impact users who have been reviewed by the reviewers manually. If the final reviewer's decision is Deny, then the user's access will be removed.
    
    
    - No change - Leave user's access unchanged
    - Remove access - Remove user's access
    - Approve access - Approve user's access
    - Take recommendations - Take the system's recommendation on denying or approving the user's continued access
    
    Use the Action to apply on denied **guest** users to specify what happens to guest users if they're denied.
    
    
    - **Remove user’s membership from the resource** will remove denied user’s access to the group or application being reviewed, they'll still be able to sign-in to the tenant.
    - **Block user from signing in for 30 days, then remove user from the tenant** will block the denied users from signing in to the tenant, regardless if they have access to other resources. If there was a mistake or if an admin decides to re-enable one’s access, they can do so within 30 days after the user has been disabled. If there's no action taken on the disabled users, they'll be deleted from the tenant.
    - Action to apply on denied guest users isn't configurable on reviews scoped to more than guest users. It's also not configurable for reviews of all Microsoft 365 groups with guest users. When not configurable, the default option of removing user's membership from the resource is used on denied users.
13. In **Enable review decision helpers** choose whether you would like your reviewer to receive recommendations during the review process.
    
    :::image type="content" source="../media/helpers.png" alt-text="Screenshot of the Enable decision helpers options.  Offer recommendations to the reviewers.":::
    
14. In the **Advanced settings** section, you can choose the following
    
    
    - Set **Justification required** to **Enable** to require the reviewer to supply a reason for approval.
    - Set **email notifications** to **Enable** to have Microsoft Entra ID send email notifications to reviewers when an access review starts, and to administrators when a review completes.
    - Set **Reminders** to **Enable** to have Microsoft Entra ID send reminders of access reviews in progress to reviewers who haven't completed their review. These reminders will be half-way through the duration of the review.
    - The content of the email sent to reviewers is autogenerated based on the review details, such as review name, resource name, due date, etc. If you need a way to communicate additional information, such as additional instructions or contact information, you can specify these details in the **Additional content for reviewer email** section. The information that you enter is included in the invitation and reminder emails sent to assigned reviewers. The section highlighted in the image below shows where this information is displayed.
15. Select **Next: Review + Create** to move to the next page.
16. Name the access review. Optionally, give the review a description. The name and description are shown to the reviewers.
17. Review the information and select **Create**.
    
    :::image type="content" source="../media/create-review.png" alt-text="Screenshot of the create review screen. Overview of the access review that has just finished creation.":::
    

## Start the access review

Once you've specified the settings for an access review, select **Start**. The access review will appear in your list with an indicator of its status.

:::image type="content" source="../media/access-reviews-list.png" alt-text="Screenshot of the List of access reviews and their status. Review the status of each item.":::


By default, Microsoft Entra ID sends an email to reviewers shortly after the review starts. If you choose not to have Microsoft Entra ID send the email, be sure to inform the reviewers that an access review is waiting for them to complete. You can show them the instructions for how to review access to groups or applications. If your review is for guests to review their own access, show them the instructions for how to review access for yourself to groups or applications.

If you've assigned guests as reviewers and they haven't accepted the invite, they'll not receive an email from access reviews because they must first accept the invitation prior to reviewing.

## Access review status table

| **Status**     | **Definition**                                                                                                                                               |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| NotStarted     | Review was created, user discovery is waiting to start.                                                                                                      |
| Initializing   | User discovery is in progress to identify all users who are part of the review.                                                                              |
| Starting       | Review is starting. If email notifications are enabled, emails are being sent to reviewers.                                                                  |
| InProgress     | Review has started. If email notifications are enabled, emails have been sent to reviewers. Reviewers can submit decisions until the due date.               |
| Completing     | Review is being completed, and emails are being sent to the review owner.                                                                                    |
| Auto-Reviewing | Review is in a system reviewing stage. The system is recording decisions for users who weren't reviewed based on recommendations or preconfigured decisions. |
| Auto-Reviewed  | Decisions have been recorded by the system for all users who weren't reviewed. Review is ready to proceed to **Applying** if Auto-Apply is enabled.          |
| Applying       | There will be no change in access for users who were approved.                                                                                               |
| Applied        | Denied users, if any, have been removed from the resource or directory.                                                                                      |
| Failed         | Review could not progress. This error could be related to the deletion of the tenant, a change in licenses, or other internal tenant changes.                |

## Create reviews via APIs

You can also create access reviews using APIs. What you do to manage access reviews of groups and application users in the Azure portal can also be done using Microsoft Graph APIs.
