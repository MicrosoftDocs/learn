
On Windows 11 or later clients, Windows Hello for Business replaces passwords with strong two-factor authentication on PCs and mobile devices. This authentication consists of a new type of user credential that is tied to a device and uses biometric authentication or a PIN.

Windows Hello addresses the following problems with passwords:

 -  Strong passwords can be difficult to remember, and users often reuse passwords on multiple sites.
 -  Server breaches can expose symmetric network credentials (passwords).
 -  Passwords are subject to replay attacks.
 -  Users can inadvertently expose their passwords due to phishing attacks.

With Windows Hello, users can authenticate to:

 -  A Microsoft account
 -  An Active Directory account
 -  A Microsoft Azure Active Directory (Azure AD) account
 -  Identity Provider Services or Relying Party Services that support Fast ID Online (FIDO) v2.0 authentication (in progress)

After an initial two-step verification of the user during enrollment, Windows Hello is set up on the user's device and Windows asks the user to set a gesture, which can be biometric, such as a fingerprint, or a PIN. The user provides the gesture to verify their identity. Windows then uses Windows Hello to authenticate users.

As an administrator in an enterprise or educational organization, you can create policies to manage Windows Hello for Business use on Windows-based devices that connect to your organization.

### Biometric sign-in

Windows Hello provides reliable, fully integrated biometric authentication based on facial recognition or fingerprint matching. Windows Hello uses a combination of special infrared (IR) cameras and software to increase accuracy and guard against spoofing. Major hardware vendors are shipping devices that have integrated Windows Hello-compatible cameras. Fingerprint reader hardware can be used or added to devices that don’t currently have it. On devices that support Windows Hello, an easy biometric gesture unlocks users’ credentials.

 -  **Facial recognition**. This type of biometric recognition uses special cameras that see in IR light, which allows them to reliably tell the difference between a photograph or scan and a living person. Several vendors are shipping external cameras that incorporate this technology, and major laptop manufacturers are incorporating it into their devices, as well.
 -  **Fingerprint recognition**. This type of biometric recognition uses a capacitive fingerprint sensor to scan your fingerprint. Fingerprint readers have been available for Windows computers for years, but the current generation of sensors is more reliable and less error prone. Most existing fingerprint readers (whether external or integrated into laptops or USB keyboards) work with Windows.

Windows stores biometric data that is used to implement Windows Hello securely on the local device only. The biometric data doesn’t roam and is never sent to external devices or servers. Because Windows Hello only stores biometric identification data on the device, there’s no single collection point an attacker can compromise to steal biometric data.
