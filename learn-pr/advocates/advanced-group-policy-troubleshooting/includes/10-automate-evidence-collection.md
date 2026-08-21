Using automation should make evidence repeatable. You should be careful that implementing automation, especially if you're using generative AI to create new PowerShell scripts, shouldn't lead you to make changes to your environment faster than they can be reviewed.

## Inventory policy objects

`Get-GPO` returns identity, ownership, status, times, versions, plus WMI filter data:

> **Prerequisites:** `[RSAT-GP] [delegated directory/GPO Read] [Read-only] [sensitive output]`; `-Path` changes the impact to Creates evidence

```powershell
Get-GPO -All -Domain 'contoso.com' |
    Sort-Object DisplayName |
    Select-Object DisplayName, Id, Owner, GpoStatus,
        CreationTime, ModificationTime,
        UserVersion, ComputerVersion, WmiFilter
```

This inventory answers:

- Which GPO changed near the incident?
- Do AD DS plus SYSVOL versions match?
- Is one side disabled?
- Is a WMI filter linked?
- Who owns the GPO?

The output doesn't include every link or permission. Join evidence from the appropriate cmdlet or report.

## Generate configuration reports

HTML supports review. XML supports comparison plus parsing:

```powershell
Get-GPOReport `
    -All `
    -Domain 'contoso.com' `
    -ReportType Xml `
    -Path 'C:\Reports\All-Policy.xml'
```

> [!NOTE]
> `Get-GPOReport -Server <DC>` captures a report for the queried GPO/directory view, including GPO details, policy settings, links represented by the report, filters, and security/delegation information. It omits or doesn't prove actual target selection, named-client GPT access, CSE execution, effective state, or complete audit history. Record the source domain controller through `-Server` during replication incidents.

## Capture inheritance

To determine inheritance:

```powershell
Get-GPInheritance `
    -Target 'OU=Application Servers,DC=contoso,DC=com'
```

> [!NOTE]
> `Get-GPInheritance -Server <DC>` captures direct/inherited GPO links, order, Enforced state, and inheritance blocking for a domain or OU target. It omits or doesn't prove site links or site-level Enforced state, and doesn't prove actual client RSoP. This output predicts scope. Actual RSoP remains the client-side evidence.

## Capture permissions

To determine GPO permissions:

```powershell
Get-GPPermission `
    -Name 'Server Authentication Baseline' `
    -All
```

> [!NOTE]
> `Get-GPPermission -All -Server <DC>` captures standard GPO trustee permission levels useful for filtering/delegation review. It omits or doesn't prove a byte-for-byte raw GPC/GPT ACL rollback record, ACE order, every special/inherited right, effective nested/token access, or named-DC GPT ACL. The cmdlet reports GPO permissions. Compare GPC plus GPT access when events show SYSVOL access failure.

When you need to perform an exact restoration, supplement `Get-GPPermission` with GPMC **Delegation > Advanced** or an approved raw security-descriptor capture. For SYSVOL access, separately capture the named-DC Group Policy Template Access Control List. For a site-linked change, use a site-capable GPMC/AD capture and name the surface used.

## Capture actual resultant policy

To capture resultant policy:

```powershell
$params = @{
    Computer   = 'APP01.contoso.com'
    User       = 'CONTOSO\Adele'
    ReportType = 'Xml'
    Path       = 'C:\Reports\APP01-Adele.xml'
}
Get-GPResultantSetOfPolicy @params
```

Ensure that you timestamp the file and pair that file with the Activity ID plus exported logs.

## Back up before high-impact correction

To back up GPOs before performing a high impact correction:

```powershell
New-Item -ItemType Directory -Path 'C:\GpoBackups' -Force | Out-Null

Backup-GPO `
    -Name 'Server Authentication Baseline' `
    -Path 'C:\GpoBackups' `
    -Comment 'Before LDAP compatibility correction'
```

`Backup-GPO` requires an existing backup directory, so create it first with a rerunnable `New-Item -Force` command.

`Backup-GPO -Server <DC>` captures GPO policy data and backup metadata; restoration can preserve the original GPO GUID, GPO ACL/security filtering and delegation, and WMI-filter link in the source domain. It omits or doesn't prove site/domain/OU links, link order, link-enabled/Enforced flags, Block Inheritance, the WMI filter object, group membership, target tokens, application/dependency state, or externally referenced content. Restore is appropriate when the backed-up GPO is from the same domain. Import, copy, plus migration are policy-lifecycle topics outside this module.

## Compare focused evidence

Useful comparisons include:

- Affected computer versus healthy peer.
- Before versus after GPO report.
- One domain controller versus another.
- Pilot baseline versus production baseline.
- RSoP versus effective state.

Normalize volatile fields before automated comparison:

- Report generation time.
- Local paths.
- Computer name.
- User name.
- Domain controller.

Don't remove fields that explain the incident.

## Correlate change records

Correlate `ModificationTime`, user/computer versions, report snapshots, backup IDs/comments, the approved change record, and directory or SYSVOL audit events when already available. If the prospective pack is missing, record that evidence gap. A matching timestamp narrows the interval; it doesn't identify every setting-level edit or author.

## Build a sanitized support bundle

Include:

- Problem statement.
- Expected state.
- Target scope.
- `gpresult` or PowerShell RSoP.
- GPO HTML or XML report.
- Inheritance output.
- Permission output.
- Activity ID.
- Exported event logs.
- Replication evidence.
- Effective-state evidence.
- Healthy-peer comparison.
- Change evidence.

Sanitize:

- User names.
- Computer names.
- Domain names.
- Internet Protocol addresses.
- Universal Naming Convention paths.
- Script content.
- Security configuration.
- Application identifiers.

Retain consistent placeholders so relationships remain visible.

Use Microsoft Trouble Shooting Script toolset only when broader collection is justified for escalation. Review the data collected before sharing it outside your organization.
