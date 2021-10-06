
These are a few try-this exercise to configure Privileged Identity Management (PIM)

## Task 1: Azure AD PIM for roles

In this task, we will configure PIM activation settings, add the Billing Administrator as a PIM role, activate the role, and test activation. 

### Configure PIM settings

> [!NOTE] 
> This task requires a **AZ500User1** account with no assigned roles. 

In this task, we will review and configure the basic PIM settings. 

1. In the **Portal**, search for and select **Azure AD Privileged Identity Management**.
1. Under **Manage** select **Azure AD Roles**.
1. Under **Manage** select **Settings**.
1. Select the **Billing Administrator** role.
1. Click **Edit**. 
1. Notice the **Activation**, **Assignment**, and **Notification** tabs.
1. Be default, MFA is required on activation. For this demonstration, change the requirement to **None**.
1. Check the box to **Require approval to activate**.
1. Discuss the other possible settings including **Activation maximum duration** and **Require approval to activate**.
1. Switch to the **Assignment** tab and require the settings. 
1. Notice the ability to expire eligible and active assignments.
1. Switch to the **Notifications** tab and discuss the settings. 
1. Notice you can send notifications when member are assigned and activated. 
1. Click **Update**.


### Configure PIM for Roles

In this task, we will add the Billing Administrator role to PIM. 

1. In the **Portal**, search for and select **Azure AD Privileged Identity Management**.
1. Under **Manage** select **Azure AD Roles**.
1. Under**Manage** select **Roles**.
1. Review the list of roles.
1. Select the **Billing Administrator** role.
1. Review **Eligible roles** and **Active roles**.
1. Click **Add member**.
1. Click **Select member** and **Select** the **AZ500User1** user. You are now a Billing Administrator.
1. Select **Set membership settings**. Notice the settings can be permanent or limited in time. 
	* Assignment type: **Eligible**
	* Permanently eligible: **check the box**. 
1. **Save** your changes and **Add** the assignment.
1. Verify the Billing Administrator is listed as an eligible role. 

### Activate a role

In this task, we will activate the Billing Administrator role. 

1. In the **Portal**, search for and select **Azure Active Directory**.
1. Under **Manage** click **Users**.
1. Select **AZ500User1**. 
1. Under **Manage** click **Assigned roles**.
1. Verify the user is not assigned to any roles.
1. Sign in the **Portal** as **AZ500User1**. 
1. Search for and select **Azure AD Privileged Identity Management**.
1. Under **Tasks** select **My roles**.
1. Under **Activate** select **Azure AD Roles**.
1. Select the **Active roles** and verify there are no roles listed.
1. On the **Eligible roles** tab notice the **Billing Administrator** role.
1. Under the **Action** column, select **Activate**.
1. **Assignment details** are shown in the Portal. This includes start and end times, and the ability to add a reason. 
1. Add a reason and then click **Activate**.
1. The **Activation status** should show all the activation stages have been completed. 
1. Use the link to **Sign out**.
1. You must sign out and log back in to start using your newly activated role.


### Test the role access

In this task, test the Billing Administrator role. 

1. Sign in to the Portal as **AZ500User1**.
1. Search for and select **Azure AD Privileged Identity Management**.
1. Under **Activate** select **Azure AD Roles**.
1. Select the **Active roles** tab and verify the **Billing Administrator** role has been activated.
1. The role should show **Activated**.
1. Notice the ability to **Deactivate** the role. 

## Task 2: Azure AD PIM for resources

In this task, we will configure PIM for Azure resources, activate the Virtual Machine Contributor role, and test the role access. 

### Configure PIM for Azure resources

In this task, we will add the subscription to PIM, then add the Virtual Machine Contributor role as a Active role.

1. In the **Portal**, search for and select **Azure AD Privileged Identity Management**.
1. Under **Manage** select **Azure Resources**.
1. Click **Discover resources**.
1. Notice the **Resource state** is **Unmanaged**.
1. Select the subscription you want to manage.
1. Click **Manage resource**.
1. Click **Yes** to confirm that PIM will manage all child objects for the selected resource.
1. Return to the **Azure resources** blade.
1. Select your subscription.
1. Under **Manage** click **Roles**.
1. Search for and select the **Virtual machine contributor** role.
1. Click **Add assignments**, then click **Select member(s)** and add the **AZ500User1** to the group.
1. On the **Membership settings** page set the **Assignment type** is **Active**. Also, note the start and end times. 
1. **Add** the role and **Save** your changes.
1. Sign out of the Portal.


### Activate the role

In this task, we will sign-in as a user and activate the role. 

1. Sign in to the **Portal** and **AZUser1**.
1. Dearch for and select **Azure AD Privileged Identity Management**.
1. Under **Tasks** select **My roles**.
1. Under **Activate** select **Azure resources**.
1. On the **Active roles** tab notice you have no assigned roles.
1. On the **Eligible roles** tab scroll to the right and **Activate** the role.
1. Notice the **Start time** and **Duration**. 
1. Provide a reason for the activation. For example, 'Need to add a NIC'. 
1. Click **Activate**.
1.  The **Activation status** should show all the activation stages have been completed.
1. Use the link to **Sign out**.
1. You must sign out and log back in to start using your newly activated role.


### Test the role access

In this task, we will check to ensure the role has been assigned. 

1. Sign in to the Portal as **AZ500User1**.
1. Search for and select **Azure AD Privileged Identity Management**.
1. Under **Activate** select **Azure resources**.
1. Select the **Active roles** tab and verify the **Virtual Machine Contributor** role has been activated. 
1. Sign out of the Portal.
1. Sign in to the Portal using a Global Admin account.
1. Search for and select **Azure Active Directory**.
1. Under **Manage** click **Users**.
1. Select **AZ500User1**.
1. Under **Manage** click **Assigned roles**.
1. Verify there are no roles listed.
1. Under **Manage** select **Azure role assignments**.
1. Verify the **Virtual machine contributor** role is listed. 
