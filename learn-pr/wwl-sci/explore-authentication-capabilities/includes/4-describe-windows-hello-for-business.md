Windows Hello, an authentication feature built into Windows 10, replaces passwords with strong two-factor authentication on PCs and mobile devices. This authentication consists of a new type of user credential that's tied to a device and uses a biometric or PIN.

Windows Hello lets users authenticate to:

- A Microsoft account.
- An Active Directory account.
- An Azure Active Directory (Azure AD) account.
- Identity Provider Services or Relying Party Services that support Fast ID Online (FIDO) v2.0 authentication (in preview)

After initial verification of the user during enrollment, Windows Hello is set up on their device and Windows asks the user to set a gesture, which can be a biometric, such as a fingerprint, or a PIN. The user provides the gesture to verify their identity. Windows then uses Windows Hello to authenticate them.

Windows stores PIN and biometric data securely on the local device; it's never sent to external devices or servers. That means there's no single collection point that an attacker might compromise.

There are two configurations for Windows Hello: Windows Hello and Windows Hello for Business.

- Windows Hello is configured by a user on their personal device and is referred to as "Windows Hello convenience PIN".  It uses a PIN or biometric gesture and is unique to that device. Windows Hello convenience PIN is not backed by asymmetric (public or private key) or certificate-based authentication.
- Windows Hello for Business is configured by Group Policy or mobile device management (MDM) policy such as Microsoft Intune, and always uses key-based or certificate-based authentication. It's much more secure than Windows Hello convenience PIN. By default, Windows Hello convenience PIN is disabled on all domain-joined computers.

## Why is Windows Hello safer than a password?

Windows Hello in Windows 10 enables users to sign in to their device using a PIN. Although a PIN looks much like a password, a Windows Hello PIN is more secure because it's tied to the specific device on which it was set up. Without the hardware, the PIN is useless.

A regular password is transmitted to a server where it can be intercepted in transmission or stolen from a server. A PIN is local to the device; it isn't transmitted anywhere, and it isn't stored on a server.

The Windows Hello PIN is backed by a Trusted Platform Module (TPM) chip, which is a secure crypto processor that's designed to carry out cryptographic operations. The chip includes multiple physical security mechanisms to make it tamper resistant, and malicious software can't tamper with the security functions of the TPM. Many mobiles phones and modern laptops have TPM.
