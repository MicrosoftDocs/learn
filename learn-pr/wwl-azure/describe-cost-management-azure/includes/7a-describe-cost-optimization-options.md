After estimating and monitoring costs, the next step is choosing the right pricing option for each workload profile.

## Reservations

Reservations are best for stable, predictable workloads. You commit to specific resource capacity for a one-year or three-year term, and Azure applies discounted pricing to matching usage.

## Azure savings plan for compute

Azure savings plan for compute is another commitment-based option for compute services. Instead of committing to a specific VM family or instance type, you commit to an hourly spend amount for one or three years, and savings are applied to eligible compute usage.

## Spot pricing

Spot Virtual Machines use unused Azure capacity at reduced prices. Spot is most appropriate for interruptible workloads because Azure can reclaim that capacity when needed.

## Decision guide

Use this quick decision pattern:

 -  Choose Reservations for predictable, long-running workloads with stable resource needs.
 -  Choose Azure savings plan for compute when usage is steady but you need more flexibility across compute services.
 -  Choose Spot pricing for fault-tolerant or interruptible workloads where lowest cost is the top priority.

For example, a production SQL workload that runs 24/7 might align with Reservations, while a mixed web/API workload that shifts among compute services might fit an Azure savings plan for compute. Batch rendering or test jobs that can restart are common Spot pricing candidates.

Review these choices regularly as usage patterns change. A workload that starts as interruptible might become business-critical later and need to move from Spot to a more predictable pricing model.

Likewise, if a workload becomes more stable over time, shifting from on-demand usage to a commitment model can improve long-term cost efficiency.

