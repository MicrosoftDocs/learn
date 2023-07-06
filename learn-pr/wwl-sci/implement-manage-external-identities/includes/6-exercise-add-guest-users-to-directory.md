## Add guest users to the directory

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a user who is assigned a limited administrator directory role or the Guest Inviter role.
2.  Select **Azure Active Directory**.
3.  Under **Manage**, select **Users**.
4.  Select **New guest user**.
    
    :::image type="content" source="../media/new-guest-user-menu-selection-9080639a.png" alt-text="Screenshot of the Users screen with the New guest user menu option selected.":::
    
5.  On the New user page, select **Invite user** and then add your information as the guest user.
6.  Group email addresses are not supported; enter the email address for an individual. Also, some email providers allow users to add a plus symbol (+) and additional text to their email addresses to help with things like inbox filtering. However, Azure AD does not currently support plus symbols in email addresses. To avoid delivery issues, omit the plus symbol and any characters following it up to the @ symbol.
7.  When complete, select **Invite**.
8.  On the Users screen, verify your account is listed and, in the **User type** column, verify **Guest** is shown.

After you send the invitation, the user account is automatically added to the directory as a guest.
