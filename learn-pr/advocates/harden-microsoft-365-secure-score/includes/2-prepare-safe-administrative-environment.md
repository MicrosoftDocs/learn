**Conditional Access** is Microsoft Entra ID’s Zero Trust policy engine for Microsoft 365. For each access attempt, it evaluates signals such as user, location, device compliance, application, and sign-in risk, then allows access, blocks it, or requires controls such as MFA, stronger authentication, a compliant device, or session restrictions. It supplements authentication rather than replacing it across services such as Teams, Exchange Online, SharePoint, and OneDrive.

You need to be careful when configuring Conditional Access as it's possible that you might configure settings that end up locking out every privileged account. Before implementing, prepare recovery accounts, test identities, permissions, inventories, and rollback data.

## Select the deployment model

Decide whether your tenant should use security defaults or custom Conditional Access.

Use security defaults when the tenant needs a Microsoft-managed baseline and doesn't require policy customization. Use custom Conditional Access when the tenant requires separate administrator controls, risk conditions, authentication strengths, application scope, device conditions, staged assignments, or explicit exclusions.

If security defaults is enabled, don't create the baseline Conditional Access policies from this module until security defaults is disabled through an approved change. Record the transition plan. Verify that custom policies reproduce required protections before the change.

## Verify licensing

The following table identifies typical minimum licensing required for the capabilities we explore in this module.

| Capability | Typical minimum license |
| --- | --- |
| Conditional Access | Microsoft Entra ID P1 |
| Full sign-in risk and user risk policies | Microsoft Entra ID P2 or Microsoft Entra Suite |
| Privileged Identity Management for Microsoft Entra roles | Microsoft Entra ID P2, Microsoft Entra ID Governance, or applicable suite entitlement |
| Self-service password reset for cloud users | Microsoft Entra ID P1 for the scenario in this module |
| Password writeback | Applicable Microsoft Entra licensing plus supported synchronization |
| Microsoft Teams meeting policies | Microsoft Teams |
| Enforced meeting templates or sensitivity labels | Microsoft Teams Premium plus applicable Microsoft Purview licensing |

A recommendation can remain security-relevant even when the tenant lacks the required license. Organizations should assess risk and determine which level of licensing meets their security needs. 

## Use least-privileged operator roles

The following table maps each administrative task to a suitable least-privileged role.

| Task | Role |
| --- | --- |
| Create Conditional Access policies | Conditional Access Administrator |
| Configure role assignments | Privileged Role Administrator |
| Configure application consent policies | Global Administrator or another currently supported least-privileged role |
| Configure password reset policy | Authentication Policy Administrator |
| Configure meeting policies | Teams Administrator |
| Read Secure Score | Security Reader or supported Microsoft Defender unified role |

Best practice is to activate privileged roles only for the change window. Use a dedicated administrative workstation where available. Don't use daily productivity accounts for tenant-wide changes.

## Prepare emergency access with break-glass accounts

Maintain at least two cloud-only emergency access, also known as break-glass, accounts. Each account should:

- Have permanent Global Administrator access solely for recovery.
- Use a strong authentication method that doesn't share a dependency with normal administrator authentication.
- Be excluded explicitly from baseline Conditional Access policies.
- Be stored under controlled emergency procedures.
- Generate high-priority alerts for every sign-in.
- Be tested at a documented interval.
- Have no mailbox, license, application use, or routine operator activity.

An exclusion from baseline Conditional Access policies prevents accidental lockout. Ensure that you configure monitoring and alerts for this account and a formal method for credential custody. These accounts only get used as a last resort, hence the term "break-glass" account.

## Create pilot identities

Before implementing Conditional Access policies, test functionality by creating a pilot or test group containing representative users. The pilot group should contain:

- One standard cloud-only user.
- One synchronized user.
- One administrator.
- One user with a passwordless method.
- One user using every critical client type.
- One user from each operational region or network path.

Don't include emergency access accounts in your pilot group. Identify application owners for clients that use legacy authentication. Identify meeting organizers who can test each participant type.

## Inventory current state

Ensure that you have a document (or documents) that capture:

- Every Conditional Access policy, including state, assignments, conditions, grants, session controls, exclusions, and named locations.
- Authentication method registration coverage.
- Interactive and non-interactive legacy authentication.
- Active risky sign-ins and risky users.
- User consent policy assignments and existing permission grants.
- Microsoft Teams meeting policies plus user assignments.
- Active and eligible administrative role assignments.
- Password reset scope, methods, registration settings, and password writeback state.

You can export configuration data to record this information. Store exported data in approved administrative storage. Take care with the exported data as it can contain tenant identifiers and sensitive configuration. 

## Prepare PowerShell

The example code in this module uses PowerShell 7 with the Microsoft.Graph and MicrosoftTeams module. To install these in your PowerShell 7 environment, run the following command on an internet connected computer:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Install-Module MicrosoftTeams -Scope CurrentUser
```

The following code interactively signs you into Microsoft Graph with delegated permissions to manage Conditional Access and authorization policies, administer Entra roles, and read directory, application, and audit-log data. These highly privileged scopes require administrator consent and remain limited by the signed-in user’s own roles. `Connect-MicrosoftTeams` then establishes a separate authenticated session for Microsoft Teams PowerShell commands.

```powershell
Connect-MgGraph -Scopes @(
    'Policy.ReadWrite.ConditionalAccess',
    'Policy.ReadWrite.Authorization',
    'RoleManagement.ReadWrite.Directory',
    'Directory.Read.All',
    'Application.Read.All',
    'AuditLog.Read.All'
)

Connect-MicrosoftTeams
```

The following code allows you to specify your emergency-access accounts. `$breakGlassObjectIds` must be replaced with at least two real emergency-access account object IDs: 

```powershell
$breakGlassObjectIds = @(
    '<emergency-account-object-id-1>',
    '<emergency-account-object-id-2>'
)

$teamsPolicy = 'Global'
```

The following ensures that you've specified your emergency-access accounts before creating policy:

```powershell
if (
    $breakGlassObjectIds.Count -lt 2 -or
    $breakGlassObjectIds -match '^<'
) {
    throw 'Provide at least two verified emergency access object identifiers.'
}
```

You can confirm the signed-in Microsoft Graph context with the following commands:

```powershell
Get-MgContext |
    Select-Object Account, TenantId, AuthType, Scopes
```

Confirm the tenant identifier before every write operation. A valid command against the wrong tenant is still a failed change.

## Apply the module safety standard

Use these rules when creating every security control:

1. Capture the original state.
1. Document the intended behavior.
1. Create Conditional Access policies in report-only mode.
1. Use the What If tool before sign-in testing.
1. Test representative users, devices, locations, clients, and resources.
1. Confirm emergency access before enforcement.
1. Record temporary exclusions with an owner and expiry date.
1. Enable policies during a monitored change window.
1. Disable a faulty policy instead of deleting it.
1. Retain evidence from the test and rollback.

Don't create permanent exclusions for ordinary users or user-based service accounts. Replace service credentials with managed identities, service principals, certificates, or workload identities where the workload supports them.

## Record rollback data

For Conditional Access, rollback normally means changing `state` from `enabled` to `disabled`. Retain the policy for investigation.

For Microsoft Teams, record the original property values before using `Set-CsTeamsMeetingPolicy`.

For role changes, assign and test the replacement before removing the broad role. Record the assignment identifier that would need restoration.

For consent settings, record the original permission grant policy assignments. For password reset, record scope and writeback dependencies.
