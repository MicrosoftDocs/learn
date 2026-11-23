Approval applies to particular machines in a known starting state. A replacement VM can have the same name and resource path as the original but a different instance identifier (`vmId`). You need both identifiers, not just a list of names.

For example, the entire pilot depends on a result from the approved canary, `fc-canary` (`c-17`). Suppose its name, resource path, and `blue` response still match, but Azure reports a replacement instance, `c-18`. Hold the rollout before the first write. Record the new identity and baseline and ask for fresh canary approval. Don't silently substitute the replacement or pick another public backend to keep the wave on schedule.

Record each VM's resource path and instance identifier in the **approved manifest**, the fixed list of machines in scope and those explicitly excluded. Before a change, compare the manifest's **file hash** (a fingerprint of its contents) with the hash in the approval record. If they differ, stop: the target list no longer matches the approved copy. A matching hash confirms the file's contents, not who approved it or whether you may proceed.

**Record M1: inventory and baseline.** The manifest has one row per VM with its full resource path, instance identifier (`vmId`), workload, pool, ring, and original state. Both the public and staff applications report the display setting. In this example, independent checks recorded `blue` at revision `0` on all 200 VMs. A revision counts writes, not command attempts. The table summarizes the manifest using abbreviated names and IDs.

| Ring | VMs | Manifest members | Approval boundary |
|---|---:|---|---|
| Canary | 1 | `fc-canary` (instance `c-17`) | Only initial write target |
| Pilot | 19 | `fc-later` (`l-22`) and `fc-web-001` through `fc-web-018` | Separate pilot approval |
| Production | 170 | `fc-web-019` through `fc-web-188` | Release only the named members of each wave |
| Staff | 10 | `fc-excluded` (`x-09`) and `fc-staff-001` through `fc-staff-009` | Observe only; outside the public backend pools |

> [!NOTE]
> **Observed evidence** comes from an actual run. The records in this module are synthetic examples of what to retain, not proof that a live fleet changed. In a real change record, **redact** secrets such as access tokens while keeping the target, exit code, and application response needed to explain the decision.

The change request identifies manifest `M1` and reviewed script `S1` by hash. Corrections, expansion, and restoration need their own approvals. Before each write, verify the manifest, instance identifiers, script, and private access route against the approval. The example rollout uses `l-22` throughout. The following identity mismatch illustrates when that rollout would have to stop.

**Hold on an identity mismatch**: Suppose `fc-later` keeps its path and tag but has been replaced with instance `l-93`. Comparing all 19 pilot identities with `M1` gives 18 matches and one mismatch. Record `expected l-22, found l-93; pilot held before dispatch`. The other 18 matches don't authorize substituting the replacement or quietly reducing the approved pilot to 18.

**Approve the replacement separately**: If the portal workload owner wants to include `l-93`, capture its own starting state rather than copying the baseline for `l-22`. For example, if a direct check returns `VmOpsDisplay:blue` at revision `0`, record that result and `l-93` in a new manifest version, `M2`. Keep `M1` as the record of the original approval. Ask the portal workload owner to approve script `S1` on `fc-later` instance `l-93` under `M2`; without that approval, leave the replacement unchanged.
