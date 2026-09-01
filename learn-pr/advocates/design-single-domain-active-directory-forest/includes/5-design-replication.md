AD DS is multimaster for most directory data. The Knowledge Consistency Checker (KCC) creates inbound connection objects for each replicated directory partition and adjusts the topology when domain controllers, sites, costs, or availability change.

## Distinguish intrasite and intersite replication

Within a site, AD DS assumes fast, reliable connectivity. Replication uses change notification and prioritizes low convergence time. Directory data isn't compressed.

Between sites, AD DS assumes constrained connectivity. Replication:

- Follows site links
- Uses schedules and intervals
- Compresses directory data
- Selects bridgehead servers automatically
- Builds a least-cost spanning topology for each directory partition

The intersite topology generator (ISTG) is the KCC role responsible for intersite connection generation in each site.

## Design site links from routing facts

A site link identifies sites that can communicate at a uniform relative cost. It doesn't create routing or firewall connectivity.

For each link, record:

- Participating sites
- Relative cost
- Replication schedule
- Replication interval
- Available bandwidth and latency
- Expected convergence
- Failure and alternate-path behavior

Lower cost is preferred. Cost is a relative topology value, not a direct bandwidth measurement. The default intersite interval is 180 minutes and can be reduced to 15 minutes. Calculate end-to-end convergence across every hop; don't evaluate each link in isolation.

Move production sites out of `DEFAULTIPSITELINK` when its broad membership no longer represents the routed network.

## Include SYSVOL replication

Directory replication and SYSVOL replication are separate replication engines. AD DS replicates directory partitions. DFS Replication (DFSR) replicates SYSVOL, including Group Policy templates and sign-in scripts.

Windows Server 2025 domains must use DFSR for SYSVOL. DFSR derives topology and schedule information from AD DS, so a site-link design that delays directory replication can also delay Group Policy file convergence. Include both the Group Policy container in AD DS and its matching files in SYSVOL when calculating and testing convergence.

## Decide whether intersite change notification is justified

Default intersite replication waits for the site-link interval during an open schedule. You can enable intersite change notification on selected site links when a low-latency requirement justifies additional WAN traffic.

Use it selectively. Change notification doesn't repair poor routing, closed schedules, or insufficient bandwidth. Baseline replication volume first, then confirm that the WAN can sustain burst traffic during large Group Policy, DNS, or directory changes.

## Preserve automatic topology management

Site links are transitive by default through **Bridge all site links**. Keep this setting when the network is fully routed. If routing isn't transitive, disable automatic bridging and model only valid paths.

Avoid:

- Manual connection objects
- Preferred bridgehead servers without a tested requirement
- Duplicate site links intended to mirror redundant routers
- SMTP site links. SMTP replication is deprecated and doesn't replicate the domain partition.

Manual topology can block KCC failover. Use it only when evidence shows that automatic selection can't satisfy a specific network constraint.

## Plan failure behavior

The KCC creates alternate connections when a partner is unavailable, but only if another domain controller hosts the required partition and network paths permit replication.

Validate these cases:

- One bridgehead server is offline
- The lowest-cost WAN path fails
- A site loses all local domain controllers
- Replication schedules don't overlap across a multihop route
- DNS resolution works across the failover path

Collect replication evidence with:

```powershell
Get-ADReplicationSiteLink -Filter * -Properties Cost,ReplicationFrequencyInMinutes,SitesIncluded |
    Select-Object Name, Cost, ReplicationFrequencyInMinutes, SitesIncluded

Get-ADReplicationPartnerMetadata -Target (Get-ADForest).Name -Scope Forest
Get-ADReplicationFailure -Scope Forest

repadmin /replsummary
repadmin /showrepl * /csv
dcdiag /e /test:sysvolcheck /test:advertising
```

For KCC, site-link, bridge, and global catalog concepts, see [Active Directory replication concepts](/windows-server/identity/ad-ds/get-started/replication/active-directory-replication-concepts).
