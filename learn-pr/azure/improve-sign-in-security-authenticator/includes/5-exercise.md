## Validate the user experience by signing in as a test user

Here, you'll create a Microsoft Entra user account for testing and enable it for Microsoft Authenticator.

:::image type="content" border="true" source="../media/phone-sign-in-microsoft-authenticator-app.png" alt-text="Screenshot of Microsoft Authenticator sign-in.":::

You'll confirm the test user can set up Microsoft Authenticator and have push notifications as the new default sign-in method. After confirming the experience for a test user, you can apply the policy to the remote employees group for your company.

## Create a test user account

Create a user account for the purposes of testing the Microsoft Authenticator registration campaign.

1. Sign in to the [Azure portal](https://portal.azure.com), then search for and select **Microsoft Entra ID** then select **Users** under **Manage**.
1. Select **New user** at the top of the pane, the select **Create new user**.
1. In the **User principal name** field, enter the username for the user account. For example, `contosouser1`. Select your tenant domain name in the drop-down.
1. In the **Display name** field, enter user's name for the account. For example, `contosouser1`.
1. Leave Auto-generate password selected, and then select **Show password**. Record the value that's displayed in the **Password** box.
1. Select **Review + create**, then select **Create**.
1. Select the newly created user in the list, then select **Authentication methods** under **Manage** on the left menu.
1. Enter a mobile phone number to which you have access in the **Phone** field. Select **Save** in the taskbar.

## Add the user to the Remote employees group

1. From the Azure portal home, search for and select **Microsoft Entra ID**, then select **Groups** under **Manage**.
1. Select the **Remote employees** group (or whatever name you gave to your group for remote workers).
1. Select **Members** under **Manage** in the left menu.
1. Select **Add members** in the taskbar, then search for and check the box next to the user you created in the previous section.
1. Select the **Select** button to add the user to the group.

## Test the sign-in flow

Sign in as the test user from a device that hasn't already set up Microsoft Authenticator. The device must use the phone number that you enabled for authentication.

1. Sign in to Azure and perform MFA with the phone number you entered (via SMS or phone call).
1. When prompted, set up the Microsoft Authenticator app. Only users who are allowed for the Microsoft Authenticator push notifications and do not have it currently set up will see the prompt.

   :::image type="content" border="true" source="../media/how-to-nudge-authenticator-app/user-mfa.png" alt-text="Screenshot of a user who performs multifactor authentication.":::

1. Select **Next** and step through Microsoft Authenticator setup. 
    1. First, download the app.  
    1. Learn how to set up Microsoft Authenticator. 
    1. Scan the QR Code.
    1. Approve the test notification.
    1. After the notification is approved, Microsoft Authenticator is successfully set up as the user’s default sign-in method.

       :::image type="content" border="true" source="../media/how-to-nudge-authenticator-app/finish.png" alt-text="Screenshot of setup completion for Microsoft Authenticator.":::

1. If you don't want to install Microsoft Authenticator, select **Not now** to snooze the prompt for up to 14 days. Admins can set the snooze duration.
