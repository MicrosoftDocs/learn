Multi-domain and multi-forest designs increase both the number of replication partners a domain controller has to track and the consequences of a replication failure going unnoticed. This unit covers the advanced replication risks that matter most once your topology grows beyond a single, well-connected domain, plus the capacity planning inputs needed to size domain controllers correctly.

## Urgent replication and change notification

Account lockouts and selected security-sensitive changes trigger **urgent replication**, which bypasses the normal intrasite delay. Password changes also have PDC-emulator-specific forwarding and conflict-resolution behavior. Intersite replication follows the site-link schedule and interval unless change notification is explicitly enabled on the link. Confirm whether security-sensitive changes and password updates converge quickly enough for users who authenticate across sites.

## Stale domain controllers, tombstones, and lingering objects

A domain controller that hasn't replicated inbound within the tombstone lifetime risks retaining lingering objects—objects deleted elsewhere that the stale domain controller didn't learn about before deletion metadata was garbage-collected. A forest created with Windows Server 2003 SP1 or later normally receives a 180-day default. Upgrading an older forest, running forest preparation, or introducing newer domain controllers doesn't automatically replace the forest's configured value. Older or explicitly customized forests can therefore retain 60 days or another value. Use the directory's effective `tombstoneLifetime` value for monitoring thresholds, maximum offline-domain-controller decisions, backup retention, and recovery planning.

This risk is more likely in complex environments because they include more disconnected sites, acquired domains with poor historical connectivity, or domain controllers that were incorrectly retained offline.

```powershell
$directoryService = "CN=Directory Service,CN=Windows NT,CN=Services,$(
    (Get-ADRootDSE).configurationNamingContext
)"

$configuredValue = (Get-ADObject -Identity $directoryService `
    -Properties tombstoneLifetime).tombstoneLifetime

if ($null -eq $configuredValue) {
    $effectiveTombstoneLifetimeDays = 60
    $valueSource = "Attribute isn't set; AD DS defaults to 60 days"
}
else {
    $parsedValue = 0
    if (-not [int]::TryParse(
        [string]$configuredValue,
        [ref]$parsedValue
    )) {
        throw "tombstoneLifetime isn't a valid integer. Don't derive monitoring thresholds."
    }

    if ($parsedValue -lt 2) {
        throw "tombstoneLifetime is below the documented minimum of 2 days. " +
            "AD DS fallback differs by Windows Server version (60 days through " +
            "Windows Server 2008; 2 days on Windows Server 2008 R2 and later). " +
            "Investigate and correct the forest value before deriving thresholds."
    }

    $effectiveTombstoneLifetimeDays = $parsedValue
    $valueSource = "Configured tombstoneLifetime attribute"
}

[pscustomobject]@{
    TombstoneLifetimeDays = $effectiveTombstoneLifetimeDays
    ValueSource = $valueSource
}

repadmin /showrepl * /csv
repadmin /replsummary
```

Validate the value in every forest and attach the output to monitoring, backup, and recovery records. A null attribute has the Microsoft-documented 60-day fallback. Treat any configured value below 2 as an exception requiring investigation rather than as a normal monitoring input, because the protocol fallback depends on domain-controller operating-system version. Don't change `tombstoneLifetime` as an isolated tuning action; assess deleted-object lifetime, backups, offline domain controllers, replication convergence, and recovery procedures through forest-level change control.

Mitigations to design in from the start:

- Alert on any domain controller that hasn't replicated inbound within a defined threshold well before the tombstone lifetime expires (for example, 14-21 days), not only when it finally exceeds it.
- Retire or rebuild domain controllers that'll be offline longer than the tombstone lifetime rather than reconnecting them; don't rely on `repadmin /removelingeringobjects` as a routine recovery step - treat it as an exception-handling procedure.
- Keep clocks synchronized (time skew tolerance affects Kerberos, not tombstone detection directly, but poor time hygiene is a common co-symptom of neglected domain controllers).
- Explicitly enable Strict Replication Consistency on every domain controller. Don't rely on forest age or an assumed default. Event 1388 means a destination without strict consistency accepted and reintroduced the object, which might then have propagated to other writable or global-catalog replicas. Event 1988 means a destination with strict consistency blocked replication of the affected partition from the source containing the lingering object.
- For either event, place the suspected stale source and affected replication path under incident containment until the partition, authoritative reference domain controller, and replica scope are known. For event 1388, escalate before cleanup, determine whether the reintroduced object is desired, and assess every writable and global-catalog replica that can hold the partition for propagation. Don't apply the event-1988 `repadmin /removelingeringobjects` sequence blindly to a 1388 incident; use the Microsoft-supported 1388 recovery procedure or an approved support-led recovery plan.
- For event 1988, keep the blocked source-partition path contained, run lingering-object detection in advisory mode first, review the output, remove approved objects, and resume replication only after replication and event-log validation.

Run the forest-wide setting from an elevated command prompt as an Enterprise Admin, or target individual domain controllers with the minimum documented domain rights:

```cmd
repadmin /regkey * +strict
```

Confirm the explicit registry value after the change. PowerShell remoting must already be approved and enabled for the administrative path:

```powershell
$domainControllers = Get-ADDomainController -Filter * |
    Select-Object -ExpandProperty HostName

Invoke-Command -ComputerName $domainControllers -ScriptBlock {
    [pscustomobject]@{
        DomainController = $env:COMPUTERNAME
        StrictReplicationConsistency = Get-ItemPropertyValue `
            -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" `
            -Name "Strict Replication Consistency" `
            -ErrorAction SilentlyContinue
    }
}
```

If event 1388 occurs, preserve the event and replication evidence, prevent further propagation through the affected path under the incident plan, inventory the object by GUID on all writable and global-catalog replicas of the partition, and escalate to the forest recovery owner before deletion or replication is resumed. Because the object has already been accepted and reintroduced, this runbook's generic `repadmin /removelingeringobjects` cleanup isn't sufficient for that branch.

If event 1988 identifies a source and partition, use an up-to-date writable replica as the authoritative reference. Replace every placeholder before execution. Run advisory mode first:

```cmd
repadmin /showrepl <authoritative-reference-dc>
repadmin /removelingeringobjects <destination-dc> <reference-dc-guid> <directory-partition-dn> /advisory_mode
```

After the owner reviews the advisory output and approves removal, repeat the `repadmin /removelingeringobjects` command without `/advisory_mode`. Use Domain Admin rights for a domain partition and Enterprise Admin rights for schema or configuration partitions. Repeat the scan for all writable and global-catalog replicas that can hold the partition. Don't resume replication merely because one object was removed.

**Post-remediation validation:**

```cmd
repadmin /replsummary
repadmin /showrepl * /errorsonly
dcdiag /e /test:Replications
```

Confirm that no new 1388 or 1988 events occur and that every affected naming context converges before removing quarantine controls.

## Disconnected sites and manual bridgehead configuration

The **Knowledge Consistency Checker (KCC)** and, for inter-site topology, the **Intersite Topology Generator (ISTG)** automatically compute replication connections and select bridgehead servers per site. Manual bridgehead configuration overrides this automatic selection and should be the exception, not the default: a manually designated bridgehead that goes offline doesn't get automatically replaced, which can silently isolate an entire site from inbound or outbound inter-site replication until someone notices and intervenes. Automatic bridgehead selection tolerates a bridgehead failure by re-electing a new one on the next KCC run.

Reserve manual bridgehead configuration for scenarios with a specific technical constraint - for example, only one domain controller in a site has a certificate or firewall rule that permits inter-site replication traffic. Document the risk and the monitoring that compensates for the loss of automatic failover whenever you do this.

```powershell
repadmin /bridgeheads
repadmin /kcc
```

## Windows Server 2025 replication priority

Windows Server 2025 introduces **Replication Priority Boost**, which lets an administrator raise the system-calculated replication priority for a specific naming context and replication partner combination, using the `setPriorityBoost` rootDSE modifier and the `msDS-PriorityBoost` attribute to read the current boost. This is most useful for scenarios such as an over-the-wire domain controller promotion that needs to replicate a large directory information tree (DIT): if replication is interrupted, you can prioritize a specific partner so the promotion resumes efficiently rather than competing with lower-priority background replication. It doesn't replace correct site and bridgehead design - it's a targeted tool for specific, known bottlenecks. For configuration steps and recommended boost values, see [Active Directory Domain Services Replication Priority Boost](/windows-server/identity/ad-ds/manage/replication-priority-boost).

## Capacity planning for domain controllers

Multi-domain and multi-forest designs increase per-domain-controller load in ways that are easy to underestimate: more universal group expansion for global catalog servers, more LDAP and Kerberos authentication traffic funneled through fewer domain controllers in smaller domains, and larger backup windows as the directory information tree grows. Plan capacity using these dimensions instead of any fixed, one-size figure:

- **LSASS and ESE database cache** - the directory database engine (ESE) performs best when frequently accessed data fits in cache; size RAM so the working set (not necessarily the entire DIT) can be cached, and monitor cache-hit ratios rather than assuming a fixed RAM figure will remain correct as the directory grows.
- **RAM** - sized to comfortably hold the LSASS working set and the OS/application overhead, with headroom for peak authentication periods (such as a Monday-morning logon surge across time zones).
- **Storage latency** - the DIT and logs are latency-sensitive; prioritize low, consistent read/write latency (typically flash-based storage) over raw capacity, and separate the database and log volumes when I/O contention is a concern.
- **CPU and NUMA** - Windows Server 2025 AD DS is NUMA-aware and can use CPUs across all processor groups, removing the prior effective ceiling around 64 logical processors on a single domain controller. Don't use this as a reason to consolidate replication redundancy into fewer, larger domain controllers - it addresses a scaling ceiling, not a design principle for reducing failure-domain diversity.
- **LDAP and authentication load** - size for peak concurrent bind rate and Kerberos ticket-request rate, not average load; global catalog servers carry additional load from universal group and cross-domain attribute queries.
- **Backup windows** - larger, multi-domain directories take longer to back up and restore; confirm the backup window and the restore time objective are still achievable as the directory grows, especially for any domain controller that also serves as a designated restore source.
- **SYSVOL** - include DFSR staging, backlog, Group Policy volume, and convergence in capacity and WAN planning. Directory replication health doesn't prove that SYSVOL is current.
- **Virtualization overcommit** - avoid CPU and memory overcommit on hypervisor hosts that run domain controllers; overcommit-induced scheduling delay can manifest as replication latency or authentication timeouts that are hard to distinguish from a network problem.
- **Failover headroom** - size the domain controller fleet per domain and per site so that the loss of one domain controller (planned maintenance or failure) doesn't push the remaining domain controllers into a sustained overload condition; this is especially important for domains with few domain controllers hosting multiple FSMO roles.

```powershell
Get-ADDomainController -Filter * | Select-Object HostName, Site, OperatingSystem, IsGlobalCatalog
Get-Counter '\NTDS\LDAP Client Sessions', '\NTDS\LDAP Searches/sec', '\NTDS\DRA Inbound Bytes Total/sec'
repadmin /showbackup *
```

## Use Windows Server 2025 locator and lookup counters

Windows Server 2025 adds three DC Locator performance counter sets — **DC Locator (Client)**, **DC Locator (DC)**, and **DC Locator (Netlogon)** — plus the **LSA Lookups** performance counter set. Use them to distinguish DNS or site-location delay from domain controller saturation, and to identify expensive cross-domain or cross-forest name and SID lookups. DC Locator (Client) reports per-process, client-side locator behavior; DC Locator (DC) reports the locator pings and requests a domain controller receives; and DC Locator (Netlogon) reports the Netlogon service's locator request and cache activity.

```powershell
Get-Counter -ListSet "DC Locator (Client)","DC Locator (DC)","DC Locator (Netlogon)","LSA Lookups"
```

Track lookup latency, errors, cache hit rates, cross-forest lookup time, and locator requests by required service. A rise in cross-forest lookup latency can indicate trust-path, DNS, or global catalog problems rather than insufficient CPU.

For counter definitions, see [DC Locator performance counters](/windows-server/identity/ad-ds/dc-locator-performance-counters) and [LSA Lookup performance counters](/windows-server/identity/ad-ds/lsa-lookup-performance-counters).
