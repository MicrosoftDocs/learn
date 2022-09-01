Azure Active Directory (Azure AD) supports bulk create and delete operations for user accounts. You can also download lists of user accounts.

Just fill out the comma-separated values (CSV) template. You can download the template from the Azure AD portal. To create users in the Azure portal, you must be signed in as a Global administrator or User administrator.

:::image type="content" source="../media/bulk-user-accounts-224ad1b7.png" alt-text="Screenshot of a CSV file being processed for a new user and written to Azure AD.":::


## Things to consider when using the template

 -  **Naming conventions**. Establish or implement a naming convention for usernames, display names, and aliases. For example, a user name could consist of last name, period, first name: 'Smith.John@contoso.com'.
 -  **Passwords**. Implement a convention for the initial password of the newly created user. Figure out a way for the new users to receive their password in a secure way. Methods commonly used include generating a random password and emailing it to the new user or their manager.

> [!NOTE]
> PowerShell is also available for bulk user uploads.
