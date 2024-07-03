Microsoft recommends passwordless authentication methods such as Windows Hello, FIDO2 security keys, and the Microsoft Authenticator app because they provide the most secure sign-in experience. Although a user can sign-in using other common methods such as a username and password, passwords should be replaced with more secure authentication methods.

:::image type="content" source="../media/microsoft-entra-id-authentication-methods-6937395a.png" alt-text="Diagram showing Microsoft recommended passwordless authentication methods.":::


Microsoft Entra multifactor authentication adds additional security over only using a password when a user signs in. The user can be prompted for additional forms of authentication, such as to respond to a push notification, enter a code from a software or hardware token, or respond to a text message or phone call.

To simplify the user on-boarding experience and register for both MFA and self-service password reset (SSPR), we recommend you enable combined security information registration. For resiliency, we recommend that you require users to register multiple authentication methods. When one method isn't available for a user during sign-in or SSPR, they can choose to authenticate with another method.

## Authentication method strength and security

When you deploy features like Microsoft Entra multifactor authentication in your organization, review the available authentication methods. Choose the methods that meet or exceed your requirements in terms of security, usability, and availability. Where possible, use authentication methods with the highest level of security.

The following table outlines the security considerations for the available authentication methods. Availability is an indication of the user being able to use the authentication method, not of the service availability in Microsoft Entra ID:

| **Authentication method**        | **Security** | **Usability** | **Availability** |
| -------------------------------- | ------------ | ------------- | ---------------- |
| Windows Hello for Business       | High         | High          | High             |
| Microsoft Authenticator          | High         | High          | High             |
| Authenticator Lite               | High         | High          | High             |
| FIDO2 security key               | High         | High          | High             |
| Certificate-based authentication | High         | High          | High             |
| OATH hardware tokens (preview)   | Medium       | Medium        | High             |
| OATH software tokens             | Medium       | Medium        | High             |
| Temporary Access Pass (TAP)      | Medium       | High          | High             |
| SMS                              | Medium       | High          | Medium           |
| Voice                            | Medium       | Medium        | Medium           |
| Password                         | Low          | High          | High             |
