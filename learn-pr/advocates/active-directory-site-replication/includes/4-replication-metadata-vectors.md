Active Directory tracks changes using monotonically increasing counters and a pair of vectors that let any destination Domain Controllers (DCs) say precisely what the state of each record it stores is. In this unit, you learn about update sequence numbers (USNs), the high-watermark and up-to-dateness vectors, and how to read the per-attribute, linked-value, and deleted-object metadata that the engine maintains.

## Update sequence numbers (USNs)

Every DC maintains its own 64-bit **USN**, incremented on each committed originating or replicated write. The current value is exposed on the RootDSE as `highestCommittedUSN`. Two timestamps you might expect to matter—object created and modified time—are informational; the USN is the authority for ordering and replication.

Each object and attribute carries USN context:

- **`uSNCreated` / `uSNChanged`** — the local USNs at which the object was created and last changed *on this DC*.
- **Local USN vs. originating USN** — when a change is applied locally (an *originating update*), the local USN and the originating USN are the same. When the change arrives by replication (a *replicated update*), the DC stamps it with a new local USN, but preserves the **originating USN**, **originating DSA** (identified by its invocation ID), and **originating time** from the DC where the change began.

USN context is why the same user object can show different "Current USN" values on two DCs but identical originating metadata: each DC numbered the change in its own sequence, while the originating stamp—the part used for conflict resolution and dampening—is carried unchanged across the forest.

### Invocation ID and DSA GUID

A DC is identified in replication metadata by two GUIDs:

- The **DSA GUID** (`objectGUID` of the DC's NTDS Settings object) is stable for the life of the DC.
- The **invocation ID** identifies the *current instance* of the directory database. It normally matches the DSA GUID, but it's **reset whenever the database is restored** from backup or snapshot, or when a virtualized DC detects a generation-ID change.

That reset is the core of **USN rollback protection**. If a DIT is restored improperly and the USN counter moves backward, partners would otherwise ignore "old" USNs they think they've already seen, silently dropping changes. Resetting the invocation ID makes the restored database look like a new source, so partners reevaluate it correctly. Inspect signatures with `repadmin /showsig`.

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

:: Invocation ID and DSA GUID for USN-rollback investigations
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

> [!WARNING]
> Deleted-object metadata is also how you detect **lingering objects**—objects that were deleted while a DC was offline past the tombstone lifetime, then reintroduced when that DC came back. A reintroduced object has originating metadata older than every partner's UTDVEC, which is exactly the signal `repadmin /removelingeringobjects` and the strict-replication-consistency setting use to find and remove it. Take care with a domain controller that has been offline longer than the tombstone lifetime.

With USNs, the HWMV, and the UTDVEC, you can state precisely what information every DC has and hasn't received, with per-attribute and deleted-object metadata telling you which DC originated each change. The next unit puts this to work: diagnosing replication failures and, where the engine's built-in priorities aren't optimal, applying Replication Priority Boost.
