One of the main features of an identity platform is to verify, or *authenticate*, credentials when a user signs in to a device, application, or service. In Microsoft Entra ID, authentication involves more than just the verification of a username and password. To improve security and reduce the need for help desk assistance, Microsoft Entra authentication includes the following components:

 -  Self-service password reset
 -  Microsoft Entra multifactor authentication
 -  Hybrid integration to write password changes back to on-premises environment
 -  Hybrid integration to enforce password protection policies for an on-premises environment
 -  Passwordless authentication

## Improve the end-user experience

Microsoft Entra ID helps to protect a user's identity and simplify their sign-in experience. Features like self-service password reset let users update or change their passwords using a web browser from any device. This feature is especially useful when the user has forgotten their password or their account is locked. Without waiting for a helpdesk or administrator to provide support, a user can unblock themselves and continue to work.

Microsoft Entra multifactor authentication lets users choose an additional form of authentication during sign-in, such as a phone call or mobile app notification. This ability reduces the requirement for a single, fixed form of secondary authentication like a hardware token. If the user doesn't currently have one form of additional authentication, they can choose a different method and continue to work.

:::image type="content" source="../media/azure-multifactor-authentication-verification-prompt-f9180449.png" alt-text="Screenshot showing available options in Azure Microsoft Multifactor verify your identity page.":::


Passwordless authentication removes the need for the user to create and remember a secure password at all. Capabilities like Windows Hello for Business or FIDO2 security keys let users sign in to a device or application without a password. This ability can reduce the complexity of managing passwords across different environments.

## Self-service password reset

Self-service password reset gives users the ability to change or reset their password, with no administrator or help desk involvement. If a user's account is locked or they forget their password, they can follow prompts to unblock themselves and get back to work. This ability reduces help desk calls and loss of productivity when a user can't sign in to their device or an application.

Self-service password reset works in the following scenarios:

 -  Password change - when a user knows their password but wants to change it to something new.
 -  Password reset - when a user can't sign in, such as when they forgot password, and want to reset their password.
 -  Account unlock - when a user can't sign in because their account is locked out and want to unlock their account.

When a user updates or resets their password using self-service password reset, that password can also be written back to an on-premises Active Directory environment. Password writeback makes sure that a user can immediately use their updated credentials with on-premises devices and applications.

## Microsoft Entra multifactor authentication

Multifactor authentication is a process where a user is prompted during the sign-in process for an additional form of identification, such as to enter a code on their cellphone or to provide a fingerprint scan.

If you only use a password to authenticate a user, it leaves an insecure vector for attack. If the password is weak or has been exposed elsewhere, is it really the user signing in with the username and password, or is it an attacker? When you require a second form of authentication, security is increased as this additional factor isn't something that's easy for an attacker to obtain or duplicate.

:::image type="content" source="../media/azure-multifactor-authentication-process-flow-options-a1c776a5.png" alt-text="Diagram showing an example of the Microsoft Entra multifactor authentication user sign-in process.":::
 Microsoft Entra multifactor authentication works by requiring two or more of the following authentication methods:

 -  Something you know, typically a password.
 -  Something you have, such as a trusted device that is not easily duplicated, like a phone or hardware key.
 -  Something you are - biometrics like a fingerprint or face scan.

Users can register themselves for both self-service password reset and Microsoft Entra multifactor authentication in one step to simplify the on-boarding experience. Administrators can define what forms of secondary authentication can be used. Microsoft Entra multifactor authentication can also be required when users perform a self-service password reset to further secure that process.
