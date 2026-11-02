Active Directory tracks changes using monotonically increasing counters and a pair of vectors that let any destination Domain Controllers (DCs) say precisely what the state of each record it stores is. In this unit, you learn about update sequence numbers (USNs), the high-watermark and up-to-dateness vectors, and how to read the per-attribute, linked-value, and deleted-object metadata that the engine maintains.

## Update sequence numbers (USNs)

Every DC maintains its own 64-bit **USN**, incremented on each committed originating or replicated write. The current value is exposed on the RootDSE as `highestCommittedUSN`. Two timestamps you might expect to matter—object created and modified time—are informational; the USN is the authority for ordering and replication.

Each object and attribute carries USN context:

- **`uSNCreated` / `uSNChanged`** — the local USNs at which the object was created and last changed *on this DC*.
- **Local USN vs. originating USN** — when a change is applied locally (an *originating update*), the local USN and the originating USN are the same. When the change arrives by replication (a *replicated update*), the DC stamps it with a new local USN, but preserves the **originating USN**, **originating DSA** (identified by its invocation ID), and **originating time** from the DC where the change began.

USN context is why the same user object can show different "Current USN" values on two DCs but identical originating metadata: each DC numbered the change in its own sequence, while the originating stamp—the part used for conflict resolution and dampening—is carried unchanged across the forest.

### Invocation ID and DSA GUID

A DC has two identifiers with different roles in replication:

- The **DSA GUID** is the `objectGUID` of the DC's NTDS Settings object. It identifies that directory server object and remains stable for that object's lifetime.
- The **invocation ID** identifies an incarnation of the DC's directory database and is used with originating USNs in replication metadata.

These identifiers need not match. A difference between them doesn't, by itself, prove that the DC has been restored. Use the DSA object GUID for operations that explicitly require a replication partner's server identity, such as Replication Priority Boost. Use invocation IDs when interpreting originating updates and UTD-vector entries.

During supported recovery, a new invocation ID identifies the restored database incarnation so partners don't confuse its new updates with updates from the earlier incarnation. This mechanism isn't permission to use arbitrary snapshot or file-copy restores.

> [!WARNING]
> Restoring a snapshot or database image doesn't inherently reset the invocation ID. Use a supported AD-aware recovery procedure. Virtualization safeguards require a supported guest and a VM-GenerationID-aware hypervisor that reports the generation change. An unsupported rollback can reuse the old invocation ID and cause partners to ignore updates, even when routine replication reports don't reveal the resulting divergence.

Inspect the current DSA object GUID and invocation ID with `repadmin /showrepl <DCName> /verbose`. Use `repadmin /showsig <DCName>` when investigating recorded retired database signatures.

For more information, see [Detect and recover from USN rollback](/troubleshoot/windows-server/active-directory/detect-and-recover-from-usn-rollback) and [Safely virtualizing AD DS](/windows-server/identity/ad-ds/introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100).

## The two vectors: high-watermark and up-to-dateness

A destination DC uses two structures to ask a source for only what it's missing.

The **high-watermark vector (HWMV)** is per-*source-partner* bookkeeping: for each NC and each partner it pulls from, the destination records the highest USN it has received from *that partner*. On the next cycle it says, in effect, "send me everything above this USN." This is the "where did I leave off with you" marker.

The **up-to-dateness vector (UTDVEC)** is broader: for each *originating* DSA (invocation ID) anywhere in the forest, the destination records the highest **originating USN** it has seen from that DSA *by any path*. The destination sends its UTDVEC with every request, and the source uses it for **propagation dampening**—skipping any change the destination has already received through a different route. Without the UTDVEC, a multi-path topology (rings, redundant site links) would replicate the same change repeatedly.

> [!TIP]
> Mentally: the **HWMV** answers "what's the next change *from you*?" and prevents repulling along one link. The **UTDVEC** answers "what have I *already seen from everyone*?" and prevents redundant replication across the whole topology. Together they make multi-master replication converge without loops.

```cmd
:: Inbound partners with per-NC high-watermark and last-success data
repadmin /showrepl <DCName> /verbose

:: The up-to-dateness vector for an NC: every originating DSA and its highest USN
repadmin /showutdvec <DCName> dc=contoso,dc=com

:: Retired database signatures for USN-rollback investigations
repadmin /showsig <DCName>
```

```powershell
# Vectors and partner state via the AD module
Get-ADReplicationUpToDatenessVectorTable -Target "NYDC1.contoso.com"
Get-ADReplicationPartnerMetadata -Target "NYDC1.contoso.com" -Partition "DC=contoso,DC=com" |
    Select-Object Partner, LastReplicationSuccess, LastReplicationResult, ConsecutiveReplicationFailures
```

## Per-attribute and linked-value metadata

Replication is attribute-level, not object-level: each attribute carries its own version number, originating DSA, originating USN, and originating time, and those stamps drive **conflict resolution** (highest version wins; ties break on timestamp, then originating DSA GUID). Read an object's metadata to see exactly which DC last changed which attribute and when.

```cmd
repadmin /showobjmeta <DCName> "CN=Ada Lovelace,OU=Eng,DC=contoso,DC=com"
```

```powershell
Get-ADReplicationAttributeMetadata -Object "CN=Ada Lovelace,OU=Eng,DC=contoso,DC=com" `
    -Server "NYDC1.contoso.com" |
    Select-Object AttributeName, Version, LastOriginatingChangeTime, LastOriginatingChangeDirectoryServerIdentity
```

**Linked-value replication (LVR)** is the reason a large group no longer replicates as one monolithic blob. Forest-level (Windows Server 2003+) directories replicate each value of a linked attribute—such as `member`/`memberOf`—independently, each with its own metadata. That means two admins adding different members to the same group on different DCs no longer overwrite each other, and you can audit individual membership changes:

```powershell
Get-ADReplicationAttributeMetadata -Object "CN=Engineers,OU=Groups,DC=contoso,DC=com" `
    -Server "NYDC1.contoso.com" -ShowAllLinkedValues |
    Where-Object AttributeName -eq 'member' |
    Select-Object AttributeValue, Version, LastOriginatingChangeTime, IsLinkValue
```

## Deleted-object metadata

A deletion isn't the absence of an object—it's a **replicated change** that turns the object into a deletion marker so every DC learns about it. When an object is deleted:

1. `isDeleted` is set to `TRUE`, the object is stripped of most attributes, renamed with its GUID, and moved to the hidden **Deleted Objects** container of its NC.
1. In this **tombstone** state it persists for the **tombstone lifetime** (`tombstoneLifetime`, 180 days by default on modern forests) so the deletion can replicate everywhere before the object is garbage-collected.
1. With the **AD Recycle Bin** enabled, deletion has two phases: a *deleted* (recoverable) object that retains its attributes for `msDS-deletedObjectLifetime`, then a *recycled* object that has been stripped and awaits collection. Recovering a deleted object restores its attributes; a recycled object can no longer be reanimated.

Inspect deleted-object metadata the same way you read any object's metadata—the engine keeps the stamps so you can see which DC performed the delete and when:

```cmd
:: Show metadata for the Deleted Objects container or a specific deleted object
repadmin /showobjmeta <DCName> "CN=Deleted Objects,DC=contoso,DC=com"
```

```powershell
# Enumerate deleted objects (requires the Return Deleted Objects control)
Get-ADObject -IncludeDeletedObjects -SearchBase "DC=contoso,DC=com" `
    -LDAPFilter "(isDeleted=TRUE)" -Properties whenChanged, lastKnownParent, isRecycled |
    Select-Object Name, whenChanged, lastKnownParent, isRecycled
```

In LDP, you enumerate deleted objects by binding to a DC, searching the **Deleted Objects** container with scope **Subtree**, and loading the predefined **Return Deleted Objects** control (LDAP OID `1.2.840.113556.1.4.417`). The `-IncludeDeletedObjects` switch allows you to view deleted objects in PowerShell.

**Lingering objects** can remain on a DC that missed deletions while replication was interrupted long enough for the deletion markers to be garbage-collected on other replicas.

> [!WARNING]
> An old originating timestamp or USN isn't sufficient evidence that an object is lingering. Lingering-object verification uses replication knowledge to identify eligible objects, then checks whether they exist on a verified up-to-date writable reference replica of the same partition. Start with advisory mode and review the reported objects before removing anything.
>
> Strict replication consistency blocks a source's updates to objects missing on the destination and reports the condition. It doesn't automatically remove lingering objects. Keep this protection enabled while following the documented diagnosis and cleanup procedure.

Start with this advisory-only command template. Replace `<SuspectDC>` with the DC to examine and `<ReferenceDSAObjectGUID>` with the healthy reference DC's **NTDS Settings objectGUID**, not its invocation ID. Use the partition being investigated in place of the example domain DN:

```text
repadmin /removelingeringobjects <SuspectDC> <ReferenceDSAObjectGUID> "DC=contoso,DC=com" /advisory_mode
```

Advisory mode reports findings without deleting objects. Review the output and follow the full [Microsoft procedure for identifying and removing lingering objects](/troubleshoot/windows-server/active-directory/active-directory-replication-event-id-1388-1988) before performing any removal. Don't omit `/advisory_mode` merely to make replication succeed.

With USNs, the HWMV, and the UTDVEC, you can state precisely what information every DC has and hasn't received, with per-attribute and deleted-object metadata telling you which DC originated each change. The next unit puts this to work: diagnosing replication failures and, where the engine's built-in priorities aren't optimal, applying Replication Priority Boost.
