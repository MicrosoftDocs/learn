
## Task 1: Review Azure AD

In this task, we will review Azure Active Directory licensing and tenants.

1. In the **Portal**, search for and select **Azure Active Directory**.
1. On the **Overview** page, locate the license information.
1. Got to the [Azure AD pricing page](https://azure.microsoft.com/pricing/details/active-directory/) and review the features and pricing for each edition. 
1. On the **Overview** page, discuss creating directories and how to switch between directories. 
1. Review the **Licenses** blade information.

## Task 2: Manage users and groups

> [!NOTE] 
> This task requires some users and groups to be populated. Dynamic groups requires a Premium P1 license. 

In this task, we will create users and groups. 

1. Under **Manage** click **Users**.
1. Review the different **Sources** such as **Windows Server AD**, **Invited User**, **Microsoft Account**, and **External Azure Active Directory**. 
1. Notice the choice for **New guest user**.
1. Click **New user**. 
1. Review the two ways to create a user: **Create user** and **Invite user**.
1. Create a new user. Review  **Identity**, **Groups and roles**, **Settings**, and **Job Info**.
1. Going back to Azure AD, under **Manage** click **Groups**.
1. Review the **Group types**: **Security** and **Office 365**.
1. Create a new group by clicking "New Group" with the **Membership type** as **Assigned**.
1. Add a user to the same group. 
1. Create another new group with **Membership type** as **Dynamic user**. 
1. Review the details to construct dynamic group membership rules.  


## Task 3: multifactor authentication in Azure

> [!NOTE] 
> This task requires a user account, **AZ500User1**. 

In this demonstration,  we will configure and test MFA. 

### Configure MFA

In this task, we will enable MFA for a user. 

1. In the **Portal**, search for and select **Azure Active Directory**.
1. Under **Manage** select **Security**.
1. Under **Manage** select **MFA**. 
1. In the center pane, under **Configure** select **Additional cloud-based MFA settings**.
1. Select the **Users** tab.
1. Select **AZ500User1**. Make a note of their user name in the form user@domain.com. 
1. On the far right click **Enable**.
1. Read the information about enabling multifactor authentication in Azure. 
1. Click **enable multi-factor auth**.
1. Wait for update. AZ500User1 will now be required to provide two factor authentication.

### Test MFA

> [!NOTE] 
> To test MFA a phone number is required. 

In this task, we will test the MFA requirement. 

1. Sign in to the **Portal** as **AZ500User1**. Use their user name from a previous step. 
1. Provide the password, click **Next**. 
1. Note that more information is required. Click **Next**.
1. Review the **Additional security** verification page.
1. In Step 1, enter your phone number and ensure the **send me a code by text message** is selected. 
1. Click **Next**.
1. In Step 2, enter the verification code from the text message.
1. Click **Verify**.
1. In Step 3, read about how to keep your existing applications working.
1. Click **Get started with this app password**.
1. If prompted, **Allow access**.
1. Click **Done**.
1. On the **Update password** screen provide and confirm a new password.
1. Click **Sign-in**. 
1. Confirm that you can now access the Portal.