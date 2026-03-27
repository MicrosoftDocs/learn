Multifactor authentication is a process in which users are prompted during the sign-in process for another form of identification. If you only use a password to authenticate a user, it leaves an insecure vector for attack. If the password is weak or exposed elsewhere, an attacker could be using it to gain access. When you require a second form of authentication, security is increased because this additional factor isn't something that's easy for an attacker to obtain or duplicate.

Microsoft Entra multifactor authentication works by requiring two or more of the following authentication methods:

- **Something you know**—typically a password or PIN **and**
- **Something you have**—such as a trusted device that's not easily duplicated, like a phone or hardware key **or**
- **Something you are**—biometrics like a fingerprint or face scan.

Multifactor authentication verification prompts are part of the Microsoft Entra sign-in event. Microsoft Entra ID automatically requests and processes multifactor authentication, without you making any changes to your applications or services. When a user signs in, they receive a multifactor authentication prompt and can choose from one of the other verification forms that they've registered. An administrator can require certain verification methods, or the user can access their MyAccount to edit or add verification methods.

### Available verification methods

The following forms of verification can be used with Microsoft Entra multifactor authentication:

- Microsoft Authenticator
- Authenticator Lite (in Outlook)
- Windows Hello for Business
- Passkey (FIDO2)
- Passkey in Microsoft Authenticator
- Certificate-based authentication (when configured for multifactor authentication)
- External authentication methods
- Temporary Access Pass (TAP)
- OATH hardware token
- OATH software token
- Short message service (SMS)
- Voice call

:::image type="content" source="../media/2-microsoft-authenticator-app.png" alt-text="Screen capture showing ways to verify your identity during sign-in.":::

### Security defaults and multifactor authentication

Security defaults are a set of basic identity security mechanisms recommended by Microsoft. When enabled, these recommendations are automatically enforced in your organization. The goal is to ensure that all organizations have a basic level of security enabled at no extra cost.

Based on Microsoft learnings, more than 99.9% of common identity-related attacks are stopped by using multifactor authentication and blocking legacy authentication. Security defaults include:

- Requiring all users to register for Microsoft Entra multifactor authentication.
- Requiring administrators to do multifactor authentication.
- Requiring all users to complete multifactor authentication when needed.
- Blocking legacy authentication protocols.
- Protecting privileged activities like access to the Azure portal.

Security defaults are a great option for organizations that want to increase their security posture but don't know where to start, or for organizations using the free tier of Microsoft Entra ID licensing. Security defaults are enabled by default on new tenants.

When users sign in and are prompted to perform multifactor authentication under security defaults, they see a screen providing them with a number to enter in the Microsoft Authenticator app. This number matching measure helps prevent users from falling for MFA fatigue attacks.

### Conditional Access and multifactor authentication

For organizations with more complex security requirements, Microsoft Entra Conditional Access policies provide more granular control. Conditional Access allows administrators to define policies that require MFA based on specific conditions, such as user location, device state, risk level, or the sensitivity of the application being accessed. For example, a policy might allow regular sign-in when the user is on a corporate network but require extra verification when the user is remote or on a personal device. Conditional Access requires Microsoft Entra ID P1 or P2 licenses.

> [!NOTE]
> Conditional Access, including authentication strengths and protecting AI services with MFA, is covered in more detail in the module, [Describe the access management capabilities of Microsoft Entra](/training/modules/explore-access-management-capabilities/).
