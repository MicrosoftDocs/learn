A read-only domain controller (RODC) hosts a read-only copy of the domain partition and, by default, caches no user or computer credentials. It's designed for locations where you need local authentication and directory lookups but can't guarantee the same physical security, network security, or administrative trust as a hub-site domain controller.

## When an RODC fits

Choose an RODC over a writable domain controller when one or more of the following apply:

- The location has weaker physical security (for example, a branch office without a locked server room or 24-hour access control).
- Local IT staff need administrative rights on the domain controller itself (for hardware, patching, or local troubleshooting) but shouldn't have domain-wide administrative rights.
- The location needs a bounded set of users and computers to authenticate locally during a temporary WAN outage, and the approved credentials can be allowed by the Password Replication Policy (PRP), prepopulated, and tested before the outage. An RODC doesn't provide write availability and doesn't authenticate an account from its local database until the required credential has been cached.
- Local authentication load doesn't need write availability - the location doesn't run applications or scripts that require a writable domain controller nearby.

> [!IMPORTANT]
> Select an RODC primarily to reduce credential exposure at a site with weaker physical security or lower administrative trust. Don't select an RODC solely because a WAN link is slow or unreliable. The first authentication for an allowed account normally needs a reachable writable domain controller unless the credential has been prepopulated. Password changes, directory writes, uncached credentials, and other writable operations continue to require a reachable writable domain controller.
>
> Before branch acceptance, prepopulate only approved branch user and computer credentials, disconnect the WAN in a controlled test window, and validate existing-user logon, first logon for a nonprepopulated account, computer authentication, password-change behavior, DNS registration, Group Policy processing, and every branch application that writes to AD DS. Record which tests are expected to fail during isolation. Restore connectivity and confirm replication health after the test.

```powershell
# Run from an elevated Windows PowerShell session with the ActiveDirectory module.
# Replace RODC01 with the approved RODC name.
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity "RODC01" -RevealedAccounts
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity "RODC01" -AuthenticatedAccounts

repadmin /showrepl RODC01
dcdiag /s:RODC01 /test:Advertising /test:NetLogons /test:DNS
```

An RODC isn't a substitute for physical security or network security controls; it limits what a domain-level compromise at that location can expose, but it doesn't prevent theft, tampering, or local privilege escalation on the host itself. If the host or its virtualization fabric is compromised, an attacker still gains local administrative control of that server and access to whatever credentials are cached on it - the RODC's value is limiting that blast radius to a defined, reviewable set of cached credentials rather than the entire domain's credential store.

## Password Replication Policy (PRP)

The PRP controls whose passwords are permitted to be cached on a specific RODC. It's built from four sets:

- **Allowed list** - accounts whose passwords are permitted to replicate to and be cached on this RODC.
- **Denied list** - accounts explicitly blocked from having their passwords cached, regardless of allowed-list membership. By default, this includes highly privileged built-in groups (Domain Admins, Enterprise Admins, Schema Admins, and similar), and that default shouldn't be relaxed without a specific, documented reason.
- **Revealed list** - accounts whose passwords are currently stored on this RODC, whether they were cached on demand after a successful authentication or prepopulated by an administrator ahead of first logon. Use this list, not an assumption about who has signed in, to scope which credentials a compromise of this RODC would expose.
- **Authenticated to** - accounts and computers that have authenticated through this RODC, whether or not their password was cached, useful for scoping which accounts genuinely use a given branch location.

Design the allowed list narrowly, scoped to the accounts that actually work from that branch, rather than adding broad groups "to be safe." Every account on the allowed list is a credential that a compromise of that specific RODC could expose.

```powershell
# Review the current PRP for an RODC
Get-ADDomainControllerPasswordReplicationPolicy -Identity RODC01 -Allowed
Get-ADDomainControllerPasswordReplicationPolicy -Identity RODC01 -Denied

# Add an account or group to the allowed list, scoped to the branch's users
Add-ADDomainControllerPasswordReplicationPolicy -Identity RODC01 -AllowedList "Branch-Users"

# Confirm which accounts have actually had their credentials cached (revealed)
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity RODC01 -RevealedAccounts

# Confirm which accounts have authenticated through this RODC
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity RODC01 -AuthenticatedAccounts
```

## Prepopulation

You can prepopulate specific accounts' passwords onto an RODC before their first authentication, which avoids a delay on first logon and lets you validate the PRP before the branch goes live. Prepopulation only succeeds for accounts already on the allowed list (directly or through group membership); it doesn't bypass the PRP.

```powershell
# Add the account to the allowed list, then prepopulate its password ahead of first logon
Add-ADDomainControllerPasswordReplicationPolicy -Identity RODC01 -AllowedList "jsmith"
repadmin /rodcpwdrepl RODC01 dc01.corp.contoso.com "CN=Jamie Smith,OU=Branch01,DC=corp,DC=contoso,DC=com"
```

## Filtered attribute set

The RODC filtered attribute set (FAS) prevents selected schema attributes from replicating to RODCs in the forest. It limits exposure from an RODC replica; it doesn't restrict reads from writable replicas. Confidentiality is a separate read-access check, and neither control replaces a least-privilege ACL.

For credential-like or highly sensitive custom attributes, require one governed design that includes:

- FAS membership to exclude the attribute from all RODCs.
- The confidential attribute flag where appropriate. A base-schema attribute, identified by `0x10` in `systemFlags`, can't be marked confidential.
- Object-specific, least-privilege ACEs for approved application identities and administrators. Reading a confidential attribute requires both `READ_PROPERTY` and `CONTROL_ACCESS` on that attribute or its property set; don't grant broad generic **All Extended Rights** merely to satisfy the control-access check.
- Confirmation that the attribute isn't system critical and that the owning application supports the schema and ACL design.
- Testing on writable domain controllers and RODCs, replication validation, recovery documentation, and schema/ACL change control.

Use the following read-only inventory. `0x200` is the FAS bit, `0x80` is the confidential bit, `0x1` in `schemaFlagsEx` identifies a system-critical attribute that can't be added to the FAS, and `0x10` in `systemFlags` identifies a base-schema attribute that can't be marked confidential:

```powershell
$attributeLdapDisplayName = "someCustomAttribute"
$schemaNc = (Get-ADRootDSE).SchemaNamingContext

$attribute = Get-ADObject -SearchBase $schemaNc `
    -LDAPFilter "(lDAPDisplayName=$attributeLdapDisplayName)" `
    -Properties lDAPDisplayName, searchFlags, schemaFlagsEx, systemFlags

[pscustomobject]@{
    Attribute = $attribute.lDAPDisplayName
    InRodcFilteredAttributeSet = (
        ([int]$attribute.searchFlags -band 0x200) -ne 0
    )
    Confidential = (
        ([int]$attribute.searchFlags -band 0x80) -ne 0
    )
    SystemCritical = (
        ([int]$attribute.schemaFlagsEx -band 0x1) -ne 0
    )
    BaseSchema = (
        ([int]$attribute.systemFlags -band 0x10) -ne 0
    )
}
```

> [!WARNING]
> Don't change `searchFlags`, confidentiality, or attribute read ACLs directly in production as an ad hoc branch fix. Schema changes are forest-wide, and an incorrect ACL can break the application or expose existing values. Test the combined change in a nonproduction forest, export the prechange schema and ACL evidence, approve the identities that retain read access, and verify that an RODC doesn't receive the attribute while the application still reads it from an authorized writable replica.

## Delegated local administration

An RODC supports delegating local administrative rights (installing drivers, patching, local troubleshooting) to a branch-office user or group without granting that account any domain-level administrative rights. This is one of the RODC's core value propositions for branch deployments with local IT support but no local domain administrators.

For an unstaged RODC installation, run the following locally from an elevated Windows PowerShell session on the target server. The credential must be a Domain Admin; introducing the first RODC in the forest also requires the forest-level preparation described later. The delegated group gains local administrative rights on the resulting RODC, not domain administrative rights.

```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

$domainAdminCredential = Get-Credential `
    -Message "Enter the approved Domain Admin credential"
$dsrmPassword = Read-Host "Enter the DSRM password" -AsSecureString

Install-ADDSDomainController `
    -Credential $domainAdminCredential `
    -DomainName "corp.contoso.com" `
    -ReadOnlyReplica `
    -DelegatedAdministratorAccountName "CORP\branch-admins" `
    -SiteName "Branch01" `
    -InstallDns `
    -SafeModeAdministratorPassword $dsrmPassword
```

Don't place credentials or the DSRM password in plain text or source control. Confirm after restart that members of `CORP\branch-admins` have only the intended local RODC administration rights.

## DNS and global catalog behavior

An RODC can host a read-only DNS zone and can be configured as a global catalog server. A read-only DNS zone on an RODC doesn't accept dynamic updates directly - client update requests are referred to a writable DNS server, and the RODC receives the update through normal replication shortly afterward. Plan for this brief delay in branch locations with dynamic DNS-dependent applications.

## Staged deployment and Install From Media (IFM)

### Prepare the forest before the first staged RODC

Creating a staged RODC account doesn't run `adprep /rodcprep`. Before staging the first RODC in a forest, complete one of these approved paths:

1. Deploy the first RODC without staging by using credentials that allow the installation workflow to run the required preparation.
2. Manually run `adprep /rodcprep`, allow the changes to replicate throughout the forest, and then stage the account.

For the manual path, use `Adprep.exe` from Windows Server installation media that matches the target deployment version. Run from an elevated command prompt with an Enterprise Admin account while every domain and required infrastructure-master path is reachable and replication is healthy:

```cmd
D:\support\adprep\adprep.exe /rodcprep
repadmin /replsummary
repadmin /showrepl * /errorsonly
```

Replace `D:` with the mounted installation-media drive. Capture the successful `adprep` output and don't proceed until the resulting permissions have converged to every affected domain. Then run the staged-account prerequisite test from Windows PowerShell as a Domain Admin:

```powershell
$domainAdminCredential = Get-Credential `
    -Message "Enter the approved Domain Admin credential for corp.contoso.com"

Test-ADDSReadOnlyDomainControllerAccountCreation `
    -DomainControllerAccountName "RODC01" `
    -DomainName "corp.contoso.com" `
    -SiteName "Branch01" `
    -Credential $domainAdminCredential
```

Don't use `-SkipPreChecks`. If preparation or replication validation fails, stop before equipment or IFM media is shipped.

A staged installation separates account creation from attachment. A Domain Admin precreates the RODC account and delegates attachment; the delegated installer then attaches a clean workgroup server with the exact staged computer name. IFM can reduce the initial directory database transfer, but it doesn't eliminate live DNS, authentication, trust, time, writable-domain-controller connectivity, SYSVOL transfer, replication of changes made after the media was created, or post-promotion validation.

### Stage 1: Create and validate the account

Run from an elevated Windows PowerShell session on a domain controller or management host with the AD DS deployment tools. Confirm the forest preparation is complete:

```powershell
$domainAdminCredential = Get-Credential `
    -Message "Enter the approved Domain Admin credential"

Test-ADDSReadOnlyDomainControllerAccountCreation `
    -DomainControllerAccountName "RODC01" `
    -DomainName "corp.contoso.com" `
    -SiteName "Branch01" `
    -Credential $domainAdminCredential

Add-ADDSReadOnlyDomainControllerAccount `
    -DomainControllerAccountName "RODC01" `
    -DomainName "corp.contoso.com" `
    -SiteName "Branch01" `
    -DelegatedAdministratorAccountName "CORP\branch-admins" `
    -InstallDns `
    -Credential $domainAdminCredential

Get-ADComputer -Identity "RODC01" -Properties userAccountControl |
    Select-Object Name, DistinguishedName, Enabled, userAccountControl
```

### Create and protect RODC IFM

Create RODC-specific IFM from a healthy, writable domain controller in the same domain. The operator requires the documented backup or domain rights for IFM creation:

```cmd
ntdsutil.exe "activate instance ntds" "ifm" "create rodc C:\IFM\RODC01" quit quit
```

Ntdsutil stores domain-controller installation media in an `Active Directory` child directory under the path supplied to `create rodc`. Preserve and verify that directory layout when copying the media; for this example, the usable installation-media path after transfer is `D:\IFM\RODC01\Active Directory`, not its parent. Confirm that the child directory and expected media files, including `ntds.dit`, are present before promotion.

Use newly generated media that is younger than the effective tombstone lifetime and compatible with the target server. Store and transport it as sensitive directory data: restrict NTFS access, use organization-approved encryption for removable media or transfer, record custody, verify integrity after transfer, and securely erase every extra copy after successful deployment. Don't send an unencrypted IFM directory to the branch.

### Stage 2: Attach the workgroup server

Before attachment, confirm that:

- The server name is exactly `RODC01`.
- The server isn't domain joined and no previous computer or domain-controller installation is present.
- The server uses approved AD DNS servers, has synchronized time, and can resolve the domain and locate a writable domain controller.
- The firewall permits the documented AD DS paths.
- The IFM directory is present, access-controlled, integrity-checked, and approved for use.

Run locally from an elevated Windows PowerShell session:

```powershell
$computerSystem = Get-CimInstance Win32_ComputerSystem
if ($computerSystem.PartOfDomain) {
    throw "The staged RODC attachment server must be in a workgroup."
}

if ($env:COMPUTERNAME -ne "RODC01") {
    throw "Rename the server to RODC01 and restart before attachment."
}

$ifmPath = "D:\IFM\RODC01\Active Directory"
if (-not (Test-Path -LiteralPath $ifmPath -PathType Container)) {
    throw "The copied IFM Active Directory child directory isn't present."
}

if (-not (Test-Path -LiteralPath (Join-Path $ifmPath "ntds.dit") -PathType Leaf)) {
    throw "The copied IFM layout doesn't contain ntds.dit at the usable path."
}

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

$domainName = "corp.contoso.com"
$targetDc = "dc01.corp.contoso.com"

Resolve-DnsName "_ldap._tcp.dc._msdcs.$domainName" `
    -Type SRV -ErrorAction Stop

& nltest.exe "/dsgetdc:$domainName" /writable /force
if ($LASTEXITCODE -ne 0) {
    throw "nltest couldn't locate a writable domain controller for $domainName."
}

$requiredTcpPorts = 53, 88, 135, 389, 445
foreach ($port in $requiredTcpPorts) {
    if (-not (Test-NetConnection -ComputerName $targetDc `
        -Port $port -InformationLevel Quiet)) {
        throw "Required TCP $port probe to $targetDc failed."
    }
}

$attachCredential = Get-Credential `
    -Message "Enter the delegated CORP\branch-admins attachment credential"
$dsrmPassword = Read-Host "Enter the DSRM password" -AsSecureString

Test-ADDSDomainControllerInstallation `
    -DomainName $domainName `
    -UseExistingAccount `
    -InstallationMediaPath $ifmPath `
    -Credential $attachCredential `
    -SafeModeAdministratorPassword $dsrmPassword

Install-ADDSDomainController `
    -DomainName $domainName `
    -UseExistingAccount `
    -InstallationMediaPath $ifmPath `
    -Credential $attachCredential `
    -SafeModeAdministratorPassword $dsrmPassword
```

These probes fail the procedure when required DNS resolution, writable-DC discovery, or tested TCP connectivity fails. They still don't prove the whole AD DS path: `Test-NetConnection` doesn't validate UDP, and a few fixed-port probes don't validate dynamic RPC negotiation or the complete authentication, replication, and SYSVOL exchanges. Don't continue unless DNS discovery, time, firewall, writable-domain-controller connectivity, UDP requirements, and dynamic RPC pass the approved end-to-end tests.

### Validate after restart

```powershell
Get-ADDomainController -Identity "RODC01" |
    Select-Object HostName, Site, IsReadOnly, IsGlobalCatalog

repadmin /showrepl RODC01
dcdiag /s:RODC01 /test:Advertising /test:NetLogons /test:DNS /test:SysVolCheck
```

Confirm inbound replication, SYSVOL and NETLOGON publication, DNS registration, global-catalog state if selected, PRP behavior, and writable-domain-controller failover. Securely erase IFM from the target and transport media after the deployment record and rollback window permit deletion.

## Writable domain controller dependencies

Despite hosting a read-only directory, an RODC requires writable domain controllers for password changes, uncached credentials, directory writes, replication, and other operations that can't complete locally. An RODC doesn't normally depend permanently on one writable domain controller. DC Locator, site and site-link topology, DNS registration, service suitability, reachability, and any explicitly selected promotion or replication source determine which writable domain controller is used. Record a tested set of suitable writable-domain-controller candidates for each RODC, their sites and DNS records, required firewall paths, expected selection behavior, capacity during failover, and monitoring. Treat `-ReplicationSourceDC` as an explicit source for the associated promotion or replication operation, not as a permanent all-service binding.

Run from the branch RODC or a representative branch host:

```cmd
nltest /dsgetdc:corp.contoso.com /writable /force
nltest /sc_query:corp.contoso.com
repadmin /showrepl RODC01
```

```powershell
$candidateWritableDcs = @(
    "dc01.corp.contoso.com",
    "dc02.corp.contoso.com"
)

foreach ($dc in $candidateWritableDcs) {
    Test-NetConnection -ComputerName $dc -Port 88
    Test-NetConnection -ComputerName $dc -Port 389
    Test-NetConnection -ComputerName $dc -Port 445
    Test-NetConnection -ComputerName $dc -Port 135
}
```

During an approved maintenance window, make one candidate unavailable to the test client or RODC without weakening production firewall policy, force rediscovery, and confirm that a suitable alternative is selected. Validate password change, uncached authentication, DNS registration, replication, and branch applications. Restore the candidate, confirm convergence, and retain evidence. Don't build firewall rules or monitoring around only one writable domain controller.

> [!IMPORTANT]
> Delegated Managed Service Accounts (dMSAs) are a Windows Server 2025 capability. Don't add dMSA behavior to an RODC design until the current dMSA prerequisites have been validated for the forest, domain, domain controllers, application server, and management tools. Record the operating system build, functional levels, support lifecycle, application support statement, PRP decision, password-retrieval authorization, and rollback plan. If any server or management path doesn't support dMSA, retain a supported service-account design until the compatibility gate is complete.

## Account for delegated Managed Service Accounts

A Windows Server 2025 application server can use a delegated Managed Service Account (dMSA) behind an RODC without writable domain controller connectivity only when:

- The dMSA is cached on the RODC.
- The application server's computer account is explicitly allowed to retrieve the managed password.

```powershell
Set-ADServiceAccount -Identity "dMSAFinApp" `
    -PrincipalsAllowedToRetrieveManagedPassword "FINAPP01$"
```

Record the dMSA in the branch PRP and credential-prepopulation plan. Detailed dMSA migration belongs to the service-account compatibility module. For current prerequisites, see [Delegated Managed Service Accounts FAQ](/windows-server/identity/ad-ds/manage/delegated-managed-service-accounts/delegated-managed-service-accounts-faq).

## Compromise response and cached-credential reset

If an RODC is lost, stolen, or suspected compromised, the response is different from a writable domain controller incident because the blast radius is defined by the revealed list:

1. Export the revealed list so you know which domain credentials were cached.
2. Reset every revealed user, computer, and service account through its approved recovery workflow. Also rotate the RODC's local and RODC-specific secrets.
3. Delete the RODC account by using the RODC-aware deletion workflow and select the option to reset cached account passwords. If you use generic metadata cleanup instead, password resets aren't automatic.
4. Clean up DNS and replication metadata.
5. Rebuild the RODC from a known-clean image and a fresh staged deployment rather than restoring the compromised server.

```powershell
Get-ADDomainControllerPasswordReplicationPolicyUsage -Identity RODC01 -RevealedAccounts |
    Select-Object Name, SamAccountName, ObjectClass, DistinguishedName
```

Document this procedure before the first RODC is deployed, not during an actual incident. For additional background, see [Read-Only DCs and the Active Directory Schema](/windows/win32/ad/rodc-and-active-directory-schema) and [Planning Regional Domain Controller Placement](/windows-server/identity/ad-ds/plan/planning-regional-domain-controller-placement).
