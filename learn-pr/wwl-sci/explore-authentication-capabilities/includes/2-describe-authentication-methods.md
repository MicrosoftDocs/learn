Authentication is the process of verifying a person's identity before granting access to a resource, application, service, device, or network. It's how a system makes sure users are who they say they are when they try to sign in. Microsoft Entra ID supports a wide range of authentication methods that balance security, usability, and deployment needs.

### Passwords

Passwords are the most common form of authentication, but they have many problems, especially when used as the only form of authentication. If they're easy enough to remember, they're easy for a hacker to compromise. Strong passwords that aren't easily hacked are difficult to remember and affect user productivity when forgotten. The use of passwords should be supplemented or replaced by more secure authentication methods available in Microsoft Entra ID.

:::image type="content" source="../media/authentication-methods-inline.png" lightbox="../media/authentication-methods-expanded.png" alt-text="Diagram showing how passwords should be supplemented or replaced. The best approach is passwordless.":::

### Phone

Microsoft Entra ID supports two options for phone-based authentication. Microsoft recommends that users move away from using text messages or voice calls for multifactor authentication in favor of more modern methods like Microsoft Authenticator or passkeys.

- **SMS-based authentication**. Short message service (SMS) used in mobile device text messaging can be used as a primary form of authentication. With SMS-based sign-in, users enter their registered mobile phone number, receive a text message with a verification code, and enter that code in the sign-in interface. SMS can also serve as a secondary form of authentication during self-service password reset (SSPR) or Microsoft Entra multifactor authentication.

- **Voice call verification**. Users can use voice calls as a secondary form of authentication to verify their identity during SSPR or Microsoft Entra multifactor authentication. An automated voice call is made to the phone number registered by the user, and the user is prompted to press # on their keypad to complete the sign-in process. Voice calls aren't supported as a primary form of authentication in Microsoft Entra ID.

### OATH

OATH (Open Authentication) is an open standard that specifies how time-based, one-time password (TOTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes.

- **Software OATH tokens** are typically applications such as the Microsoft Authenticator app and other authenticator apps. Microsoft Entra ID generates the secret key, or seed, that's input into the app and used to generate each OTP.

- **OATH TOTP hardware tokens** are small hardware devices that look like a key fob and display a code that refreshes every 30 or 60 seconds, providing a second factor for authentication.

Software and hardware OATH tokens are supported as secondary forms of authentication in Microsoft Entra ID, to verify an identity during SSPR or Microsoft Entra multifactor authentication.

### Other authentication methods

Microsoft Entra ID supports several other authentication methods for specific scenarios:

- **Temporary Access Pass (TAP)**. A time-limited passcode issued by an administrator that can be used to sign in and register other authentication methods, including passwordless methods. TAP is useful for onboarding new users or helping users recover access when they've lost their credentials.

- **QR code authentication**. Designed primarily for frontline workers on shared devices, QR code authentication allows users to sign in by scanning a unique QR code (which can be printed on a badge) and entering a numeric PIN, eliminating the need to type complex usernames and passwords.

- **Email one-time passcode (OTP)**. A verification code sent to a user's email address, used as a secondary form of authentication during self-service password reset (SSPR). It can also be configured for guest user sign-in.

- **Platform Credential for macOS**. A phishing-resistant credential backed by the device's Secure Enclave that enables passwordless sign-in and single sign-on (SSO) across apps on macOS devices, using Touch ID or a password to unlock the credential.

- **Authenticator Lite**. A capability embedded in familiar apps like Outlook mobile that allows users to complete MFA using push notifications or time-based one-time passcodes without needing the separate Microsoft Authenticator app.

- **External authentication methods**. Enable organizations to integrate a non-Microsoft multifactor authentication provider (such as Duo Security or RSA SecurID) with Microsoft Entra ID, so users can satisfy MFA requirements using an authentication solution the organization already has in place.

### Passwordless authentication

The end-goal for many organizations is to remove the use of passwords as part of sign-in events. Passwordless methods replace passwords with something you have, combined with something you are or something you know, providing a more secure and convenient experience.

Microsoft Entra ID provides the following passwordless authentication options.

#### Windows Hello for Business

Windows Hello for Business replaces passwords with strong two-factor authentication on devices, combining a key or certificate tied to a device with something the person knows (a PIN) or something the person is (biometrics). The gesture triggers the use of a private key to cryptographically sign data sent to the identity provider, which verifies the user's identity.

Windows Hello for Business helps protect against credential theft because an attacker must have both the device and the biometric info or PIN, making it more difficult to gain access without the employee's knowledge.

#### Passkeys (FIDO2)

Passkeys based on the FIDO2 (Fast Identity Online) standard are a phishing-resistant passwordless authentication method. Passkeys use public key cryptography, where a public-private key pair is created during registration. The private key is stored securely and the public key is registered with Microsoft Entra ID.

There are two types of passkeys:

- **Device-bound passkeys**—the private key is stored on a single physical device and never leaves it. Examples include FIDO2 security keys (USB, Bluetooth, or NFC devices) and passkeys in Microsoft Authenticator.
- **Synced passkeys**—the private key is synced across a user's devices through a cloud passkey provider, like Apple iCloud Keychain or Google Password Manager.

Passkeys are phishing resistant because they're bound to the specific site where they were registered. A passkey created for a legitimate sign-in page can't be used on a fraudulent look-alike site, even one created with AI-powered phishing toolkits.

#### Microsoft Authenticator

The Microsoft Authenticator app provides a versatile, free authentication solution for iOS and Android devices. It supports passkeys, passwordless sign-in, and multifactor authentication.

- **Passkey sign-in**. Users can register a device-bound passkey in the app, enabling phishing-resistant authentication using their biometric or device PIN.
- **Passwordless sign-in**. Instead of entering a password, users see a number on the sign-in screen, match it in their Authenticator app, and confirm using their biometric or PIN.
- **Push notification with number matching**. When used as a secondary factor for MFA or SSPR, the app sends a push notification. The user must enter the number shown on the sign-in screen into the Authenticator app to approve the request.
- **OATH verification codes**. The app can also generate OATH verification codes as another form of authentication.

:::image type="content" source="../media/authenticator-passwordless.png" alt-text="Screen capture of Microsoft Authenticator passwordless sign-in with number matching.":::

#### Certificate-based authentication

Microsoft Entra certificate-based authentication (CBA) enables users to authenticate directly with X.509 certificates against their Microsoft Entra identity. CBA eliminates the need for federated infrastructure like Active Directory Federation Services (AD FS), providing a simplified, cloud-native approach. CBA is supported as a primary form of passwordless authentication and, when configured, as a multifactor authentication method.

### Phishing-resistant authentication

With the rise of AI-driven cyberattacks, traditional MFA methods like SMS or email one-time passwords are increasingly vulnerable to remote phishing, where attackers use social engineering and AI-driven tools to steal identity credentials without physical access to a user's device.

Microsoft recommends phishing-resistant authentication methods for the most secure sign-in experience. These methods use public key cryptography where the credential is bound to the specific website origin (domain) where it was registered. Because the authenticator verifies the requesting site's domain before responding, the credential can't be used on a fraudulent look-alike site, replayed, or shared with malicious actors. Phishing-resistant methods in Microsoft Entra ID include:

- Windows Hello for Business
- Platform Credential for macOS
- Passkeys (FIDO2), including FIDO2 security keys and synced passkeys
- Passkeys in Microsoft Authenticator
- Certificate-based authentication (CBA)

### Primary and secondary authentication

Some authentication methods can be used as the primary factor when you sign in to an application or device. Other authentication methods are only available as a secondary factor when you use Microsoft Entra multifactor authentication or SSPR. The following table summarizes when an authentication method can be used during a sign-in event.

| Method | Primary authentication | Secondary authentication |
|---|---|---|
| Windows Hello for Business | Yes | MFA |
| Platform Credential for macOS | Yes | MFA |
| Passkey (FIDO2) | Yes | MFA |
| Passkey in Microsoft Authenticator | Yes | MFA |
| Synced passkey | Yes | MFA |
| Certificate-based authentication | Yes | MFA |
| Microsoft Authenticator (passwordless) | Yes | No |
| Microsoft Authenticator (push notification) | Yes | MFA and SSPR |
| Authenticator Lite | No | MFA |
| Hardware OATH tokens | No | MFA and SSPR |
| Software OATH tokens | No | MFA and SSPR |
| External authentication methods | No | MFA |
| Temporary Access Pass (TAP) | Yes | MFA |
| SMS sign-in | Yes | MFA and SSPR |
| Voice call | No | MFA and SSPR |
| QR code | Yes | No |
| Email OTP | No | SSPR |
| Password | Yes | No |
