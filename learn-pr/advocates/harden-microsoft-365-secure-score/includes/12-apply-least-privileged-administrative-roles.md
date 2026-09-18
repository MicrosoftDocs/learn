**Secure Score recommendation:** Use least-privileged administrative roles.

Permanent tenant-wide privilege increases the effect of account compromise and administrator error. Least privilege limits permission, scope, and duration.

For every privilege assignment, ask:

- **Permission:** What exact operations are required?
- **Scope:** Which users, groups, applications, administrative units, or resources need administration?
- **Duration:** Is standing access necessary, or can the user activate eligible access briefly?

Avoid assigning Global Administrator when a task-specific role works. Use administrative units or resource scope where supported. Use Privileged Identity Management for eligible, time-bound activation.

Best practice recommends fewer than five Global Administrators and at least two cloud-only emergency Global Administrator accounts. Best practice also recommends limiting privileged role assignments. 

## Inventory active assignments

Build a role definition lookup, then list assignments:

```powershell
$roleDefinitions = @{}

Get-MgRoleManagementDirectoryRoleDefinition -All |
    ForEach-Object {
        $roleDefinitions[$_.Id] = $_.DisplayName
    }

$activeAssignments = @(
    Get-MgRoleManagementDirectoryRoleAssignment -All |
        Select-Object `
            Id,
            PrincipalId,
            DirectoryScopeId,
            @{
                Name = 'Role'
                Expression = {
                    $roleDefinitions[$_.RoleDefinitionId]
                }
            }
)

$activeAssignments |
    Sort-Object Role, PrincipalId
```

The inventory contains identifiers. Resolve each principal to a user, group, or service principal. Investigate deleted or unknown principals. Review group membership when a role is group-assigned.

## Map tasks to roles

For each person who needs to perform administrative tasks:

1. List recurring tasks.
1. Find the least-privileged built-in role for each task.
1. Check whether scope can be reduced.
1. Decide whether access can be eligible.
1. Assign the replacement.
1. Test the real task.
1. Remove the broad assignment only after successful validation.

The following table maps common administrative tasks to candidate least-privileged roles.

| Task | Candidate role |
| --- | --- |
| Reset passwords for non-administrators | Helpdesk Administrator |
| Manage authentication methods | Authentication Administrator |
| Create Conditional Access policies | Conditional Access Administrator |
| Manage enterprise applications | Cloud Application Administrator |
| Review security data | Security Reader |
| Manage Microsoft Teams | Teams Administrator |

Role capabilities change. Confirm the current role permission reference and least-privileged role-by-task guidance.

## Configure eligible access

To configure eligible access, in the Microsoft Entra admin center:

1. Select **ID Governance** > **Privileged Identity Management**.
1. Select **Microsoft Entra roles**.
1. Open **Assignments**.
1. Convert suitable standing assignments to eligible assignments.
1. Configure role settings.
1. Require multifactor authentication.
1. Require justification.
1. Require approval for sensitive roles where operationally viable.
1. Limit activation duration.
1. Send activation notifications.
1. Require an incident or ticket number where applicable.

Keep emergency access accounts outside normal activation. 

## Create an eligible assignment with Microsoft Graph PowerShell

To configure eligible access using PowerShell, resolve one principal and one role:

```powershell
$principal = Get-MgUser -UserId '<user-principal-name>'

$roles = @(
    Get-MgRoleManagementDirectoryRoleDefinition `
        -Filter "displayName eq 'Helpdesk Administrator'"
)

if ($roles.Count -ne 1) {
    throw 'Expected one Helpdesk Administrator role definition.'
}

$role = $roles[0]
```

You can create a 180-day eligible assignment using the following script:

```powershell
$params = @{
    action = 'adminAssign'
    principalId = $principal.Id
    roleDefinitionId = $role.Id
    directoryScopeId = '/'
    justification = 'Replace standing broad privilege with eligible task-specific access'
    scheduleInfo = @{
        startDateTime = (Get-Date).ToUniversalTime()
        expiration = @{
            type = 'afterDuration'
            duration = 'P180D'
        }
    }
}

$eligibilityRequest = `
    New-MgRoleManagementDirectoryRoleEligibilityScheduleRequest `
        -BodyParameter $params

$eligibilityRequest |
    Select-Object Id, Status, Action, PrincipalId, RoleDefinitionId
```

The request creates eligibility. Role settings determine activation requirements. Confirm approval, duration, authentication, and notification settings separately.

## Validate the replacement

To verify that assignments have been configured correctly, have the administrator:

1. Activate the eligible role.
1. Complete the required authentication.
1. Enter justification.
1. Obtain approval if configured.
1. Perform the required task.
1. Confirm unrelated privileged tasks are blocked.
1. Let the activation expire.
1. Confirm privilege is removed.

Only once you've confirmed that the time limited eligible assignment functions as expected, you can remove the obsolete direct assignment using the following PowerShell command:

```powershell
Remove-MgRoleManagementDirectoryRoleAssignment `
    -UnifiedRoleAssignmentId '<obsolete-assignment-id>'
```

Take care when using this operation. Verify the exact assignment identifier, replacement role, tested task, rollback owner, and emergency access before running it.

## Add recurring governance

Make sure that you have adequate and separate documented records of each privileged assignments. You should:

- Review privileged assignments at a defined interval.
- Use access reviews to remove obsolete eligibility.
- Alert on new Global Administrator and privileged role assignments.
- Alert on changes to role settings.
- Review role-assignable group membership.
- Review service principals with directory roles.
- Remove inactive assignments.
- Keep an approved exception register.

Least privilege is a lifecycle rather than "set and forget".
