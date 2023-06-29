You need to assign additional permissions to one of your newly created administrators.

In this exercise, you will create a user account to use in the exercises.

## Create an Azure account and add Azure Active Directory Premium P2 trial licenses

The tasks in this exercise and the exercises in this learning path require you to already have an Azure subscription that you can use or to sign up for an Azure trial account. If you already have your own Azure subscription, you may skip this task and continue to the next.

1.  In a web browser, go to [Azure portal](https://azure.microsoft.com/free/).
2.  Scroll down through the page to learn more about the benefits and free services available.
3.  Select **Start free**.
4.  Use the wizard to sign up for your Azure trial subscription.
5.  You will need to an Azure AD P2 license to complete some of the exercises. In the organization you created, search for and then select **Azure Active Directory**.
6.  Select **Licenses** in the menu.
7.  In the right **Quick tasks** menu of the Licenses - Overview page, select **Get a free trial**
8.  Under Getting started with Azure AD, select **Get a free trial for Azure AD Premium**.
9.  In the Activate pane, under **AZURE AD PREMIUM P2**, select **Free trial** and then select **Activate**.
10. In the navigation menu on the left, select **Overview**.
11. Refresh the browser until you see Azure AD Premium P2 under the organization name. It may take a couple of minutes.
12. You may need to sign out and sign back into Microsoft Azure if you encounter any problems with expected features not being available.

## Add a new user

Now, let's create a user account.

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a Global administrator
2.  Search for and then select **Azure Active Directory**.
3.  In the left navigation menu, under **Manage**, select **Users**, then select **New User**.
4.  Create a user using the following information:
    
    | **Setting** | **Value**   |
    | ----------- | ----------- |
    | User name   | Chris       |
    | Name        | Chris Green |
    | First name  | Chris       |
    | Last name   | Green       |
    | Password    | Pass@word1  |
5.  Select **Create**. The user is now created and registered to your organization.

## Assign a role to a user

Using Azure Active Directory (Azure AD), you can designate limited administrators to manage identity tasks in less-privileged roles. Administrators can be assigned for such purposes as adding or changing users, assigning administrative roles, resetting user passwords, managing user licenses, and managing domain names.

1.  In Azure Active Directory, All users blade, select **Chris Green**.
2.  On the **user’s profile** page, select **Assigned roles**. The **Assigned roles** page appears.
3.  Select **Add assignments**, select the role to assign to the user (for example, *Application administrator*), and then select **Add**.
    
    :::image type="content" source="../media/directory-role-select-role-5a90aac4.png" alt-text="Screenshot of the Assigned roles page - showing the selected role of Application administrator.":::
    

The newly assigned Application administrator role appears on the user’s **Assigned roles** page.

## Remove a role assignment

If you need to remove the role assignment from a user, you can also do that from the **Assigned roles** page.

### To remove a role assignment from a user

1.  In **Azure Active Directory**, select **Users**, and then select the user getting the role assignment removed. For example, *Chris Green*.
2.  Select **Assigned roles**, then select the name of the role your wish to removed - `Application Administrator`.
3.  On the far right side of the screen, select **Remove**. Then select **Yes** option when prompted for confirmation.
    
    :::image type="content" source="../media/directory-role-remove-role-b5708b23.png" alt-text="Screenshot of the Remove assignments dialog box with Yes highlighted.":::
    

The Application administrator role is removed from the user and it no longer appears on the **Chris Green – Assigned roles** page.
