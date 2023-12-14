Features like **multifactor authentication (MFA)** are a great way to secure your organization. Still, users often get frustrated with the additional security layer on top of having to remember their passwords. Passwordless authentication methods are more convenient because the password is removed and replaced with something you have, plus something you are or something you know.

| **Authentication** | **Something you have**                    | **Something you are or know** |
| ------------------ | ----------------------------------------- | ----------------------------- |
| Passwordless       | Windows 10 Device, phone, or security key | Biometric or PIN              |

Each organization has different needs when it comes to authentication. Microsoft global Azure and Azure Government offer the following **three** passwordless authentication options that integrate with Azure Active Directory (Azure AD):

1.  Windows Hello for Business
2.  Microsoft Authenticator
3.  Fast Identity Online2 (**FIDO2**) security keys

:::image type="content" source="../media/passwordless-convenience-security-1ba3f8c9.png" alt-text="Screenshot showing three passwordless authentication options that integrate with Azure Active Directory.":::


## Windows Hello for Business

Windows Hello for Business is ideal for information workers that have their own designated Windows PC. The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner. With public key infrastructure (PKI) integration and built-in support for single sign-on (SSO), Windows Hello for Business provides a convenient method for seamlessly accessing corporate resources on-premises and in the cloud.

## Microsoft Authenticator

You can also allow your employee's phone to become a passwordless authentication method. You may already be using the Authenticator app as a convenient multi-factor authentication option in addition to a password. You can also use the Authenticator App as a passwordless option.

## Fast Identity Online2 (FIDO2) security keys:

The FIDO (Fast IDentity Online) Alliance helps to promote open authentication standards and reduce the use of passwords as a form of authentication. FIDO2 is the latest standard that incorporates the web authentication (WebAuthn) standard.

FIDO2 security keys are an unphishable standards-based passwordless authentication method that can come in any form factor. Fast Identity Online (FIDO) is an open standard for passwordless authentication. FIDO allows users and organizations to leverage the standard to sign in to their resources without a username or password using an external security key or a platform key built into a device.

Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices but could also use Bluetooth or Near-Field Communication (NFC). With a hardware device that handles the authentication, the security of an account is increased as there's no password that could be exposed or guessed.

FIDO2 security keys can be used to sign into their Azure AD or hybrid Azure AD joined Windows 10 devices and get single-sign-on to their cloud and on-premises resources. Users can also sign in to supported browsers. FIDO2 security keys are a great option for enterprises that are very security sensitive or have scenarios or employees who aren't willing or able to use their phone as a second factor.
