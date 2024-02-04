## Create a new user in Microsoft Entra ID

You can skip creating this user if you have already created the same user in the earlier module.

1.  Browse to the Identity menu in the [Microsoft Entra admin center](https://entra.microsoft.com/).
2.  In the left navigation, under select **Users**.
3.  Within the Users page, on the menu, select **New user**.
4.  Create a user using the following information:
    
    | **Setting** | **Value**                 |
    | ----------- | ------------------------- |
    | User name   | ChrisG                    |
    | Name        | Chris Green               |
    | First name  | Chris                     |
    | Last name   | Green                     |
    | Password    | make up a unique password |
    |             |                           |
5.  When complete, verify the account for Chris Green is shown in the **All users** list.

## Create a security group in Microsoft Entra ID

1.  Browse to the Microsoft Entra admin center screen.
2.  In the left navigation, under **Identity**, select **Groups**.
3.  In the Groups screen, on the menu, select **New group**.
4.  Create a group using the following information:
    
    | **Setting**     | **Value**                                                |
    | --------------- | -------------------------------------------------------- |
    | Group type      | Security                                                 |
    | Group name      | Marketing                                                |
    | Membership type | Assigned                                                 |
    | Owners          | Assign your own administrator account as the group owner |
    | Members         | Chris Green                                              |
    
    :::image type="content" source="../media/create-group-7be1cd36.png" alt-text="Screenshot of the new group creation page in Microsoft Entra ID. The New Group page has the Group type, Group name, Owners, and Members highlighted. Chris Green is being added to the group as it is being created.":::
    
5.  When complete, verify the group named **Marketing** is shown in the **All groups** list.

## Assign a license to a group

1.  In the **All groups** list, select **Marketing**.
2.  In the Marketing window, under **Manage**, select **Licenses**.
3.  On the menu, select **Assignments**.
4.  In the update license assignments, under **Select licenses**, review the list of available licenses and then select the check box for one of the licenses.
5.  Under **Review license** options, review the available options for the license you have selected.
    
    > [!TIP]
    > When multiple licenses are selected, you can use the Review license options menu to select a specific license and view the license option for that license.
    
    :::image type="content" source="../media/assign-license-group-779b730c.png" alt-text="Screenshot of the select license dialog. The image displays licenses selected and assigned to a group. The review license menu is also selected displaying multiple licenses being added to the group.":::
    
6.  Select **Save**.

## Restore or remove a recently deleted user with Microsoft Entra ID

After you delete a user, the account remains in a suspended state for 30 days. During that 30-day window, the user account can be restored, along with all its properties. After that 30-day window passes, the permanent deletion process is automatically started.

You can view your restorable users, restore a deleted user, or permanently delete a user using Microsoft Entra ID user interface.

> [!IMPORTANT]
> Neither you nor Microsoft customer support can restore a permanently deleted user.

## Required permissions

You must have one of the following roles to restore or permanently delete users.

 -  Global administrator
 -  Partner Tier-1 Support
 -  Partner Tier-2 Support
 -  User administrator
