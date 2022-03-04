## Create a new user in Azure Active Directory

You can skip creating this user if you have already created the same user in the earlier module.

1.  Browse to the [Azure Active Directory](https://portal.azure.com/) blade.
2.  In the left navigation, under **Manage**, select **Users**.
3.  In the Users blade, on the menu, select **New user**.
4.  Create a user using the following information:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        User name
      :::column-end:::
      :::column:::
        Chris
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        Chris Green
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        First name
      :::column-end:::
      :::column:::
        Chris
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Last name
      :::column-end:::
      :::column:::
        Green
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Password
      :::column-end:::
      :::column:::
        Pass@word1
      :::column-end:::
    :::row-end:::
    
5.  When complete, verify the account for Chris Green is shown in the **All users** list.

## Create a security group in Azure Active Directory

1.  Browse to the [Azure Active Directory](https://portal.azure.com/) blade.
2.  In the left navigation, under **Manage**, select **Groups**.
3.  In the Groups blade, on the menu, select **New group**.
4.  Create a group using the following information:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Group type
      :::column-end:::
      :::column:::
        Security
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Group name
      :::column-end:::
      :::column:::
        Marketing
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Membership type
      :::column-end:::
      :::column:::
        Assigned
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Owners
      :::column-end:::
      :::column:::
        Assign your own administrator account as the group owner
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Members
      :::column-end:::
      :::column:::
        Chris Green
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/create-group-4f2ec329.png" alt-text="Screen image displaying the New Group blade with Group type, Group name, Owners, and Members highlighted.":::
    
5.  When complete, verify the group named **Marketing** is shown in the **All groups** list.

## Assign a license to a group

1.  In the **All groups** list, select **Marketing**.
2.  In the Marketing blade, under **Manage**, select **Licenses**.
3.  On the menu, select **Assignments**.
4.  In the update license assignments blade, under **Select licenses**, review the list of available licenses and then select the check box for one of the licenses.
5.  Under **Review license** options, review the available options for the license you have selected.

    > [!TIP]
    > When multiple licenses are selected, you can use the Review license options menu to select a specific license and view the license option for that license.:::image type="content" source="../media/assign-license-group-8e7c8e37.png" alt-text="Screen image displaying licenses selected and assigned to a group. The review license menu is also selected displaying multiple selection options.":::

6.  Select **Save**.

## Restore or remove a recently deleted user with Azure Active Directory

After you delete a user, the account remains in a suspended state for 30 days. During that 30-day window, the user account can be restored, along with all its properties. After that 30-day window passes, the permanent deletion process is automatically started.

You can view your restorable users, restore a deleted user, or permanently delete a user using Azure Active Directory (Azure AD) in the Azure portal.

> [!IMPORTANT]
> Neither you nor Microsoft customer support can restore a permanently deleted user.

## Required permissions

You must have one of the following roles to restore or permanently delete users.

 -  Global administrator
 -  Partner Tier1 Support
 -  Partner Tier2 Support
 -  User administrator
