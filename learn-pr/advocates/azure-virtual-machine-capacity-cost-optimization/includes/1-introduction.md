A VM that fits your application at deployment can become too small as traffic grows or unnecessarily expensive when demand falls. Continuously monitor CPU and memory use alongside application response times during normal and peak demand. Use those trends to rightsize the VM: choose a size that meets the workload's performance targets and leaves enough spare capacity, or headroom, for spikes without paying for capacity the application doesn't need.

Consider a month-end processing job. A smaller VM might handle an average day but miss the month-end deadline. Finishing on time doesn't guarantee a lower bill: if no other eligible VM uses the freed portion of a prepaid reservation, you still pay for it.

A disaster recovery VM, by contrast, can be correctly sized even when it's usually idle. Size it for the work it must take over when the primary service fails. Use the recovery runbook and a representative failover drill, not everyday CPU utilization, to establish how much capacity it needs.

In this module you decide whether a change is justified, whether Azure can supply the target size, and what savings the evidence supports.

> [!WARNING]
> Use the supplied cases. Don't resize a production VM, purchase a commitment, or deliberately exhaust quota or capacity to reproduce a failure.

## How to use the cases

Use the supplied workload, failure, and cost examples to make your decisions. You don't need an Azure subscription or a running VM. The scenarios describe the decisions an operator would make, not changes that you perform. The financial records illustrate a separate change, not savings from an attempt that stopped before resizing.

> [!NOTE]
> A smoke test is a quick check of basic functionality. For example, an operator might process the same small batch before and after a resize and compare the order count and total with the expected values. A match doesn't show that the application can handle peak demand.
