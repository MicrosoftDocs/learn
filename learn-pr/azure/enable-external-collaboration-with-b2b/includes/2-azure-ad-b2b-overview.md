
The clinicians need to access to your organization's application. You'll use Azure Active Directory B2B (Azure AD B2B) give them access.

Here, you'll have a brief overview of the concepts you need to understand to use Azure AD B2B effectively.

## Azure AD B2B overview

Your organization needs to work with external users. To collaborate with your organization, these users will need to have their required level of access to the applications. Azure Active Directory B2B is a service in Azure that enables you to collaborate with your external partners in a secure manner. Your partner users are invited as guest users. You remain in control of what they should have access to, and for how long.

Azure AD B2B let's you collaborate with your external partner users through the following process:

![Azure AD B2B overview](../media/2-guest-user.png)

<!--Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/tutorial-mfa/aad-b2b-mfa-example.png -->

1. **Invite a guest user**

    You invite your external users, as guest users to your directory. There are different ways you can invite guest user, such as through Azure PowerShell or through the Azure portal. You can invite users in bulk, or invite individual users at a time. For example, to invite an individual user using the Azure portal, you'll fill in a form with your guest user's details and a custom invitation message.

    ![Invitation form](../media/2-invitation-form.png)

    Your guest users will show up in your directory, in your list of users. From here, you can manage your users by making changes, removing users, or adding new users.

    ![Invite user in the Azure portal](../media/2-invite-guest-user.png)

1. **Guest user accepts invitation and reviews permissions**

    The guest user receives an invitation via email. The user uses the **Guest started** link in the email to access the services you want to share with them.

    ![Email confirmation](../media/2-email-confirmation.png)

    The user is asked for their consent the first time they use the link. Azure AD B2B helps you provide transparency for your partner users in this way. Your external users will always know what information they're sharing. The user must accept the permissions needed by Azure AD B2B, before they can gain access.

    ![Permissions](../media/2-consentscreen.png)

    <!-- Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/what-is-b2b/consentscreen.png -->

1. **Multi-factor authentication**

    At this point, if you've enabled multi-factor authentication, the user will need to provide multi-factor authentication details for their account. When multi-factor authentication is configured, the user must enter a verification code sent to their mobile device, before they're granted access.

    ![Multi-factor authentication](../media/2-mfa.png)

1. **User is forwarded to the access panel**

    Your guest user is then forwarded to the access panel page, where they can access all the applications and services you've shared with them. These applications and services can be cloud-based, or on-premises.

    ![Shared apps](../media/2-shared-apps.png)

    <!-- Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/what-is-b2b/access-panel-manage-app.png -->

