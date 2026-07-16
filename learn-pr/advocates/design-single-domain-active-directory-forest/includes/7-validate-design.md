Design validation proves that the planned topology meets requirements under normal and failed conditions. A diagram without measurable behavior isn't an implementation-ready design.

## Define acceptance criteria

Use criteria that another engineer can test:

| Area | Example acceptance criterion |
| --- | --- |
| Namespace | The organization owns the suffix, the AD DS zone is delegated, and users can use the approved routable UPN |
| DNS | Every site can resolve AD DS service records after one DNS server fails |
| Site mapping | Every production IPv4 and IPv6 prefix maps to the intended site |
| DC Locator | Clients select a local domain controller or the documented covering site |
| Replication | Changes converge between the most distant sites within the approved interval |
| SYSVOL | Group Policy containers and matching SYSVOL content converge within the approved interval |
| Domain controllers | Maintenance or loss of one failure domain leaves authentication, DNS, and global catalog service |
| FSMO | Role owners are monitored, backed up, reachable, and have documented transfer targets |
| Time | The forest-root PDC uses approved external sources and domain members follow the hierarchy |

## Review configuration evidence

After implementation, capture:

```powershell
Get-ADForest |
    Select-Object RootDomain, Domains, Sites, GlobalCatalogs, SchemaMaster, DomainNamingMaster

Get-ADDomain |
    Select-Object DNSRoot, DomainMode, PDCEmulator, RIDMaster, InfrastructureMaster

Get-ADReplicationSite -Filter *
Get-ADReplicationSubnet -Filter * -Properties Site
Get-ADReplicationSiteLink -Filter * -Properties Cost,ReplicationFrequencyInMinutes,SitesIncluded

Get-ADDomainController -Filter * |
    Select-Object HostName, Site, IsGlobalCatalog, IPv4Address

Get-ADReplicationFailure -Scope Forest
repadmin /replsummary
dcdiag /e /test:dns
dcdiag /e /test:sysvolcheck /test:advertising
```

Interpret the output. An empty replication-failure list doesn't prove that a disconnected site, missing subnet, or invalid site-link schedule is correct.

## Test failure scenarios

Test at least:

1. Stop one domain controller in each major site.
1. Remove access to the preferred DNS server.
1. Interrupt the primary WAN path.
1. Confirm client site detection and domain controller selection.
1. Confirm that replication uses the expected alternate path.
1. Confirm that the PDC emulator and approved time source remain reachable.
1. Restore service and verify convergence without manual connection objects.

Use production-like latency, routing, firewall, and DNS conditions. A flat lab network can't validate an intersite design.

## Complete the design record

The final record should contain:

- Forest, domain, UPN, and NetBIOS names
- DNS zones, scopes, delegations, forwarders, aging, and scavenging
- Sites, subnets, site links, costs, schedules, and intervals
- Domain controller, DNS, global catalog, and FSMO placement
- Time hierarchy
- Failure-domain mapping
- Acceptance criteria and test evidence
- Exceptions, owners, and review dates

Approve the design only when the network, identity, DNS, security, backup, and application owners agree on the failure assumptions.
