Changing one limit at a time helps test whether it was holding the stock reporting service back. In this unit, you'll compare the service's read rate and response time before and after a simulated increase to a disk or VM storage limit, with the workload held constant. The change might meet both targets, improve throughput while leaving another bottleneck, or make no difference.

The two diagnoses make different predictions. In D, a higher disk limit should allow more reads to finish. In V, the same kind of change should have little effect because the VM already limits how many reads can finish.

> [!NOTE]
> **How a reversal helps:** In an A/B/A comparison, A is the original setting, B is the change, and the second A restores the original. If B completes 5% more reads than the first A, but the second A also gains 5%, the gain persisted after the reversal. That comparison alone doesn't show that B caused it.

The simulated results below isolate one limit at a time. Higher throughput isn't enough: the stock reporting service still needs 6,000 reads per second **and** application p95 below 10 milliseconds.

| Experiment | Only changed variable | Result | Interpretation |
|---|---|---|---|
| D disk upgrade | Disk IOPS ceiling 3,000 to 6,000 | 5,200 IOPS; processor 96%; runnable backlog; application p95 13 ms | More reads finish, but both targets are still missed. CPU contention is a candidate, not an established cause. |
| V disk upgrade | Disk IOPS ceiling 12,000 to 16,000 | 3,990 IOPS; VM uncached near 100% | No read-rate gain: 3,990 reads/s is still below 6,000. The trial doesn't report post-change application p95, so the latency effect is unknown. The joint target wasn't met. |
| V VM-path experiment | VM uncached IOPS envelope 4,000 to 8,000, other fixture constraints unchanged | 6,000 IOPS; application p95 8 ms; guest healthy | Supports the VM-path hypothesis in this controlled fixture |

A real VM resize changes several characteristics, not only storage IOPS. Therefore the last row is a controlled fixture, not a claim that a real resize isolates one hardware property. After a resize, record, which limits changed and what happened to performance. If several limits changed together, the result alone can't tell you which one caused the improvement.

Before labeling measurements "after resize," confirm that the resize operation succeeded for this VM and that the workload resumed. If allocation failed, Azure can display the requested size while the VM is still running at its previous size. Check the operation outcome, not just the size field. Compare a steady window after restart and warm-up under comparable demand. If the change didn't take effect, you haven't tested the new limits.

In D, the readings show VM-wide processor pressure, not which process used the CPU or whose threads waited. Before recommending more CPU, establish whether the stock reporting service's threads were waiting for processor time or whether other work accounted for the backlog. In V, raising the disk limit produced no measured gain in read rate. Only the higher VM uncached limit met both targets in the simulation. Neither result authorizes a production change.
