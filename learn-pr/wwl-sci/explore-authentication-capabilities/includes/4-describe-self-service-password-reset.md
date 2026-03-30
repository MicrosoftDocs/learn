Self-service password reset (SSPR) is a feature of Microsoft Entra ID that allows users to change or reset their password, without administrator or help desk involvement. If a user's account is locked or they forget their password, they can follow a prompt to reset it and get back to work. This ability reduces help desk calls and loss of productivity when a user can't sign in to their device or an application. SSPR also includes robust audit logs available through an API, enabling data to be imported to a security information and event monitoring (SIEM) system.

### How self-service password reset works

When a user accesses the SSPR portal, the Microsoft Entra platform performs several checks: it verifies the user's account is valid and SSPR is enabled, confirms the user registered the required authentication methods, and determines where the user's password is managed. If all checks pass, the user is guided through the process to reset or change their password.

To use SSPR, users must be:

- Assigned a Microsoft Entra ID license.
- Enabled for SSPR by an administrator.
- Registered with the authentication methods they want to use. Two or more authentication methods are recommended in case one is unavailable.

SSPR capabilities vary by license tier. For details on licensing requirements, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

### Authentication methods for SSPR

When enabled for SSPR, users must register at least one authentication method. Choosing two or more methods is recommended so users have flexibility if one method becomes unavailable. The following authentication methods are available for SSPR:

- Microsoft Authenticator push notifications
- Software OATH tokens
- Hardware OATH tokens (preview)
- Short message service (SMS)
- Voice call
- Email OTP
- Security questions (retiring March 2027)

> [!IMPORTANT]
> Security questions will be retired for SSPR in March 2027. After that date, users will no longer be able to reset passwords using security questions. Organizations should ensure users are set up with other supported authentication methods before enforcement begins.

Administrators configure how many methods are required to reset or unlock a password—one or two. When Microsoft Authenticator is used as a method and only one method is required, only verification code is available. When two methods are required, users can use notification or verification code alongside other enabled methods.

> [!NOTE]
> By default, administrator accounts are enabled for SSPR and are required to use two authentication methods to reset their password through a strong two-gate policy. Administrators can't use security questions.

### Registration and reconfirmation

Administrators can require users to register for SSPR when they sign in to any application using modern authentication or a web browser, including Microsoft 365, the Microsoft Entra admin center, and federated or custom applications. Users who haven't registered are prompted at each sign-in until they complete registration.

Administrators can also require users to reconfirm their authentication information after a set period (0 to 730 days), ensuring that registered methods remain current and available when needed.

### Notifications

SSPR can send email notifications to keep users and administrators informed about password events:

- **Users** receive an email when their password is reset, sent to their primary and alternate email addresses stored in Microsoft Entra ID.
- **Global administrators** receive an email when another administrator resets their password using SSPR, providing extra awareness for privileged account activity.

### On-premises integration and password writeback

In hybrid environments, Microsoft Entra Connect cloud sync can write password changes from Microsoft Entra ID back to an on-premises Active Directory. When password writeback is enabled, users who are federated, using pass-through authentication, or using password hash synchronization can reset their passwords and have the new password written back on-premises without delay.

Administrators can also allow users to unlock their on-premises accounts without resetting their password, separating the unlock and reset operations for greater flexibility.

If a non-Microsoft password filter is in use for on-premises Active Directory, it must be configured to apply during admin-initiated password reset scenarios to work correctly with SSPR. Microsoft Entra password protection for Active Directory Domain Services is supported by default.

### Account recovery

SSPR addresses scenarios where users forget their password but retain access to at least one registered authentication method. However, situations arise where users lose access to all their authentication methods—for example, when a device is lost and backup methods are unavailable. In these total lockout scenarios, SSPR isn't sufficient.

Microsoft Entra ID account recovery addresses these critical scenarios by enabling users to regain access through a comprehensive identity verification process. Unlike SSPR, which relies on preregistered methods, account recovery focuses on re-establishing trust in the user's identity when all authentication methods are unavailable.

The following table compares SSPR and account recovery:

| Aspect | Self-service password reset | Account recovery |
|---|---|---|
| Primary use case | User forgot password but has access to registered methods | User lost access to all authentication methods |
| Authentication requirement | At least one registered method | Identity verification through certified provider |
| Recovery scope | Password only | Complete authentication method reset |
| Security level | Relies on preregistered methods | Comprehensive identity proofing |

Account recovery uses Microsoft Entra Verified ID with Face Check, powered by Azure AI services, to provide high-assurance identity verification without exposing sensitive personal data. By removing human judgment from the verification process, it eliminates the social engineering risks inherent in traditional helpdesk-led recovery. Organizations benefit from reduced helpdesk burden, improved user experience during lockout scenarios, and enhanced security posture—particularly for distributed workforces where physical presence for identity verification isn't practical. 

Microsoft Entra Verified ID is covered in more detail in the module, [Describe the identity protection and governance capabilities of Microsoft Entra](/training/modules/describe-identity-protection-governance-capabilities/).
