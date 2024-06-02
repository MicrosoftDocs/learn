Microsoft Entra users can satisfy multifactor authentication requirements by using various authentications methods. 

Your company wants remote employees to use more secure sign-in methods than SMS and voice call, so you need to research what options are available.

Here, you'll review modern authentication methods and security features. Then, you'll compare various methods for security, usability, and availability before deciding how to switch remote employees to a more secure sign-in method.

:::image type="content" border="true" source="../media/methods.png" alt-text="Diagram showing authentication methods.":::

<a name='what-authentication-and-verification-methods-are-available-in-azure-active-directory'></a>

## What authentication and verification methods are available in Microsoft Entra ID?

Users with accounts in Microsoft Entra ID have many ways to authenticate themselves when they sign in for services like Microsoft 365 or Azure. While a username and password is one common way, that basic password should be supplemented or replaced with the modern authentication and security features in Microsoft Entra ID.

Let's take a closer look at each method to better understand their advantages. Knowing the advantages of each method will help you determine a path to move remote employees from less secure methods.

### Microsoft Authenticator

For flexibility and usability, Microsoft recommends that you use Microsoft Authenticator. This authentication method provides the best user experience. Users can sign in to any platform or browser by getting a notification to their phone, matching a number displayed on the screen to the one on their phone, and then using their biometric (touch or face) or PIN to confirm. It has multiple modes, such as passwordless, MFA push notifications, and OATH codes.

:::image type="content" border="true" source="../media/phone-sign-in-microsoft-authenticator-app.png" alt-text="Screenshot of Microsoft Authenticator sign-in.":::

### Windows Hello for Business

Windows Hello for Business is ideal for information workers who have their own designated Windows PCs. The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner. With public key infrastructure (PKI) integration and built-in support for single sign-on (SSO), Windows Hello for Business provides a convenient method for seamlessly accessing corporate resources on-premises and in the cloud.

:::image type="content" border="true" source="../media/windows-hello-sign-in.jpeg" alt-text="Screenshot of Windows Hello for Business sign-in.":::

### FIDO2 security keys

The FIDO (Fast IDentity Online) Alliance helps to promote open authentication standards and reduce the use of passwords as a form of authentication. FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard.

FIDO2 security keys are an unphishable, standards-based passwordless authentication method that can come in any form factor. Fast Identity Online (FIDO) is an open standard for passwordless authentication. FIDO allows users and organizations to leverage the standard to sign in to their resources without a username or password by using an external security key or a platform key built into a device.

Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices, but could also use Bluetooth or NFC. With a hardware device that handles the authentication, account security is increased because there's no password that could be exposed or guessed.

Users can use FIDO2 security keys to sign in to their Microsoft Entra ID or Microsoft Entra hybrid joined Windows devices and get single-sign-on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises that are very security sensitive, or have scenarios where employees aren't willing or able to use their phone as a second factor.

:::image type="content" border="true" source="../media/security-key.png" alt-text="Screenshot of FIDO2 Security key sign-in.":::

### OATH tokens

OATH TOTP (Time-based One Time Password) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes.

Software OATH tokens are typically applications such as Microsoft Authenticator and other authenticator apps. Microsoft Entra ID generates the secret key, or *seed*, that's input into the app and used to generate each OTP. Microsoft Authenticator automatically generates codes when set up to do push notifications, so a user has a backup even if their device doesn't have connectivity.

OATH-TOTP SHA-1 hardware tokens refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. These keys must be input into Microsoft Entra ID.

:::image type="content" border="true" source="../media/oath-tokens.png" alt-text="Screenshot of OATH token upload.":::

### SMS

Frontline workers often use SMS-based sign-in. With SMS-based sign-in, users don't need to know a username and password to access applications and services. The user instead enters their registered mobile phone number, receives a text message with a verification code, and enters that code into the sign-in interface. SMS authentication is less secure than other methods, because SMS messages are not encrypted and can be intercepted.

### Voice call

Users can also verify themselves using a mobile phone as secondary form of authentication. With phone call verification, an automated voice call is made to the phone number the user registers. To complete the sign-in process, the user is prompted to press # on their keypad. Like SMS, voice calls are less secure than other authentication methods because they're not encrypted and can be intercepted.
  
## Compare security

The following table summarizes user considerations for each Microsoft Entra authentication method. Usability refers to how easily users can sign in with that method. For example, you can only use OATH tokens as a secondary form of verification. Availability refers to the number of environments where users can sign in with that method. Some environments don't allow phones to be used for verification, which makes SMS and Voice call less available.

| Authentication method          | Security | Usability | Availability |
|--------------------------------|:--------:|:---------:|:------------:|
| Windows Hello for Business     | High     | High      | High         |
| Microsoft Authenticator app    | High     | High      | High         |
| FIDO2 security key             | High     | High      | High         |
| OATH hardware tokens           | Medium   | Medium    | High         |
| OATH software tokens           | Medium   | Medium    | High         |
| SMS                            | Medium   | High      | Medium       |
| Voice                          | Medium   | Medium    | Medium       |
| Password                       | Low      | High      | High         |

## Decide which authentication methods to enable

Budget constraints prevent some passwordless options. In your scenario, you can't buy new PCs with Windows Hello for Business or FIDO2 security keys. On the other hand, remote employees who sign in with SMS or voice call already have phones that run either Android or iOS. Microsoft Authenticator is a free app that can turn those phones into a strong credential that's more secure than an SMS or voice call, and also capable for passwordless sign-in.

You decide to promote Microsoft Authenticator push notifications as an easy way to move remote employees from less secure methods. You'll create a *registration campaign* to nudge users to set up Microsoft Authenticator whenever they sign in.

:::image type="content" border="true" source="../media/switch.png" alt-text="Diagram showing switch to more secure authentication methods.":::
