
You need to enable the clinicians to access to your organization's application. You'll use Azure Active Directory B2B (Azure AD B2B).

Here, you'll have a brief overview of the concepts you need to understand to use Azure AD B2B effectively.

## Azure AD B2B overview

Your organization needs to work with external users. To collaborate with your organization, these users will need to have their required level of access to the applications. Azure Active Directory B2B is a service in Azure that enables you to collaborate with your external partners in a secure manner. Your partner users are invited as guest users. You remain in control of what they should have access to, and for how long.

![Azure AD B2B overview](../media/2-guest-user.png)

<!--Original image: https://docs.microsoft.com/en-us/azure/active-directory/b2b/media/tutorial-mfa/aad-b2b-mfa-example.png -->

Azure AD B2B's concept of guest users make it possible for external users to have the right level of access. Guest users are more restricted compared with regular default member users. Default member users are accounts meant for an organization's internal users. A user that is a default member user type can potentially be given access to read all administrative roles and memberships, read subscriptions or properties of policies, whereas guest users will not be able to do these things.

 You can collaborate with your partners, even if they do not have an IT department that commonly manages the identities within an organization. You use your partnering user's email address to collaborate with them. You can send an invitation to via their email address, or share a direct link, and they will only have to click a link to access your shared applications.

Azure AD B2B also makes it possible for you to put Conditional Access policies in place to further protect your applications. So you can ensure access is only granted if certain criteria are met. As an example, you can ensure that users are asked to complete an additional authentication step with multi-factor authentication before accessing an application.

Azure AD B2B also enables you to have a customized onboarding process. You can create self-service sign-up forms using the B2B invitation API so users can request the appropriate access the need. So you can build your own onboarding processes for your applications. You're also able to delegate specific owners of applications to handle the invitations for guest users for those applications. This feature is helpful if, for example, you want to make it possible for a sales manager to invite guest users to a sales application their team uses internally.
