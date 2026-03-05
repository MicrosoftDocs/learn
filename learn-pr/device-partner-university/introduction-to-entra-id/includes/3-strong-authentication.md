Single sign-on (SSO) enables users to authenticate once and gain access to multiple applications without repeated credential entry. This approach simplifies access and reduces password fatigue, contributing to improved security and user efficiency.

Multifactor authentication (MFA) enhances security by requiring two or more verification factors during sign-in. For example, users might enter a password and then confirm the sign-in using the Microsoft Authenticator app on their smartphone or a FIDO2 security key, or a biometric factor such as a fingerprint or facial recognition. MFA helps reduce the risk of compromised credentials by requiring additional verification beyond a username and password.

Microsoft Entra ID supports passwordless authentication through alternative methods such as biometrics via Windows Hello for Business, time-based codes from the Microsoft Authenticator app, and FIDO2 security keys. These methods reduce reliance on passwords and lower the risk of credential theft.

IT administrators can define authentication strength requirements by configuring Conditional Access policies using the 'Require authentication strength' control. This allows organizations to enforce tailored security standards based on preferred authentication method combinations.

Authentication strength options include:

- **MFA strength**: Combines methods that satisfy the 'Require MFA' setting.
- **Passwordless MFA strength**: Includes methods that meet MFA requirements without using passwords.
- **Phishing-resistant MFA strength**: Requires interaction between the authentication method and the sign-in interface to prevent interception or reuse.

### Example of phishing-resistant MFA

The built-in phishing-resistant MFA strength supports the following authentication methods:

- Windows Hello for Business  
- FIDO2 security key  
- Microsoft Entra certificate-based authentication (multifactor)

These methods are designed to resist common phishing techniques by ensuring that authentication credentials can't be easily intercepted or reused remotely.