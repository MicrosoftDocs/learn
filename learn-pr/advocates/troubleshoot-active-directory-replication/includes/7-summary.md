In this module you learned that AD DS replication troubleshooting is an evidence problem, not something you resolve by running every replication synchronization command you are aware of.

Use this sequence when troubleshooting AD DS replication:

1. Establish expected partners, schedules, and directory partitions.
2. Preserve forest-wide and destination-specific evidence.
3. Identify the destination, source, partition, last success, and first useful error.
4. Test the implicated DNS, network, authentication, topology, or local-health dependency.
5. Apply one supported correction or stop at an escalation boundary.
6. Verify every affected relationship and the original business symptom.

## Core tool reference

The following table lists the core tools in your replication troubleshooting toolkit:

| Tool | Primary use | Risk |
| --- | --- | --- |
| `repadmin /replsummary` | Find broad source and destination failure patterns. | Read-only diagnostic |
| `repadmin /showrepl` | Inspect inbound partners, partitions, timestamps, and statuses. | Read-only diagnostic |
| `Get-ADReplicationFailure` | Query structured failure data through ADWS. | Read-only diagnostic |
| `dcdiag /test:replications` | Correlate partner failures with DC diagnostics. | Read-only diagnostic |
| `Resolve-DnsName` | Prove host, service, and GUID CNAME identity. | Read-only diagnostic |
| `Test-NetConnection` | Test one named endpoint and port. | Read-only diagnostic |
| `repadmin /showconn` and `repadmin /options` | Inspect connections and disabled replication. | Read-only diagnostic |
| `repadmin /replicate` | Test one valid source, destination, and partition after correction. | Low-impact operational change |

## Status and event quick reference

The following table lists the status and event items that are important in replication troubleshooting:

| Status or evidence | Interpretation | Response |
| --- | --- | --- |
| Error 1722 | An RPC operation failed, but the status doesn't identify whether DNS, network, endpoint, authentication, or service state failed. | Test the named dependency path from the destination. |
| Error 1256 after an earlier source failure | The destination canceled later work after the earlier failure. | Investigate the first non-1256 status. |
| Status 8477 | An isolated result means replication is in progress. | Recheck it. Investigate if it persists or repeats beyond the expected schedule or operational window. |
| Error 8452 | The named partition is being removed or the source isn't currently valid for that destination. | Compare current topology and partition placement; allow expected changes to converge. |
| Event 1988 or error 8606 | A possible lingering object was blocked. | Preserve evidence and escalate assessment. |
| Event 2042 or error 8614 | The affected inbound relationship exceeded the tombstone-lifetime protection window. | Keep the safeguard in place and escalate before reconnection. |
| Event 2095 or **DSA not writable** | Update sequence number rollback or another unsafe writable state is possible. | Preserve evidence, isolate only when guidance requires it, and escalate supported recovery. |

## Resources

- [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures)
- [Troubleshoot common Active Directory replication errors](/troubleshoot/windows-server/active-directory/common-active-directory-replication-errors)
- [Determine the interval](/windows-server/identity/ad-ds/plan/determining-the-interval)
- [Learn about Active Directory-integrated DNS zones](/windows-server/identity/ad-ds/plan/active-directory-integrated-dns-zones)
- [Verify DNS functionality to support directory replication](/windows-server/identity/ad-ds/manage/troubleshoot/verify-dns-functionality-to-support-directory-replication)
- [Troubleshoot domain controller location issues](/troubleshoot/windows-server/active-directory/troubleshoot-domain-controller-location-issues)
- [Troubleshoot Active Directory replication error 1722](/troubleshoot/windows-server/active-directory/replication-error-1722-rpc-server-unavailable)
- [Troubleshoot Active Directory replication status 8477](/troubleshoot/windows-server/active-directory/replication-error-8477)
- [Troubleshoot Active Directory replication error 8452](/troubleshoot/windows-server/active-directory/replication-error-8452)
- [Troubleshoot Active Directory replication Event 1988](/troubleshoot/windows-server/active-directory/active-directory-replication-event-id-1388-1988)
- [Troubleshoot Active Directory replication Event 2042](/troubleshoot/windows-server/active-directory/active-directory-replication-event-id-2042)
- [Troubleshoot Active Directory replication error 8614](/troubleshoot/windows-server/active-directory/replication-error-8614)
- [Detect and recover from update sequence number rollback](/troubleshoot/windows-server/active-directory/detect-and-recover-from-usn-rollback)
- [Troubleshoot missing SYSVOL and Netlogon shares (DFSR-specific)](/troubleshoot/windows-server/networking/troubleshoot-missing-sysvol-and-netlogon-shares)
- [Migrate SYSVOL replication to DFSR](/windows-server/storage/dfs-replication/migrate-sysvol-to-dfsr)
- [FRS deprecation blocks replica domain controller installation](/troubleshoot/windows-server/active-directory/ntfrs-deprecation-blocks-replic-dc-installation)
- [Review Windows service port requirements](/troubleshoot/windows-server/networking/service-overview-and-network-port-requirements)
- [Run Microsoft Support and Recovery Assistant for Active Directory replication](https://aka.ms/sara-adreplication)
- [Collect Active Directory troubleshooting data with TroubleShootingScript](/troubleshoot/windows-client/windows-tss/collect-data-analyze-troubleshoot-active-directory-scenarios#scenario-active-directory-replication-and-topology)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)
