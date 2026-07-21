Some replication errors describe an expected topology transition while others protect the forest from stale or inconsistent data. Distinguish what type of error you're encountering before forcing replication.

## Validate topology only when evidence points to it

The Knowledge Consistency Checker (KCC) builds connection objects from sites, subnets, site links, costs, schedules, bridgehead availability, and current failures. A manual connection can make one path work while leaving the design fault in place.

The following table explains tools you can use in your diagnosis:

| Command | Access and effect | Decision supported |
| --- | --- | --- |
| `repadmin /showconn <DCName>` | **Read-only diagnostic.** | Does the destination have the expected inbound connection objects? |
| `repadmin /options <DCName>` | **Read-only diagnostic** when used without a change switch. | Is inbound or outbound replication disabled? |
| `Get-ADReplicationConnection -Filter * -Server <DCHostName>` | **Read-only diagnostic.** Requires ADWS. Use `-Server <DCHostName>` to select the ADWS/DC view under comparison. | Which generated or manual connections exist? |
| `Get-ADReplicationSite -Filter * -Server <DCHostName>` | **Read-only diagnostic.** Requires ADWS. Use `-Server <DCHostName>` to select the ADWS/DC view under comparison. | Which sites are defined? |
| `Get-ADReplicationSubnet -Filter * -Server <DCHostName>` | **Read-only diagnostic.** Requires ADWS. Use `-Server <DCHostName>` to select the ADWS/DC view under comparison. | Does each network map to the intended site? |
| `Get-ADReplicationSiteLink -Filter * -Properties ReplicationSchedule -Server <DCHostName>` | **Read-only diagnostic.** Requires ADWS. Use `-Server <DCHostName>` to select the ADWS/DC view under comparison. | Do costs, schedules, and site membership match physical connectivity? |

You should run topology queries from an administrative workstation or DC with an account that has permission to read the configuration partition.

```console
repadmin /showconn BNE-DC-01
repadmin /options BNE-DC-01
```

```powershell
$topologyServer = "BNE-DC-01.contoso.com"

Get-ADReplicationConnection -Filter * -Server $topologyServer
Get-ADReplicationSite -Filter * -Server $topologyServer
Get-ADReplicationSubnet -Filter * -Server $topologyServer
Get-ADReplicationSiteLink `
  -Filter * `
  -Properties ReplicationSchedule `
  -Server $topologyServer
```

Repeat the queries with the other DSA/DC view being compared when you suspect topology divergence and label each result with its `-Server` value.

Treat `DISABLE_INBOUND_REPL` or `DISABLE_OUTBOUND_REPL` as evidence, not an invitation to clear the option. Determine whether an administrator or an AD DS safeguard set it.

## Interpret error 8452 in context

Error 8452 means the named directory partition is being removed or the source isn't a valid replica for that destination. It commonly appears when:

- A DC is promoted or demoted.
- A global catalog or application partition is added or removed.
- The KCC changes a source partner.
- Site or site-link changes haven't converged.
- The DSA/DC that initiates the replication request has stale topology or partition knowledge.

The condition can be transient. It becomes something you should action when another replication failure prevents topology or partition knowledge from converging.

Use this decision sequence:

1. Confirm that the destination should host the directory partition.
2. Confirm that the source is a current partner for that partition.
3. Check recent promotion, demotion, partition, and topology changes.
4. Compare the destination's current connection objects and replica knowledge with the explicit `-Server` view of the DSA/DC that initiated the request.
5. Wait for normal convergence when the state is expected.
6. Investigate the blocking replication failure when the state persists.

Avoid `repadmin /syncall` while DCs disagree about partners or partition placement. A broad request can repeatedly start relationships that the destination no longer considers valid.

## Recognize data-consistency risks and stop conditions

Evaluate the following evidence before deciding whether the condition is transient or requires controlled recovery.

| Evidence | Meaning | Immediate response |
| --- | --- | --- |
| Event 1988 or error 8606 | A destination using strict replication consistency detected an update for an object it no longer holds. The source can contain a lingering object. | Preserve the event, source, object, and partition details. Don't enable divergent replication. Escalate lingering-object assessment. |
| Event 2042 or error 8614 | The destination hasn't successfully inbound-replicated this partition from the named source for longer than the forest's tombstone lifetime, or appears not to have because of a forward or backward system-time jump. AD DS blocks inbound replication from that source to prevent objects deleted and garbage-collected elsewhere from being reintroduced. | Keep the protection in place. Determine which endpoint is outdated, preserve time evidence, identify a known-good writable replica, and escalate before recovery. |
| Event 2095 or `Dsa Not Writable` | AD DS detected update sequence number (USN) rollback or another state that makes the DC unsafe to write. | Preserve evidence, isolate the DC when current guidance requires it, and use supported recovery guidance. |
| Error 8418 | The destination's schema view differs from the source. | If it follows a planned schema update, moves through normal topology, and clears after partner cycles, monitor it as transient. If it persists, blocks promotion, lacks a known update, or includes invalid-definition or corruption evidence, stop broad forcing, preserve schema and replication evidence, investigate the blocker, and escalate. |
| Error 8451 | Replication encountered a database-layer error; the status doesn't by itself prove corruption. | Preserve the source, destination, partition, affected object, primary and secondary errors, and NTDS, ESENT, and storage events. Select remediation only from the Microsoft procedure for the identified secondary error; escalate suspected corruption or recurrent hardware or storage faults. |

> [!WARNING]
> Don't disable or weaken strict replication consistency, clear replication safeguards, edit the directory database, restore copied database files, reset the DC account, or demote a DC as an improvised repair. Verification of strict replication consistency, and supported enabling of it when required by the documented lingering-object procedure, are protective actions; perform them only under that procedure and change control.

## Understand rollback risk

Replication partners track changes with USNs and a database invocation identity. An unsupported rollback can return a DC to an older database state while partners retain knowledge that they already received its later changes. Those partners can then ignore new changes that reuse old USN values.

This explains two critical facts:

- Repadmin can show no conventional partner failure during a USN rollback.
- Event 2095 and writable-state safeguards outweigh normal-looking Repadmin output.

On supported guests and hypervisors, a detected virtual machine Generation ID change causes AD DS to assign a new invocation ID, discard the relative identifier (RID) pool, and perform nonauthoritative inbound synchronization. This prevents USN rollback; it isn't a backup, and originating changes made after the restored point that haven't replicated elsewhere are permanently lost.

Manual virtual hard disk replacement and file or full-disk restore aren't covered by virtual machine Generation ID protection. These actions can still cause quarantine, USN rollback, or lingering objects.

## Preserve an escalation package

Before disruptive action, collect:

- Forest-wide Repadmin and DCDiag output.
- Directory Service, System, DNS Server, and relevant DFS Replication events.
- Source, destination, directory partition, timestamps, and time zones.
- Current sites, subnets, site links, connections, and replication options.
- Recent DNS, network, security, virtualization, restore, promotion, and demotion changes.
- The identity of a known-good writable replica for each affected partition.

Isolate an affected DC only when the event and current Microsoft guidance support that action. Recovery ownership, authoritative data selection, and object cleanup are outside this module.
