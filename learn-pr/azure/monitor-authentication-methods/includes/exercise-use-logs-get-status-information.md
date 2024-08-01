In this exercise, you'll:

- View sign-in logs for your Microsoft Entra instance.
- Change columns to view in your sign-in logs.
- Filter data to include in your sign-in logs view.
- Review a failed user sign-in.



If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

<a name='view-azure-active-directory-sign-in-logs'></a>

## View Microsoft Entra sign-in logs

To see the sign-in logs for Microsoft Entra ID:

1. Navigate to your [sign-in log](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/SignIns).

1. Click a record in the list to see the **Activity Details** page.

1. Review the information that is tracked for this sign in.



## Create a failed sign-in

To create a failed sign-in:

1. In the Azure portal, navigate to the [Users](https://portal.azure.com/#view/Microsoft_AAD_UsersAndTenants/UserManagementMenuBlade/~/AllUsers) page.

2. In the toolbar on the top, click **New user**, and then click **Create new user**. 
    :::image type="content" source="../media/create-new-user-in-users-all-users.png" alt-text="Screenshot that shows the Users page.":::

3. On the **New user** page, do:

    1. In the **User name** textbox, type **Isabella**.
    
    1. In the **Name** textbox, type **Isabella Simonsen**.
    
    1. Click **Create**.   

4. Try to sign in with the new account using an incorrect password.
    :::image type="content" source="../media/enter-password-dialog.png" alt-text="Screenshot that shows the Enter password dialog for a failed sign-in.":::

5. Wait for 5 minutes to ensure that you can find a record of the sign-in in the sign-in log.



## Review a failed sign-in

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a Reports Reader.

2. Navigate to your [sign-in log](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/SignIns).

3. In the toolbar on the top, click **Add filters**, select **Status**, and then click **Apply**.
    :::image type="content" source="../media/select-status-filter.png" alt-text="Screenshot that shows how to select Status field as filter.":::

4. Select **Failure** as **Status**, and then click **Apply**.                                 
    :::image type="content" source="../media/select-failure-filter.png" alt-text="Screenshot that shows how to select Failure as value for the Status filter.":::

5. Click **Isabella Simonsen** in the list of records.

6. Review Britta's sign-in information.
    :::image type="content" source="../media/activity-details-sign-ins.png" alt-text="Screenshot that shows the details of a failed sign-in.":::
 
