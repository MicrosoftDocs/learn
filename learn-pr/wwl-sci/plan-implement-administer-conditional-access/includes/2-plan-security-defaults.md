Managing security can be difficult with common identity-related attacks like password spray, replay, and phishing becoming more and more popular. Security defaults provide secure default settings that Microsoft manages on behalf of organizations to keep customers safe until organizations are ready to manage their own identity security story. Security defaults provide preconfigured security settings, such as:

 - Requiring all users to register for multifactor authentication.
 - Requiring administrators to perform multifactor authentication.
 - Blocking legacy authentication protocols.
 - Requiring users to perform multifactor authentication when necessary.
 - Protecting privileged activities like access to the Azure portal.
    
   :::image type="content" source="../media/security-defaults-azure-active-directory-portal.png" alt-text="Screenshot of the Microsoft Entra admin center with the toggle to enable security defaults.":::

## Availability

Microsoft security defaults are available to everyone. The goal is to ensure that all organizations have a basic level of security enabled at no extra cost. You turn on security defaults in the Azure portal. If your tenant was created on or after October 22, 2019, it is possible security defaults are already enabled in your tenant. To protect all of our users, the security defaults feature is being rolled out to all new tenants created.

### Who's it for?

| **Who should use security defaults?**                                                           | **Who shouldn't use security defaults?**                                                                                                 |
| ----------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Organizations that want to increase their security posture but don't know how or where to start | Organizations currently using Conditional Access policies to bring signals together, make decisions, and enforce organizational policies |
| Organizations utilizing the free tier of Microsoft Entra ID Licensing                           | Organizations with Microsoft Entra ID Premium licenses                                                                                   |
|                                                                                                 | Organizations with complex security requirements that warrant using Conditional Access                                                   |

## Policies enforced

### Unified multifactor authentication registration

All users in your tenant must register for multifactor authentication (MFA) in the form of the Multifactor Authentication. Users have 14 days to register for multifactor authentication within Microsoft Entra ID by using the Microsoft Authenticator app. After the 14 days have passed, the user won't be able to sign in until registration is completed. A user's 14-day period begins after their first successful interactive sign-in after enabling security defaults.

### Protecting administrators

Users with privileged access have increased access to your environment. Due to the power these accounts have, you should treat them with special care. One common method to improve the protection of privileged accounts is to require a stronger form of account verification for sign-in. In Microsoft Entra ID, you can get a stronger account verification by requiring multifactor authentication.

After registration with Multifactor Authentication is finished, the following nine Microsoft Entra administrator roles will be required to perform additional authentication every time they sign in:

 - Global Administrator
 - SharePoint Administrator
 - Exchange Administrator
 - Conditional Access Administrator
 - Security Administrator
 - Helpdesk Administrator
 - Billing Administrator
 - User Administrator
 - Authentication Administrator

### Protecting all users

We tend to think that administrator accounts are the only accounts that need extra layers of authentication. Administrators have broad access to sensitive information and can make changes to subscription-wide settings. But attackers frequently target end users.

After these attackers gain access, they can request access to privileged information on behalf of the original account holder. They can even download the entire directory to perform a phishing attack on your whole organization.

One common method to improve protection for all users is to require a stronger form of account verification, such as multifactor authentication, for everyone. After users complete Multifactor Authentication registration, they'll be prompted for additional authentication whenever necessary. This functionality protects all applications registered with Microsoft Entra ID, including SaaS applications.

### Blocking legacy authentication

To give your users easy access to your cloud apps, Microsoft Entra ID supports a variety of authentication protocols, including legacy authentication. *Legacy authentication* is an authentication request made by:

 - Clients that don't use modern authentication (for example, an Office 2010 client). Modern authentication encompasses clients that implement protocols, such as OAuth 2.0, to support features like multifactor authentication and smart cards. Legacy authentication typically only supports less secure mechanisms like passwords.
 - Client that uses mail protocols such as IMAP, SMTP, or POP3.

Today, the majority of compromising sign-in attempts come from legacy authentication. Legacy authentication does not support multifactor authentication. Even if you have a multifactor authentication policy enabled on your directory, an attacker can authenticate by using an older protocol and bypass multifactor authentication.

After security defaults are enabled in your tenant, all authentication requests made by an older protocol will be blocked. Security defaults blocks Exchange Active Sync basic authentication.
