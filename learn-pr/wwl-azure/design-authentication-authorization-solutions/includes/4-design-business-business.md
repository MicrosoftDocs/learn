Every organization needs to work with external users. [Microsoft Entra business-to-business (B2B)](/azure/active-directory/external-identities/what-is-b2b) is a feature of Microsoft Entra ID that enables you to securely collaborate with external partners. Your partner users are invited as guest users. You remain in control of what they have access to, and for how long. 

:::image type="content" source="../media/external-identities.png" alt-text="Diagram that shows how business-to-business users are invited to Microsoft Entra ID." border="false":::

<a name='things-to-know-about-azure-ad-b2b'></a>

### Things to know about Microsoft Entra B2B

Let's explore how the Microsoft Entra B2B features can support external users in a business-to-business solution for Tailwind Traders.

- With Microsoft Entra B2B, the external partner uses their own identity management solution. Microsoft Entra ID isn't required.

- Tailwind Traders doesn't need to manage the _external_ accounts or passwords.

- Tailwind Traders doesn't need to sync the external accounts or manage the account lifecycles.

- External users use their identities to collaborate with the Tailwind Traders organization. The identities are managed by the partner themselves, or by another external identity provider on their behalf. 

- Guest users sign in to the Tailwind Traders apps and services with their own work, school, or social identities.

- Microsoft Entra B2B makes it possible for Tailwind Traders to collaborate with external partner users.

   :::image type="content" source="../media/business-to-business-guest-users.png" alt-text="Diagram that shows how guest users are invited to Microsoft Entra ID." border="false":::
 
   1. External users are invited as guest users to access the Tailwind Traders directory. You might fill in a form with the guest user's details and send them a custom invitation message.

   1. The guest user receives the Tailwind Traders invitation via email. The first time the invite link is used, the user is asked for consent. The user must accept the permissions needed by Microsoft Entra B2B before they can gain access to Tailwind Traders. 

   1. If you enabled multifactor authentication (MFA), the user provides the extra details for their account. When MFA is configured, the user must enter a verification code sent to their mobile device before they're granted access.

   1. The guest user is then forwarded to the access panel page for Tailwind Traders. The page shows all the apps and services that you shared with that user. These apps and services can be cloud-based, or on-premises.


<a name='things-to-consider-when-using-azure-ad-b2b'></a>

### Things to consider when using Microsoft Entra B2B

Tailwind Traders wants to provide identity management for partners, external vendors, and guest users. As the CTO, you'd like to use Microsoft Entra B2B to implement this support. Here are some options to keep in mind.

- **Consider designating an app owner to manage guest users**. (Microsoft recommended) Delegate guest user access to Tailwind Traders app owners because the owners know best who should be given access to their apps.

- **Consider conditional access policies to control access**. Define conditional access policies to intelligently grant or deny access to users. Conditional access policies use factors that aren't credential-based. You might make it mandatory for users to be on specific device platforms like Android or Windows. You might block users from accessing Tailwind Traders, if they don't meet the required location criteria.

- **Consider the benefits of using MFA**. Set conditional access policies to require an [MFA process](/azure/active-directory/authentication/concept-mfa-howitworks), before the user can access Tailwind Traders apps. This action ensures that all users who access an app must pass an extra authentication challenge before accessing the app.

- **Consider integration with identity providers**. Integrate with identity providers so external users can sign in by using an existing account. Microsoft Entra ID supports external identity providers like Facebook, Microsoft accounts, Google, or enterprise identity providers. You can set up federation for Tailwind Traders with identity providers so external users can use their existing social or enterprise account. External users won't have to create a new account just to access your Tailwind Traders apps.

- **Consider self-service sign-up user flow**. Create a self-service sign-up user flow for external users who want to access your Tailwind Traders apps. As part of the sign-up flow, you can provide options for different social or enterprise identity providers, and collect information about the user. You can also customize the onboarding experience for B2B guest users.

