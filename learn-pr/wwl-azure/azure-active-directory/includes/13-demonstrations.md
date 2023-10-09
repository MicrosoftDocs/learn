## Task 1: Review Azure AD

In this task, we'll review Azure Active Directory licensing and tenants.

1.  In the **Portal**, search for and select **Azure Active Directory**.
2.  On the **Overview** page, locate the license information.
3.  Go to the [Azure AD pricing page](https://azure.microsoft.com/pricing/details/active-directory/) and review the features and pricing for each edition.

## Task 2: Manage users and groups

> [!NOTE]
> This task requires some users and groups to be populated. Dynamic groups requires a Premium P1 license.

In this task, we'll create users and groups.

1.  Under the **Manage** blade, click **Users**.
2.  Review the different **Sources** such as **Windows Server AD**, **Invited User**, **Microsoft Account**, and **External Azure Active Directory**.
3.  Notice the choice for **New guest user**.
4.  Click **New user**.
5.  Review the two ways to create a user: **Create user** and **Invite user**.
6.  Create a new user. Review **Identity**, **Groups and roles**, **Settings**, and **Job Info**.
7.  Navigate to Azure AD, under **Manage** click **Groups**.
8.  Review the **Group types**: **Security** and **Microsoft 365**.
9.  Create a new group by clicking "New Group" with the **Membership type** as **Assigned**.
10. Add a user to the same group.
11. Create another new group with **Membership type** as **Dynamic user**.
12. Review the details to construct dynamic group membership rules.

## Task 3: multifactor authentication in Azure

> [!NOTE]
> This task requires a user account, **AZ500User1**.

In this demonstration, we will configure and test MFA.

### Configure MFA

In this task, we'll enable MFA for a user.

1.  In the **Portal**, search for and select **Azure Active Directory**.
2.  Under **Manage** select **Security**.
3.  Under **Manage** select **MFA**.
4.  In the center pane, under **Configure** select **Additional cloud-based MFA settings**.
5.  Select the **Users** tab.
6.  Select **AZ500User1**. Make a note of their user name in the form user@domain.com.
7.  On the far right click **Enable**.
8.  Read the information about enabling multifactor authentication in Azure.
9.  Click **enable multi-factor auth**.
10. Wait for update. AZ500User1 will now be required to provide two factor authentication.

### Test MFA

> [!NOTE]
> To test MFA a phone number is required.

In this task, we'll test the MFA requirement.

1.  Sign in to the **Portal** as **AZ500User1**. Use their user name from a previous step.
2.  Provide the password, click **Next**.
3.  More information is required. Click **Next**.
4.  Review the **Additional security** verification page.
5.  In Step 1, enter your phone number and ensure the **send me a code by text message** is selected.
6.  Click **Next**.
7.  In Step 2, enter the verification code from the text message.
8.  Click **Verify**.
9.  In Step 3, read about how to keep your existing applications working.
10. Click **Get started with this app password**.
11. If prompted, **Allow access**.
12. Click **Done**.
13. On the **Update password** screen, provide and confirm a new password.
14. Click **Sign-in**.
15. Confirm that you can now access the Portal.
