Microsoft Entra ID simplifies how enterprises manage access to groups and applications with Microsoft Entra access reviews. Other Microsoft Online Services such as Microsoft 365 can also be managed with Microsoft Entra access reviews.

## Perform access review using My Apps

You can start the access review process from the notification email or by going directly to the site.

1.  **Email**:
    
    :::image type="content" source="../media/access-review-email.png" alt-text="Screenshot that shows an example email from Microsoft to review access to a group.":::
    
2.  Select the **Start review** link to open the access review.
3.  **If you don't have the email**, you can find your pending access reviews by following these steps:
    
    
    1.  Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com/).
    2.  Select **Access reviews** from the left menu to see a list of pending access reviews assigned to you.
        
        > [!IMPORTANT]
        > If no access reviews appear, there are no access reviews to perform for that organization and no action is needed at this time.
    3.  Select the name of the access review you want to perform.

Once you open the access review, you see the names of users who need to have their access reviewed.

There are two ways that you can approve or deny access:

- You can approve or deny access for one or more users manually by choosing the appropriate action for each user request.
- You can accept the system recommendations.

### Approve or deny access for one or more users

1.  Review the list of users and decide whether to approve or deny their continued access.
    
    
    - To approve or deny access for a single user, select the circle next to their name.
    - To approve or deny access for multiple users, select the circles next to each user.
2.  Select **Approve** or **Deny** on the bar.
    
    > [!NOTE]
    > If you're unsure, you can select "Don't know" and the user gets to keep their access and your choice is recorded in the audit logs.
3.  The administrator of the access review can require that you supply a reason in the **Reason** box for your decision.
    
    
    - Even when a reason isn't required, you can still provide a reason for your decision and the information that you include is available to other reviewers.
4.  Once you specify the action to take, select **Save**.
    
    
    - If a user is denied access, they aren't removed immediately. They're removed when the review period ends or when an administrator stops the review if [Auto apply](/azure/active-directory/governance/complete-access-review) is enabled.
    - If there are multiple reviewers, the last submitted response is recorded. Consider an example where an administrator designates two reviewers – Alice and Bob. Alice opens the access review first and approves a user's access request. Before the review period ends, Bob opens the access review and denies access on the same request previously approved by Alice. The last decision denying the access is the response that gets recorded.

### Approve or deny access based on recommendations

To make access reviews easier and faster for you, we also provide recommendations that you can accept with a single selection. The system generates recommendations using two methods:

- **No sign-in within 30 days**: Users who haven't signed in during the past 30 days are recommended for denial. The user's last sign-in date displays alongside the recommendation.
- **Peer outlier**: If a user doesn't have the same access as their peers, the system recommends denial based on the user's average distance in the organization's reporting structure.

To accept recommendations:

1.  Select one or more users, then select **Accept recommendations** on the bar. Or, to accept recommendations for all unreviewed users, make sure no users are selected and then select **Accept recommendations** on the top bar.
2.  Select **Submit** to confirm.
