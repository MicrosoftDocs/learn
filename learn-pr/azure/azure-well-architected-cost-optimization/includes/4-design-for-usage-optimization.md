| :::image type="icon" source="../media/goal.svg"::: Get the most out of your tools and operations. Make sure they meet both functional and nonfunctional requirements of the solution. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Different services come with different features and price points. After you pick a plan, don't let those features go to waste. Find ways to use them fully and get your money's worth. Also, keep an eye on your billing models. It's smart to check if there's a better billing model that fits how you're actually using the service.

**Example scenario**

Contoso University hosts a commercial off-the-shelf (COTS) system that helps faculty manage courses and lets students register. It's connected to a cloud-based education management system that they plan to fully switch to in a few years. For now, they want to optimize costs on the custom integration parts.

The technology solution of the COTS offering is generally treated like a black box, except for its database, which runs on Azure Database for MySQL. The custom integration is an Azure durable function that runs fanned out on a Standard Azure App Service plan that used to host the university's website, but doesn't anymore. The durable function is a Python app that uses Azure Storage. It syncs data every night from the MySQL database to the cloud-based API.

## Use the full value of your resources

**Buy only what you need, and use everything that you're paying for.**

Some resource SKUs come with built-in features for performance, security, or reliability. If you're paying for them, make sure you're using them. And if you don't need those features, pick a simpler SKU to save money.

*Contoso's challenge*

- The durable function runs on a Standard App Service plan that was originally sized for a public website, but that website has since been retired.

- The team never re-evaluated the SKU, so they're still paying for features and capacity that they don't use.
- They're unsure which features are actually needed for the integration workload.

*Applying the approach and outcomes*

- The team reviews the current App Service plan and concludes that the integration doesn't require the same level of scalability or performance and can be supported by a lower-tier configuration.

- They move the function to a lower-tier plan that still supports durable functions but costs much less.
- They also check their MySQL SKU and confirm that it's rightsized for the current workload.
- These changes help them reduce costs without affecting performance or reliability.

## Optimize your high availability design

**Prioritize deployment of active-active or active-only over active-passive models, as part of your recovery plan, if you already paid for the resources.**

If your design defaults to using active-passive models, you might have idle resources that could otherwise be used. Converting to active-active might enable you to meet your load leveling and scale bursting requirements without overspending. If you can meet your recovery targets with an active-only model, the costs of those resources can be removed completely.

*Contoso's challenge*

- The COTS application uses Azure Database for MySQL Flexible Server configured for same-zone high availability, which provides a standby server in the same availability zone as the primary server. They also have enabled automatic backups.

- The workload's recovery point objective (RPO) is relatively long at 12 hours, and the recovery time objective (RTO) is three hours during the school day.
- Based on previous recovery tests, the team knows that they can meet their RPO and RTO targets through automatic failover to the standby server. They have also tested recovering the database from a backup and they can meet the targets in this scenario.

*Applying the approach and outcomes*

- The workload team reevaluates the benefit of the high availability design versus the cost of the service being twice as much as a single instance.

- The team tests building a new instance and recovering a database from backup and they're satisfied that they will still be in compliance with their recovery targets, so they decide to eliminate the standby instance.
- The team updates the disaster recovery plan to reflect the new recovery strategy and realize the cost savings through the new configuration.

## Scale smart with demand

**Adjust capacity based on what you actually need.**

Instead of provisioning for peak usage all the time, scale up when demand increases and scale down when it drops. This approach keeps your costs aligned with real usage.

*Contoso's challenge*

- The integration function runs every night, but the App Service plan always stays active.

- They're paying for compute resources that sit idle most of the day.
- They haven't explored options for scaling down or pausing the service when it's not in use.

*Applying the approach and outcomes*

- The team configures the App Service plan to scale down during off-hours.

- They explore moving the function to Azure Container Apps or the Azure Functions Consumption plan, which can scale to zero.
- They also set up alerts to monitor usage and adjust scaling rules as needed.
- These changes help them align costs with actual usage and reduce waste.
