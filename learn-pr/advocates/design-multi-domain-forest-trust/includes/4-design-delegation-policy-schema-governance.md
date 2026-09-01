Adding domains multiplies administrative boundaries. Without a deliberate OU, delegation, GPO, and schema-governance design, multi-domain environments drift toward either over-broad Domain Admins membership (because delegation was never designed) or unmanageable one-off ACL grants (because delegation was designed ad hoc, object by object).

## Organizational unit structure

Design OUs around **delegation and policy application boundaries**, not around the organization chart. A common, defensible pattern separates OUs by:

- Object type at the top level (users, computers, service accounts, groups), so GPOs and delegated permissions can target a consistent object type without exceptions.
- Administrative or geographic boundary beneath that, matching who actually administers the objects day to day.
- Tiering for privileged objects - domain controllers, Tier 0 servers, and privileged accounts belong in OUs that are explicitly excluded from broad delegation and from standard end-user GPOs.

Avoid deep OU nesting purely to mirror a reporting structure. Every additional level adds GPO inheritance and delegation surface to reason about without adding security value.

## Delegate administration deliberately

Use the Delegation of Control Wizard or explicit `dsacls` or PowerShell ACL changes, scoped to the smallest OU and permission set that satisfies the requirement—for example, reset passwords and unlock accounts rather than Full Control. Avoid broad domain-root delegation. An access control entry (ACE) propagates to descendants only when its inheritance flags, inherited object type, object-specific GUIDs, and each descendant's discretionary access control list (DACL) allow inheritance. Protected or inheritance-disabled DACLs can change the result. Before approval, evaluate the effective permissions on representative users, groups, computers, and OUs, including Tier 0 objects.

> [!IMPORTANT]
> Group Policy **Block Inheritance** affects GPO processing only. It doesn't block directory ACL inheritance. Protect Tier 0 OUs by using narrowly scoped directory ACLs, protected administrative boundaries, and verified effective access; don't rely on a Group Policy inheritance setting to exclude delegated ACEs.

```powershell
# Broad ACE inventory; this doesn't determine whether an ACE is a default.
# Run with the ActiveDirectory module and read access to the target OU.
$ouPath = "AD:\OU=Regional Admins,DC=corp,DC=contoso,DC=com"
$rootDse = Get-ADRootDSE
$guidNames = @{}

Get-ADObject -SearchBase $rootDse.SchemaNamingContext `
    -LDAPFilter '(|(objectClass=attributeSchema)(objectClass=classSchema))' `
    -Properties lDAPDisplayName, schemaIDGUID |
    Where-Object { $_.schemaIDGUID } |
    ForEach-Object {
        $guid = New-Object Guid (,$_.schemaIDGUID)
        $guidNames[$guid.Guid] = $_.lDAPDisplayName
    }

Get-ADObject `
    -SearchBase "CN=Extended-Rights,$($rootDse.ConfigurationNamingContext)" `
    -LDAPFilter '(objectClass=controlAccessRight)' `
    -Properties displayName, rightsGuid |
    Where-Object { $_.rightsGuid } |
    ForEach-Object {
        $guidNames[([Guid]$_.rightsGuid).Guid] = $_.displayName
    }

function Resolve-ADPermissionGuid {
    param([Guid]$Guid)

    if ($Guid -eq [Guid]::Empty) {
        return "All"
    }

    if ($guidNames.ContainsKey($Guid.Guid)) {
        return $guidNames[$Guid.Guid]
    }

    return $Guid.Guid
}

(Get-Acl -Path $ouPath).Access |
    Select-Object IdentityReference, AccessControlType, ActiveDirectoryRights,
        IsInherited, InheritanceType,
        @{Name = "ObjectType"; Expression = { Resolve-ADPermissionGuid $_.ObjectType }},
        @{Name = "InheritedObjectType"; Expression = {
            Resolve-ADPermissionGuid $_.InheritedObjectType
        }},
        InheritanceFlags, PropagationFlags |
    Sort-Object IdentityReference, IsInherited, ActiveDirectoryRights
```

Treat this output as a broad ACE inventory, not a list of exceptions. Compare it with an approved, versioned ACL baseline and delegation register for the domain and OU class. Investigate every difference, resolve object and extended-right GUIDs, and verify effective access on representative descendant objects before changing an ACE. Save the prechange security descriptor and use change control so the ACL can be restored if validation fails.

Review delegation on a schedule, not only at creation time. Delegated rights are one of the most common sources of privilege-escalation paths that security tooling (such as attack-path analysis) later flags as unexpected.

## GPO scope and inheritance

Group Policy applies in the order local, site, domain, OU (with nested OUs applying from the top down), and the closest OU wins on a conflicting setting unless a higher-level GPO is explicitly enforced. Design decisions to document:

- Which GPOs are linked at the domain level and are therefore intended for every object in the domain (for example, a baseline security policy).
- Which OUs use **Block Inheritance**, and why. This should be rare because it drops inherited GPOs except links marked **Enforced**.
- Which GPOs are marked **Enforced**, since an enforced GPO overrides Block Inheritance and any conflicting setting at a lower level. Reserve Enforced for policies that must never be locally overridden, such as domain-wide audit or credential-protection baselines.
- Security filtering and WMI filtering used to narrow a GPO's effective scope beyond its link location.

```powershell
Get-GPInheritance -Target "OU=Regional Admins,DC=corp,DC=contoso,DC=com"

# Confirm whether an OU blocks inheritance from parent GPOs
(Get-GPInheritance -Target "OU=Tier0,DC=corp,DC=contoso,DC=com").GpoInheritanceBlocked
```

Document GPO scope per domain when the forest has multiple domains, since GPOs don't replicate across domain boundaries - each domain needs its own equivalent baseline GPOs, and configuration drift between domains is a common audit finding.

## Protected objects and AdminSDHolder

Members of protected groups - Domain Admins, Enterprise Admins, Schema Admins, and similar privileged groups - have their permissions periodically reset to match the `AdminSDHolder` object by the SDProp process, which overrides any custom ACL applied directly to a protected account or group. Design implications:

- Don't rely on custom, object-level ACLs to restrict what a protected-group member can do; SDProp will overwrite unexpected changes on its next cycle (by default, every 60 minutes).
- If you intentionally modify a domain's `AdminSDHolder` permissions, document the change explicitly. It changes the protected-object baseline in that domain and persists until reverted.
- Removing an account from every protected group doesn't restore inheritance or clear `adminCount`. After confirming that the account is no longer protected, explicitly re-enable inheritance, remove unintended ACEs, and clear `adminCount` according to the approved recovery procedure.

```powershell
# Run separately in each domain with the ActiveDirectory module.
$domain = Get-ADDomain
$forest = Get-ADForest
$forestRootDomain = Get-ADDomain -Identity $forest.RootDomain `
    -Server $forest.RootDomain -ErrorAction Stop

# adminCount is an investigation signal and can remain set after protection ends.
$adminCountObjects = Get-ADObject `
    -LDAPFilter '(&(adminCount=1)(|(objectClass=user)(objectClass=group)))' `
    -Properties adminCount, objectClass, sAMAccountName, memberOf |
    Select-Object Name, sAMAccountName, objectClass, DistinguishedName, memberOf

# Resolve each group against the domain that owns it. This prevents the three
# forest-root groups from disappearing when the script runs in a child domain.
$protectedGroupDefinitions = @(
    [pscustomobject]@{ Sid = "S-1-5-32-544"; Server = $domain.PDCEmulator; Label = "Administrators" }
    [pscustomobject]@{ Sid = "S-1-5-32-548"; Server = $domain.PDCEmulator; Label = "Account Operators" }
    [pscustomobject]@{ Sid = "S-1-5-32-549"; Server = $domain.PDCEmulator; Label = "Server Operators" }
    [pscustomobject]@{ Sid = "S-1-5-32-550"; Server = $domain.PDCEmulator; Label = "Print Operators" }
    [pscustomobject]@{ Sid = "S-1-5-32-551"; Server = $domain.PDCEmulator; Label = "Backup Operators" }
    [pscustomobject]@{ Sid = "S-1-5-32-552"; Server = $domain.PDCEmulator; Label = "Replicator" }
    [pscustomobject]@{ Sid = "$($domain.DomainSID.Value)-512"; Server = $domain.PDCEmulator; Label = "Domain Admins" }
    [pscustomobject]@{ Sid = "$($domain.DomainSID.Value)-516"; Server = $domain.PDCEmulator; Label = "Domain Controllers" }
    [pscustomobject]@{ Sid = "$($domain.DomainSID.Value)-521"; Server = $domain.PDCEmulator; Label = "Read-only Domain Controllers" }
    [pscustomobject]@{ Sid = "$($domain.DomainSID.Value)-526"; Server = $domain.PDCEmulator; Label = "Key Admins" }
    [pscustomobject]@{ Sid = "$($forestRootDomain.DomainSID.Value)-518"; Server = $forestRootDomain.PDCEmulator; Label = "Schema Admins" }
    [pscustomobject]@{ Sid = "$($forestRootDomain.DomainSID.Value)-519"; Server = $forestRootDomain.PDCEmulator; Label = "Enterprise Admins" }
    [pscustomobject]@{ Sid = "$($forestRootDomain.DomainSID.Value)-527"; Server = $forestRootDomain.PDCEmulator; Label = "Enterprise Key Admins" }
)

$groupResolutionFailures = @()
$protectedGroups = foreach ($definition in $protectedGroupDefinitions) {
    try {
        [pscustomobject]@{
            Definition = $definition
            Group = Get-ADGroup -Identity $definition.Sid `
                -Server $definition.Server -ErrorAction Stop
        }
    }
    catch {
        $groupResolutionFailures += [pscustomobject]@{
            ProtectedGroup = $definition.Label
            Sid = $definition.Sid
            Server = $definition.Server
            Error = $_.Exception.Message
        }
    }
}

$membershipEnumerationFailures = @()
$currentProtectedMembers = foreach ($entry in $protectedGroups) {
    try {
        $groupName = $entry.Group.Name
        $groupSid = $entry.Group.SID.Value
        Get-ADGroupMember -Identity $entry.Group.DistinguishedName `
            -Server $entry.Definition.Server -Recursive -ErrorAction Stop |
            Select-Object @{Name = "ProtectedGroup"; Expression = { $groupName }},
                @{Name = "ProtectedGroupSid"; Expression = { $groupSid }},
                Name, SamAccountName, objectClass, DistinguishedName, SID
    }
    catch {
        $membershipEnumerationFailures += [pscustomobject]@{
            ProtectedGroup = $entry.Definition.Label
            Sid = $entry.Definition.Sid
            Server = $entry.Definition.Server
            Error = $_.Exception.Message
        }
    }
}

$adminCountObjects
$currentProtectedMembers |
    Sort-Object ProtectedGroup, objectClass, SamAccountName -Unique
$groupResolutionFailures
$membershipEnumerationFailures
```

> [!WARNING]
> `Get-ADGroupMember -Recursive` is a useful convenience inventory, not authoritative proof across every foreign security principal, cross-domain nesting path, or foreign forest; Microsoft also documents a failure case when a group has members in another forest that doesn't run Active Directory Web Services. For authoritative evidence, query direct and nested membership in each account domain, resolve every foreign security principal SID against its source domain or forest, reconcile the results with the resource-domain groups, and record every unresolved SID or query failure. Don't clear `adminCount`, enable inheritance, or rewrite an object's ACL solely because it isn't returned by one membership query. Review the AdminSDHolder baseline and change history, obtain approval before remediation, and re-run the inventories after the next SDProp cycle.

## Schema change governance

The schema is forest-wide, and a change made in one domain's context affects every domain in the forest. Establish a governance process before any additional domain or forest is added, not after the first ad hoc schema extension request:

- Require a documented business justification and a named approver (typically an Enterprise/Schema Admins-scoped role) for any schema extension.
- Require the change to be tested in a non-production forest first, since schema attributes and classes can't be deleted once created - only deactivated.
- Maintain an approved schema extension register for every custom `attributeSchema` and `classSchema` object. Record the LDAP display name, OID, schema ID GUID, owning application and team, dependent classes or attributes, approved change record, creation and modification dates, defunct state, security classification, and forest-recovery or migration requirement.

```powershell
# Discovery evidence for the schema register. The query doesn't by itself
# distinguish Microsoft-built-in objects from approved custom extensions.
$schemaNc = (Get-ADRootDSE).SchemaNamingContext

Get-ADObject -SearchBase $schemaNc `
    -LDAPFilter '(|(objectClass=attributeSchema)(objectClass=classSchema))' `
    -Properties lDAPDisplayName, attributeID, governsID, schemaIDGUID,
        adminDescription, whenCreated, whenChanged, isDefunct |
    Select-Object Name, objectClass, lDAPDisplayName, attributeID, governsID,
        schemaIDGUID, adminDescription, whenCreated, whenChanged, isDefunct |
    Sort-Object objectClass, lDAPDisplayName
```

Compare the discovery output with a versioned baseline captured from a matching, unextended forest and with approved vendor or internal schema change records. Don't classify an object as custom solely by age or description. Test additions and defunct operations in a nonproduction forest, back up a healthy system-state recovery source, verify schema replication convergence, and confirm application behavior before and after the production change. Schema objects aren't deleted as a normal rollback; approved deactivation uses the defunct mechanism where supported.

Treat schema governance as a permanent operating discipline for the forest, especially once more than one domain or business unit depends on the same schema.
