Authentication establishes the identity of a person, service, or device by requiring credentials. In Azure, common methods include passwords, single sign-on (SSO), multifactor authentication (MFA), and passwordless sign-in. Modern approaches are designed to improve both security and user convenience.

The following diagram shows the security level compared to the convenience. Notice Passwordless authentication is high security and high convenience while passwords on their own are low security but high convenience.

:::image type="content" source="../media/authentication-methods-option-auth-spectrum.png" alt-text="Diagram comparing Password Only, Multifactor Authentication, and Passwordless methods across security and convenience. Passwordless scores highest on both scales.":::


## What's single sign-on?

Single sign-on (SSO) lets a user sign in once and access multiple trusted applications. SSO reduces password sprawl, which lowers the chance of credential-related incidents and decreases account lockout and reset overhead.

From an operations perspective, SSO also simplifies lifecycle management. Access is tied to one identity, making it easier to update or remove access when roles change.

> [!IMPORTANT]
> Single sign-on is only as secure as the initial authenticator because the subsequent connections are all based on the security of the initial authenticator.

## What’s multifactor authentication?

Multifactor authentication (MFA) prompts a user for an extra factor during sign-in, so a compromised password alone isn't enough for access. These factors fall into three categories:

 -  **Something the user knows** — a password or challenge question.
 -  **Something the user has** — a code sent to a mobile phone.
 -  **Something the user is** — a biometric signal such as a fingerprint or face scan.

With MFA enabled, an attacker who obtains a password still needs the second factor — such as a phone prompt or biometric signal — to complete sign-in.

### What's Microsoft Entra multifactor authentication?

Microsoft Entra multifactor authentication is a Microsoft service that provides multifactor authentication capabilities. Microsoft Entra multifactor authentication enables users to choose an additional form of authentication during sign-in, such as a phone call or mobile app notification.

## What’s passwordless authentication?

While MFA adds security, passwords themselves remain a usability and risk challenge. Passwordless methods eliminate the password entirely, replacing it with a trusted device plus a biometric signal or PIN.

After initial registration, the user signs in with a factor they know or are — such as a PIN or fingerprint — instead of typing a password.

Microsoft Entra ID supports three passwordless options:

 -  Windows Hello for Business
 -  Microsoft Authenticator app
 -  FIDO2 security keys

:::image type="content" source="../media/authentication-methods-option-passwordless-comparison.png" alt-text="Three-card comparison of Windows Hello for Business, Microsoft Authenticator, and FIDO2 Security Keys showing authentication type, form factor, and best-fit scenario for each.":::

### Windows Hello for Business

Windows Hello for Business is ideal for information workers that have their own designated Windows PC. The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner. With public key infrastructure (PKI) integration and built-in support for single sign-on (SSO), Windows Hello for Business provides a convenient method for seamlessly accessing work resources on-premises and in the cloud.

### Microsoft Authenticator app

The Microsoft Authenticator app can also serve as a passwordless credential, turning any iOS or Android phone into a strong sign-in factor.

To sign in, the user receives a notification on their phone, matches a number displayed on screen, and confirms with a biometric signal (touch or face) or PIN. No password is needed.

### FIDO2 security keys

FIDO2 is an open standard for passwordless authentication built on the web authentication (WebAuthn) specification. FIDO2 security keys are unphishable hardware devices — typically USB, but also available with Bluetooth or NFC — that handle authentication without a username or password.

Users register a FIDO2 key and then select it at the sign-in screen as their primary authentication method. Because the hardware device handles authentication, there's no password that could be exposed or guessed.

