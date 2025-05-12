| :::image type="icon" source="../media/goal.svg"::: Get the most out of your tools and operations. Make sure they meet both functional and nonfunctional requirements of the solution. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Different services come with different features and price points. After you pick a plan, don't let those features go to waste. Find ways to use them fully and get your money's worth. Also, keep an eye on your billing models. It's smart to check if there's a better billing model that fits how you're actually using the service.

**Example scenario**

Contoso University hosts a commercial off-the-shelf (COTS) system that helps faculty manage courses and lets students register. It's connected to a cloud-based education management system that they plan to fully switch to in a few years. For now, they want to optimize costs on the custom integration parts.

The technology solution of the COTS offering is generally treated like a black box, except for its database, which runs on Azure Database for MySQL. The custom integration is an Azure durable function that runs fanned out on a Standard Azure App Service plan that used to host the university's website, but doesn't anymore. The durable function is a Python app that uses Azure Storage. It syncs data every night from the MySQL database to the cloud-based API.

## Use consumption-based pricing when it makes sense

**Some services only charge consumption-based pricing, which means that you only pay for what you use. You can turn the service off when you don't need it and avoid extra costs. That's great for things that you only use now and then, instead of paying for them to run all the time.**

With consumption-based pricing, you only get charged for what you actually use. It's a smart option if your workload doesn't need to run all the time.

*Contoso's challenge*

- The sync job runs every night for about an hour at a set time, and it usually works just fine. Problems are rare, and the current setup handles transient faults well.

- The job only needs compute power for about an hour a day, but they're paying for continuous use. The team started looks for a better setup.

- They thought about writing a script to shut down the service after each run and redeploy it the next day, but that felt too risky and complicated.

*Applying the approach and outcomes*

- After checking the job history, the team finds that the longest run is just under two hours. They compare costs of the dedicated plan to the cost of the Azure Functions consumption plan. They find that even for the worst case scenario, the consumption plan is cheaper.

- They run a performance test and notice that the job took a bit longer, but it was still within acceptable limits.

- In the end, switching to the consumption plan reduces costs because they're only paying when the job is actually running.

## Optimize your high availability design

**If you already paid for resources, it's better to go with active-active or active-only setups instead of active-passive.**

Active-passive can leave some resources sitting idle, which isn't great for your budget. Switching to active-active can help handle traffic spikes without overspending. And if active-only still meets your recovery goals, you might be able to remove those costs entirely.

*Contoso's challenge*

- The COTS app uses Azure Database for MySQL Flexible Server with same-zone high availability, which means there's a standby server ready in the same zone. They also have automatic backups turned on.

- The workload's recovery point objective (RPO) is relatively long at 12 hours, and the recovery time objective (RTO) is three hours during the school day.
- They've tested both automatic failover to the standby server and backup recovery and confirmed that both options meet their targets.

*Applying the approach and outcomes*

- The team takes another look at whether the high availability setup is worth the extra cost. It basically doubles the price of running just one instance.

- They test building a new instance and recovering the database from a backup. Everything works fine and still meets their recovery goals, so they decide to remove the standby instance.
- The team updates the disaster recovery plan to match the new setup and start saving money right away.

## Keep your cloud environment tidy

**Make it a habit to regularly check for unused resources or old data in your cloud setup and clean them out. Over time, these components that were once useful can stick around and quietly accrue costs. Keep your environment clean to help keep things efficient and save money.**

Shutting down resources that you're not using and deleting data that you don't need frees up budget for more important work.

*Contoso's challenge*

- The university has been cautious about shutting down resources, just in case they ever need to roll back to a previous configuration. But that decision has led to some old services being left on for months, sometimes forgotten.

- There's no formal process to review what's still running, so these abandoned services usually only get noticed by accident.

*Applying the approach and outcomes*

- The team adds shutting down the App Service to their to-do list as part of moving the durable function to a consumption-based setup. In the next sprint, they'll shut down those App Service deployments across all environments.

- To catch unused resources early, they set up alerts in Azure Advisor to flag anything that's not being used.
- They also apply a new policy. The team must do a full review of preproduction environments every month and production every quarter. If they find any abandoned resources, they go straight into the backlog to be decommissioned.