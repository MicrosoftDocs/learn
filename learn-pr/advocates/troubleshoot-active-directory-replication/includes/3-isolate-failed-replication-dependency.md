After scoping the failed replication path in the previous unit, use the first actionable status and correlated evidence to isolate the dependency most likely to have failed. Focus on the indicated DNS, network or RPC, time, authentication, topology, or local-service checks, and change only one component at a time so that you can evaluate its effect.

- Error 1722 means an RPC operation couldn't complete. It doesn't identify the failed layer. The destination might resolve the wrong address, lack a route, fail to establish TCP 135 or the configured replication-endpoint connection, encounter authentication failure, or contact an unavailable service.
- Error 1753 is narrower. It means that the destination contacted the RPC Endpoint Mapper (EPM) on the selected source, but EPM couldn't return the requested AD DS replication endpoint. Investigate wrong-host resolution, AD DS startup, and Directory Replication Service (DRS) endpoint registration first.

Anchor each check to the failed destination, source, directory partition, and timestamp. Test from the destination named in the replication result, and follow the same source name and DNS path that replication uses. For an inbound pull that never reaches the source, expect the actionable failure evidence on the destination; don't require a matching source-side failure event.

## Use targeted dependency tests

The following table lists diagnostic tools, their function, and where to use these tools:

| Command | Where, access, and effect | Important result |
| --- | --- | --- |
| `Resolve-DnsName` | **Read-only diagnostic.** Run on the destination or from its DNS path; no directory privilege is required. | `Name`, `Type`, `NameHost`, and `IPAddress` must identify the intended source. |
| `Test-NetConnection -Port 135` | **Read-only diagnostic.** Run on the destination; no directory privilege is required. | `RemoteAddress` identifies the selected endpoint; `TcpTestSucceeded` shows whether a Transmission Control Protocol (TCP) connection to port 135 was established. This isn't an EPM query or a DRS-interface test. |
| `dcdiag /test:dns /s:<DCName> /v /DnsBasic` or `/DnsRecordRegistration` | **Read-only diagnostic.** Run from an elevated prompt with Enterprise Admin credentials or equivalent delegated authorization for the target. These narrower diagnostics are preferred when they answer the question. | Identify basic DNS or record-registration failures without automatically running every DNS subtest. |
| `w32tm /query /status` and `w32tm /query /source` | **Read-only diagnostic.** Run on the suspected DC. Membership in local Administrators is required for local queries; Domain Admins is required for remote operations. | Record source, last successful synchronization, stratum, root delay and dispersion, and synchronization state. These queries don't measure peer offset. |
| `w32tm /monitor /computers:SEA-DC-01,BNE-DC-01` or `w32tm /stripchart /computer:<Target> /samples:5 /dataonly` | **Read-only diagnostic.** Run from an administrative system that can contact the DCs. Domain Admins is required for remote operations. | Measure the relevant DC offsets before classifying a Kerberos time failure. |
| `nltest /dsgetdc:<DomainName> [/force] [service flags]` | **Read-only diagnostic.** Use `/force` when the conclusion is freshness-sensitive, such as after a DNS, site, or topology change, because DC Locator can otherwise return cached discovery; `/force` maps to the DC Locator `DS_FORCE_REDISCOVERY` behavior, which ignores cached data and performs a fresh discovery. Add only the service flags required by the hypothesis: for example, `/dns /kdc` when testing DNS-capable KDC discovery, or `/gc` when a global catalog is required. The `/kdc` and `/gc` requirements can't be combined, so test them separately. Don't add KDC or GC flags to every replication diagnosis. | Record the returned DC, site, and flags. |
| `klist -li 0x3e7` and `setspn -F -Q <ExactServicePrincipalName>` | **Read-only diagnostic.** For DC replication, run `klist` elevated on the affected DC to inspect the LocalSystem cache. Query the exact SPN from the error; use forest scope when ownership might be elsewhere. Bare `klist` applies only to the current user's operation. | Correlate tickets and SPN ownership with the replication security context. Don't purge tickets or change SPNs as a diagnostic shortcut. |

```console
nltest /dsgetdc:contoso.com /force /dns /kdc
```

This example tests a fresh DNS-capable KDC discovery hypothesis. For a general DC-location check, use `nltest /dsgetdc:contoso.com /force` without service-specific requirements.

> [!NOTE]
> A successful TCP 135 test proves only that a TCP connection to port 135 was established. It doesn't prove that EPM processed an RPC request or that the DRS endpoint is registered and reachable. By default, AD DS replication uses an endpoint in the configured dynamic TCP range. An environment can instead use a supported fixed AD replication RPC port. Validate the actual approved endpoint policy end to end against the current [Windows service port requirements](/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements).

`dcdiag /test:dns` without a DNS subtest runs `/DnsAll`. Classify it as a **low-impact operational change** used diagnostically, not as a read-only query: its dynamic-update test creates and automatically removes `_dcdiag_test_record`. The `/e` switch targets all DCs in the forest and can be slow. Use the narrowest subtest and scope that answer the diagnostic question.

## Verify the source identity

The `repadmin /showrepl` output supplied the source DSA object GUID. Record transport and DNS evidence separately. For network and RPC diagnostics, record the route `BNE-DC-01` uses to reach the current source address (`10.10.1.20` in this scenario). For DNS diagnostics, inventory the configured DNS servers on adapters that are currently up. A route to the source doesn't identify the resolver that the DNS Client uses, so don't derive a resolver list from the route-chosen interface.

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
```

In this scenario, the inventory identifies `10.40.1.10` as a configured resolver on an adapter that reports Up; verify separately that this DNS server hosts the stated writable AD-integrated zones. DNS administration records confirm that this server hosts writable, Active Directory-integrated `contoso.com` and `_msdcs.contoso.com` zones in their documented domain and forest replication scopes. Don't infer authority merely because a server answers a query. An administrator with DNS-server read access can use this **read-only diagnostic** to confirm that the zones are hosted:

```powershell
Get-DnsServerZone `
  -ComputerName 10.40.1.10 `
  -Name "contoso.com","_msdcs.contoso.com"
```

Now query the corresponding canonical name (CNAME) record:

```text
3f7d6a19-2d85-4b30-93f2-1167f4955b84
```

From `BNE-DC-01`, query the source's GUID-based CNAME record in `_msdcs` and its host record through the configured authoritative branch DNS path.

```powershell
Resolve-DnsName `
  -Name "3f7d6a19-2d85-4b30-93f2-1167f4955b84._msdcs.contoso.com" `
  -Type CNAME `
  -DnsOnly `
  -NoHostsFile `
  -Server 10.40.1.10

Resolve-DnsName `
  -Name "SEA-DC-01.contoso.com" `
  -Type A `
  -DnsOnly `
  -NoHostsFile `
  -Server 10.40.1.10
```

Abridged output:

```output
Name
----
3f7d6a19-2d85-4b30-93f2-1167f4955b84._msdcs.contoso.com

Type      : CNAME
NameHost  : SEA-DC-01.contoso.com

Name       : SEA-DC-01.contoso.com
Type       : A
IPAddress  : 10.10.1.10
```

The CNAME identifies the correct DC. The host record returns its retired address. It's stronger evidence than the generic 1722 message.

As a **read-only diagnostic**, inspect every A record for the source on the writable authoritative server serving BNE. This prevents a stale value from being hidden among valid multihomed addresses:

```powershell
Get-DnsServerResourceRecord `
  -ComputerName 10.40.1.10 `
  -ZoneName "contoso.com" `
  -Name "SEA-DC-01" `
  -RRType A
```

The scenario inventory confirms that `10.10.1.20` is the intended address and that `10.10.1.10` is retired. Before correction, preserve the complete record set, the source's intended adapter and DNS settings, and the zone's writable authoritative replicas. Under DNS change control, correct only the demonstrated stale address, preserve valid multihomed addresses, verify every relevant authoritative copy, flush the destination resolver cache, and query both `10.40.1.10` and BNE's normal client path. Require exactly the intended answer before TCP or replication testing.

Confirm the endpoint difference:

```powershell
Test-NetConnection -ComputerName SEA-DC-01.contoso.com -Port 135
Test-NetConnection -ComputerName 10.10.1.20 -Port 135
```

Abridged output:

```output
ComputerName     : SEA-DC-01.contoso.com
RemoteAddress    : 10.10.1.10
RemotePort       : 135
TcpTestSucceeded : False

ComputerName     : 10.10.1.20
RemoteAddress    : 10.10.1.20
RemotePort       : 135
TcpTestSucceeded : True
```

BNE can establish TCP 135 to `10.10.1.20`, while the source name selects retired address `10.10.1.10`. The stale host record is the leading cause. Confirm end-to-end AD DS replication only after correction by using the targeted replication test in the next unit.

## Correlate the destination evidence

For this inbound pull failure, correlate the `07:11:32 +10:00` attempt with Directory Service and DNS Server events on `BNE-DC-01`. Preserve the provider, event ID, source DC, directory partition, timestamp and offset, and embedded status. The source name and partition can appear as fields in a destination-logged event even though `SEA-DC-01` wasn't contacted. A destination DNS event in the same window strengthens the DNS-path finding; the absence of a symmetric source event doesn't weaken it.

## Map other evidence to a dependency

Use this table when the first useful status differs from the scenario.

| Category | Representative evidence | Targeted checks | Safe response boundary |
| --- | --- | --- | --- |
| DNS and DC location | Error 8524; event 2087; event 2088; missing host, service, or GUID CNAME record | Resolve host, service, and GUID CNAME records through the destination's configured DNS path; establish authority and zone scope; run the narrowest DCDiag DNS subtest | Event 2087 means DNS resolution prevented replication. Event 2088 means GUID-CNAME lookup failed but fallback resolution allowed replication to succeed; repair DNS hygiene, but don't count 2088 alone as a failed attempt. |
| RPC unavailable | Error 1722; name, route, firewall, endpoint, or service evidence | Test the selected name and address, route, TCP 135, the approved dynamic range or supported fixed replication port, and relevant service state | Restore only the demonstrated path, endpoint-policy, or service fault. TCP 135 success isn't end-to-end RPC or replication proof. |
| EPM reached, replication endpoint unavailable | Error 1753 | Verify that the selected address belongs to the intended DC, AD DS completed startup, and the DRS endpoint is registered with EPM | Correct wrong-host resolution or the demonstrated AD DS registration/startup fault. Don't treat 1753 as proof of blocked TCP 135, blocked dynamic ports, or Kerberos failure. |
| Authentication and identity | Error 5; error 1908; target-principal-name error; Kerberos, secure-channel, or time evidence; Netlogon event 5805 | Validate the selected Key Distribution Center, measured time offset, LocalSystem tickets, exact SPN ownership, secure channel, and DC machine-account identity | Correct the demonstrated time or identity fault. Don't grant permissions or reset a DC account as a shortcut. |
| Authorization | Error 8453 | First determine whether the failure is scheduled DC-to-DC replication or a user-triggered request. For scheduled replication, inspect the destination DC computer account's effective rights on the affected naming-context head. For a user-triggered operation, inspect the initiating administrator's elevated token and its rights on that naming context. | Restore only the demonstrated default or delegated right to the identity that failed. Don't change a DC naming-context ACL to compensate for an operator token, and don't add broad groups to solve authentication or token problems. |
| Topology and schedule | Event 1311; event 1925; **No inbound neighbors**; error 8452; one-site pattern | Treat event 1311 as evidence that KCC can't build a connected topology. Classify event 1925 by its embedded status, source, destination, and partition before selecting tests. | Correct demonstrated sites, subnets, site links, schedules, bridgeheads, or connection inputs. Avoid permanent manual connections that mask a mapping or path fault. |
| Replication disabled or rejected | Error 8456 from the source; error 8457 at the destination; disabled-replication options; `Dsa Not Writable`; events 2103, 1393, or 2881 | Check `repadmin /options` on both endpoints, Directory Service events, Netlogon state, disk state, and the documented safeguard cause | Preserve disabled-replication or quarantine evidence. Don't clear options or re-enable replication outside the cause-specific procedure. |
| Local DC health and resources | Stopped services; database, disk, or specifically implicated processor or memory events | Check the affected AD DS, DNS Server, Netlogon, Key Distribution Center, Windows Time, RPC, storage, and evidenced resource state | Restore a demonstrated service or capacity issue. Escalate database, file-system, or safeguard-triggered states. |

## Separate tool failure from replication failure

The Active Directory PowerShell replication cmdlets use ADWS. If `Get-ADReplicationFailure` fails while Repadmin can query partner state, test ADWS and its management path. Don't classify that cmdlet error as a replication-engine failure.

The reverse also matters. A successful PowerShell query proves that ADWS answered. It doesn't prove that every replication partner and partition is healthy.

## Separate directory replication from system volume replication

Group Policy has two paths. AD DS replicates the Group Policy container object. The configured SYSVOL replication engine replicates the Group Policy template files. Current domains normally use Distributed File System Replication (DFSR), but verify the SYSVOL migration state before choosing evidence. Inspect the DFS Replication log for DFSR-based SYSVOL or the legacy File Replication Service (FRS) log when the domain remains in an older supported migration state.

If directory partner status is healthy but policy files differ, investigate the configured SYSVOL engine and SYSVOL state separately. Don't use an AD DS replication correction as a SYSVOL repair.

The Contoso evidence demonstrates a stale DNS host record. The next unit examines conditions where topology or data consistency makes direct correction unsafe.
