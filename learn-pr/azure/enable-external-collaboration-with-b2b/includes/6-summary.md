Your organization needed to publish an application that allows clinicians from partnering healthcare providers to access records for patients at your facilities. As the admin, you were asked to enable them to collaborate securely.

Azure AD B2B makes it possible to collaborate with external users. First, you checked your cross-tenant access settings and external collaboration settings to make sure B2B collaboration was available. You invited external users as guests in Azure AD B2B. Then you added the guest as a user of an application that you wanted to share for collaboration. You explored how to add extra security to the collaboration through Conditional Access policies that enforce multi-factor authentication.

Without Azure AD B2B, collaboration would be more difficult. Users couldn't just use their existing credentials to access the application. You wouldn't have been able to scope an external user's access to a particular application only. Instead, you might have been forced to give access at a higher scope. External users could then be given more access than they need, resulting in an increased security risk. Without the ease of enforcing multi-factor authentication through Conditional Access policies, configuring multi-factor authentication would be more complex and time consuming.

You can use Azure AD B2B to rapidly create a collaborative environment with external users whom you invite. Users can be given access through a simple invitation and redemption process. Users select a link, and get access to an application, just by sharing their email address. You don't have to create and store credentials for them, avoiding any unnecessary responsibilities. You can also use Conditional Access policies that enforce multi-factor authentication, to add an extra layer of security for the shared application.

## Learn more

To learn more about Azure AD B2B, see:

- [Azure Active Directory B2B documentation](/azure/active-directory/external-identities/)
- [What is guest user access in Azure Active Directory B2B?](/azure/active-directory/external-identities/what-is-b2b)
- [External Identities in Azure Active Directory](/azure/active-directory/external-identities/external-identities-overview)