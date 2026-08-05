Diagnose from the impacted computer outward. Preserve evidence until you can state which dependency failed and which layer owns it.

## Use a repeatable workflow

Use a repeatable workflow when diagnosing problems:

Follow these steps:

1. Define the exact symptom, scope, start time, and recent changes.
1. Separate host resolution, service location, connectivity, service health, authentication, and replication hypotheses.
1. Identify the affected client, requested service, queried servers, authoritative zone, expected records, and expected site.
1. Capture configuration plus event evidence before changes.
1. Test from the affected computer. Query each authoritative server directly when required.
1. Compare observed responses with the known-good baseline.
1. Decide whether Domain Name System is the cause, a consequence of unhealthy directory replication, or unrelated.
1. Correct the root cause at the owning layer.
1. Re-register records or clear a relevant cache only when the diagnosis supports it.
1. Verify name resolution, locator behavior, the original operation, plus replication when applicable.

:::image type="content" source="../media/diagnostic-decision-tree.svg" alt-text="Diagram that shows troubleshooting from a directory service symptom through correction and end-to-end verification.":::

## Use focused tools

The following tools can help in the diagnostic process:

| Tool | Run location plus privilege | Evidence | Next decision |
| --- | --- | --- | --- |
| `ipconfig /all` | Affected computer; standard command prompt | Suffixes, addresses, resolver order, adapter state | Correct client configuration or continue to exact queries. |
| `Resolve-DnsName` | Affected computer; standard PowerShell | Service, host, authority, direct-server answers | Trace delegation, authority, target, or inconsistency. |
| `nltest /dsgetdc:<domain> /force` | Affected computer; normally no elevation required | Selected domain controller, address, forest, site, capabilities | Investigate locator, site, reachability, or later authentication. |
| `nltest /dsgetsite` | Affected computer; normally no elevation required | Client site | Correct subnet mapping or continue. |
| `dcdiag /test:dns` | Domain controller or management host with AD DS tools; sufficient query rights | Basic health, registration, update | Isolate service, record, update, or server fault. |
| `repadmin /replsummary` | Domain controller or management host with AD DS tools; sufficient directory rights | Summarized replication failures | Determine whether zone inconsistency follows replication failure. |
| Domain Name System Manager or DNS cmdlets | Management host with DNS Server tools; suitable read or administrative rights | Zone type, scope, update mode, records, permissions | Correct the authoritative configuration. |
| Event Viewer | Affected member or domain controller; rights to the local or remote log | Time-correlated client, server, Netlogon, system, directory events | Correlate cause with operation. |
| `Test-NetConnection` | Affected computer; standard PowerShell | Target port reachability | Separate answer correctness from network or service reachability. |

>[!NOTE]
>`dcdiag` and `repadmin` must run on a domain controller or a suitable management computer with the AD DS administration tools installed. Domain Name System Manager and DNS PowerShell cmdlets require the DNS Server tools locally or through Remote Server Administration Tools (RSAT). Use credentials with sufficient rights to read the targeted server, directory data, records, and logs; changing configuration or permissions requires the corresponding administrative rights.

## Capture client evidence

An example of capturing client evidence is as follows:

On `BNE-APP7`, run:

```cmd
ipconfig /all
```

Healthy excerpt:

```text
Primary Dns Suffix  . . . . . . : corp.contoso.com
IPv4 Address. . . . . . . . . . : 10.20.15.27
DNS Servers . . . . . . . . . . : 10.20.0.10
                                    10.40.0.10
```

Faulty excerpt:

```text
Primary Dns Suffix  . . . . . . : corp.contoso.com
IPv4 Address. . . . . . . . . . : 10.20.15.27
DNS Servers . . . . . . . . . . : 10.20.0.53
```

The faulty output doesn't yet prove the resolver is wrong. Query the exact locator record against `10.20.0.53`, then against known authoritative servers.

## Target domain controller diagnostics

Run the basic test from an elevated command prompt on the suspected domain controller:

```cmd
dcdiag /test:dns /v /s:BNE-DC1 /DnsBasic
```

Use a registration-specific test when records are absent:

```cmd
dcdiag /test:dns /v /s:BNE-DC1 /DnsRecordRegistration
```

Use a dynamic update test when registration authorization is in doubt:

```cmd
dcdiag /test:dns /v /s:BNE-DC1 /DnsDynamicUpdate
```

In this example, `/s:BNE-DC1` selects the domain controller tested. The synthetic create/delete operation uses the credentials under which DCDiag runs, or credentials supplied to DCDiag; it doesn't use the tested domain controller's security context. A pass shows that those credentials completed the synthetic operation through the tested path. It doesn't prove that a member computer, DHCP registration identity, Netlogon, or the owner of an existing production record can update that record. Test the intended identity, record owner, access control list (ACL), prerequisites, and production path separately.

Important output includes connectivity, essential services, client resolver reachability, host registration, zone authority, locator record registration, and update results. An expected `AAAA` warning in an environment where Internet Protocol version 6 is deliberately not used doesn't explain an unrelated service record failure.

Before forcing DNS registration:

1. Identify the intended registrar: DNS Client service, Netlogon, DHCP server, or another managed identity.
1. Identify an authoritative server that's writable for the relevant zone and application directory partition.
1. Confirm the intended update mode, normally **Secure only** for an Active Directory-integrated zone.
1. Confirm Domain Name System and network connectivity to the writable authority.
1. Inspect the existing name or record owner and ACL, then compare them with the intended registrar.
1. Test with the intended identity or a suitably scoped diagnostic.
1. Re-register only after establishing missing or stale registration and correcting the authorization or path fault.

Registration can occur in the following ways:

- Netlogon registers domain controller locator records.
- `nltest /dsregdns` can initiate a justified locator-record refresh.
- `ipconfig /registerdns` requests direct host registration through the DNS Client service.

| Action | Expected or validated result | Required follow-up |
| --- | --- | --- |
| Correct a member's resolver assignment | `ipconfig /all` shows the approved internal resolvers on the active adapter | Query the exact site-specific and domain-wide service records through the normal client path. |
| `ipconfig /renew` in a DHCP-managed design | Lease renewal succeeds and approved DNS settings and registration policy are reapplied | Query the relevant host record; inspect owner and ACL if update still fails. |
| `ipconfig /registerdns` when direct registration is intended | The command completes without a local invocation error | Query the expected `A` and applicable `PTR` records; completion alone doesn't prove server acceptance or ownership. |
| `nltest /dsregdns` on a domain controller | The command reports successful initiation or completion | Query required locator records on relevant authoritative servers, then run DC Locator. |
| `nltest /dsgetdc:<domain> /force` | Output names a suitable domain controller, address, domain, forest, site, and required flags | Test reachability and the original directory operation. |
| DNS or ACL correction | The intended registrar can update the affected name | Compare the resulting data and security, then verify the consumer operation. |

Command success alone isn't end-to-end proof.

> [!CAUTION]
> Don't delete a zone, enable nonsecure updates, remove broad record sets, or restart services across every domain controller as a diagnostic shortcut. These actions can create security exposure, destroy evidence, or widen an outage.

## Connect Domain Name System to replication evidence

Active Directory replication error `8524` reports that “The DSA operation is unable to proceed because of a DNS lookup failure.” DSA means **Directory System Agent**.

Directory Service event `2087` means all attempted resolution paths for the source partner failed, so replication couldn't proceed.

Test the exact NTDS Settings object GUID-based CNAME record named by the event:

```powershell
Resolve-DnsName `
  "4f3c5e6a-2d31-4db1-a706-4b2f79017c01._msdcs.contoso.com" `
  -Type CNAME `
  -Server 10.20.0.10
```

Then resolve the returned target and test required reachability. If the NTDS Settings object GUID-based CNAME record exists on `BNE-DC1` but not `PER-DC1`, query that exact name and type directly on every relevant authoritative server and identify the application directory partition that contains the zone. Inspect replication:

```cmd
repadmin /replsummary
repadmin /showrepl PER-DC1
```

`repadmin /replsummary` provides summarized failure evidence; it doesn't prove partition convergence. `repadmin /showrepl PER-DC1` reports inbound partner and naming-context status for `PER-DC1`. If convergence of the affected DNS object remains in question, compare `repadmin /showobjmeta` for that object across the relevant replicas. After repairing replication, requery the exact record.

Event `2088` means the GUID-based DNS lookup failed, but fall back by fully qualified domain name or NetBIOS name succeeded and replication completed. The fallback success doesn't remove the need to correct the NTDS Settings object GUID-based CNAME registration, delegation, resolution, or convergence fault.

Domain Name System Server event `4013` can occur while a directory-integrated server waits for initial directory synchronization. A brief startup condition differs from a persistent event accompanied by failed zone load, failed replication, or unavailable directory services.

## Recognize selected failure patterns

The following table describes failure patterns:

| Pattern | Evidence chain | Root correction |
| --- | --- | --- |
| Incorrect resolver | Client lists nonauthoritative server; exact service query fails; direct authoritative query succeeds | Correct client or resolver path. |
| Missing or stale record | Authority is correct; expected service, GUID-based CNAME, or host data is absent or wrong | Correct registration owner, permissions, update path, or stale-data process. |
| Secure update rejection | Zone is authoritative; update test fails; access control or ownership denies writer | Correct ownership, credentials, permissions, or intended registration model. |
| Delegation failure | Parent authority exists; child query can't reach authoritative child servers | Correct delegation, glue, conditional path, or firewall route. |
| Replication divergence | Authoritative servers return different data; replication errors align with last change | Restore directory replication, then verify zone convergence. |
| Incorrect site choice | Locator succeeds but site fields or targets conflict with topology | Correct subnet mapping, site records, coverage, or topology. |
| Multihomed target | Service record is valid; target resolves to an unreachable interface | Prevent unintended address registration, then correct affected records. |
