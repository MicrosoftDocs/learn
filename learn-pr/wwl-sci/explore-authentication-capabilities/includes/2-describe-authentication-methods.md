One of the main features of an identity platform is to verify, or authenticate, credentials when a user signs in to a device, application, or service. Microsoft Entra ID offers different methods of authentication. 

### Passwords

Passwords are the most common form of authentication, but they have many problems, especially if used in single-factor authentication, where only one form of authentication is used. If they're easy enough to remember, they're easy for a hacker to compromise. Strong passwords that aren't easily hacked are difficult to remember and affect user productivity when forgotten.  

The use of passwords should be supplemented or replaced with more secure authentication methods available in Microsoft Entra ID.

:::image type="content" source="../media/authentication-methods-inline.png" lightbox="../media/authentication-methods-expanded.png" alt-text="Diagram showing how passwords should be supplemented or replaced.  The best approach is Passwordless.":::

### Phone

 Microsoft Entra ID supports two options for phone-based authentication.  

- **SMS-based authentication**. Short message service (SMS) used in mobile device text messaging can be used as a primary form of authentication. With SMS-based sign-in, users don't need to know a username and password to access applications and services. The user instead enters their registered mobile phone number, receives a text message with a verification code, and enters that in the sign-in interface.

    Users can also choose to verify their identity through SMS text messaging on a mobile phone, as a secondary form of authentication during self-service password reset (SSPR) or Microsoft Entra Multifactor Authentication.  For example, users can supplement their password by using SMS text messaging. An SMS is sent to the mobile phone number containing a verification code. To complete the sign-in process, the verification code provided is entered into the sign-in interface.

- **Voice call verification**. Users can use voice calls as a secondary form of authentication, to verify their identity, during self-service password reset (SSPR) or Microsoft Entra Multifactor Authentication.  With phone call verification, an automated voice call is made to the phone number registered by the user. To complete the sign-in process, the user is prompted to press # on their keypad. Voice calls are not supported as a primary form of authentication, in Microsoft Entra ID.

### OATH

OATH (Open Authentication) is an open standard that specifies how time-based, one-time password (TOTP) codes are generated. One-time password codes can be used to authenticate a user. OATH TOTP is implemented using either software or hardware to generate the codes.

- **Software OATH tokens** are typically applications. Microsoft Entra ID generates the secret key, or seed, that's input into the app and used to generate each OTP.

- **OATH TOTP hardware tokens** (supported in public preview) are small hardware devices that look like a key fob that displays a code that refreshes every 30 or 60 seconds. OATH TOTP hardware tokens typically come with a secret key, or seed, preprogrammed in the token. These keys and other information specific to each token must be input into Microsoft Entra ID and then activated for use by end-users.

OATH software and hardware tokens, are only supported as secondary forms of authentication in Microsoft Entra ID, to verify an identity during self-service password reset (SSPR) or Microsoft Entra Multifactor Authentication.

### Passwordless authentication
The end-goal for many organizations is to remove the use of passwords as part of sign-in events. When a user signs in with a passwordless method, credentials are provided by using methods like biometrics with Windows Hello for Business, or a FIDO2 security key. These authentication methods can't be easily duplicated by an attacker.

Microsoft Entra ID provides ways to natively authenticate using passwordless methods to simplify the sign-in experience for users and reduce the risk of attacks.

The following video explains the problem with passwords, and why passwordless authentication is so important.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4zhD7]

#### Windows Hello for Business 
Windows Hello for Business replaces passwords with strong two-factor authentication on devices. This two-factor authentication is a combination of a key or certificate tied to a device and something that the person knows (a PIN) or something that the person is (biometrics). PIN entry and biometric gesture both trigger the use of the private key to cryptographically sign data that is sent to the identity provider. The identity provider verifies the user's identity and authenticates the user.

Windows Hello for Business helps protect against credential theft, because an attacker must have both the device and the biometric info or PIN, making it more difficult to gain access without the employee's knowledge.

As a passwordless authentication method, Windows Hello for Business serves as a primary form of authentication.  In addition, Windows Hello for Business can be used as a secondary form of authentication to verify an identity during multifactor authentication.

#### FIDO2
Fast Identity Online (FIDO) is an open standard for passwordless authentication. FIDO allows users and organizations to leverage the standard to sign in to their resources using an external security key or a platform key built into a device, eliminating the need for a username and password.

FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard and is supported by Microsoft Entra ID.  FIDO2 security keys are an unphishable standards-based passwordless authentication method that can come in any form factor. These FIDO2 security keys are typically USB devices, but could also be Bluetooth or Near Field Communication (NFC) based devices, which are used for short-range wireless data transfer. With a hardware device that handles the authentication, the security of an account is increased as there's no password that could be exposed or guessed.

With FIDO2 security keys, users can sign in to Microsoft Entra ID or hybrid Microsoft Entra ID joined Windows 10 devices and get single-sign on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises who are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.

As a passwordless authentication method, FIDO2 serves as a primary form of authentication.  In addition, FIDO2 can be used as a secondary form of authentication to verify an identity during multifactor authentication.

### Microsoft Authenticator app

As a passwordless authentication method, the Microsoft Authenticator app can be used as a primary form of authentication to sign in to any Microsoft Entra ID account or as an additional verification option during self-service password reset (SSPR) or Microsoft Entra Multifactor Authentication events.

To use Microsoft Authenticator, a user must download the phone app from the Microsoft store and register their account. Microsoft Authenticator is available for Android and iOS.

With Passwordless sign-in, the Authenticator App turns any iOS or Android phone into a strong, passwordless credential. To sign in to their Microsoft Entra ID account, a user enters their username, matches a number displayed on the screen to the one on their phone, then uses their biometric or PIN to confirm.

:::image type="content" source="../media/phone-sign-in-microsoft-authenticator-app.png" alt-text="Screen capture of Microsoft authenticator sign-in request":::

When a user chooses Authenticator as secondary form of authentication, to verify their identity, a notification is pushed to the phone or tablet. If the notification is legitimate, the user selects **Approve**, otherwise, they select **Deny**.

:::image type="content" source="../media/3-microsoft-authenticator-app-approval-request.png" alt-text="Screen Capture of Microsoft authenticator app approval request":::

The Authenticator app can also be used as a software token to generate an OATH verification code. After entering your username and password, you enter the code provided by the Authenticator app into the sign-in interface. The OATH verification code provides a second form of authentication for SSPR or MFA.

### Certificate-based authentication
Microsoft Entra Identity certificate-based authentication (CBA) enables customers to allow or require users to authenticate directly with X.509 certificates against their Microsoft Entra Identity, for applications and browser sign-in.  CBA is supported only as a primary form of passwordless authentication.

X.509 certificates, which are part of the public key infrastructure (PKI), are digitally signed documents that bind an identity (an individual, organization, website) to its public key.  For more information, see [Describe concepts of cryptography]( /training/modules/describe-concepts-of-cryptography/).

### Primary and secondary authentication
Some authentication methods can be used as the primary factor when you sign in to an application or device.  Other authentication methods are only available as a secondary factor when you use Microsoft Entra Multifactor Authentication or SSPR.  While that information is called-out in the text that describes each authentication method, the following table summarizes when an authentication method can be used during a sign-in event.

:::image type="content" source="../media/primary-secondary-authentication-v2-inline.png" lightbox="../media/primary-secondary-authentication-v2-expanded.png" alt-text="Screen capture of a table that summarizes if authentication method is used for primary and/or secondary authentications.":::
