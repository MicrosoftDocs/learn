Active Directory Domain Services (AD DS) replication distributes directory changes between domain controllers (DCs). A failure can leave users, groups, computers, Group Policy links, and replication topology data inconsistent. The visible symptom often depends on which DC answers a request.

Replication depends on more than the directory service. A healthy replication attempt requires:

- A valid source, destination, and directory partition.
- Current topology and schedule information.
- Domain Name System (DNS) name resolution.
- Network and Remote Procedure Call connectivity.
- Kerberos authentication, time accuracy, and required permissions.
- Healthy services, storage, and directory database state.

This dependency chain makes random command execution inefficient. Start with replication evidence. Test the dependency that the evidence implicates.

## Scenario

Contoso has one forest and one domain, `contoso.com`.

:::image type="content" source="../media/contoso-replication-topology.svg" alt-text="Diagram showing SEA-DC-01 in the Seattle site as the source and BNE-DC-01 in the Brisbane site as the destination across the SEA-BNE site link.":::

Both servers are writable DCs that run DNS Server and are enlisted in the `DomainDnsZones` and `ForestDnsZones` application partitions. `BNE-DC-01` uses `10.40.1.10`, its own address, as a configured DNS resolver. That DNS service hosts writable Active Directory-integrated copies of the authoritative `contoso.com` and `_msdcs.contoso.com` zones.

The expected state before the incident is:

| Item | Scenario value |
| --- | --- |
| Site link | `SEA-BNE` |
| Schedule | Open continuously |
| Replication interval | 60 minutes |
| Last successful SEA-to-BNE replication | 2026-07-20 05:56 +10:00 |
| Group change | 2026-07-20 06:00 +10:00 |
| SEA address change | 2026-07-20 06:05 +10:00 |
| Actionable deadline | 2026-07-20 07:00 +10:00, which is the group-change time plus one 60-minute interval |
| Monitoring tolerance | 15 minutes |
| Baseline collection | 2026-07-20 07:15 +10:00 |

The group change must occur after the 05:56 last success. Otherwise, that successful cycle would already have carried the change to `BNE-DC-01`, and the symptom couldn't occur.

At 06:00, an administrator adds `User-1042` to the `Payroll-Approvers` group on `SEA-DC-01`. At 07:15, after the 07:00 actionable deadline and the 15-minute monitoring tolerance, a query sent to `BNE-DC-01` doesn't show the new membership.

Recent changes include:

- An address change on `SEA-DC-01` from `10.10.1.10` to `10.10.1.20` at 06:05.
- Firewall maintenance between the sites.
- A site-link schedule change completed the previous week.

No outage is planned. Both DCs respond to local administration.

The scenario supplies sanitized command output and event evidence. It doesn't require a lab or a damaged directory.

## Safety boundaries

The following table provides a classification for each troubleshooting and diagnostic task:

| Classification | Meaning | Examples |
| --- | --- | --- |
| Read-only diagnostic | Queries state without changing directory data or configuration. | `repadmin /showrepl`, `Resolve-DnsName`, Windows Time queries |
| Low-impact operational change | Changes a demonstrated dependency or starts a targeted operation. | Correcting one DNS record, registering configured DNS records, targeted replication |
| High-impact recovery | Can discard data, alter consistency safeguards, or change DC identity. | Lingering-object removal, registry overrides, account reset, demotion, database recovery |

> [!IMPORTANT]
> This module doesn't explore high-impact recovery strategies. Events that indicate stale data, lingering objects, update sequence number rollback, database damage, or schema mismatch are escalation points.

## Troubleshooting method

We'll use the following troubleshooting method throughout the module:

1. Establish expected replication paths, schedules, and partitions.
2. Preserve evidence and collect a baseline.
3. Scope the failed source, destination, partition, and time range.
4. Test the dependency implicated by the earliest useful error.
5. Apply the smallest supported correction.
6. Verify replication and the original business symptom.

By the end of this module, you'll understand how to interpret replication evidence, isolate a failed dependency, choose a safe response, and verify convergence.
