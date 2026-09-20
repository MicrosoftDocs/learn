**Secure Score recommendation:** Require multifactor authentication for all users.

Passwords are vulnerable to phishing, reuse, password spray, credential stuffing, malware, and disclosure. Multifactor authentication reduces the value of a stolen password by requiring another proof.

## Design the policy

When creating the policy to require multifactor authentication for all users, make sure you exclude:

- The two emergency access accounts.
- Directory synchronization accounts only where their supported architecture requires exclusion.
- Temporary migration exceptions with an owner and expiry date.

Include **All resources**. Application exclusions create bypass paths. Replace user-based service identities with managed identities, workload identities, service principals, or certificate-based authentication.

Require the built-in **Multifactor authentication** strength. This permits methods that satisfy Microsoft Entra multifactor authentication. Use separate policies when a population requires a stronger method.

The administrator policy from the previous unit remains necessary. When both policies apply, the sign-in must satisfy both. A phishing-resistant multifactor method satisfies the general multifactor requirement. The general policy doesn't weaken the administrative policy.

## Assess registration readiness

Read authentication method registration before enforcement:

```powershell
Get-MgReportAuthenticationMethodUserRegistrationDetail -All |
    Select-Object `
        UserPrincipalName,
        IsMfaRegistered,
        IsMfaCapable,
        IsPasswordlessCapable |
    Sort-Object UserPrincipalName
```

Find users who can't satisfy the policy:

```powershell
Get-MgReportAuthenticationMethodUserRegistrationDetail -All |
    Where-Object { -not $_.IsMfaCapable } |
    Select-Object UserPrincipalName, IsMfaRegistered, IsMfaCapable
```

`IsMfaRegistered` indicates registration. `IsMfaCapable` indicates that registered methods can satisfy multifactor authentication. Investigate gaps instead of excluding users permanently.

Plan registration communications, service desk support, accessibility accommodations, device requirements, and temporary access passes where appropriate.

## Create the policy in the portal

1. In the Microsoft Entra admin center, select **Entra ID** > **Conditional Access** > **Policies**.
1. Create `CA002-Require-MFA-All-Users`.
1. Include **All users**.
1. Exclude both emergency access accounts.
1. Exclude a synchronization role only after verifying the affected account and dependency.
1. Include **All resources**.
1. Under **Grant**, select **Require authentication strength**.
1. Select **Multifactor authentication**.
1. Set the policy to **Report-only**.
1. Create the policy.

## Create the policy with Microsoft Graph PowerShell

Resolve the directory synchronization role template:

```powershell
$directorySyncRoleId = (
    Get-MgDirectoryRoleTemplate -All |
        Where-Object DisplayName -EQ 'Directory Synchronization Accounts'
).Id

if (-not $directorySyncRoleId) {
    throw 'Directory Synchronization Accounts role template was not found.'
}
```

Create the report-only policy:

```powershell
$params = @{
    displayName = 'CA002-Require-MFA-All-Users'
    state = 'enabledForReportingButNotEnforced'
    conditions = @{
        clientAppTypes = @('all')
        users = @{
            includeUsers = @('All')
            excludeUsers = $breakGlassObjectIds
            excludeRoles = @($directorySyncRoleId)
        }
        applications = @{
            includeApplications = @('All')
        }
    }
    grantControls = @{
        operator = 'OR'
        authenticationStrength = @{
            id = '00000000-0000-0000-0000-000000000002'
        }
    }
}

$allUserPolicy = New-MgIdentityConditionalAccessPolicy `
    -BodyParameter $params

$allUserPolicy |
    Select-Object Id, DisplayName, State
```

The built-in multifactor authentication strength identifier is `00000000-0000-0000-0000-000000000002`.

If no synchronization account requires exclusion, omit `excludeRoles`. Every exclusion must map to a verified dependency.

## Analyze report-only impact

Review sign-in logs for:

- Users who would be interrupted.
- Users who can't satisfy multifactor authentication.
- Client types with unexpected behavior.
- Non-interactive sign-ins using user credentials.
- Service accounts that need workload identity migration.
- Applications with embedded browsers or unsupported authentication libraries.

Filter the sign-in logs by Conditional Access policy and report-only result. Review both interactive and non-interactive sign-ins. A successful interactive pilot doesn't prove that background clients are compatible.

## Use staged enforcement

For a large tenant, use a staged policy before the all-user policy:

1. Clone the settings.
1. Include the pilot group instead of all users.
1. Keep emergency exclusions.
1. Enable the pilot policy.
1. Observe a complete business cycle.
1. Expand in controlled waves.
1. Enable the all-user policy.
1. Disable the temporary staged policies after the final policy is stable.

Avoid overlapping wave policies that are difficult to troubleshoot if something goes wrong or you experience unexpected outcomes. 

> [!NOTE]
> Keep a policy register document that records each policy's scope, state, purpose, owner, and retirement date. This documentation will assist you in keeping track of policies that have been implemented and the intent of those policies. This allows later administrators to compare the intent of the policy with the actual configuration of the policy.

## Validate effective behavior

To validate policy behavior, test:

- A registered pilot user accessing an included resource.
- A user without a capable method.
- A modern desktop client.
- A mobile client.
- A browser session.
- A non-interactive workload that previously used user credentials.
- A privileged user also covered by the stronger administrator policy.

Confirm that:

- The registered user completes multifactor authentication.
- The unprepared user receives the expected registration or block experience.
- Modern clients continue to function.
- Unsupported service identities are migrated rather than permanently excluded.
- The privileged user must use the stronger method.

Enable the policy only after the observed report-only impact matches the design.
