| :::image type="icon" source="../media/goal.svg"::: Maximize the use of resources and operations. Apply them to the negotiated functional and nonfunctional requirements of the solution. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Services and offerings provide various capabilities and pricing tiers. After you purchase a set of features, avoid underutilizing them. Find ways to maximize your investment in the tier. Likewise, continuously evaluate billing models to find those that better align to your usage, based on current production workloads.

**Example scenario**

Contoso University is currently hosting a commercial off-the-shelf (COTS) solution that allows the university faculty to create and update courses for the school year and is the primary registration portal used by students for those courses. The solution has a custom integration with a software-as-a-service (SaaS) education management system, which they hope to eventually migrate all of their functions to in a few years. In the meantime, they want to optimize costs on the custom integration components. 

The technology solution of the COTS offering is generally treated like a black box, except for its database which is Azure Database for MySQL. The custom integration is an Azure Durable Function, which runs fanned out on a Standard service plan in Azure App Service. This App Service previously hosted a university website, but that is no longer the case. This durable function is a Python application backed by a dedicated Azure Storage account that performs a nightly sync from the MySQL database into the SaaS's API.

## Use consumption-based pricing when it's practical

**There may be services that offer consumption-based pricing, which means that you are only billed for the utilization of the service, and you can shut down the service when it isn't needed to stop incurring costs. If you have workload components that are only utilized sporadically, this can help minimize wasted costs when compared to paying for the component to run 24/7/365.**

By using consumption-based pricing, you only pay for exactly what you use. This option is a good choice when your workload compute isn't expected to be utilized full-time.

*Contoso's challenge*

- The sync job usually runs for about an hour every night, at a specific time. The performance of it has historically been satisfactory. Malfunctions are rare and transient faults are handled well in the current configuration.
- As the compute needed for the sync job is only utilized about an hour per day, and they pay for 24 hours regardless of the utilization, the workload team is interested in an alternative to the current design.
- The team has considered writing a script to shut down the service each night after the sync runs and redeploying it the next day, but this solution would carry a high degree of risk and complexity.

*Applying the approach and outcomes*

- The team analyzes the job history and they find that the longest the function ever runs has been just under two hours. They compare the cost of the dedicated plan to the cost of Azure Functions consumption plan for the worst-case scenario and conclude that the consumption plan will be less expensive.
- The team runs a performance test to ensure performance is sufficient and they notice a slight increase in run time, but it’s still within acceptable limits.
- The workload's overall cost is reduced by using the consumption plan as they only incur costs when the job is executing.

## Optimize your high availability design

**Prioritize deployment of active-active or active-only over active-passive models, as part of your recovery plan, if you already paid for the resources.**

If your design defaults to using active-passive models, you might have idle resources that could otherwise be used. Converting to active-active might enable you to meet your load leveling and scale bursting requirements without overspending. If you can meet your recovery targets with an active-only model, the costs of those resources can be removed completely.

*Contoso's challenge*

- The COTS application uses Azure Database for MySQL Flexible Server configured for same-zone high availability, which provides a standby server in the same availability zone as the primary server. They also have enabled automatic backups.
- The workload's RPO is relatively long at 12 hours, and the RTO is three hours during the school day.
- Based on previous recovery tests, the team knows that they can meet their RPO and RTO targets through automatic failover to the standby server. They have also tested recovering the database from a backup and they can meet the targets in this scenario.

*Applying the approach and outcomes*

- The workload team reevaluates the benefit of the high availability design vs the cost of the service being twice as much as a single instance.
- The team tests building a new instance and recovering a database from backup and they are satisfied that they will still be in compliance with their recovery targets, so they decide to eliminate the standby instance.
- The team updates the DR plan to reflect the new recovery strategy and realize the cost savings through the new configuration.

## Keep your cloud environment clean of unused resources and data

**Regularly and rigorously review deployments for unused resources and data and decommission them.  Over time resources and data that were required for some purpose in the past, but are no longer being used can linger in your cloud environments and unnecessarily accrue costs. Be vigilant about keeping your environments clean to help optimize for cost efficiency.**

Shutting down unused resources and deleting data when you no longer need it reduces waste and frees up funds so you can invest them elsewhere.

*Contoso's challenge*

- The university has historically taken a conservative approach to decommissioning solutions, fearing that they may need to revert to a prior configuration. This cautiousness has led to having abandoned services running in one or more environments for months that have been forgotten about in some cases.
- When abandoned services are discovered, it is usually by accident as there is no formal process to review the environment for such services.

*Applying the approach and outcomes*

- The team adds decommissioning of the App Service to the backlog as part of the migration from App Service to the consumption hosting for the Durable Function. As part of the next sprint, they will be shutting down the App Service deployments across all environments.
- To help in proactively detecting abandoned resources, the team sets up alerts in Azure Advisor to notify them of unused resources.
- The team implements a new policy that requires the team to do monthly full reviews of pre-production environments and quarterly full reviews of the production environment to identify abandoned resources. Any abandoned resources found will be added to the backlog to decommission.