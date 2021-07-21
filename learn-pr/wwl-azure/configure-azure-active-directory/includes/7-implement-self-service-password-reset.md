Many helpdesk calls are requests to reset passwords for users. Enabling **Self-service password reset** (SSPR) gives the users the ability to bypass the helpdesk and reset their own passwords.

To configure Self-Service Password Reset, you first determine who will be enabled to use self-service password reset. From your existing Azure AD tenant, on the Azure portal under **Azure Active Directory** select **Password reset.**

In the Password reset properties there are three options: **None**, **Selected**, and **All**.

:::image type="content" source="../media/AZ104_Conf_SSPR-1221c9a0.png" alt-text="Screenshot of the Password reset - Properties page in Azure portal showing the options for which groups can be enabled for self-service password reset None, Selected, and All.":::


The **Selected** option is useful for creating specific groups who have self-service password reset enabled. You can create group for testing or proof of concept before deploying to a larger group. Once you are ready to deploy this functionality to all users with accounts in your AD Tenant, you can change the setting to **All**.

## Authentication methods

After enabling password reset for user and groups, you pick the number of authentication methods required to reset a password and the number of authentication methods available to users.

At least one authentication method is required to reset a password. It is a good idea to have other methods available. You can choose from email notification, a text, or code sent to user’s mobile or office phone, or a set of security questions.

:::image type="content" source="../media/AZ104_Auth_for_SSPR-aedf554e.png" alt-text="Screenshot from the Azure portal of the Password reset - Authentication methods page showing Azure AD authentication methods available and the number required.":::


You can require a security questions to be registered for the users in your AD tenant. You can also configure how many correctly answered security questions are required for a successful password reset. Security questions can be less secure than other methods because some people might know the answers to another user's questions.

> [!NOTE]
> Azure Administrator accounts can always reset their passwords no matter what options are configured.
