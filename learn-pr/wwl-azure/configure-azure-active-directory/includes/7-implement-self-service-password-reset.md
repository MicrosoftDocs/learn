Many helpdesk calls are requests to reset passwords for users. Enabling **Self-service password reset** (SSPR) gives the users the ability to bypass the helpdesk and reset their own passwords.

To configure Self-Service Password Reset, you first determine who will be enabled to use self-service password reset. From your existing Azure AD tenant, on the Azure portal under **Azure Active Directory** select **Password reset.**

In the Password reset properties there are three options: **None**, **Selected**, and **All**.

:::image type="content" source="../media/configure-password-reset-6d7cf7b8.png":::


You can require a security questions to be registered for the users in your AD tenant. You can also configure how many correctly answered security questions are required for a successful password reset. Security questions can be less secure than other methods because some people might know the answers to another user's questions.

> [!NOTE]
> Azure Administrator accounts can always reset their passwords no matter what options are configured.
