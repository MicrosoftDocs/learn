## Task 1: Review Azure AD

In this task, we'll review Azure Active Directory licensing and tenants.

1.  In the **portal**, search for and select **Azure Active Directory**.
2.  On the **Overview** page, locate the license information.
3.  Go to the [Azure AD pricing page](https://azure.microsoft.com/pricing/details/active-directory/) and review the features and pricing for each edition.
4.  On the **Overview** page, review how to create directories and how to switch between directories.
5.  Review the **Licenses** pane information.

## Task 2: Manage users and groups

> [!NOTE]
> This task requires some users and groups to be populated. Dynamic groups requires a Premium P1 license.

In this task, we will create users and groups.

1.  Under **Manage**, select **Users**.
2.  Review the different **Sources**, such as **Windows Server AD**, **Invited User**, **Microsoft Account**, and **External Azure Active Directory**.
3.  Notice the choice for **New guest user**.
4.  Select **New user**.
5.  Review the two ways to create a user: **Create user** and **Invite user**.
6.  Create a new user. Review **Identity**, **Groups and roles**, **Settings**, and **Job Info**.
7.  Going back to Azure AD, under **Manage**, select **Groups**.
8.  Review the **Group types**: **Security** and **Office 365**.
9.  Create a new group by clicking **New Group**, with the **Membership type** as **Assigned**.
10. Add a user to the same group.
11. Create another new group with **Membership type** as **Dynamic user**.
12. Review the details to construct dynamic group membership rules.

## Task 3: Multifactor authentication in Azure

> [!NOTE]
> This task requires a user account, **AZ500User1**.

In this demonstration, we will configure and test MFA.

### Configure MFA

In this task, we will enable MFA for a user.

1.  In the **portal**, search for and select **Azure Active Directory**.
2.  Under **Manage**, select **Security**.
3.  Under **Manage**, select **MFA**.
4.  In the center pane, under **Configure**, select **Additional cloud-based MFA settings**.
5.  Select the **Users** tab.
6.  Select **AZ500User1**. Make a note of their user name in the form user@domain.com.
7.  On the far right, select **Enable**.
8.  Read the information about enabling multifactor authentication in Azure.
9.  Select **enable multi-factor auth**.
10. Wait for update. AZ500User1 will now be required to provide two-factor authentication.

### Test MFA

> [!NOTE]
> To test MFA, a phone number is required.

In this task, we'll test the MFA requirement.

1.  Sign in to the **portal** as **AZ500User1**. Use your user name from a previous task.
2.  Provide the password, and then select **Next**.
3.  Note that more information is required. Select **Next**.
4.  Review the **Additional security** verification page.
5.  In Step 1, enter your phone number. Ensure that **send me a code by text message** is selected.
6.  Select **Next**.
7.  In Step 2, enter the verification code from the text message.
8.  Select **Verify**.
9.  In Step 3, read about how to keep your existing applications working.
10. Select **Get started with this app password**.
11. If prompted, select **Allow access**.
12. Select **Done**.
13. On the **Update password** page, provide and confirm a new password.
14. Select **Sign-in**.
15. Confirm that you can now access the portal.
