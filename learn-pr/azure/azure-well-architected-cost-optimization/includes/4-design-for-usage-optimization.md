| :::image type="icon" source="../media/goal.svg"::: Get the most out of your tools and operations. Make sure they meet both functional and nonfunctional requirements of the solution. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Different services come with different features and price points. After you pick a plan, don’t let those features go to waste. Find ways to use them fully and get your money’s worth. Also, keep an eye on your billing models. It’s smart to check if there’s a better billing model that fits how you’re actually using the service.

**Example scenario**

Contoso University hosts a commercial off-the-shelf (COTS) system that helps faculty manage courses and lets students register. It’s connected to a cloud-based education management system that they plan to fully switch to in a few years. For now, they want to optimize costs on the custom integration parts.

The technology solution of the COTS offering is generally treated like a black box, except for its database, which runs on Azure Database for MySQL. The custom integration is an Azure durable function that runs fanned out on a Standard Azure App Service plan that used to host the university’s website, but doesn’t anymore. The durable function is a Python app that uses Azure Storage. It syncs data every night from the MySQL database to the cloud-based API.

## Use consumption-based pricing when it makes sense

**Some services only charge consumption-based pricing, which means that you only pay for what you use. You can turn the service off when you don’t need it and avoid extra costs. That’s great for things that you only use now and then, instead of paying for them to run all the time.**

With consumption-based pricing, you only get charged for what you actually use. It’s a smart option if your workload doesn’t need to run all the time.

*Contoso's challenge*

- The sync job runs every night for about an hour at a set time, and it usually works just fine. Problems are rare, and the current setup handles transient faults well.

- The job only needs compute power for about an hour a day, but they’re paying for continuous use. The team started looks for a better setup.

- They thought about writing a script to shut down the service after each run and redeploy it the next day, but that felt too risky and complicated.

*Applying the approach and outcomes*

- After checking the job history, the team finds that the longest run is just under two hours. They compare costs of the dedicated plan to the cost of the Azure Functions consumption plan. They find that even for the worst case scenario, the consumption plan is cheaper.

- They run a performance test and notice that the job took a bit longer, but it was still within acceptable limits.

- In the end, switching to the consumption plan reduces costs because they’re only paying when the job is actually running.

## Optimize your high availability design

**If you already paid for resources, it’s better to go with active-active or active-only setups instead of active-passive.**

Active-passive can leave some resources sitting idle, which isn’t great for your budget. Switching to active-active can help handle traffic spikes without overspending. And if active-only still meets your recovery goals, you might be able to remove those costs entirely.

*Contoso's challenge*

- They COTS app uses Azure Database for MySQL Flexible Server with same-zone high availability, which means there’s a standby server ready in the same zone. They’ve also got automatic backups turned on.

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