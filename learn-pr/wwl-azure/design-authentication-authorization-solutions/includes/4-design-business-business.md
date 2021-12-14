Every organization needs to work with external users. [Azure AD Business to Business (B2B)](/azure/active-directory/external-identities/what-is-b2b) is a feature of Azure AD that enables you to securely collaborate with external partners. Your partner users are invited as guest users. You remain in control of what they have access to, and for how long. 

With Azure AD B2B, the partner uses their own identity management solution. Azure AD is not required. You don't need to manage external accounts or passwords. You don't need to sync accounts or manage account lifecycles. Guest users sign in to your apps and services with their own work, school, or social identities.

With Azure AD B2B, external users can use their identities to collaborate with your organization. Their identities are managed by the partner themselves, or by another external identity provider on their behalf. 

:::image type="content" source="../media/external-identities.png" alt-text="Business to Business users are invited to Azure Active Directory.":::


The following steps show how Azure AD B2B lets you collaborate with external partner users. The numbers in the diagram are explained after the diagram.

:::image type="content" source="../media/business-to-business-guest-users.png" alt-text="Guest users are invited to Azure Active Directory.":::
 

1. You invite external users as guest users to your directory. For example, you fill in a form with your guest user's details and a custom invitation message.

2. Guest user receives an invitation via email. The first time the link is used, the user is asked for consent. The user must accept the permissions needed by Azure AD B2B before they can gain access. 

3. If you've enabled multifactor authentication (MFA), the user provides these extra details for their account. When MFA is configured, the user must enter a verification code sent to their mobile device before they're granted access.

4. Your guest user is then forwarded to the access panel page. This page presents all the applications and services you've shared with them. These applications and services can be cloud-based, or on-premises.

## Best practices for Azure AD B2B

- **Designate an application owner to manage guest users.** It’s a good idea to delegate guest user access to application owners. Application owners are in the best position to decide who should be given access to a particular application.

- **Use conditional access policies to intelligently grant or deny access**. Conditional access policies use factors that aren't credential-based. For example, you can make it mandatory for users to be on specific device platforms, such as Android or Windows. Another example, you can block users if they don't meet the required location criteria.

- **Enable MFA**. You can use conditional access policies to require a [MFA process](/azure/active-directory/authentication/concept-mfa-howitworks), before they can access applications. This action ensures that everyone who uses the application must pass an additional authentication challenge before accessing it.

- **Integrate with identity providers**. Azure AD supports external identity providers like Facebook, Microsoft accounts, Google, or enterprise identity providers. You can set up federation with identity providers so your external users can sign in with their existing social or enterprise accounts instead of creating a new account just for your application. 

- **Create a self-service sign-up user flow**. With a self-service sign-up user flow, you can create a sign-up experience for external users who want to access your apps. As part of the sign-up flow, you can provide options for different social or enterprise identity providers, and collect information about the user. You can also Customize the onboarding experience for B2B guest users. 
