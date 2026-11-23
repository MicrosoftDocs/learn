The earlier resize and disk detachment were outside the scope of a support-link update. When a request *does* authorize an infrastructure change, it needs its own target list, approval, and recovery route. Identify what must keep working, how much capacity the change will take away, and which observations would let you safely change the next VM.

## Decide how many VMs you can drain

Each portal pool has ten equal backends. In the busiest pool all ten average 65% CPU at peak, or 6.5 VMs' worth of load. Assuming even redistribution within that pool, draining one leaves nine at about **72%** each; draining two leaves eight at about **81%**. If the portal workload owner's ceiling is 80%, a two-VM drain fails even though the other 180 portal VMs are healthy: they don't automatically receive this pool's traffic. Drain one per pool, postpone, or add and validate spare capacity under separate approval. Also check memory, queue depth, request latency, and shared dependencies.

Compare the serving count and CPU estimate for each option before scheduling the drain.

:::image type="content" source="../media/back-drain-capacity.svg" alt-text="Diagram that shows one drain leaving nine backends at 72% CPU and two drains leaving eight at 81%, above the 80% ceiling.":::

Use the following sequence for a planned drain:

1. **Agree on a limit**: In this example the portal workload owner requires nine healthy backends per pool, an 80% CPU ceiling, and a 95th-percentile return submission time under 500 ms. Spread maintenance across different pools, with no more than five VMs offline fleet-wide. Check quota and test any added spare before counting it as capacity.
1. **Stop new work, then wait for existing work**: Use the application's drain or readiness mechanism on the target. With an Azure Standard Load Balancer, a failed backend health probe stops new flows to that backend, but established TCP flows can continue. Check active sessions and queued jobs on the VM. If the drain deadline expires with a return still being processed, defer the change rather than dropping the transaction.
1. **Put the VM back deliberately**: Verify the new state on the VM, restore readiness, and check the probe, user-facing latency, and errors. Even with all ten backends healthy again, a 95th-percentile time of 720 ms fails the 500-ms gate. Hold the next drain and investigate.

## Carry out an approved disk or network change

Each request below has its own approved target list. Use the disk and network mappings for each pool to choose a canary and safe batch size. One successful Azure write isn't evidence that the rest of a wave has usable storage or connectivity.

| Approved change | How to stage it | Evidence and stop condition |
|---|---|---|
| Expand the data volumes on ten approved backends from 128 GiB to 256 GiB | Map each managed disk ID and logical unit number (LUN) to its Windows volume. Check recovery points and online expansion support. Start with one backend and drain and deallocate if needed. Enlarge its managed disk, rescan in Windows, and extend the intended volume before repeating in batches. | Suppose Azure reports 256 GiB on all ten disks, but only nine guest volumes grew. Report nine verified and one incomplete, not ten successes. Investigate the outlier's mapping and verify a test read/write on each target. Shrinking the disk isn't a rollback plan. |
| Move a wave of portal backends to a new load-balancer pool | Record the source and destination membership, rules, probes, and private access route. Drain and move one canary. Admit further backends only while both pools meet their capacity limits. | Match the expected members to healthy probes in the new pool. Test each moved backend directly and through the intended frontend, and verify it gets no new flows from the old path. If a check fails, hold further moves. Use the recorded associations to recover only the affected members. |
| Tighten a network security group rule on the portal tier | Identify every interface or subnet that inherits the rule. If it's shared, don't edit it as a one-VM canary. First test the proposed rule on an isolated equivalent target with the same traffic requirements. Retain the previous rule and its priority. | From the approved sources, open **new** connections to test the portal, load-balancer probe, and private administration. Also verify that a connection the rule is supposed to deny is denied. An existing session that stays open doesn't prove the new rule permits reconnection. |
