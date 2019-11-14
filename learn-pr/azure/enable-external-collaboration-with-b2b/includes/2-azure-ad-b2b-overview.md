
You need to enable the clinicians to access to your organization's application. You'll use Azure Active Directory B2B (Azure AD B2B).

Here, you'll have a brief overview of the concepts you need to understand to use Azure AD B2B effectively.

## Azure AD B2B overview

Your organization needs to work with external users. To collaborate with your organization, these users will need to have their required level of access to the applications. Azure Active Directory B2B is a service in Azure that enables you to collaborate with your external partners in a secure manner. Your partner users are invited as guest users. You remain in control of what they should have access to, and for how long.

A typical Azure AD B2B workflow can be as follows:

![Azure AD B2B overview](../media/2-guest-user.png)

<!--Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/tutorial-mfa/aad-b2b-mfa-example.png -->

You invite your external users, as guest users to your directory. For example, you can invite them using the Azure portal. Your guest users will show up in your directory in your list of users.

![Invite user in the Azure portal](../media/2-invite-guest-user.png)

The guest users receive an invitation via email. The user uses the link in the email to access the apps you want to share with them. The user is asked for their consent the first time they use the link. Azure AD B2B provides transparency for your partner users in this way. Your external users know what information they're sharing. 

![Permissions](../media/2-consentscreen.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/what-is-b2b/consentscreen.png -->

Your guest users are then forwarded to the access panel page, where they can access all the applications and services you have allowed to be shared with them.  These application and services can be cloud-based, or on-premises based. 

![Shared apps](../media/2-shared-apps.png)

<!-- Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/what-is-b2b/access-panel-manage-app.png -->

Optionally, you can add multi-factor authentication as an additional layer of protection for your guest users and apps.  When the user then attempts to access an application, they're prompted to enter a verification code sent to their mobile device, before they're granted access.
