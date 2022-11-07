Many helpdesk calls are requests to reset passwords for users. The Azure Active Directory **self-service password reset** (SSPR) feature lets you give users the ability to bypass helpdesk and reset their own passwords.

### Things to know about the Azure AD SSPR feature

Examine the following characteristics and requirements of the SSPR feature:

- SSPR requires an Azure AD account with Global Administrator privileges to manage SSPR options. This account can always reset their own passwords, no matter what options are configured.

- SSPR uses a security group to limit the users who have SSPR privileges.

- All user accounts in your organization must have a valid license to use SSPR.

### Things to consider when using SSPR

Your organization wants to implement support for SSPR in their management solution. As you plan for your configuration, review the following points:

- **Consider who can reset their passwords**. Decide which users in your organization should be enabled to use the feature. In the Azure portal, there are three options for the SSPR feature: **None**, **Selected**, and **All**.

   :::image type="content" source="../media/configure-password-reset-6d7cf7b8.png" alt-text="Screenshot that shows the self-service password reset options for an Azure AD tenant in the Azure portal.":::

   The **Selected** option is useful for creating specific groups who have SSPR enabled. You can create groups for testing or proof of concept before applying the feature to a larger group. When you're ready to deploy SSPR to all user accounts in your Azure AD tenant, you can change the setting.

- **Consider your authentication methods**. Determine how many authentication methods are required to reset a password, and select the authentication options for users.

   - Your system must require at least one authentication method to reset a password.

   - A strong SSPR plan offers multiple authentication methods for the user. Options include email notification, text message, or a security code sent to the user's mobile or office phone. You can also offer the user a set of security questions.

   - You can require security questions to be registered for the users in your Azure AD tenant.

   - You can configure how many correctly answered security questions are required for a successful password reset.

- **Consider combining methods for stronger security**. Security questions can be less secure than other authentication methods. Some users might know the answers for a particular user's questions, or the questions might be easy to solve. If you support security questions, combine this option with other authentication methods.
