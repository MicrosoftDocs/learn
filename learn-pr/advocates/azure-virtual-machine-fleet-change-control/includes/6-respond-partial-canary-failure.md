One backend has received a write, 189 public backends are waiting, and 10 staff VMs are outside the rollout. When the canary command reports failure, the portal workload owner needs to know which link that backend serves before approving another write. The records below show how to distinguish a partial change from a rollback. The fleet counts come from direct per-VM checks, not a sample through the load balancer.

## The first change

**Record C1, 09:05.** Azure accepted the canary command. Its instance view says `Failed`, exit code `42`, with the message `FAIL_AFTER_WRITE`. A separate read-only check produced the following results:

| Ring | VMs checked | Change command | Display file and direct response | Revision |
|---|---:|---|---|---:|
| Canary | 1 | Attempted, exit `42` | `green`, `VmOpsDisplay:green` | 1 |
| Pilot, including `fc-later` | 19 | Not sent | All `blue`, `VmOpsDisplay:blue` | 0 |
| Remaining production backends | 170 | Not sent | All `blue`, `VmOpsDisplay:blue` | 0 |
| Staff, including `fc-excluded` | 10 | Out of scope | All `blue`, `VmOpsDisplay:blue` | 0 |

The status to report is **command failed; canary changed; pilot held**. Exit `42` describes how the script ended. Revision `1` and the direct `green` response show that the write took effect before the failure. The other 199 VMs remain at their baseline. Preserve the failed attempt and don't retry it or start the pilot under the original approval.

:::image type="content" source="../media/canary-partial-failure.svg" alt-text="Diagram that shows the canary writing green before exit 42 while the other 189 public backends and 10 excluded staff VMs remain blue.":::

## Correction and expansion

**Record C2, 09:12.** Once the post-write failure is understood, the portal workload owner approves a correction on `fc-canary` only, with the failure input off. At 09:14 the correction reports exit `0` and `changed=False`. The canary still serves `VmOpsDisplay:green` at revision `1`: the setting was verified without a second write. All 199 other VMs remain `blue / 0`. The correction approval doesn't release the pilot.

**Record A2, 09:18.** After reviewing C1 and C2, the portal workload owner approves `S1` on the 19 pilot instances in `M1`, including `fc-later` (`l-22`). The runbook dispatches at most five writes at once and no more than one per pool. By 09:35, all 19 commands have exited `0`; all 19 backends independently return `green / 1`. Including the canary, 20 public VMs now serve the new link. The other 170 public VMs and all 10 staff VMs remain `blue / 0`.

The change between 09:14 and 09:18 was the **scope of approval**, not the canary's state. Likewise, 19 healthy pilot results support a request for a production wave. They don't authorize writes to any of the remaining 170 public backends.

**Record A3: bounded production expansion.** At 09:40 the portal workload owner releases `fc-web-019` through `fc-web-038` (20 VMs). At 09:58 all 20 return `green / 1`, directly and with no missing results. At 10:00 the portal workload owner releases `fc-web-039` through `fc-web-058` (another 20) under the same concurrency and pool limits. By 10:20 those 20 also return `green / 1`. The trial window ends there. **60 changed** (1 canary + 19 pilot + 20 + 20), **130 deferred**, **10 excluded**. The canary's initial failed attempt remains in the record.
