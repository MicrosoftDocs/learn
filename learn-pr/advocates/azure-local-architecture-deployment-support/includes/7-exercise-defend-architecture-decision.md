In this exercise, you act as the architect for the fictional manufacturer introduced earlier. Complete a paper design: don't create Azure resources, change licenses, or run failure tests.

## Scenario and constraints

A regional branch datacenter needs existing Azure Local VMs for production scheduling and inventory services. Application owners require local execution during a temporary WAN interruption. They've approved connected Azure management and haven't requested permanent management isolation.

Use the following supplied assumptions. They're training inputs, not validated production measurements or Microsoft sizing recommendations.

| Input | Supplied value or requirement |
| --- | --- |
| Candidate hardware | Three, four, or five identical catalog-qualified nodes |
| Per-node resources | 512 GiB memory and 32 physical cores |
| Per-surviving-host memory allowance | 64 GiB |
| Cluster-wide infrastructure memory | 96 GiB |
| Additional operational reserve | 20 percent after host and infrastructure deductions |
| Workload memory including planned growth | 960 GiB |
| Initial failure contract | One unavailable node in total |
| Storage candidate | Hyperconverged, with an illustrative 100 TiB physical capacity tier |
| Storage assumptions | 10 TiB physical repair reserve, 2 TiB physical overhead, three data copies, 2 TiB logical infrastructure |
| Planned workload storage including growth | 22 TiB |
| Network candidate | A qualified redundant pattern with 25 Gbps links; demand measurements remain outstanding |
| External array | No existing qualified array |
| Recovery objectives | Host-outage application RTO of 15 minutes; site-loss RPO of 15 minutes and RTO of four hours |
| Commercial position | Eligible-license evidence and support quotes haven't yet been reviewed |

The application team hasn't yet demonstrated new logins, application restart, or backup recovery during loss of cloud connectivity. Storage latency, CPU demand, placement, and site-recovery readiness also aren't yet proven. Treat missing evidence as a condition to resolve, not as a successful test.

## Complete the design tasks

Use the supplied scenario and calculations to complete these tasks in order, recording the reasoning for each decision.

1. Select a platform, deployment type, and connectivity model. Explain why a compact container-oriented appliance isn't a substitute for the required VM capability.
1. Map one local inventory transaction and one Azure VM-management operation. Identify which dependencies may stop during the WAN outage.
1. Calculate the memory budget for three nodes with one unavailable and four nodes with one unavailable. Compare each with 960 GiB.
1. Calculate the storage workload budget and compare it with 22 TiB. State which resiliency and performance assumptions still require validation.
1. Reassess the design if the business adds a requirement for a failure during node maintenance. State whether four nodes still fit and what the five-node calculation does and doesn't prove.
1. Identify the mechanism and evidence needed for host failover, data damage, and site loss. Don't derive an RPO or RTO from redundancy alone.
1. Write an architecture decision record with rejected alternatives, accountable owners, commercial conditions, and explicit revisit triggers.

## Suggested reasoning

A connected hyperconverged design is a reasonable **conditional selection**. It matches the stated VM and connectivity needs without introducing an unqualified external array. Its selection doesn't prove that local identity or the application can operate through the required WAN interruption.

Three nodes fail the memory requirement: the failure-state workload budget is 640 GiB. Four nodes pass that one-unavailable-node calculation with a 998.4 GiB workload budget and 38.4 GiB spare. Four nodes don't pass a two-unavailable-node requirement. Five identical nodes restore the 998.4 GiB budget in that case, but only for the modeled memory dimension.

The illustrative storage workload budget is `(100 - 10 - 2) / 3 - 2`, or approximately 27.3 TiB. Against the 22 TiB demand that already includes growth, about 5.3 TiB remains within that simplified workload budget. Don't deduct the 10 TiB physical repair reserve a second time or assume the remaining logical capacity demonstrates acceptable rebuild performance.

Reject the three-node alternative for insufficient failure-state memory. Reject small form factor for this scenario's required Azure Local VM support. Don't justify disaggregated storage merely because it supports independent scaling: first establish that independent storage growth is a requirement and that a qualified array and operating model exist.

The proposed recovery targets remain unproven. Host failover requires a supported resilient configuration and measured application recovery. Site loss requires a separate supported recovery destination and end-to-end evidence. Neither the memory arithmetic nor an OEM support quote demonstrates the four-hour recovery target.

## Record the decision and its conditions

An *architecture decision record* (ADR) captures the context, selected option, reasoning, tradeoffs, and conditions. It preserves the reasoning behind a decision so that a future engineer can tell when it's no longer valid.

The following worked record shows how to document the proposed design without treating unresolved conditions as proven capabilities.

| Record field | Worked decision |
| --- | --- |
| Status | Conditional; not approved for production commitment |
| Context | Existing VMs, local transactions during WAN interruption, connected management, one unavailable node in total |
| Decision | Four symmetric catalog-qualified nodes with hyperconverged local storage and connected operations |
| Supporting evidence | Deployment workload eligibility; 998.4 GiB modeled memory budget; approximately 27.3 TiB modeled storage budget |
| Rejected alternatives | Three nodes fail memory; small form factor doesn't provide the required listed VM capability |
| Tradeoffs | Compute and storage expansion are coupled; cloud-dependent management can be interrupted independently of local execution |
| Failure boundary | One unavailable node only; no implied tolerance of an additional failure during maintenance |
| Technical conditions | Demonstrate CPU, storage latency, repair behavior, network throughput, placement, quorum, and WAN-outage application behavior |
| Recovery conditions | Demonstrate host-outage RTO and site-loss RPO/RTO with a supported recovery design and protected recovery assets |
| Commercial conditions | Verify the deployment tier, eligible-license evidence, guest and application rights, and all support agreements |
| Accountable owners | Platform lead coordinates; workload, network, identity, storage, licensing, and recovery owners close their respective conditions |
| Revisit triggers | New workload, changed residency or connectivity, external storage, two-unavailable-node requirement, support-lifecycle change, or capacity forecast approaching the approved limit |

## Review the decision before approval

The architecture review should be able to answer these questions from the ADR and its evidence, without relying on the architect's memory.

- Does the selected deployment support the actual workload and connectivity combination?
- Is the claimed failure tolerance supported by quorum, data resilience, capacity, and application dependencies?
- Are reserves and growth counted exactly once with consistent units?
- Can operators maintain the system without violating the agreed failure contract?
- Are recovery objectives demonstrated rather than inferred?
- Are technical support, operational ownership, and commercial rights independently covered?

If a condition can't be met, revise the design or obtain explicit acceptance of a changed requirement. Reducing an undocumented reserve, ignoring a workload restriction, or changing the meaning of "available" isn't evidence.
