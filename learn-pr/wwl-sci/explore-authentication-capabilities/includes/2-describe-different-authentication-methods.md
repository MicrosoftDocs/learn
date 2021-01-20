Legacy applications have relied on a single form of authentication, most often a password. However, passwords are problematic for users, and easily compromised. *Multi-factor authentication* (MFA) requires more than one form of verification to prove that an identity is legitimate, such as a trusted device or a fingerprint scan. That means that even when an identity’s password has been compromised, a hacker cannot gain entry to a resource.

Multi-factor authentication dramatically improves the security of an identity, whilst still being simple for users. The additional authentication factor must be something that is difficult for an attacker to obtain or duplicate.

The following video explains the problem with passwords, and why multi-factor authentication is so important.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4zhD7]

Azure Active Directory Multi-Factor Authentication works by requiring:

- **Something you know** – typically a password or PIN **and**
- **Something you have** – such as a trusted device that is not easily duplicated, like a phone or hardware key **or**
- **Something you are** - biometrics like a fingerprint or face scan.

Multi-factor authentication verification prompts are configured to be part of the Azure AD sign-in event. Azure AD automatically requests and processes multi-factor authentication, without you making any changes to your applications or services. When a user signs in, they receive an MFA prompt, and can choose from one of the additional verification forms that they've registered.

An administrator can require certain verification methods, or the user can access their MyAccount to edit or add verification methods.

The following additional forms of verification can be used with Azure Active Directory multi-factor authentication:

- Microsoft Authenticator app
- SMS
- Voice call
- OATH Hardware token

:::image type="content" source="../media/2-microsoft-authenticator-app.png" alt-text="Microsoft authenticator app":::

## Security defaults and MFA

Security defaults are a set of basic identity security mechanisms recommended by Microsoft. When enabled, these recommendations will be automatically enforced in your organization. The goal is to ensure that all organizations have a basic level of security enabled at no extra cost. These defaults enable some of the most common security features and controls, including:

- Enforcing Azure Active Directory Multi-Factor Authentication registration for all users
- Forcing Administrators to use Multi-Factor Authentication
- Requiring all users to perform Multi-Factor Authentication when needed

Security defaults are a great option for organizations that want to increase their security posture but don’t know where to start, or for organizations using the free tier of Azure AD licensing.  Security defaults may not be appropriate for organizations with Azure AD premium licenses or more complex security requirements. To learn more, see **What are security defaults?** in the Learn More section below.
