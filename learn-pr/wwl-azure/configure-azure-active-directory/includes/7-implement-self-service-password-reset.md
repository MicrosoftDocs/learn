Many helpdesk calls are requests to reset passwords for users. Enabling **Self-service Password Reset** (SSPR) gives the users the ability to bypass the helpdesk and reset their own passwords.

To configure Self-Service Password Reset, you first determine who will be enabled to use self-service password reset. From your existing Azure AD tenant, on the Azure portal under **Azure Active Directory (Users)** select **Password reset.**

In the Password reset properties there are three options: **None**, **Selected**, and **All**.

:::image type="content" source="../media/configure-password-reset-6d7cf7b8.png" alt-text="Password reset options":::


The **Selected** option is useful for creating specific groups who have self-service password reset enabled. You can create group for testing or proof of concept before deploying to a larger group. Once you are ready to deploy this functionality to all users with accounts in your AD Tenant, you can change the setting.

**Authentication methods**

After enabling password reset for user and groups, you pick the number of authentication methods required to reset a password and the number of authentication methods available to users. At least one authentication method is required to reset a password. It is a good idea to have other methods available. You can choose from email notification, a text, or code sent to user’s mobile or office phone, or a set of security questions.

You can require security questions to be registered for the users in your AD tenant. You can also configure how many correctly answered security questions are required for a successful password reset. Security questions can be less secure than other methods because some people might know the answers to another user's questions.

> [!NOTE]
> Azure Administrator accounts can always reset their passwords no matter what options are configured.
