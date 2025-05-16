**Exercise environment needs** - this lab assumes you have a basic Microsoft Entra tenant with at least User Administrator rights to complete it.  You can get a free trial subscription for at [Try Azure for Free](https://azure.microsoft.com/free).

## Remove a user from Microsoft Entra ID

1. Browse to the [Microsoft Entra admin center](https://entra.microsoft.com/).
2. In the left navigation, under **Identity**, select **Users**.
3. In the **Users** list, select the check box for a user that will be deleted. For example, select **Chris Green**.
    
   > [!TIP]
   > Selecting users from the list allows you to manage multiple users at the same time. If you select the user, to open that user’s page, you will only be managing that individual user.
   
   :::image type="content" source="../media/remove-user.png" alt-text="Screenshot of Microsoft Entra ID all users' list with one user check box selected.":::
    
4. With the user account selected, on the menu, select **Delete user**.
5. Review the dialog box and then select **OK**.

## Restore a deleted user

You can see all the users that were deleted less than 30 days ago. These users can be restored.

1. In the Users page, in the left navigation, select **Deleted users**.
2. Review the list of deleted users and select the user you deleted.
    
   > [!IMPORTANT]
   > By default, deleted user accounts are permanently removed from Microsoft Entra ID automatically after 30 days.

3. On the menu, select **Restore user**.
4. Review the dialog box and then select **OK**.
5. In the left navigation, select **All users**.
6. Verify the user has been restored.
