Delegating permissions in Active Directory (AD) involves assigning specific administrative tasks to users or groups, allowing them to perform certain Active Directory functions without granting them full administrative rights. Delegation of permissions supports the principle of least privilege while allowing you to delegate tasks to non-administrative users. Granting permissions to such users to perform certain Active Directory management tasks doesn’t require adding those users to privileged domain groups such as Domain Admins or Account Operators. Delegating permissions ensures that individuals have only the access necessary to perform their job functions. By delegating permissions, you control how the permissions are configured, minimizing the risk of accidental or deliberate misuse of those permissions.

For example, you can delegate permissions to an Active Directory security group, such as the Helpdesk team, to perform certain common management tasks. Delegation allows you to grant Helpdesk the permissions to add users to groups, create new users in Active Directory, or reset user account passwords.

## Delegate password reset permissions

A common and critical task that administrators often perform is resetting user account passwords. Administrators must periodically ensure that passwords are regularly updated in accordance with security best practices. By delegating password reset permissions, organizations can improve efficiency and reduce time spent on a routine task.

When delegating password reset permissions, you enable designated users to help with password administration, while still maintaining strict control over who can do this task.

To delegate password reset permissions in Active Directory, you follow these general steps:

1.  Open **Active Directory Users and Computers** (ADUC).
2.  Right-click the OU where you want to delegate control, then select **Delegate Control**.
3.  The **Delegation of Control Wizard** opens. Click **Next**.
4.  Click **Add** to open the **Select Users, Computers, or Groups** dialog box. Here, you can choose the user or group to whom you want to delegate the password reset permission.
5.  After selecting the user or group, click **Next**.
6.  In the **Tasks to Delegate** page, select **Reset user passwords and force password change at next logon**.
7.  Click **Next**, review your selections, and click **Finish** to apply the delegation.
