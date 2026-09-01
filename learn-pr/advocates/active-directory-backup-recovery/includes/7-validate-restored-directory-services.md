After you've performed recovery, you need to validate restored directory services. Define pass criteria before recovery starts. Validation must prove service health, replication health, data authority, security state, and dependency readiness.

## Validate role-aware services

Don't mark an optional role absent as a failure.

**Run on:** each recovered Windows Server 2025 domain controller in an elevated local session. `Get-WindowsFeature` requires the ServerManager module.

```powershell
$serviceNames = @('NTDS', 'DFSR', 'Netlogon', 'KDC', 'W32Time')

if ((Get-WindowsFeature -Name DNS).Installed) {
    $serviceNames += 'DNS'
}

Get-Service -Name $serviceNames
```

Expected state depends on the recovery phase. Early forest recovery can intentionally stop KDC or omit global catalog capability.

## Validate domain controller readiness

```powershell
dcdiag /test:Advertising /test:SysVolCheck /test:NetLogons /v
dcdiag /test:Replications /v
```

Review the full output. A summary alone can hide warnings or skipped tests.

Validate shares:

```powershell
Get-SmbShare -Name SYSVOL, NETLOGON
```

The shares must exist only after the intended SYSVOL synchronization completes.

For the authoritative DFS Replication initialization path, confirm DFS Replication event ID 4602 on the designated authoritative controller before treating SYSVOL as ready.

For a forced nonauthoritative DFS Replication synchronization, confirm:

- Event ID 4114 after membership is disabled.
- Event ID 4614 after membership is enabled and initial synchronization starts.
- Event ID 4604 after SYSVOL initialization completes.

Don't accept event ID 4614 alone. It indicates that the controller can still be waiting for initial replication.

## Validate replication

Run the following commands from an approved management host. Select a recovered domain controller that's running in normal AD DS mode and has Active Directory Web Services available.

```powershell
repadmin /replsum
repadmin /showrepl * /errorsonly
repadmin /viewlist *
```

The `*` values in these `repadmin` commands are documented `repadmin` syntax. The `Get-ADReplicationFailure -Target` parameter doesn't support wildcards.

For a single restored controller, identify both the target and the server that enumerates the result:

```powershell
$restoredDc = 'DC01.contoso.com'

$replicationFailures = Get-ADReplicationFailure `
    -Target $restoredDc `
    -Scope Server `
    -EnumeratingServer $restoredDc `
    -ErrorAction Stop

$replicationFailures |
    Select-Object Server, Partner, FirstFailureTime, FailureCount, LastError
```

For forest recovery, discover the forest through an explicitly selected seed controller. Early in recovery, some controllers can be intentionally offline, so retain enumeration errors without stopping at the first unreachable controller:

```powershell
$seedDc = 'DC01.contoso.com'
$forestName = 'contoso.com'
$enumerationErrors = @()

Get-ADForest -Identity $forestName -Server $seedDc -ErrorAction Stop |
    Select-Object Name, RootDomain

$replicationFailures = Get-ADReplicationFailure `
    -Target $forestName `
    -Scope Forest `
    -EnumeratingServer $seedDc `
    -ErrorVariable enumerationErrors `
    -ErrorAction SilentlyContinue

$replicationFailures |
    Select-Object Server, Partner, FirstFailureTime, FailureCount, LastError

$enumerationErrors |
    ForEach-Object { Write-Warning $_.Exception.Message }
```

Empty output means only that no failures are recorded for the controllers that were reachable and enumerated. Treat every enumeration error as an unvalidated controller. Compare `repadmin /viewlist *`, the PowerShell results, and the enumeration errors with the approved recovered-controller inventory.

Use both tool families as complementary evidence:

- `Get-ADReplicationFailure` provides structured failure objects for the explicit scope successfully enumerated through the selected server.
- `repadmin /replsum` summarizes replication, `repadmin /showrepl * /errorsonly` shows per-partition inbound errors, and `repadmin /viewlist *` provides controller inventory.

Neither tool alone validates partition completeness, intended topology, lingering objects, invocation IDs, DFS Replication SYSVOL, DNS, or application readiness.

Also inspect:

- Replication quarantine.
- Lingering objects.
- Unexpected invocation IDs.
- Stale connection objects.
- Missing directory partitions.
- Inbound and outbound topology.

During isolated recovery, expected partner scope can be deliberately small. Validate against the approved topology, not the original production topology.

## Validate DNS

Validate AD-integrated data by partition:

- Domain naming context.
- `DomainDnsZones`.
- `ForestDnsZones`.

Validate separately:

- File-backed zones.
- Delegations.
- Conditional forwarders.
- Forwarders.
- Policies.
- Dynamic update settings.

Check:

- The `_msdcs` CNAME records.
- Domain controller locator SRV records.
- A and AAAA records.
- NS records.
- Name resolution from every recovered domain.
- Removal of retired-controller records.

Confirm stale records don't return through replication or dynamic registration.

## Validate operations masters

Pin these checks to the approved recovered controller instead of relying on Domain Controller Locator:

Run these checks from an elevated Windows PowerShell session on the target controller or an approved RSAT host with the AD DS tools installed. `netdom query` requires an elevated command prompt, and a nonelevated run fails in a way that's easy to misread as a locator problem.

```powershell
$targetDc = 'DC01.contoso.com'
$forestName = 'contoso.com'
$domainName = 'contoso.com'
$queryCredential = Get-Credential -Message "Enterprise Admin for $forestName"

Get-ADForest `
    -Identity $forestName `
    -Server $targetDc `
    -Credential $queryCredential `
    -ErrorAction Stop |
    Select-Object SchemaMaster, DomainNamingMaster

Get-ADDomain `
    -Identity $domainName `
    -Server $targetDc `
    -Credential $queryCredential `
    -ErrorAction Stop |
    Select-Object PDCEmulator, RIDMaster, InfrastructureMaster

netdom query "/domain:$domainName" "/server:$targetDc" `
    "/userD:$domainName\<domain-admin>" /passwordD:* FSMO
```

For a domain-only recovery, omit the forest-role query. Repeat the domain query with the approved target in every recovered domain. Retain the output, confirm every role points to the intended recovered controller, and confirm former holders can't reconnect.

On an isolated recovery network, `netdom` must be able to locate the named domain, so name resolution and Domain Controller Locator dependencies for that domain must exist on the isolated network. Treat a locator failure as missing recovery DNS, and an authentication failure as a credential or isolation problem, rather than as evidence of incorrect role placement, and confirm the `Get-ADDomain` result against the recovered controller.

## Validate time configuration

Kerberos depends on time.

Validate:

- Forest-root PDC Emulator time source.
- Domain hierarchy.
- Hypervisor time integration policy.
- Recovery-network time source.
- Client skew.

Don't let an untrusted production time source control isolated recovery.

## Validate authentication

Test:

- User sign-in.
- Computer secure channel.
- Password change.
- Kerberos ticket issuance.
- Service ticket issuance.
- Group Policy processing.
- Global catalog query.
- Cross-domain authentication.
- Trust authentication.

Use representative accounts. Don't rely on one administrator sign-in.

## Validate security

Review the following items:

- Privileged groups.
- Delegated control.
- Built-in accounts.
- Service accounts.
- Group managed service accounts (gMSAs).
- Scheduled tasks.
- Services with stored credentials.
- Certificate and federation decisions.
- Directory synchronization.
- Administrative endpoints.
- Backup infrastructure.

Confirm obsolete controllers are blocked at network, virtualization, and directory layers.

## Validate applications

Application owners test:

- Kerberos service principal names.
- Constrained delegation.
- LDAP and LDAPS.
- Group-based authorization.
- Trust-dependent access.
- Password and key rollover.
- DNS dependencies.

An application test is a return-to-service gate, not an informal observation.

## Review event records

Inspect relevant records for:

- Directory Service.
- DFS Replication.
- DNS Server.
- Kerberos Key Distribution Center.
- Netlogon.
- Windows Time.
- Backup.
- VSS.
- Storage.
- Security.

Define accepted warnings. Don't normalize unexplained errors because the environment is in recovery.

## Validate the isolated seed forest

Before production reconnection, place the recovered seed domain controllers on a common network that remains isolated from production.

Resolve:

- IP-address changes.
- DNS client configuration.
- Domain and forest DNS delegation.
- Conditional forwarding and root hints.
- Firewall paths for AD DS replication, DNS, Kerberos, time, and management.
- Temporary connection objects required to establish the intended seed replication topology.

Don't use untrusted production DNS, time, or management services.

### Validate expected controller inventory

Run:

```powershell
repadmin /viewlist *
nltest /dclist:<domain>
```

Compare the results with the approved seed-forest inventory.

Confirm:

- Only intended recovered domain controllers are present.
- Removed controllers have no remaining server object, NTDS Settings object, computer account, replication connection, or locator record.
- No obsolete controller can register or replicate.

### Validate seed replication

Run:

```powershell
repadmin /replsum
repadmin /showrepl * /errorsonly
dcdiag /v
```

Review:

- Replication failures and latency.
- Schema and configuration partitions.
- Every recovered domain naming context.
- `DomainDnsZones` and `ForestDnsZones`.
- Required application partitions.
- SYSVOL and NETLOGON.
- Secure dynamic DNS updates.
- Operations master ownership.
- Relative identifier issuance.
- Time hierarchy.
- Parent-child and cross-domain trust.

Don't accept skipped tests or unexplained warnings as success.

### Establish global catalog readiness

Don't add or readd a global catalog merely because the forest-root controller is online. In a multidomain forest, a restored controller that was a global catalog before the failure should have had the role removed soon after restore so that potentially newer partial replicas were discarded. A single-domain forest is the documented exception.

Continue only after the first writable controller in every required domain is restored, the controllers are connected on the isolated seed network, and replication across the approved topology is validated. Confirm that the schema, configuration, every recovered domain naming context, `DomainDnsZones`, `ForestDnsZones`, and required application partitions are present and synchronized.

Then:

1. Add a global catalog in the forest-root domain.
1. Force or monitor full synchronization of every required forest partition.
1. Review partition-specific inbound replication evidence on the selected global catalog:

    ```console
    repadmin /showrepl DC01.contoso.com /all /verbose
    ```

1. Confirm global catalog promotion completion, including Directory Service event ID 1119 or equivalent current readiness evidence.
1. Recheck that every required partition is present, synchronized, and queryable.
1. Test universal group membership and forest-wide searches.

Don't direct applications or ordinary users to the seed forest until at least one global catalog is ready.

### Validate recovery authentication

Use the prestaged built-in RID-500 Administrator credential for every forest domain and the designated recovery accounts to validate recovery authentication. If `IgnoreGCFailures` was temporarily approved on a domain controller, test the documented no-GC limitation on that same domain controller, after it has restarted with the value set, under the required isolation and access controls. Microsoft documents Directory Service event 1119 **or** `Global Catalog Promotion Complete` data `1` as readiness evidence. After this module's stricter local readiness gate (event 1119 **and** registry data `1` on the promoted controller, plus the locator, replication, universal-group, authentication, and forest-query tests above), restore or remove the value on the affected authenticating domain controller from protected prior-state evidence, restart it, and repeat the following validation through every affected authentication path:

- Domain sign-in.
- Kerberos ticket issuance.
- Password changes.
- Computer secure channels.
- Global catalog queries.
- Parent-child authentication.
- Trust authentication.

Don't rely on one privileged interactive sign-in as proof of authentication health.

### Establish the seed-forest checkpoint

The seed forest reaches its checkpoint only when:

- One stable writable domain controller exists in every recovered domain.
- Every first recovered controller has the intended authoritative SYSVOL state.
- AD DS replication converges across the approved seed topology.
- DNS resolves required forest and domain records.
- At least one global catalog is ready.
- Operations master, relative identifier, time, and trust validation passes.
- No untrusted controller or management plane can connect.
- Security approves the recovered directory state.

Take and validate a new backup of every recovered seed domain controller before adding further controllers or admitting production workloads.

Record:

- Backup identifier.
- Controller name and domain.
- Completion time.
- Catalog and key validation.
- Restore-test plan.
- Technical and security approval.
- Effective lifetime limit and recovery-point age at approval, per recovered domain, including whether each lifetime came from an explicitly configured attribute or a documented default.

## Apply reconnection gates

Use the following checklist for recovery:

| Gate | Evidence | Owner |
|---|---|---|
| Directory database | Required partitions present and queryable | Directory recovery owner |
| Replication | Approved topology converges | Directory recovery owner |
| SYSVOL | Correct authority and ready shares | Group Policy owner |
| DNS | Zones, records, delegation, resolution | DNS owner |
| Time | Trusted hierarchy and acceptable skew | Platform owner |
| Authentication | Kerberos, sign-in, password, secure channel | Identity owner |
| Trust | Direction and application use validated | Trust owner |
| Security | Persistence decisions closed | Security owner |
| Applications | Critical transactions pass | Application owner |
| Business | Data loss and residual risk accepted | Business owner |

Stop recovery if you're unable to pass one of these gates.

## Establish a new baseline

After stabilization:

1. Take new full-server or system-state backups according to policy.
1. Validate catalogs and keys.
1. Test restoration.
1. Retire unsafe or obsolete recovery media.
1. Record elapsed time and data loss.
1. Update diagrams and dependencies.
1. Correct root cause.
1. Update the runbook.
