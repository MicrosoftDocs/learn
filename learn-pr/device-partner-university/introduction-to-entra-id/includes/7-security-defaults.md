Security defaults provide a baseline level of protection against identity-related threats such as password spray, replay attacks, and phishing. These preconfigured settings are designed to simplify security management and are available to all organizations at no additional cost.

Microsoft has made these defaults broadly available based on observed effectiveness. Data indicates that more than 99.9% of identity-based attacks can be mitigated by implementing multifactor authentication (MFA) and blocking legacy authentication protocols.

## Security default controls

Security defaults include the following core protections:

- [Requiring all users to register for MFA](/entra/fundamentals/security-defaults#require-all-users-to-register-for-azure-ad-multifactor-authentication)
- [Requiring administrators to do MFA](/entra/fundamentals/security-defaults#require-administrators-to-do-multifactor-authentication)
- [Requiring users to do MFA when necessary](/entra/fundamentals/security-defaults#require-users-to-do-multifactor-authentication-when-necessary)
- [Blocking legacy authentication protocols]/(entra/fundamentals/security-defaults#block-legacy-authentication-protocols)
- [Protecting privileged activities like access to the Azure portal](/entra/fundamentals/security-defaults#protect-privileged-activities-like-access-to-the-azure-portal)

Tenants created on or after October 22, 2019, may have security defaults enabled by default. These settings are automatically applied to new tenants to enhance baseline security.

## Enable security defaults

To enable security defaults:

1. Sign in to the Microsoft Entra admin center with Security Administrator privileges.
1. Navigate to **Identity > Overview > Properties**.
1. Select **Manage security defaults**.
1. Set **Security defaults** to **Enabled**.
1. Select **Save**.
