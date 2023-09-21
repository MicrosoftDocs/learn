You've decided to implement self-service password reset (SSPR) in Azure Active Directory (Azure AD) for your organization. You want to start using SSPR for a group of 20 users in the marketing department as a trial deployment. If everything works well, you'll enable SSPR for your whole organization.

In this unit, you'll learn how to enable SSPR in Azure AD.

## Prerequisites

Before you start to configure SSPR, you need these things in place:

- **An Azure AD organization**: This organization must have at least a trial license enabled.
- **An Azure AD account with Global Administrator privileges**: You'll use this account to set up SSPR.
- **A non-administrative user account**: You'll use this account to test SSPR. It's important that this account isn't an administrator, because Azure AD imposes extra requirements on administrative accounts for SSPR. This user, and all user accounts, must have a valid license to use SSPR.
- **A security group with which to test the configuration**: The non-administrative user account must be a member of this group. You'll use this security group to limit who you roll SSPR out to.

If you don't already have an Azure AD organization that you can use for this module, we'll set one up in the next unit.

## Scope of SSPR rollout

There are three settings for the **Self-service password reset enabled** property:

- **Disabled**: No users in the Azure AD organization can use SSPR. This value is the default.
- **Enabled**: All users in the Azure AD organization can use SSPR.
- **Selected**: Only the members of the specified security group can use SSPR. You can use this option to enable SSPR for a targeted group of users who can test it and verify that it works as expected. When you're ready to roll it out broadly, set the property to **Enabled** so that all users have access to SSPR.

## Configure SSPR

Here are the high-level steps to configure SSPR:

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), go to **Active Directory** > **Password reset**.
1. Properties:
   - Enable SSPR.
   - You can enable it for all users in the Azure AD organization or for selected users.
   - To enable for selected users, you must specify the security group. Members of this group can use SSPR.

    ![Screenshot of the Password Reset configuration panel. Properties option is selected allowing user to enable self service password resets.](../media/3-enable-sspr.png)

1. Authentication methods:
   - Choose whether to require one or two authentication methods.
   - Choose the authentication methods that the users can use.

    ![Screenshot of the Password Reset panel's Authentication methods option selected displaying panel with authentication options.](../media/3-auth-methods.png)

1. Registration:
   - Specify whether users are required to register for SSPR when they next sign in.
   - Specify how often users are asked to reconfirm their authentication information.

    ![Screenshot of the Password Reset panel's Registration option selected displaying panel with registration options.](../media/3-registration-options.png)

1. Notifications: Choose whether to notify users and administrators of password resets.

    ![Screenshot of the Password Reset panel's Notification option selected displaying panel with notification options.](../media/3-notification-settings.png)

1. Customization: Provide an email address or web page URL where your users can get help.

    ![Screenshot of the Password Reset panel's Customization option selected displaying panel with helpdesk options.](../media/3-customization-settings.png)
