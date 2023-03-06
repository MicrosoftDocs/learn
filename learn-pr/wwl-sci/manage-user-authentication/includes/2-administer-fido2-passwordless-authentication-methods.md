As part of the sign-in experience for accounts in Azure AD, there are several ways that users can authenticate themselves. Historically, a username and password is the most common way a user would provide credentials. With modern authentication and security features in Azure AD, that basic password should be supplemented or replaced with more secure authentication methods.

:::image type="content" source="../media/authentication-methods-4b9b6734.png" alt-text="Screenshot of the strengths and preferred authentication methods in Azure A D.":::


Passwordless authentication methods such as Windows Hello, FIDO2 security keys, and the Microsoft Authenticator app provide the most secure sign-in events.

Azure AD Multi-Factor Authentication (MFA) adds extra security over only using a password when a user signs in. The user can be prompted for other forms of authentication. The user may have to respond to a push notification, enter a code from a software or hardware token. Finally, the user might have to respond to an SMS or phone call.

Simplify the user on-boarding experience by registering for both MFA and self-service password reset (SSPR). Microsoft recommends you enable combined security information registration. For resiliency, we recommend you require users to register multiple authentication methods. When one method isn't available for a user during sign-in or SSPR, they can choose to authenticate with another method.

### Authentication method strength and security

When you deploy features like Azure AD Multi-Factor Authentication in your organization, review the available authentication methods. Choose the methods that meet or exceed your requirements in terms of security, usability, and availability. Where possible, use authentication methods with the highest level of security.

The following table outlines the security considerations for the available authentication methods. Availability is an indication of the user being able to use the authentication method, not of the service availability in Azure AD:

:::image type="content" source="../media/authentication-method-strength-security-c8fdb55b.png" alt-text="Diagram of an X Y grid that shows inconvenient to convenient side to side and low security to high security top to bottom.":::


| **Authentication method**      | **Security** | **Usability** | **Availability** |
| ------------------------------ | ------------ | ------------- | ---------------- |
| Windows Hello for Business     | High         | High          | High             |
| Microsoft Authenticator app    | High         | High          | High             |
| FIDO2 security key             | High         | High          | High             |
| OATH hardware tokens (preview) | Medium       | Medium        | High             |
| OATH software tokens           | Medium       | Medium        | High             |
| SMS                            | Medium       | High          | Medium           |
| Voice                          | Medium       | Medium        | Medium           |
| Password                       | Low          | High          | High             |

> [!TIP]
> For flexibility and usability, we recommend that you use the Microsoft Authenticator app. This authentication method provides the best user experience and multiple modes, such as passwordless, MFA push notifications, and OATH codes.

### How each authentication method works

Some authentication methods can be used as the primary factor when you sign in to an application or device. A good example of primary authentication is to use a FIDO2 security key or a password. Other authentication methods are only available as a secondary factor. Examples are when you use Azure AD Multi-Factor Authentication or SSPR.

The following table outlines when an authentication method can be used during a sign-in event:

| **Method**                     | **Primary authentication** | **Secondary authentication** |
| ------------------------------ | -------------------------- | ---------------------------- |
| Windows Hello for Business     | Yes                        | MFA                          |
| Microsoft Authenticator app    | Yes (preview)              | MFA and SSPR                 |
| FIDO2 security key             | Yes                        | MFA                          |
| OATH hardware tokens (preview) | No                         | MFA and SSPR                 |
| OATH software tokens           | No                         | MFA and SSPR                 |
| SMS                            | Yes (preview)              | MFA and SSPR                 |
| Voice call                     | No                         | MFA and SSPR                 |
| Password                       | Yes                        |                              |

All of these authentication methods can be configured in the Azure portal and increasingly using the Microsoft Graph REST API beta.

> [!NOTE]
> In Azure AD, a password is often one of the primary authentication methods. You can't disable the password authentication method. If you use a password as the primary authentication factor, increase the security of sign-in events using Azure AD Multi-Factor Authentication.

The following verification methods can be used in certain scenarios:

 -  App passwords - used for old applications that don't support modern authentication and can be configured for per-user Azure AD Multi-Factor Authentication.
 -  Security questions - only used for SSPR.
 -  Email address - only used for SSPR.

## What is FIDO2

The FIDO (Fast IDentity Online) Alliance helps to promote open authentication specifications and reduce the use of passwords as a form of authentication. FIDO2 is the latest specification that incorporates the web authentication (WebAuthn) specification. Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices, but could also use Bluetooth or NFC (near field communication). With a hardware device that handles the authentication, the security of an account is increased as there's no password that could be exposed or guessed. FIDO2 security keys can be used to sign into their Azure AD or hybrid Azure AD joined Windows 10 or 11 devices and get single-sign on to their cloud and on-premises resources. Users can also sign into supported browsers. FIDO2 security keys are a great option for enterprises who are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.

 -  FIDO2 security keys are an unphishable specification-based passwordless authentication method that can come in any form factor
 -  Fast Identity Online (FIDO) is an open specification for passwordless authentication
 -  FIDO allows users and organizations to leverage the specification to sign into their resources without a username or password using an external security key or a platform key built into a device

## Enable FIDO2 security key method

1. Sign into the Azure portal.
1. Browse to **Azure Active Directory** \- **Security** \- **Authentication methods** \- **Authentication method policy**.
1. Under the method **FIDO2 Security Key**, choose the following options:
    
    
     -  **Enable** \- Yes or No
     -  **Target** \- All users or Select users
1. **Save** the configuration.

### Manage user registration and FIDO2 security keys

1. Browse to **https://myprofile.microsoft.com**.
1. Sign in if you haven't already.
1. Select **Security Info**.
1. If the user already has at least one Azure AD Multi-Factor Authentication method registered, they can immediately register a FIDO2 security key.
1. If they don't have at least one Azure AD Multi-Factor Authentication method registered, they must add one.
1. Add a FIDO2 security key by selecting **Add method** and choosing **Security key**.
1. Choose **USB device** or **NFC device**.
1. Have your key ready and choose **Next**.
1. A box will appear and ask the user to create/enter a PIN for your security key and then perform the required gesture for the key, either biometric or touch.
1. The user will be returned to the combined registration experience and asked to provide a meaningful name for the key so the user can identify which one if they have multiple. Select **Next**.
1. Select **Done** to complete the process.

### Sign in with passwordless credential

In the example below a user has already provisioned their FIDO2 security key. The user can choose to sign in on the web with their FIDO2 security key inside of a supported browser on Windows 10 version 1903 or higher or Windows 11.

:::image type="content" source="../media/fast-identity-windows-edge-sign-in-6c0f9eb8.png" alt-text="Screenshot of the security key sign-in for Microsoft Edge. Great multifactor verification process.":::


## Prerequisites for cloud-only deployment

 -  Windows 10, version 1511 or later or Windows 11
 -  Microsoft Azure account
 -  Azure AD
 -  Azure AD Multi-Factor Authentication
 -  Modern Management - *optional,* Microsoft Intune, or supported third-party mobile-device management (MDM)
 -  Azure AD Premium subscription - *optional*, needed for automatic MDM enrollment when the device joins Azure AD
