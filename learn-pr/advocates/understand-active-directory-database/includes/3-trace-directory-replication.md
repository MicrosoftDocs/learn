Active Directory Domain Services (AD DS) replication moves directory changes between domain controllers (DCs). Replication doesn't directly copy `NTDS.dit`, Extensible Storage Engine (ESE) transaction logs, checkpoints, or other database files between servers. Each DC commits changes to its own local database and replication partners exchange logical object and attribute updates.

This distinction matters during investigation. A stale group membership, missing DNS application-partition record, or inconsistent Group Policy container is evidence about directory replicas. It isn't evidence that one DC should receive another DC's database files.

## Follow a logical replication flow

A normal AD DS write has a local commit before any partner can receive it.

1. **Originating write**. A client or management tool sends a Lightweight Directory Access Protocol (LDAP) or Remote Procedure Call (RPC) request to a writable DC. The directory service validates schema, security, naming, and other directory rules.
1. **Local commit**. The writable DC records the change in its hosted replica, assigns local replication state, and commits the change through its local database and log path.
1. **Change notification or polling**. Intrasite partners are notified quickly. Intersite replication commonly follows site-link schedules and polling intervals.
1. **Partner request**. The destination DC performs inbound replication. It asks a source partner for changes that the destination hasn't already received for that directory partition.
1. **Remote commit**. The destination validates and commits the received logical updates into its own local replica.

Replication is pull-based from the destination's perspective. When `repadmin /showrepl` reports an inbound neighbor, read it as "this destination tried to obtain this naming context from this source."

## Scope replication by naming context

A directory partition, also called a naming context, replicates independently. A DC can only replicate a partition that it hosts.

| Naming context | Replica scope |
| --- | --- |
| Domain partition, such as `DC=contoso,DC=com` | DCs in that domain. Writable DCs host writable replicas. Read-only domain controllers (RODCs) host read-only replicas. |
| Configuration partition | Every DC in the forest. |
| Schema partition | Every DC in the forest. |
| Application partitions, such as `DomainDnsZones` and `ForestDnsZones` | Only DCs enlisted for that application partition. |
| Global catalog partial replica | Global catalog servers hold selected attributes from other domain partitions. |

A missing partner or absent row isn't automatically a fault. First confirm that the destination is expected to host that naming context and that the source is a valid partner for it.

## Treat topology as a convergence factor

Topology controls when and where logical changes are requested. It isn't the payload.

| Factor | Administrator-facing effect |
| --- | --- |
| Sites and subnets | Influence which DCs are treated as near each other and which links are intersite. |
| Connection objects | Define direct replication partners that a destination can request changes from. |
| Knowledge Consistency Checker (KCC) | Builds and maintains replication topology from site, server, and link configuration. |
| Schedules and intervals | Determine when a change is expected to converge, especially across site links. |
| RPC connectivity | Provides the transport used by normal AD DS replication. |

Use these factors to set expectations before interpreting latency. A change that hasn't crossed a closed schedule is different from a change that failed across an open schedule.

## Interpret metadata without doing repair math

AD DS tracks replication state with update sequence numbers (USNs), invocation identifiers, watermarks, and per-attribute metadata. This module uses those values only as read-only evidence.

For a nonlinked attribute on a known object, distinguish the visible value from its replication metadata. Query the visible value directly on each named DC. `Get-ADReplicationAttributeMetadata` exposes properties such as `AttributeName`, `Version`, `LastOriginatingChangeDirectoryServerIdentity`, `LastOriginatingChangeDirectoryServerInvocationId`, `LastOriginatingChangeUsn`, `LastOriginatingChangeTime`, and `LocalChangeUsn`.

`LocalChangeUsn` is assigned by the DC specified by `-Server` when that DC commits the update locally. It has meaning only within that DC's USN space and must never be compared with `LocalChangeUsn` from another DC. When recording evidence, add a custom `QueriedServer` column containing the exact `-Server` value so the local USN remains bound to its source; `QueriedServer` isn't a native metadata property.

Multi-DC reads run sequentially, not as an atomic snapshot. Equal visible values show agreement only at their respective query times, and equal `Version` values alone don't prove that replicas hold the same originating update. For the same nonlinked attribute, compare the visible value and the combination of `Version`, `LastOriginatingChangeDirectoryServerInvocationId`, `LastOriginatingChangeUsn`, and `LastOriginatingChangeTime`. Matching fields provide same-originating-update evidence; retain `LastOriginatingChangeDirectoryServerIdentity` as readable context.

`LastOriginatingChangeTime` is provenance recorded from the originating DC's clock. Don't use it alone to order updates that originated independently on different DCs. Linked-value metadata, replication vectors, invocation-epoch analysis, conflict calculations, and repair math are outside this module; unit 7 provides the detailed read-only comparison exercise.

## Recognize writable and read-only roles

Writable DCs use multimaster replication. More than one writable DC can originate ordinary directory updates for the partitions they host. Normal convergence then carries those logical changes to other replicas.

An RODC doesn't perform ordinary originating updates. For an LDAP Add, Modify, Modify DN, or Delete request, identify the object that determines the naming context: the parent for Add, or the target object for the other operations. If that object exists, the RODC returns an LDAP referral to a DC that holds a writable replica of the relevant naming context. If the required parent or target doesn't exist, the result is `noSuchObject`.

Don't describe this ordinary LDAP behavior as generic proxying. Password change is a separately documented path: supported Network Logon (NRPC) or Security Account Manager Remote (SAMR) password-change requests received by an RODC can be forwarded to its writable hub DC. That special forwarding behavior doesn't make the RODC a writable source for ordinary LDAP updates.

## Use complementary read-only evidence

Start with supported tools that query directory state. Don't inspect, copy, replace, or synchronize database files.

| Evidence source | Read-only use |
| --- | --- |
| `repadmin /replsummary /bysrc` | Source DSA, or outbound, summary. Each row aggregates the destinations to which that source replicates and omits destination names. |
| `repadmin /replsummary /bydest` | Destination DSA, or inbound, summary. Each row aggregates the sources from which that destination replicates and omits source names. |
| `repadmin /showrepl <DestinationDC>` | Inbound replication status for the named destination, grouped by naming context and source partner. |
| `repadmin /showrepl <DestinationDC> /all /verbose` | The base inbound report with verbose fields; `/all` also appends outbound change-notification neighbors and KCC connection objects. |
| `repadmin /showobjmeta <DCName> "<ObjectDN>"` | Attribute-level metadata for a known object when you need to compare visible values. |
| `Get-ADReplicationPartnerMetadata -Target <DestinationDC> -PartnerType Inbound -Partition <NamingContext>` | Structured relationship metadata for inbound partners in the explicit naming context through Active Directory Web Services (ADWS). |
| `Get-ADReplicationFailure` | Structured current failure data by server, site, domain, or forest. |
| `Get-ADReplicationAttributeMetadata` | Attribute metadata for a known object through PowerShell. |
| **Directory Service** event log | Destination and source events that identify naming context, partner, time, and status. |

In a `replsummary` row, `largest delta` is the longest interval since a successful replication represented by that row. `fails/total` is the number of relationships whose latest recorded attempt is failing divided by the total relationships represented at capture; it isn't a cumulative history of every attempt. `%%` is that failure percentage. `error` surfaces an error code for failing relationships, but the summary omits the counterpart DC. Use partner-level output to identify the relationship, naming context, and result instead of inferring a root cause from the summary alone.

If neither `/bysrc` nor `/bydest` is supplied, `repadmin` displays the perspective with fewer partner errors. Use both switches when both perspectives must be reviewed explicitly.

`Get-ADReplicationPartnerMetadata` is partition-scoped relationship evidence. Supply `-Partition` when investigating a particular naming context. Only when neither `-Partition` nor `-Filter` is supplied does the cmdlet use the target's default naming context. Its latest-attempt and latest-success fields describe a partner relationship at capture; they don't prove delivery or convergence of a particular object or attribute.

Correlate at least two evidence sources before deciding which store, partner, or access path is implicated. A clean AD DS relationship view doesn't prove object-level convergence or healthy SYSVOL file replication. Unit 7 provides the detailed, read-only lab execution; this unit establishes how to interpret its evidence.

## Know the boundary

This unit explains how logical directory replication differs from database-file storage and how to read basic evidence safely. It doesn't teach replication-vector calculations, conflict-resolution algorithms, lingering-object removal, update sequence number rollback remediation, or repair procedures.

For detailed replication failure isolation and correction, use the dedicated Microsoft Learn module [Troubleshoot Active Directory Domain Services replication](/training/modules/troubleshoot-active-directory-replication/).
