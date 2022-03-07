Azure Active Directory (Azure AD) supports bulk user create and delete operations and supports downloading lists of users. Just fill out the comma-separated values (CSV) template. You can download the template from the Azure AD portal. To create users in the Azure portal, you must be signed in as a Global administrator or User administrator.

:::image type="content" source="../media/bulk-user-accounts-224ad1b7.png" alt-text="A CSV file is shown being processed by New-ADUser and writing to Azure AD.":::


## Things to consider when using the template

 -  **Naming conventions**. Establish or implement a naming convention for usernames, display names, and aliases. For example, a user name could consist of last name, period, first name: 'Smith.John@contoso.com'.
 -  **Passwords**. Implement a convention for the initial password of the newly created user. Figure out a way for the new users to receive their password in a secure way. Methods commonly used include generating a random password and emailing it to the new user or their manager.

> [!NOTE]
> PowerShell is also available for bulk user uploads.
