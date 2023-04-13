In this set of exercises, you will test conditional access.

## Task 1 - Configure conditional access (require MFA)

> [!NOTE]
> This task requires a user account, AZ500User1. If you want to show the MFA verification, the user account must have a phone number.

This task will review conditional access policy settings and create a policy that requires MFA when signing in to the Portal.

### Configure the policy

1.  In the **Portal,** search for and select **Azure Active Directory**.
2.  Under **Manage,** select **Security**.
3.  Under **Protect,** select **Conditional access**.
4.  Click **New Policy**.
     -  Name: **AZ500Policy1**
     -  Users and groups &gt; Select users and groups &gt; Users and Groups &gt; Select: **AZ500User1**
     -  Cloud apps or actions &gt; Select apps &gt; Select: **Microsoft Azure Management**
     -  Review the warning that this policy impacts Portal access.
     -  Conditions &gt; Sign-in risk &gt; Review the risk levels
     -  Device platforms &gt; Review the devices that can be included, such as Android and iOS.
     -  Locations &gt; Review the physical location selections.
     -  Under **Access controls** click **Grant**.
     -  Review the Grant options such as MFA. You may require one or more of the controls.
     -  Select **Require multi-factor authentication**.
     -  For **Enable policy,** select **On**.
5.  Click **Create**.

### Test the policy

1.  Sign in to the **Portal** as the **AZ500User1**.
2.  Before you can sign in, a second authentication is required.
3.  If you have a phone number associated with the user, provide and verify the text code. You should be able to sign in to the Portal successfully.
4.  If you do not have a phone number associated with the user, this demonstrates that MFA is in effect.
5.  You may want to return to the **AZ500Policy1** and turn the policy **Off**.

## Task 2 - Access review

In this task, we will configure an access review.

### Configure an access review

1.  In the **Portal**, search for and select **Identity Governance**.
2.  Under **Access Reviews,** select **Access Reviews**.
3.  Click **New Access Review**.
4.  We will create an access review to ensure we validate the AZ500Admin group membership.
5.  Complete the required information and discuss each setting. Configuration settings are added as you make your selections. For example, if you select a weekly access review, you will be prompted for the duration.
     -  Review name: **AZ500Review**
     -  Start date: **current date**
     -  Frequency: **One-time**
     -  Users to review: **Members of a group**
     -  Scope: **Everyone**
     -  Select a group: **AZ500Admins**
     -  Reviewers: **Selected user**
     -  Select reviewers: **add yourself as a reviewer**
     -  Review the **Upon completion settings**, specifically the action if a reviewer doesn't respond.
     -  Review **Advanced settings**.
6.  **Start** the access review.
7.  On the **Access review** page, ensure the new access review is listed.
8.  The **Status** will change from **Not started** to **Initializing**.

### Conduct an access review

In this task, we will conduct an access review.

1.  When the access review is complete, you will receive an email. This is the email associated with your reviewer account.
2.  View the email and discuss the review instructions. Note when the review period will end.
3.  In the email, click **Start review**.
4.  On the **Access reviews** page, click the **AZ500Review**.
5.  Notice you are reviewing the AZ500Admin group members. There are two members.
6.  Use the **Details** link to view information about the user.
7.  Select **Approve** for one user and **Deny** for the other. Be sure to provide a **Reason**.
8.  **Submit** your reviews.

### Review the access review results

In this task, we will review the access review results.

1.  Return to the **Portal**.
2.  Click the **AZ500Review**.
3.  From the **Overview** blade, review the results.
4.  There should be one member **approved** and one member **denied**.
5.  Click **Results** for more detailed information about the reviewer and their reasons.
6.  From the **Overview** blade, click **Stop** and confirm you want to stop the review.
7.  The **Review status** should now be **Complete**.

### Apply the access review

In this task, we will apply the review results.

1.  In the **Portal**, search for and select **Azure Active Directory**.
2.  Under **Manage,** select **Groups**.
3.  Locate the **AZ500Admins** group.
4.  Review the members of the group.
5.  Confirm there are two members.
6.  Return to the **AZ500Review**.
7.  Click **Apply**.
8.  Confirm that you want to remove the denied member.
9.  The **Review status** will change from **Applying** to **Result applied**.
10. Verify the **AZ500Admins** group now only has one member.
