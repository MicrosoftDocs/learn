Software as a Service (SaaS) providers like the fitness company often need to provision a SQL database for each customer; in our case, for each location. As a service provider, you'll need to react to unpredictable workloads, especially when storing customer data. You might not have visibility as to how quickly each client will grow or when demand will spike.

## How are database resources traditionally provisioned?

Traditionally, SaaS providers would either need to over-provision resources to ensure they have capacity for peak demand, which adds cost; or under-provision, which could affect performance during high demand.

## What is a SQL elastic pool?

SQL elastic pools are a resource-allocation service used to scale and manage the performance and cost of a group of Azure SQL databases. Elastic pools allow you to purchase resources for the group. You set the amount of resources available to the pool, add databases to the pool, and set minimum and maximum resource limits for the databases within the pool.

The pool resource requirements are set based on the overall needs of the group. The pool allows the databases within the pool to share the allocated resources. SQL elastic pools are used to manage the budget and performance of multiple SQL databases.

## When to use an elastic pool?

SQL elastic pools are ideal when you have several SQL databases that have a low average utilization, but have infrequent, high utilization spikes. In this scenario, you can allocate enough capacity in the pool to manage the spikes for the group, but the total resources can be less than the sum of all of the peak demand of all of the databases. Because the spikes are infrequent, a spike from one database will be unlikely to affect the capacity of the other databases in the pool.

In our fitness-company scenario, the individual locations might run promotions at different times of year or see spikes in demand during regional holidays.

### How many databases to add to a pool?

The general guidance is that if the combined resources you'd need for individual databases to meet capacity spikes is more than 1.5 times the capacity required for the elastic pool, then the pool will be cost effective.

At a minimum, we recommend adding at least two S3 databases or fifteen S0 databases to a single pool for it to have potential cost savings.

Depending on the performance tier, you can add up to 100 or 500 databases to a single pool.

## Create an elastic pool

SQL elastic pools must be hosted in a SQL server. You'll specify an existing server or create a new server when creating an elastic pool.

Like many Azure resources, elastic pools can be created from the Azure portal, or the Azure CLI running the `az sql elastic-pools create` command, or via PowerShell running the `New-AzSqlElasticPool` command.

In the next unit, you'll complete an exercise to create a SQL elastic pool.

## Add databases to an elastic pool

You can add databases using the Azure portal, the Azure CLI, or PowerShell.

When using the portal, you can add a new pool to an existing SQL server, or you can create a new SQL elastic pool resource and specify the server.

When using the CLI, call `az sql db create` and specify the pool name using the `--elastic-pool-name` parameter. This command can move an existing database into the pool or create a new one if it doesn't exist.

When using PowerShell, you can assign new databases to a pool using `New-AzSqlDatabase` and move existing databases using `Set-AzSqlDatabase`.

You can add existing Azure SQL databases from your Azure SQL server into the pool or create new databases. You can mix service tiers within the same pool.
