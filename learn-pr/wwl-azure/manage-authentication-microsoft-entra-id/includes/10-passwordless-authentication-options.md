Features like multifactor authentication (MFA) are a great way to secure your organization, but users often get frustrated with the additional security layer on top of having to remember their passwords. Passwordless authentication methods are more convenient because the password is removed and replaced with something you have, plus something you are or something you know.<br>

| **Authentication** | **Something you have**                    | **Something you are or know** |
| ------------------ | ----------------------------------------- | ----------------------------- |
| Passwordless       | Windows 10 Device, phone, or security key | Biometric or PIN              |

Each organization has different needs when it comes to authentication. Microsoft Azure and Azure Government offer the following four passwordless authentication options that integrate with Microsoft Entra ID:

 -  Windows Hello for Business
 -  Microsoft Authenticator
 -  Passkeys FIDO2 (Fast IDentity Online 2)
 -  Certificate-based authentication

:::image type="content" source="../media/passwordless-convenience-security-3e1c4bb8.png" alt-text="Diagram showing multifactor authentication methods.":::


**Windows Hello for Business**

Windows Hello for Business is ideal for information workers that have their own designated Windows PC. The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner. With public key infrastructure (PKI) integration and built-in support for single sign-on (SSO), Windows Hello for Business provides a convenient method for seamlessly accessing corporate resources on-premises and in the cloud.

:::image type="content" source="../media/windows-welcome-page-0b2cf1b6.png" alt-text="Screenshot showing an example of the Windows welcome page.":::


The following steps show how the sign-in process works with Microsoft Entra ID:

:::image type="content" source="../media/windows-hello-flow-b3fcb3d2.png" alt-text="Diagram showing an example of how the sign-in process works with Microsoft Entra ID.":::


1. A user signs into Windows using biometric or PIN gesture. The gesture unlocks the Windows Hello for Business private key and is sent to the Cloud Authentication security support provider, referred to as the Cloud AP provider.

2. The Cloud AP provider requests a nonce (a random arbitrary number that can be used just once) from Microsoft Entra ID.

3. Microsoft Entra ID returns a nonce that's valid for 5 minutes.

4. The Cloud AP provider signs the nonce using the user's private key and returns the signed nonce to the Microsoft Entra ID.

5. Microsoft Entra ID validates the signed nonce using the user's securely registered public key against the nonce signature. Microsoft Entra ID validates the signature and then validates the returned signed nonce. When the nonce is validated, Microsoft Entra ID creates a primary refresh token (PRT) with session key that is encrypted to the device's transport key and returns it to the Cloud AP provider. The Cloud AP provider receives the encrypted PRT with session key.

6. The Cloud AP provider uses the device's private transport key to decrypt the session key and protects the session key using the device's Trusted Platform Module (TPM).

7. The Cloud AP provider returns a successful authentication response to Windows. The user is then able to access Windows as well as cloud and on-premises applications without the need to authenticate again (SSO).

## Microsoft Authenticator

You can also allow your employee's phone to become a passwordless authentication method. You may already be using the Authenticator app as a convenient multifactor authentication option in addition to a password. You can also use the Authenticator App as a passwordless option.

:::image type="content" source="../media/approve-sign-in-page-2e4b3029.png" alt-text="Screenshot showing an example of the Microsoft authenticator application.":::


The Authenticator App turns any iOS or Android phone into a strong, passwordless credential. Users can sign in to any platform or browser by getting a notification to their phone, matching a number displayed on the screen to the one on their phone, and then using their biometric (touch or face) or PIN to confirm.

Passwordless authentication using the Authenticator app follows the same basic pattern as Windows Hello for Business. It's a little more complicated as the user needs to be identified so that Microsoft Entra ID can find the Authenticator app version being used:

:::image type="content" source="../media/authenticator-application-flow-adf46d1a.png" alt-text="Diagram showing how a user signs in with a Fast IDentity Online 2 security key.":::


1. The user enters their username.

2. Microsoft Entra ID detects that the user has a strong credential and starts the Strong Credential flow.

3. A notification is sent to the app via Apple Push Notification Service (APNS) on iOS devices, or via Firebase Cloud Messaging (FCM) on Android devices.

4. The user receives the push notification and opens the app.

5. The app calls Microsoft Entra ID and receives a proof-of-presence challenge and nonce.

6. The user completes the challenge by entering their biometric or PIN to unlock private key.

7. The nonce is signed with the private key and sent back to Microsoft Entra ID.

8. Microsoft Entra ID performs public/private key validation and returns a token.

## Passkeys (FIDO2)

The FIDO (Fast IDentity Online) Alliance helps to promote open authentication standards and reduce the use of passwords as a form of authentication. FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard.

FIDO2 security keys are an unphishable standards-based passwordless authentication method that can come in any form factor. Fast Identity Online (FIDO) is an open standard for passwordless authentication. FIDO allows users and organizations to leverage the standard to sign in to their resources without a username or password using an external security key or a platform key built into a device.

Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices, but could also use Bluetooth or NFC. With a hardware device that handles the authentication, the security of an account is increased as there's no password that could be exposed or guessed.

FIDO2 security keys can be used to sign in to their Microsoft Entra ID or Microsoft Entra hybrid joined Windows 10 devices and get single-sign on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises who are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.

See the reference document here: [Support for FIDO2 authentication with Microsoft Entra ID](/entra/identity/authentication/fido2-compatibility). For developer best practices, see [Support FIDO2 auth in the applications they develop](/entra/identity-platform/support-fido2-authentication).

> [!NOTE]
> If you purchase and plan to use NFC-based security keys, you need a supported NFC reader for the security key. The NFC reader isn't an Azure requirement or limitation. Check with the vendor for your NFC-based security key for a list of supported NFC readers.

If you're a vendor and want to get your device on this list of supported devices, check out our guidance on how to [become a Microsoft-compatible FIDO2 security key vendor](/entra/identity/authentication/concept-fido2-hardware-vendor).

To get started with FIDO2 security keys, complete the following how-to:

[Enable passwordless sign using FIDO2 security keys](/entra/identity/authentication/howto-authentication-passwordless-security-key)

:::image type="content" source="../media/concept-web-sign-in-security-key-e14a87a7.png" alt-text="Screenshot showing a requirement to sign in with Windows Hello or a security key.":::


The following process is used when a user signs in with a FIDO2 security key:

:::image type="content" source="../media/fast-identity-online-2-security-key-flow-04704017.png" alt-text="Screenshot showing how a user signs in with a Fast IDentity Online 2 security key.":::


1. The user plugs the FIDO2 security key into their computer.

2. Windows detects the FIDO2 security key.

3. Windows sends an authentication request.

4. Microsoft Entra ID sends back a nonce.

5. The user completes their gesture to unlock the private key stored in the FIDO2 security key's secure enclave.

6. The FIDO2 security key signs the nonce with the private key.

7. The primary refresh token (PRT) token request with signed nonce is sent to Microsoft Entra ID.

8. Microsoft Entra ID verifies the signed nonce using the FIDO2 public key.

9. Microsoft Entra ID returns PRT to enable access to on-premises resources.

## FIDO2 security key providers

The following providers offer FIDO2 security keys of different form factors that are known to be compatible with the passwordless experience. We encourage you to evaluate the security properties of these keys by contacting the vendor and the [FIDO Alliance](https://fidoalliance.org/).

## Certificate-based authentication

Microsoft Entra certificate-based authentication (CBA) enables customers to allow or require users to authenticate directly with X.509 certificates against their Microsoft Entra ID for applications and browser sign-in. CBA enables customers to adopt phishing-resistant authentication and sign in with an X.509 certificate against their Public Key Infrastructure (PKI).

:::image type="content" source="../media/cloud-native-certificate-27ad7a44.png" alt-text="Diagram showing an example of certificate-based authentication.":::


### Key benefits of using Microsoft Entra CBA

| **Benefits**                  | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Great user experience         | - Users who need certificate-based authentication can now directly authenticate against Microsoft Entra ID and not have to invest in federated AD FS.<br>\- Portal UI enables users to easily configure how to map certificate fields to a user object attribute to look up the user in the tenant ([certificate username bindings](/entra/identity/authentication/concept-certificate-based-authentication-technical-deep-dive#understanding-the-username-binding-policy))<br>\- Portal UI to [configure authentication policies](/entra/identity/authentication/concept-certificate-based-authentication-technical-deep-dive#understanding-the-authentication-binding-policy) to help determine which certificates are single-factor versus multifactor.                                                                                                                                                         |
| Easy to deploy and administer | - Microsoft Entra CBA is a free feature, and you don't need any paid editions of Microsoft Entra ID to use it.<br>\- No need for complex on-premises deployments or network configuration.<br>\- Directly authenticate against Microsoft Entra ID.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Secure                        | - On-premises passwords don't need to be stored in the cloud in any form.<br>\- Protects your user accounts by working seamlessly with Microsoft Entra Conditional Access policies, including Phishing-Resistant [multifactor authentication](/entra/identity/authentication/concept-mfa-howitworks) (MFA requires [licensed edition](/entra/identity/authentication/concept-mfa-licensing)) and blocking legacy authentication.<br>\- Strong authentication support where users can define authentication policies through the certificate fields, such as issuer or policy OID (object identifiers), to determine which certificates qualify as single-factor versus multifactor.<br>\- The feature works seamlessly with [Conditional Access features](/entra/identity/conditional-access/overview) and authentication strength capability to enforce MFA to help secure your users. |

### Supported scenarios

The following scenarios are supported:

 -  User sign-ins to web browser-based applications on all platforms.
 -  User sign-ins to Office mobile apps on iOS/Android platforms as well as Office native apps in Windows, including Outlook, OneDrive, and so on.
 -  User sign-ins on mobile native browsers.
 -  Support for granular authentication rules for multifactor authentication by using the certificate issuer **Subject** and **policy OIDs**.
 -  Configuring certificate-to-user account bindings by using any of the certificate fields:
     -  Subject Alternate Name (SAN) PrincipalName and SAN RFC822Name
     -  Subject Key Identifier (SKI) and SHA1PublicKey
 -  Configuring certificate-to-user account bindings by using any of the user object attributes:
     -  User Principal Name
     -  onPremisesUserPrincipalName
     -  CertificateUserIds

### Unsupported scenarios

We recommend no more than **20 sets of keys** for each passwordless method for any user account. As more keys are added, the user object size increases, and you may notice degradation for some operations. In that case, you should remove unnecessary keys.

When you use PowerShell to create a CSV file with all of the existing keys, carefully identify the keys that you need to keep, and remove those rows from the CSV. Then use the modified CSV with PowerShell to delete the remaining keys to bring the account key count under the limit.

It is safe to delete any key reported as "Orphaned"="True" in the CSV. An orphaned key is one for a device that is not longer registered in Microsoft Entra ID. If removing all Orphans still doesn't bring the User account below the limit it is necessary to look at the "DeviceId" and "CreationTime" columns to identify which keys to target for deletion. Be careful to remove any row in the CSV for keys you want to keep. Keys for any DeviceID corresponding to devices the user actively uses should be removed from the CSV before the deletion step.

## Choose a passwordless method<br>

The choice between these three passwordless options depends on your company's security, platform, and app requirements.

Here are some factors for you to consider when choosing Microsoft passwordless technology:

| **System Nexus**    | **Windows Hello for Business**                                                                                                                                                                                                                                                   | **Passwordless sign-in with the Authenticator app**                                                                                                                 | **FIDO2 security keys**                                                                                                                                                                                                                                   |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Pre-requisite       | Windows 10, version 1809 or later<br>Microsoft Entra ID                                                                                                                                                                                                                          | Authenticator app<br>Phone (iOS and Android devices)                                                                                                                | Windows 10, version 1903 or later<br>Microsoft Entra ID                                                                                                                                                                                                   |
| Mode                | Platform                                                                                                                                                                                                                                                                         | Software                                                                                                                                                            | Hardware                                                                                                                                                                                                                                                  |
| Systems and devices | PC with a built-in Trusted Platform Module (TPM)<br>PIN and biometrics recognition                                                                                                                                                                                               | PIN and biometrics recognition on phone                                                                                                                             | FIDO2 security devices that are Microsoft compatible                                                                                                                                                                                                      |
| User experience     | Sign in using a PIN or biometric recognition (facial, iris, or fingerprint) with Windows devices.<br>Windows Hello authentication is tied to the device; the user needs both the device and a sign-in component such as a PIN or biometric factor to access corporate resources. | Sign in using a mobile phone with fingerprint scan, facial or iris recognition, or PIN.<br>Users sign in to work or personal account from their PC or mobile phone. | Sign in using FIDO2 security device (biometrics, PIN, and NFC)<br>User can access device based on organization controls and authenticate based on PIN, biometrics using devices such as USB security keys and NFC-enabled smartcards, keys, or wearables. |
| Enabled scenarios   | Password-less experience with Windows device.<br>Applicable for dedicated work PC with ability for single sign-on to device and applications.                                                                                                                                    | Password-less anywhere solution using mobile phone.<br>Applicable for accessing work or personal applications on the web from any device.                           | Password-less experience for workers using biometrics, PIN, and NFC.<br>Applicable for shared PCs and where a mobile phone isn't a viable option (such as for help desk personnel, public kiosk, or hospital team)                                        |

Use the following table to choose which method will support your requirements and users.

| **Persona**        | **Scenario**                                      | **Environment**              | **Passwordless technology**                          |
| ------------------ | ------------------------------------------------- | ---------------------------- | ---------------------------------------------------- |
| Admin              | Secure access to a device for management tasks    | Assigned Windows 10 device   | Windows Hello for Business and/or FIDO2 security key |
| Admin              | Management tasks on non-Windows devices           | Mobile or non-windows device | Passwordless sign-in with the Authenticator app      |
| Information worker | Productivity work                                 | Assigned Windows 10 device   | Windows Hello for Business and/or FIDO2 security key |
| Information worker | Productivity work                                 | Mobile or non-windows device | Passwordless sign-in with the Authenticator app      |
| Frontline worker   | Kiosks in a factory, plant, retail, or data entry | Shared Windows 10 devices    | FIDO2 Security keys                                  |
