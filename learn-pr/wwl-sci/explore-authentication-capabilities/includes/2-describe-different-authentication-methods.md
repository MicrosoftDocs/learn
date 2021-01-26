Legacy applications have relied on a single form of authentication, most often a password. However, passwords are problematic for users, and easily compromised. *Multifactor authentication* requires more than one form of verification, such as a trusted device or a fingerprint scan, to prove that an identity is legitimate. It means that, even when an identity’s password has been compromised, a hacker can't access a resource.

Multifactor authentication dramatically improves the security of an identity, while still being simple for users. The extra authentication factor must be something that's difficult for an attacker to obtain or duplicate.

The following video explains the problem with passwords, and why multifactor authentication is so important.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4zhD7]

Azure Active Directory multifactor authentication works by requiring:

- **Something you know** – typically a password or PIN **and**
- **Something you have** – such as a trusted device that's not easily duplicated, like a phone or hardware key **or**
- **Something you are** – biometrics like a fingerprint or face scan.

Multifactor authentication verification prompts are configured to be part of the Azure AD sign-in event. Azure AD automatically requests and processes multifactor authentication, without you making any changes to your applications or services. When a user signs in, they receive a multifactor authentication prompt, and can choose from one of the additional verification forms that they've registered.

An administrator can require certain verification methods, or the user can access their MyAccount to edit or add verification methods.

The following extra forms of verification can be used with Azure Active Directory multifactor authentication:

- Microsoft Authenticator app
- SMS
- Voice call
- OATH Hardware token

:::image type="content" source="../media/2-microsoft-authenticator-app.png" alt-text="Microsoft authenticator app":::

## Security defaults and multifactor authentication

Security defaults are a set of basic identity security mechanisms recommended by Microsoft. When enabled, these recommendations will be automatically enforced in your organization. The goal is to ensure that all organizations have a basic level of security enabled at no extra cost. These defaults enable some of the most common security features and controls, including:

- Enforcing Azure Active Directory multifactor authentication registration for all users.
- Forcing administrators to use multifactor authentication.
- Requiring all users to complete multifactor authentication when needed.

Security defaults are a great option for organizations that want to increase their security posture but don’t know where to start, or for organizations using the free tier of Azure AD licensing.  Security defaults may not be appropriate for organizations with Azure AD premium licenses or more complex security requirements. To find out more, see **What are security defaults?** in the Learn More section in the summary.
