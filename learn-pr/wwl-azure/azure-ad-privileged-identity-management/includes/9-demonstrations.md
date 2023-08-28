These are a few try-this exercise to configure Privileged Identity Management (PIM)

## Task 1: Azure AD PIM for roles

In this task, we will configure PIM activation settings, add the Billing Administrator as a PIM role, activate the role, and test activation.

### Configure PIM settings

> [!NOTE]
> This task requires a **AZ500User1** account with no assigned roles.

In this task, we will review and configure the basic PIM settings.

1.  In the **Portal**, search for and select **Azure AD Privileged Identity Management**.
2.  Under **Manage** select **Azure AD Roles**.
3.  Under **Manage** select **Settings**.
4.  Select the **Billing Administrator** role.
5.  Click **Edit**.
6.  Notice the **Activation**, **Assignment**, and **Notification** tabs.
7.  By default, MFA is required on activation. For this demonstration, change the requirement to **None**.
8.  Check the box to **Require approval to activate**.
9.  Discuss the other possible settings including **Activation maximum duration** and **Require approval to activate**.
10. Switch to the **Assignment** tab and require the settings.
11. Notice the ability to expire eligible and active assignments.
12. Switch to the **Notifications** tab and discuss the settings.
13. Notice you can send notifications when members are assigned and activated.
14. Click **Update**.

### Configure PIM for Roles

In this task, we will add the Billing Administrator role to PIM.

1.  In the **Portal**, search for and select **Azure AD Privileged Identity Management**.
2.  Under **Manage** select **Azure AD Roles**.
3.  Under**Manage** select **Roles**.
4.  Review the list of roles.
5.  Select the **Billing Administrator** role.
6.  Review **Eligible roles** and **Active roles**.
7.  Click **Add member**.
8.  Click **Select member** and **Select** the **AZ500User1** user. You are now a Billing Administrator.
9.  Select **Set membership settings**. Notice the settings can be permanent or limited in time.
     -  Assignment type: **Eligible**
     -  Permanently eligible: **check the box**.
10. **Save** your changes and **Add** the assignment.
11. Verify the Billing Administrator is listed as an eligible role.

### Activate a role

In this task, we will activate the Billing Administrator role.

1.  In the **Portal**, search for and select **Azure Active Directory**.
2.  Under **Manage** click **Users**.
3.  Select **AZ500User1**.
4.  Under **Manage** click **Assigned roles**.
5.  Verify the user is not assigned to any roles.
6.  Sign in the **Portal** as **AZ500User1**.
7.  Search for and select **Azure AD Privileged Identity Management**.
8.  Under **Tasks** select **My roles**.
9.  Under **Activate** select **Azure AD Roles**.
10. Select the **Active roles** and verify there are no roles listed.
11. On the **Eligible roles** tab notice the **Billing Administrator** role.
12. Under the **Action** column, select **Activate**.
13. **Assignment details** are shown in the Portal. This includes start and end times, and the ability to add a reason.
14. Add a reason and then click **Activate**.
15. The **Activation status** should show all the activation stages have been completed.
16. Use the link to **Sign out**.
17. You must sign out and log back in to start using your newly activated role.

### Test the role access

In this task, test the Billing Administrator role.

1.  Sign in to the Portal as **AZ500User1**.
2.  Search for and select **Azure AD Privileged Identity Management**.
3.  Under **Activate** select **Azure AD Roles**.
4.  Select the **Active roles** tab and verify the **Billing Administrator** role has been activated.
5.  The role should show **Activated**.
6.  Notice the ability to **Deactivate** the role.

## Task 2: Azure AD PIM for resources

In this task, we will configure PIM for Azure resources, activate the Virtual Machine Contributor role, and test the role access.

### Configure PIM for Azure resources

In this task, we will add the subscription to PIM, then add the Virtual Machine Contributor role as a Active role.

1.  In the **Portal**, search for and select **Azure AD Privileged Identity Management**.
2.  Under **Manage** select **Azure Resources**.
3.  Click **Discover resources**.
4.  Notice the **Resource state** is **Unmanaged**.
5.  Select the subscription you want to manage.
6.  Click **Manage resource**.
7.  Click **Yes** to confirm that PIM will manage all child objects for the selected resource.
8.  Return to the **Azure resources** blade.
9.  Select your subscription.
10. Under **Manage** click **Roles**.
11. Search for and select the **Virtual machine contributor** role.
12. Click **Add assignments**, then click **Select member(s)** and add the **AZ500User1** to the group.
13. On the **Membership settings** page set the **Assignment type** is **Active**.
14. **Add** the role and **Save** your changes.
15. Sign out of the Portal.

### Activate the role

In this task, we will sign-in as a user and activate the role.

1.  Sign in to the **Portal** and **AZ500User1**.
2.  Search for and select **Azure AD Privileged Identity Management**.
3.  Under **Tasks** select **My roles**.
4.  Under **Activate** select **Azure resources**.
5.  On the **Active roles** tab notice you have no assigned roles.
6.  On the **Eligible roles** tab scroll to the right and **Activate** the role.
7.  Notice the **Start time** and **Duration**.
8.  Provide a reason for the activation. For example, 'Need to add a NIC'.
9.  Click **Activate**.
10. The **Activation status** should show all the activation stages have been completed.
11. Use the link to **Sign out**.
12. You must sign out and log back in to start using your newly activated role.

### Test the role access

In this task, we will check to ensure the role has been assigned.

1.  Sign in to the Portal as **AZ500User1**.
2.  Search for and select **Azure AD Privileged Identity Management**.
3.  Under **Activate** select **Azure resources**.
4.  Select the **Active roles** tab and verify the **Virtual Machine Contributor** role has been activated.
5.  Sign out of the Portal.
6.  Sign in to the Portal using a Global Admin account.
7.  Search for and select **Azure Active Directory**.
8.  Under **Manage** click **Users**.
9.  Select **AZ500User1**.
10. Under **Manage** click **Assigned roles**.
11. Verify there are no roles listed.
12. Under **Manage** select **Azure role assignments**.
13. Verify the **Virtual machine contributor** role is listed.
