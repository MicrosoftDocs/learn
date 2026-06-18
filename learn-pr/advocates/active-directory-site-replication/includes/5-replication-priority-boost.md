When replication is healthy, the metadata from the previous unit converges quietly in the background. When it isn't, you need a repeatable way to find *which* partner, *which* naming context, and *which* error is blocking convergence—and occasionally a way to tell the engine that a particular partner matters more than its defaults suggest. This unit builds a diagnosis workflow and then introduces the Windows Server 2025 **Replication Priority Boost** feature for the cases where the built-in priorities aren't the most efficient choice.

## A replication failure diagnosis workflow

Work from the forest-wide summary down to the specific failing link, then to the error code.

**1. Get the forest-wide picture.** `repadmin /replsummary` lists every DC with its largest replication delta and a count of failures. Large deltas and nonzero error counts point you at the DCs to investigate.

```cmd
repadmin /replsummary
repadmin /showrepl * /csv > repl.csv
```

**2. Inspect the failing partner and error.** For a suspect DC, `repadmin /showrepl /verbose` shows each inbound partner, the last success and last failure time, and the Win32 error of the most recent failure.

```cmd
repadmin /showrepl <DCName> /verbose
repadmin /queue  <DCName>          :: pending inbound replication work
repadmin /showconn <DCName>        :: connection objects feeding this DC
```

**3. Corroborate with `dcdiag` and the event log.** `dcdiag` interprets several conditions for you, and the Directory Service log carries the authoritative NTDS Replication/KCC events.

```cmd
dcdiag /test:Replications /test:Intersite /test:KccEvent /test:CheckSecurityError /v
```

**4. Map the error to a cause.** A handful of errors account for most cases:

| Symptom / error | Typical cause | First checks |
| --- | --- | --- |
| `1722` RPC server unavailable | Network/firewall, DC down, name resolution | Connectivity to RPC endpoint mapper (TCP 135) and the dynamic port; `ping`/`nltest /dsgetdc` |
| `1256` remote system not available | Partner offline or unreachable for some time | Partner health; expected if a DC was rebooting |
| `8524` DSA operation/DNS failure | Missing or stale DNS SRV/CNAME records | `dcdiag /test:DNS`; confirm the DSA GUID `_msdcs` CNAME resolves |
| `-2146893022` / access denied | Kerberos or **time skew** beyond five minutes; machine account/secure channel | Time hierarchy (`w32tm /query /status`); secure channel |
| `8606` / `8614` | **Lingering objects** / data older than tombstone lifetime | Don't force replication; remediate lingering objects |

> [!TIP]
> Time is the most common silent cause of "access denied" replication failures. Kerberos rejects tickets when DC clocks differ by more than the allowed skew, and that surfaces as authentication errors on the replication RPC. Validate the time hierarchy before chasing the replication stack.

## How the engine prioritizes replication—and where it falls short

When a destination DC pulls its outstanding work from partners, the engine serves those tasks by **priority**. That priority is **hardcoded heuristic**:

- The **configuration NC** outranks the **domain NC**, because topology changes are considered more important.
- An **intra-site** partner outranks an **inter-site** partner, because proximity usually implies relevance.
- DCs in the same group share the same priority.

These defaults are right most of the time. They're *wrong* in a few recurring situations:

- **Functional, not geographic, sites.** When sites model primary versus backup roles rather than physical proximity, an *inter-site* change can matter more than an intra-site one—the opposite of the default.
- **Over-the-wire DC promotion of a large directory.** Promoting a DC across a WAN replicates a large DIT. If the transfer is interrupted by a reboot or network blip, replication can resume from a *different* partner, and you'd prefer it converge from one specific, well-connected source.
- **A specific partner you want to favor** over others in the same group, or a case where configuration-NC changes simply aren't urgent for this DC.

## Replication Priority Boost on Windows Server 2025

Replication Priority Boost lets you add a **boost factor** on top of the built-in priority for a specific replication partner and naming context, expressed on the destination DC's `repsFrom` data. It's a runtime priority hint—not a topology change—so use it alongside, not instead of, a correct site design.

### Requirements and compatibility

- The **destination** DC must run Windows Server 2025. The **source** DC can run Windows Server 2022 or later.
- There are no special system requirements to enable it on Windows Server 2025.

### Set the boost with `setPriorityBoost`

The boost is applied through a RootDSE modifier attribute named **`setPriorityBoost`**, and read back through the parameterized RootDSE attribute **`msDS-PriorityBoost`**. The value you write has three colon-separated parts:

```text
<naming context>:<source partner DSA GUID>:<boost factor>
```

For example, to boost a single application partition partner:

```text
CN=app1:ae732425-2e31-4246-98a5-60ce2e1c8101:5
```

The GUID is the source partner's **DSA GUID**: the `objectGUID` of the source DC's **NTDS Settings** object, not the computer account object GUID.

Set it interactively with **Ldp.exe** (you can script the same modify with `ldifde`):

1. Run **Ldp.exe** and **Connection > Connect** to the Windows Server 2025 destination DC, then bind as a Domain/Enterprise Admin.
2. **Browse > Modify**. Leave the **DN** blank so the operation targets the RootDSE.
3. In **Edit Entry Attribute**, type `setPriorityBoost`.
4. In **Values**, type `<naming context>:<source DSA GUID>:<boost factor>`—for example `DC=contoso,DC=com:<source-DSA-GUID>:10`.
5. Set the operation to **Add**, select **Enter**, then **Run**. A successful `ldap_modify_s ... Modified ""` confirms it.

```text
----------
***Call Modify...
ldap_modify_s(Id, '(null)',[1] attrs);
Modified "".
----------
```

To confirm the boost, **Browse > Search** the RootDSE with an empty base DN, **Base** scope, and filter `(objectClass=*)`. In **Attributes**, request the parameterized attribute `"msDS-PriorityBoost;parameter=<naming context>:<source DSA GUID>"`, for example:

```text
"msDS-PriorityBoost;parameter=DC=contoso,DC=com:<source-DSA-GUID>"
```

The search result returns the same parameterized attribute with the boost value, such as:

```text
msDS-PriorityBoost;parameter=DC=contoso,DC=com:<source-DSA-GUID>: 10;
```

### Choosing a boost factor

Microsoft publishes recommended boost values for the common scenarios. Start from these rather than guessing:

| Scenario | Boost factor |
| --- | --- |
| Favor one intra-site partner over its peer intra-site partners | `2` |
| Make the **domain NC** outrank the **configuration NC** | `10` |
| Favor an inter-site DC over an intra-site DC, when the inter-site source **doesn't** have `DRS_NEVER_NOTIFY` set | `2` |
| Favor an inter-site DC over an intra-site DC, when the inter-site source **has** `DRS_NEVER_NOTIFY` set | `18` |

The larger value in the last row exists because a source that never sends change notification starts from a lower effective priority, so it needs a bigger boost to overtake an intra-site peer.

### Operate it as a controlled change

Replication Priority Boost is a precision tool. Apply it deliberately:

- **Use it for a defined need**—a WAN promotion, a primary/backup site asymmetry, or a single favored partner—not as a blanket setting.
- **Validate in an isolated lab first.** Set the boost, generate change on the source, force replication, and confirm with `repadmin /showrepl /verbose` and `repadmin /queue` that the boosted partner is serviced ahead of its peers.
- **Document and review.** Record the NC, partner GUID, and factor, and remove the boost once the scenario that justified it (such as the over-the-wire promo) is complete.
- **Fix topology first.** If you find yourself boosting many partners, the underlying cost or site design is probably wrong—revisit the design from the earlier units before reaching for boosts.

> [!IMPORTANT]
> A boost changes the *order* in which outstanding work is serviced; it doesn't create connectivity, repair a failing link, or substitute for correct costs and schedules. Diagnose and clear actual replication failures first, then use Replication Priority Boost to shape priority where the built-in heuristics genuinely don't fit your topology.

In the exercise that follows, you combine everything in this module: evaluate a site topology, validate DC Locator on Windows Server 2025, read replication metadata to prove convergence, diagnose an induced failure, and apply a Replication Priority Boost in a controlled lab scenario.
