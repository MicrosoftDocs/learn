
You're going to use Azure Active Directory B2B (Azure AD B2B) to give clinicians access to your organization's application. 

Here, you'll learn what Azure AD B2B is, and how it works.

## Azure AD B2B overview

Your organization needs to work with external users. To collaborate, these users will require a certain level of access to your applications. Azure Active Directory B2B is a service that enables you to securely collaborate with external partners. With Azure AD B2B, your partner users are invited as guest users. You remain in control of what they have access to, and for how long.

Azure AD B2B lets you collaborate with external partner users through the following process:

![Azure AD B2B overview](../media/2-guest-user.png)

<!--Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/tutorial-mfa/aad-b2b-mfa-example.png -->

1. **Invite a guest user**

    You invite external users as guest users to your directory. There are different ways you can invite a guest user, such as through Azure PowerShell or the Azure portal. You could invite users as individuals one at a time, or in bulk. For example, to invite an individual using the Azure portal, you fill in a form with your guest user's details and a custom invitation message.

    ![Invitation form](../media/2-invitation-form.png)

    Once you've invited your guest users. Your guest users will show up in your directory, in the list of users. From here, you can manage users by making changes, removing users, or adding new ones.

    ![Invite user in the Azure portal](../media/2-invite-guest-user.png)

1. **Guest user accepts invitation and reviews permissions**

    The guest user receives an invitation via email, then uses a link in the email to access the services you want to share with them.

    The user is asked for their consent the first time they use the link. In this way, Azure AD B2B helps to provide transparency for partner users. Your external users will always know what information they're sharing. The user must accept the permissions needed by Azure AD B2B before they can gain access.

    ![Permissions](../media/2-consent-screen.png)

1. **Multi-factor authentication**

    At this point, if you've enabled multi-factor authentication, the user can now provide multi-factor authentication details for their account. When multi-factor authentication is configured, the user must enter a verification code sent to their mobile device, before they're granted access.

    ![Multi-factor authentication](../media/2-mfa.png)

1. **User is forwarded to the access panel**

    Your guest user is then forwarded to the access panel page, where they can access all the applications and services you've shared with them. These applications and services can be cloud-based, or on-premises.
