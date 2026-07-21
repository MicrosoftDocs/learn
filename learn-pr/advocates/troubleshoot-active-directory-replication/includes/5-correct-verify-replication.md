You should only implement a correction when evidence identifies the cause of the issue. When implementing a correction, use change control techniques, record the prechange state, and keep the change's blast radius as narrow as possible.

For example: The `SEA-BNE` site link is continuously available with a 60-minute replication interval. The last successful `SEA-DC-01` to `BNE-DC-01` replication was at 05:56 +10:00, the group change occurred at 06:00, and the source address changed at 06:05. The group change must follow the last success or that successful cycle would already have carried it to `BNE-DC-01`. The symptom became actionable at 07:00, one interval after the group change; the 07:15 baseline is beyond that window.

The following table establishes operational safety boundaries before learners perform corrective actions. It identifies:

- Whether each action is read-only or changes state.
- Where to run it and required permissions.
- Its actual effect and blast radius.

| Action | Classification | Where and access | Effect |
| --- | --- | --- | --- |
| Inspect DNS client, zone, or A-record state; edit the A record | **Read-only diagnostic** for inspection; **low-impact operational change** for an edit | Named DC or DNS management host; DNS-server read access for zone/record inspection; DNS Administrators or delegated zone or record rights for an edit | Inspection reads local or DNS data. An edit changes only the selected record. |
| Flush a resolver cache | **Low-impact operational change** | Named DC; local administrator | Clears only that computer's DNS client cache. |
| Request host registration or restart Netlogon | **Low-impact operational change** | `SEA-DC-01`; local administrator; secure update must authorize the DC computer account | Requests a DNS update or changes local service state. It doesn't prove that registration succeeded. |
| Run DNS and TCP probes | **Read-only diagnostic** | `BNE-DC-01`; no directory privilege | Reads DNS responses and tests a selected TCP connection. |
| Run `repadmin /replicate` | **Low-impact operational change** | Run under a security context authorized to initiate replication at the named destination DSA; normal same-domain DC-to-DC replication authorization is separate from operator delegation. | Starts targeted inbound replication and changes replicated state, not topology. |
| Run Repadmin or replication-only DCDiag tests | **Read-only diagnostic** | Elevated DC or RSAT host; rights on every included DC; Enterprise Admins or equivalent for the documented forest-wide procedure | Reads replication and diagnostic state. |
| Run the full DCDiag DNS test | **Low-impact operational change** | Elevated DC or RSAT host; Enterprise Admins or equivalent for every included DC | Includes a disclosed transient dynamic-update write/delete. |
| Query a business or configuration object | **Read-only diagnostic** | Host with the required module and management path; directory read access | Reads directory data. |
| Check SYSVOL shares, migration state, replicated-folder state, and events | **Read-only diagnostic** | Administrative host with share, event-log, WMI/CIM, and directory read access; run `dfsrmig /getglobalstate` on the PDC emulator and use `dfsrmig /getmigrationstate` to verify all DCs reached that target | Reads SYSVOL and replication-engine state; it doesn't repair SYSVOL. |

## Correct the demonstrated DNS fault

The Contoso evidence shows:

- The GUID CNAME resolves to `SEA-DC-01.contoso.com`.
- The host record resolves that name to retired address `10.10.1.10`.
- The destination `BNE-DC-01` can reach current address `10.10.1.20` on TCP 135.
- The failure began after the source address changed.

First establish the DNS write and query path, keeping transport and DNS evidence separate. For network and RPC diagnostics, record the route `BNE-DC-01` uses to reach the current source address (`10.10.1.20` in this scenario). For DNS diagnostics, inventory configured DNS servers on adapters that are currently up. The route to the source doesn't identify which resolver the DNS Client uses.

```powershell
$route = Find-NetRoute -RemoteIPAddress "10.10.1.20" |
  Where-Object { $_.CimClass.CimClassName -eq "MSFT_NetRoute" }

$route |
  Select-Object InterfaceAlias, InterfaceIndex, DestinationPrefix, NextHop, RouteMetric

$upInterfaceIndexes = Get-NetAdapter -IncludeHidden |
  Where-Object { $_.Status -eq "Up" } |
  Select-Object -ExpandProperty ifIndex

Get-DnsClientServerAddress -AddressFamily IPv4 |
  Where-Object {
    $_.InterfaceIndex -in $upInterfaceIndexes -and
    $_.ServerAddresses.Count -gt 0
  } |
  Select-Object InterfaceAlias, InterfaceIndex, ServerAddresses

Get-DnsServerZone `
  -ComputerName "BNE-DC-01" `
  -Name "contoso.com" |
  Format-List *

Get-DnsServerZone `
  -ComputerName "BNE-DC-01" `
  -Name "_msdcs.contoso.com" |
  Format-List *
```

In this scenario, the inventory identifies `10.40.1.10` as a configured resolver on an adapter that reports Up; verify separately that this DNS server hosts the stated writable AD-integrated zones.

Inspect every `SEA-DC-01` A record on the writable authoritative server that serves `BNE-DC-01`.

```powershell
Get-DnsServerResourceRecord `
  -ComputerName "BNE-DC-01" `
  -ZoneName "contoso.com" `
  -Name "SEA-DC-01" `
  -RRType A
```

Under DNS change control, update or remove only the demonstrated stale `10.10.1.10` A record. Preserve every address intentionally registered for a valid adapter. Before requesting registration on a multihomed DC, inventory every adapter, its IPv4 addresses, configured DNS servers, and `RegisterThisConnectionsAddress` setting:

```powershell
Get-DnsClient |
  Select-Object InterfaceAlias, InterfaceIndex, RegisterThisConnectionsAddress

Get-NetIPAddress -AddressFamily IPv4 |
  Select-Object InterfaceAlias, InterfaceIndex, IPAddress, AddressState
```

`ipconfig /registerdns` registers addresses from all eligible interfaces; it's appropriate only after the intended registered-address set is confirmed. In this scenario, the corrected set contains `10.10.1.20` and excludes `10.10.1.10`.

In a secure AD-integrated zone, verify through approved DNS administration that the corrected record's owner and security allow the `SEA-DC-01` computer account to make subsequent secure dynamic updates. Don't take ownership, replace records solely to change ownership, or grant broad ACLs as a shortcut. If ownership or secure-update authorization is unclear, preserve the record evidence and escalate to the zone administrator.

Verify the A record directly on each writable DNS replica that can serve BNE, then confirm BNE's normal DNS Client result. If the GUID CNAME or DC Locator SRV records are missing, use the approved Netlogon/registration procedure:

```powershell
Restart-Service Netlogon
ipconfig /registerdns
dcdiag /test:dns /v /s:SEA-DC-01 /DnsRecordRegistration
```

Netlogon registers DC Locator records, including the GUID CNAME and LDAP and Kerberos SRV records; the DNS Client service registers host A records. Don't restart Netlogon for this scenario when only the A record is stale and locator records are already correct.

## Recheck the dependency

On `BNE-DC-01`, clear the destination's resolver cache. Then query every applicable configured DNS server explicitly and confirm the local DNS Client result before repeating the TCP test.

```console
ipconfig /flushdns
```

```powershell
# Direct-server proof. Run this query once for every IPv4 server address in the DNS-server inventory.
Resolve-DnsName `
  -Name "SEA-DC-01.contoso.com" `
  -Type A `
  -DnsOnly `
  -NoHostsFile `
  -Server 10.40.1.10

# Local DNS Client result only; it doesn't identify the responding DNS server.
Resolve-DnsName `
  -Name "SEA-DC-01.contoso.com" `
  -Type A `
  -DnsOnly `
  -NoHostsFile

Test-NetConnection `
  -ComputerName SEA-DC-01.contoso.com `
  -Port 135
```

Abridged expected fields:

```output
Name       : SEA-DC-01.contoso.com
Type       : A
IPAddress  : 10.10.1.20

ComputerName     : SEA-DC-01.contoso.com
RemoteAddress    : 10.10.1.20
RemotePort       : 135
TcpTestSucceeded : True
```

The direct-server query proves the answer returned by `10.40.1.10`. The no-`-Server` query shows the local DNS Client result but doesn't identify the responding resolver. `-DnsOnly -NoHostsFile` keeps either query from using a local Hosts-file mapping. For the single-address Contoso source, both queries must return exactly `10.10.1.20`, with no stale `10.10.1.10` answer. The TCP result shows that a connection to port 135 was established at the intended address. End-to-end AD DS replication still requires the dynamic RPC path, authentication, and the replication service endpoint.

## Run one targeted replication test

`repadmin /replicate` starts one inbound replication operation. It changes replicated state but doesn't change topology. Run it only after proving the source is a valid partner for the named partition.

Run from an elevated shell under a security context authorized to initiate the request on the destination DSA. The normal DC-to-DC replication relationship supplies its usual replication authorization; administrative access on both source and destination DCs isn't a universal prerequisite. For a cross-domain, nondefault naming context, or delegated operation, confirm that the initiating identity has the required rights on the named naming context before testing.

Record the UTC/local timestamp of this manual test as `ManualTestTime`.

```console
repadmin /replicate BNE-DC-01 SEA-DC-01 "DC=contoso,DC=com"
```

Expected result:

```output
Sync from SEA-DC-01 to BNE-DC-01 completed successfully.
```

This result proves that the corrected path can replicate the domain partition. It doesn't prove that every partner and partition is healthy.

Don't start with `repadmin /syncall`. It broadens the operation, can obscure the original relationship, and can request obsolete relationships during topology divergence. Use `repadmin /kcc <DCName>` only after correcting a demonstrated topology input and documenting the expected connection change.

## Verify the immediate result

Immediately after the synchronous targeted operation succeeds, query the destination:

```console
repadmin /showrepl BNE-DC-01 /all /verbose
```

For `DC=contoso,DC=com`, confirm that the inbound source is `SEA-DC-01`, the last attempt succeeded, and the last-success time advanced from the prechange 05:56 value. This is immediate proof for one source, destination, and directory partition.

## Verify scheduled convergence

The `SEA-BNE` link is continuously open with a 60-minute interval. A successful manual test advances last-success time, so it isn't proof of scheduled recovery. After the next eligible automatic schedule window, confirm a newer automatic inbound attempt and success for every affected `SEA-DC-01` partner and naming context. Compare partner-specific timestamps and failure counts in detailed output:

```console
repadmin /showrepl BNE-DC-01 /all /verbose
```

```powershell
Get-ADReplicationPartnerMetadata `
  -Target "BNE-DC-01.contoso.com" `
  -Scope Server `
  -Partition * `
  -PartnerType Inbound `
  -EnumerationServer "BNE-DC-01.contoso.com"
```

Verify that each affected row has a successful attempt later than `ManualTestTime`, that last-success also advances after that timestamp, and that consecutive failures don't increase. Use `repadmin /replsummary` separately for forest-wide monitoring. Its largest delta is the longest interval since last success across a server's partners, so it reflects end-to-end topology latency and cumulative scheduling and outage allowance; don't compare it to one link's 60-minute schedule.

Query the business object directly against the repaired destination:

```powershell
Get-ADGroupMember `
  -Identity "Payroll-Approvers" `
  -Server "BNE-DC-01.contoso.com" |
  Where-Object SamAccountName -eq "User-1042"
```

This is a read-only directory query of direct membership, matching the direct add in the scenario. The expected result contains `User-1042`; an empty result fails the business check. Use `-Recursive` only when the requirement is effective nested membership. If replication is healthy but a signed-in user's access token remains stale, test token renewal separately rather than reopening replication troubleshooting.

## Verify SYSVOL for a Group Policy incident

Group Policy has two paths:

- The directory object is current through AD DS replication.
- The policy files are current through Distributed File System Replication (DFSR), or File Replication Service (FRS) only in a legacy domain that remains at DFSRMIG state `0` (`Start`). FRS evidence is diagnostic for that legacy state; it isn't DFSR guidance.

Use read-only checks. Confirm that both DCs expose SYSVOL and that the shares are accessible:

```powershell
Test-Path "\\SEA-DC-01\SYSVOL"
Test-Path "\\BNE-DC-01\SYSVOL"
```

On the PDC emulator, read the domain's intended global SYSVOL migration state. `dfsrmig /getglobalstate` reads the PDC emulator's local AD DS copy, and a result from another DC can be stale because the global state replicates with latency. Then run `dfsrmig /getmigrationstate` to determine whether every DC reached that global state.

```console
dcdiag /test:sysvolcheck /s:SEA-DC-01
dcdiag /test:sysvolcheck /s:BNE-DC-01
dfsrmig /getglobalstate
dfsrmig /getmigrationstate
```

DFSRMIG migration states use the `0` (`Start`), `1` (`Prepared`), `2` (`Redirected`), and `3` (`Eliminated`) namespace. `/getglobalstate` establishes the target; `/getmigrationstate` must show every DC at that target before migration is complete. State `0` uses FRS and state `3` uses DFSR only; states `1` and `2` are transitional, so preserve the migration state and escalate a stalled or inconsistent migration rather than treating it as a routine replication repair. Don't compare these migration states to `DfsrReplicatedFolderInfo.State`: for an active DFSR SYSVOL replicated folder, state `4` means `Normal`. A domain using FRS must plan supported migration to DFSR. Newer Windows Server replica-DC promotion is blocked until SYSVOL is migrated from FRS; don't treat an FRS-state check as a long-term operating model.

When DFSR is the active SYSVOL engine, query both DCs. The `SYSVOL share` replicated folder must report state `4` (`Normal`).

```powershell
"SEA-DC-01", "BNE-DC-01" | ForEach-Object {
  Get-CimInstance `
    -ComputerName $_ `
    -Namespace "root\microsoftdfs" `
    -ClassName DfsrReplicatedFolderInfo `
    -Filter "ReplicatedFolderName='SYSVOL share'" |
    Select-Object PSComputerName, ReplicatedFolderName, State
}
```

Review recent DFS Replication warnings and errors on both DCs. Event 2213 means DFSR paused replication on the volume after a dirty shutdown; it's a database-state safeguard, not a content-freshness finding. On a domain controller, DFSR autorecovery is normally enabled, so a 2213 that requires manual resume isn't the default SYSVOL behavior: preserve or back up the affected replicated data and escalate to the documented Event 2213 recovery procedure, which backs up the data and then calls the `ResumeReplication` method of `DfsrVolumeConfig`. Don't run a resume against a domain controller's SYSVOL volume as a routine step. Event 4012 is a separate content-freshness protection condition; preserve evidence and escalate it rather than treating it as a routine resume. For state `0`, review the **File Replication Service** log and FRS state instead of the DFSR state test; this is legacy diagnostic evidence only, so apply neither DFSR state values nor DFSR recovery to FRS. During states `1` or `2`, review both engines and the migration state.

For the affected Group Policy object (GPO), identify its GUID and compare `gpt.ini` version data and the relevant files under `\\SEA-DC-01\SYSVOL\contoso.com\Policies\{GUID}` and `\\BNE-DC-01\SYSVOL\contoso.com\Policies\{GUID}`. Share availability alone doesn't prove file convergence.

Escalate a missing SYSVOL share, DFSR state `5` (`In Error`), Event 4012, an Event 2213 paused-database condition on SYSVOL, unhealthy legacy FRS state (preserve evidence and use the FRS-to-DFSR migration/deprecation guidance rather than DFSR-only recovery), or divergent GPO files. Authoritative or nonauthoritative SYSVOL recovery is outside this module.

## Record and monitor the result

Document:

- Symptom and business impact.
- Failed destination, source, partition, and time range.
- Root cause: stale host record after the source address change.
- Correction and approval.
- Before-and-after DNS, Repadmin, DCDiag, event, and business evidence.
- Prevention owner and monitoring change.

Alert on:

- Repeated failures rather than a single transient attempt.
- Largest deltas beyond the expected schedule and outage window.
- Unreachable partners or disabled inbound or outbound replication.
- Repeated DNS registration or lookup failures.

Read the forest's configured and effective `tombstoneLifetime`:

```powershell
$configurationNamingContext = (Get-ADRootDSE).configurationNamingContext
$directoryService = Get-ADObject `
  -Identity "CN=Directory Service,CN=Windows NT,CN=Services,$configurationNamingContext" `
  -Properties tombstoneLifetime

$configuredTombstoneLifetime = $directoryService.tombstoneLifetime
$effectiveTombstoneLifetime = if ($null -eq $configuredTombstoneLifetime) {
  60
} elseif ($configuredTombstoneLifetime -lt 2) {
  2
} else {
  $configuredTombstoneLifetime
}

[pscustomobject]@{
  ConfiguredTombstoneLifetimeDays = if ($null -eq $configuredTombstoneLifetime) {
    "Not set"
  } else {
    $configuredTombstoneLifetime
  }
  EffectiveTombstoneLifetimeDays = $effectiveTombstoneLifetime
  EffectiveValueReason = if ($null -eq $configuredTombstoneLifetime) {
    "Attribute absent; AD DS protocol default is 60 days"
  } elseif ($configuredTombstoneLifetime -lt 2) {
    "Configured value is below the 2-day minimum; on Windows Server 2008 R2 and later the effective value is 2 days"
  } else {
    "Configured value"
  }
}
```

Set a critical operational alert sufficiently before `EffectiveTombstoneLifetimeDays` to allow investigation and recovery. Report both values: an absent attribute has a documented effective value of 60 days, and a present value below the two-day minimum has an effective value of two days on Windows Server 2008 R2 and later. Event 2042 is incident-specific corroboration, not the sole way to discover the threshold. Escalate before reconnecting a DC that approaches or exceeds the effective value; keep this AD DS threshold separate from DFSR content freshness and Event 4012.

Maintain accurate DNS records, sites, subnets, and site links. Validate firewall changes against current port guidance. Monitor time and storage. Decommission failed DCs promptly through supported procedures.

Escalate forest-wide impact, database or schema errors, event 1988, event 2042 or error 8614, event 2095, uncertain lingering-object scope, security compromise, or any case without a defensible known-good replica.
