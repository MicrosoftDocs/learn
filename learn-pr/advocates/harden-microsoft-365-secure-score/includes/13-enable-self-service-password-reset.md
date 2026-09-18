**Secure Score recommendation:** Enable self-service password reset for all users.

Self-service password reset lets users recover from forgotten passwords and account lockout without help desk intervention. Secure verification reduces support-based social engineering and recovery time.

Microsoft Entra self-service password reset supports **None**, **Selected**, or **All** users. To complete the Secure Score action requires the **All** scope.

Use a trial group during pilot deployment. Move to all users after registration, notification, support, and hybrid writeback validation. The final setting must be **All** for the recommendation.

Administrators have a separate reset policy and normally require two verification methods. Test the Secure Score behavior with a non-administrator account.

## Prepare authentication methods

Authentication methods for password reset are managed through the current Microsoft Entra **Authentication methods policy**. Legacy multifactor authentication and self-service password reset method policies reached deprecation.

Choose methods based on security and recoverability:

- Microsoft Authenticator.
- Fast Identity Online version 2 security keys or passkeys where supported by the recovery flow.
- Temporary Access Pass for controlled onboarding or recovery.
- Telephone methods only where the risk decision permits them.
- Email only where supported and appropriate.

Require enough methods to resist loss of one device without making recovery impossible. Protect method registration with Conditional Access. Monitor changes to security information.

## Account for hybrid identities

For synchronized users, the on-premises directory is often the password authority. Enable password writeback so a cloud-initiated reset updates the on-premises password.

When configuring validate:

- Microsoft Entra Connect Sync or cloud sync configuration.
- Required on-premises permissions.
- Network connectivity.
- On-premises password policy.
- Account lockout behavior.
- Password hash synchronization latency.
- Audit and notification events.

Without password writeback, a synchronized user can receive an apparent cloud recovery path that doesn't update the authoritative password as required.

## Configure the portal

To configure self-service password reset in the portal:

1. Sign in to the Microsoft Entra admin center as at least an Authentication Policy Administrator.
1. Select **Entra ID** > **Password reset** > **Properties**.
1. During pilot, select **Selected** and choose the pilot group.
1. Configure registration, notifications, and help desk customization.
1. Configure supported methods through the Authentication methods policy.
1. Enable and test password writeback for hybrid users.
1. Complete pilot testing.
1. Return to **Properties**.
1. Set **Self service password reset enabled** to **All**.
1. Save.

You should also enable:

- User notification after a password reset.
- Administrator notification after an administrator reset.
- A current help desk link.
- Registration prompts appropriate to the rollout.

## Respect the automation boundary

Microsoft Graph doesn't expose the non-administrator **None**, **Selected**, or **All** scope as a supported PowerShell setting. Use the portal for the Secure Score configuration.

Don't substitute:

```powershell
Update-MgPolicyAuthorizationPolicy -AllowedToUseSspr:$true
```

This is because `AllowedToUseSspr` controls self-service password reset availability for tenant administrators. It doesn't set the all-user scope.

## Assess rollout coverage

To assess the success of rollout of this policy, connect with reporting permission using the following command:

```powershell
Connect-MgGraph -Scopes 'AuditLog.Read.All'
```

Then query user registration state with the following command:

```powershell
$registrationDetails = @(
    Get-MgReportAuthenticationMethodUserRegistrationDetail -All
)

$registrationDetails |
    Select-Object `
        UserPrincipalName,
        IsSsprEnabled,
        IsSsprRegistered,
        IsSsprCapable |
    Sort-Object UserPrincipalName
```

To find gaps, run the following PowerShell script:

```powershell
$registrationDetails |
    Where-Object {
        -not $_.IsSsprEnabled -or
        -not $_.IsSsprRegistered -or
        -not $_.IsSsprCapable
    } |
    Select-Object `
        UserPrincipalName,
        IsSsprEnabled,
        IsSsprRegistered,
        IsSsprCapable
```

Interpret the properties separately:

- `IsSsprEnabled`: The user is in scope.
- `IsSsprRegistered`: The user registered recovery data.
- `IsSsprCapable`: The registered methods satisfy the current reset policy.

A user can be enabled without being capable. Closing this gap requires registration or method remediation.

## Test recovery

To test self-service password reset, use a non-administrator test account:

1. Open a private browser session.
1. Open the Microsoft Entra security information registration page from My Account.
1. Register the required methods.
1. Close the session.
1. Open another private session.
1. Open the Microsoft password reset page.
1. Complete verification.
1. Reset the password.
1. Confirm the notification.
1. Sign in with the new password.

For a synchronized account, also confirm the new password works against an on-premises resource after writeback. You should also confirm that the old password fails.

Test the following failure scenarios:

- Insufficient registered methods.
- A lost device.
- A blocked or disabled user.
- An on-premises password policy rejection.
- A writeback connectivity failure.

The help desk must recognize the characteristics of each failure scenarios without bypassing identity proofing.

## Operate securely

To maintain a secure posture:

- Review registration coverage.
- Alert on authentication method changes.
- Remove obsolete methods.
- Protect security information registration.
- Review writeback health.
- Keep help desk identity verification separate from ordinary profile knowledge.
- Test recovery after authentication policy changes.
