You study the report produced for Contoso by a firm of IT security specialists. You realize that user accounts that are members of high-privilege groups, such as Enterprise Admins and Domain Admins, have full access to all systems and data. You recognize that those accounts must be closely guarded.

However, there are users that require certain admin rights to perform their duties. For example, help desk staff must be able to reset passwords and unlock accounts for ordinary users, while some IT staff will be responsible for installing applications on clients or servers, or performing backups.

Although Active Directory and member servers have built-in groups that have predetermined privileges assigned, such as Backup Operators and Account Operators, these might not fit your needs. You now need to determine how best to provide this limited administrative access.

## Use the Delegation of Control Wizard

Delegated privilege provides a way to grant limited authority to specified users or groups. You can delegate more granular privileges to users or groups by using the **Delegation of Control Wizard**. The wizard allows you to assign permissions at the site, domain, or organization unit level. The wizard has the following pre-defined tasks  that you can assign:

- Create, delete, and manage user accounts.
- Reset user passwords and force password change at next sign in.
- Read all user information.
- Create, delete, and manage groups.
- Modify the membership of a group.
- Join a computer to the domain (only available at the domain level).
- Manage Group Policy links.
- Generate Resultant Set of Policy (Planning).
- Generate Resultant Set of Policy (Logging).
- Create, delete, and manage inetOrgPerson accounts.
- Reset inetOrgPerson passwords and force password change at next sign in.
- Read all inetOrgPerson information.

You can also combine permissions to create and assign custom tasks.

To launch the **Delegation of Control Wizard**, open Active Directory Users and Computers and locate the organizational unit (OU) that you want to delegate control over.

> [!NOTE]
> You can also delegate control on the domain object.

> [!TIP]
> To delegate control over a site, use the Active Directory Sites and Services tool to delegate control.

Then use the following procedure:

1. Right-click or activate the context menu to OU and select **Delegate Control**, and then select **Next**.

2. In the **Delegation of Control Wizard**, select the user or group to which you want to delegate control and then select **Next**.

   > [!TIP]
   > You should avoid assigning rights to specific users. Instead, you should use groups, even if the group contains only one user. This makes ongoing administration easier.

3. On the **Tasks to Delegate** page, select from a list of common tasks, or else select a custom task to delegate. For example, to delegate the ability to manage user accounts, select the following:

    - Create, delete, and manage user accounts.
    - Reset user passwords and force password changes at next logon.
    - Read all user information.

4. Select **Finish**.

:::image type="content" source="../media/m1-delegate-1.png" alt-text="A screenshot of the Tasks to Delegate page in the Delegation of Control Wizard. The administrator has selected the tasks that relate to user management.":::

> [!IMPORTANT]
> After you have assigned delegated access, you can't use the **Delegation of Control Wizard** to review your settings.

To review previously configured delegated tasks:
1. In **Active Directory Users and Computers**, on the menu, select **View**, and then select **Advanced Features**.
2. Locate the OU that you delegated. Right-click or activate the context menu and select **Properties**.
3. In the ***OU name* Properties** dialog box, select the **Security** tab, and then select **Advanced**. 
4. Locate the security principal to which you delegated control and review the permissions. You can also change the delegated permissions here.

:::image type="content" source="../media/m1-delegate-2.png" alt-text="A screenshot of the Advanced Security Settings for IT dialog box. The administrator has selected the Permissions tab. Displayed are the permissions on the IT OU, including delegated permissions for ContosoAdmin.":::

> [!NOTE]
> The **Delegation of Control Wizard** provides a simple, wizard-driven interface for the configuration of AD DS permissions on AD DS objects.

## Demonstration

The following video demonstrates how to use the **Delegation of Control Wizard** to implement delegated privileges. The main steps in the process are:

1. Open **Active Directory Users and Computers**.
2. Create a new group called **Sales Managers** in the **Managers** OU.
3. Add a user to the **Sales Managers** group.
4. Run the **Delegation of Control Wizard**, targeting the **Sales** OU.
5. Assign the **Sales Managers** group the **Reset user passwords and force password change at next logon** permission on the **Sales** OU.
6. Sign in as a member of the **Sales Managers** group and verify that the user can reset a password for users in the **Sales** OU but not in the **Research** OU.

>[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4McI8]