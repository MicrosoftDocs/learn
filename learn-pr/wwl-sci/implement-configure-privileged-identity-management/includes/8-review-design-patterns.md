Knowing how each control works isn't the same as knowing which ones to reach for. Across Entra roles, Azure resource roles, groups, and AI workloads, the same underlying question recurs: what level of friction, scope, and duration is right for this workload, at this risk level, for this team?

## Privilege as an architectural decision

Just-in-time (JIT) access isn't a feature toggle — it's a posture. Every privileged assignment should represent a deliberate decision about who needs access, to what, for how long, and under what conditions. The goal isn't zero standing access — sometimes permanent active assignment is correct — but zero *unjustified* standing access. That framing shifts Privileged Identity Management (PIM) from a compliance checkbox to a design tool: one you use when you're defining how a workload, team, or service should behave under normal conditions and under pressure.

## Patterns for JIT access design

The following table maps common design patterns to the scenarios where they apply, what each pattern prevents, and the trade-off you accept when you choose it.

| Pattern | When to apply | What it prevents | Key trade-off |
|---|---|---|---|
| Eligible by default, activate when needed | All roles except break-glass and workload identities | Standing privilege, unlimited exploitation window | Activation friction for routine tasks |
| Short activation windows for production | Critical and High-tier resources (production subscriptions, Key Vault, AI control planes) | Prolonged access after task completes | May require re-activation for extended work |
| Approval for high-impact roles | Critical-tier roles where a single activation could cause irreversible damage | Unilateral privilege escalation | Approval latency; requires designated approvers |
| Regular access reviews | All eligible assignments, quarterly minimum | Privilege accumulation; stale assignments | Operational overhead for reviewers |
| Emergency access excluded from JIT | Break-glass accounts only | JIT dependency failure during an outage | Must compensate with maximum monitoring and documented procedure |

These patterns aren't mutually exclusive. A production subscription might combine short activation windows with mandatory approval — mapping directly to the Critical-tier controls. High-tier resources typically warrant short windows without approval, while Standard-tier resources can rely on eligible assignment alone. Applying the right combination at each tier is what turns individual PIM settings into a coherent access strategy.

## The break-glass exception

Break-glass accounts are excluded from JIT not because they're exempt from governance, but because PIM's activation path — which depends on multifactor authentication (MFA), approver availability, and service health — can itself fail during the outage conditions that require emergency access. When the identity platform is partially degraded, the last thing you need is access gated behind a service that isn't responding. The governance model shifts accordingly: instead of time-limited activation, the controls become zero normal use, maximum alerting, and a documented break-glass procedure that is rehearsed and audited on a fixed schedule.

> [!IMPORTANT]
> Break-glass accounts must never be used for routine tasks. Any activation should trigger an immediate investigation to determine whether the use was authorized and whether underlying access gaps need to be addressed.

A privileged access strategy holds together not because every control is configured, but because the decisions behind those controls can be explained and defended — which is exactly what the following knowledge check tests.
