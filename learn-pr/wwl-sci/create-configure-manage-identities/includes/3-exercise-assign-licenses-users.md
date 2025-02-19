**Exercise environment needs** - this lab assumes you have a basic Microsoft Entra tenant with at least User Administrator rights to complete it.  You can get a free trial subscription for at [Try Azure for Free](https://azure.microsoft.com/free).

## Create a new user in Microsoft Entra ID

You can skip creating this user if you have already created the same user in the earlier module.

1.  Browse to the Identity menu in the [Microsoft Entra admin center](https://entra.microsoft.com/).
2.  In the left navigation, under select **Users**, then **All Users.**
3.  Within the Users page, on the menu, select + **New user** and **Create new user**.
4.  Create a user using the following information:
    
    | **Setting**         | **Value**                 |
    | ------------------- | ------------------------- |
    | User principal name | ChrisG                    |
    | Name                | Chris Green               |
    | First name          | Chris                     |
    | Last name           | Green                     |
    | Password            | make up a unique password |
    |                     |                           |
5.  When complete, verify the account for Chris Green is shown in the **All users** list.

## Create a security group in Microsoft Entra ID

1.  Browse to the Microsoft Entra admin center screen.
2.  In the left navigation, under **Identity**, select **Groups** and then **All groups**.
3.  In the Groups screen, on the menu, select **New group**.
4.  Create a group using the following information:
    
    | **Setting**     | **Value**                                                |
    | --------------- | -------------------------------------------------------- |
    | Group type      | Security                                                 |
    | Group name      | Marketing                                                |
    | Membership type | Assigned                                                 |
    | Owners          | Assign your own administrator account as the group owner |
    | Members         | Chris Green                                              |
    
    :::image type="content" source="../media/create-group-7be1cd36-19fd1287.png" alt-text="Screenshot of the new group creation page in Microsoft Entra ID. Create new groups and add members.":::
    
5.  When complete, verify the group named **Marketing** is shown in the **All groups** list.

## Assign a license to a group

1.  In the **All groups** list, select **Marketing**.
2.  In the Marketing window, under **Manage**, select **Licenses**.
3.  Notices that no licenses are currently assigned to this group.
4.  Open a new tab in your browser.
5.  Go to the Microsoft 365 admin center at [http://admin.microsoft.com](https://admin.microsoft.com).
6.  Select **Billing** from the menu on the left.
7.  Select **Licenses**.
8.  From the list of licenses you have available, select one.
9.  Next you'll select **Groups** from the list near the top of the screen.<br>
10. On the Groups page, select + **Assign license**.<br>
11. Search for and select the **Marketing** group we created earlier.
12. Select the **Assign** button at the bottom of the dialog.
13. You should get a message that licenses were successfully assigned.

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
