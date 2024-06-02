Microsoft Entra ID supports several bulk operations, including bulk create and delete for user accounts. The most common approach for these operations is to use the Azure portal. Azure PowerShell can be used for bulk upload of user accounts.

### Things to know about bulk account operations

Let's examine some characteristics of bulk operations in the Azure portal. Here's an example that shows the **Bulk create user** option for new user accounts in Microsoft Entra ID:

:::image type="content" source="../media/bulk-user-accounts-224ad1b7.png" alt-text="Screenshot that shows the Bulk create user option for new user accounts in Azure AD.":::

- Only Global administrators or User administrators have privileges to create and delete user accounts in the Azure portal.

- To complete bulk create or delete operations, the admin fills out a comma-separated values (CSV) template of the data for the user accounts.

- Bulk operation templates can be downloaded from the Microsoft Entra admin center.

- Bulk lists of user accounts can be downloaded.

### Things to consider when creating user accounts

Here are some design considerations for creating and deleting user accounts. Think about what user account conventions and processes might be required by your organization.

- **Consider naming conventions**. Establish or implement a naming convention for your user accounts. Apply conventions to user account names, display names, and user aliases for consistency across the organization. Conventions for names and aliases can simplify the bulk create process by reducing areas of uniqueness in the CSV file. A convention for user names could begin with the user's last name followed by a period, and end with the user's first name, as in `Sawyer-Miller.Aran@contoso.com`.

- **Consider using initial passwords**. Implement a convention for the initial password of a newly created user. Design a system to notify new users about their passwords in a secure way. You might generate a random password and email it to the new user or their manager.

- **Consider strategies for minimizing errors**. View and address any errors, by downloading the results file on the **Bulk operation results** page in the Azure portal. The results file contains the reason for each error. An error might be a user account that's already been created or an account that's duplicated. Generally, it's easier to upload and troubleshoot smaller groups of user accounts.
