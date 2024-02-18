There are several ways to add cloud identity user accounts in Microsoft Entra ID. A common approach is by using the Azure portal. User accounts can also be added to Microsoft Entra ID through Microsoft 365 Admin Center, Microsoft Intune admin console, and the Azure CLI.

### Things to know about cloud identity accounts

Let's review how cloud identity user accounts are defined in Microsoft Entra ID. Here's an example of the new **User** page in the Azure portal. The administrator can **Create** a user within the organization or **Invite** a guest user to provide access to organization resources:

:::image type="content" source="../media/add-user-accounts-133b7dbf.png" alt-text="Screenshot of the User page in the Azure portal.":::

- A new user account must have a display name and an associated user account name. An example display name is `Aran Sawyer-Miller` and the associated user account name could be `asawmill@contoso.com`.

- Information and settings that describe a user are stored in the user account profile.

- The profile can have other settings like a user's job title, and their contact email address.

- A user with Global administrator or User administrator privileges can preset profile data in user accounts, such as the main phone number for the company.

- Non-admin users can set some of their own profile data, but they can't change their display name or account name.

### Things to consider when managing cloud identity accounts

There are several points to consider about managing user accounts. As you review this list, consider how you can add cloud identity user accounts for your organization.

- **Consider user profile data**. Allow users to set their profile information for their accounts, as needed. User profile data, including the user's picture, job, and contact information is optional. You can also supply certain profile settings for each user based on your organization's requirements.

- **Consider restore options for deleted accounts**. Include restore scenarios in your account management plan. Restore operations for a deleted account are available up to 30 days after an account is removed. After 30 days, a deleted user account can't be restored.

- **Consider gathered account data**. Collect sign-in and audit log information for user accounts. Microsoft Entra ID lets you gather this data to help you analyze and improve your infrastructure.
