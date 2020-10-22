Elastic pools are a deployment option in which you purchase Azure compute resources (CPU, memory, and storage) that is then shared among multiple databases defined as belonging to the same pool. An easy comparison to an on-premises SQL Server is that an elastic pool is like a SQL Server instance that has multiple user databases. By using elastic pools, you can easily manage pool resources while at the same time potentially saving costs. Elastic pools also facilitate easy scalability up to the set limits such that if a single database within the pool needs resources due to an unpredictable workload, the resources are there. If the entire pool needs additional resources, a simple slider option within the Azure portal will facilitate scaling the elastic pool up or down.

## Creating new pools

Creating new SQL elastic pools from the Azure portal is straightforward. From the portal, click “Create a Resource” and then search for “SQL Elastic database pool” and you will see the screen shown below.

:::image type="content" source="../media/module-22-plan-implement-final-16.png" alt-text="The Create Elastic Pool screen in the Azure portal":::

Click “Create” shown in the image above in order to launch the screen shown in the image below.

:::image type="content" source="../media/module-22-plan-implement-final-17.png" alt-text="Elastic Pool Creation in Azure portal":::

## Adding a database to an existing pool

Using the Azure portal, locate the pool to which you are adding a database, as showing in the image below.

:::image type="content" source="../media/module-22-plan-implement-final-18.png" alt-text="Adding a Database to an Elastic Pool in Azure portal":::

The image below shows the process for selecting which database(s) you wish to add to the pool.

:::image type="content" source="../media/module-22-plan-implement-final-19.png" alt-text="Elastic Pool database addition":::

Click Apply on the screen shown in the image below.

:::image type="content" source="../media/module-22-plan-implement-final-20.png" alt-text="The Final Screen to add a database to an elastic pool":::

Click Apply one more time and the database will be added to the elastic pool.

## Managing pool resources

The Azure portal delivers a wealth of information regarding the state and health of the elastic pool. You can view resource utilization and see which database is consuming the most resources. This information can be helpful for diagnosing performance issues or identity a database that might not be a good fit for the pool, such as when one database is consuming the vast majority of pool resources. The image below shows an elastic pool with even resource utilization.

:::image type="content" source="../media/module-22-plan-implement-final-21.png" alt-text="The Resource Utilization of an Elastic Pool":::

If you need to adjust the pool to decrease or increase resources allocated to the pool, you can make that change via the Configure option in the Settings section of the Elastic Pool management blade.

From that blade, you can quickly and easily adjust:

- Pool size including DTUs, vCores, and storage size.

- Service Tier

- Resources per database

- Which databases are included in the pool, by adding or removing them.

As shown in the image below, you can adjust numerous settings in the Elastic Pool. Many of these changes can be made online, including the min and max DTUs or vCores per database. You can change the size of total size of the pool or add and remove databases from the pool as needed. Active connections will be dropped as the resizing completes.

:::image type="content" source="../media/module-22-plan-implement-final-22.png" alt-text="The Azure portal page showing Elastic Pool Configuration":::

Probably the most useful feature is the ability to monitor Database Resource Utilization, as shown in the image below. This feature allows you to easily see how databases are performing within the pool.

:::image type="content" source="../media/module-22-plan-implement-final-23.png" alt-text="Utilization per database in an Elastic Pool from the Azure portal":::

An elastic pool is a good fit for multi-tenant databases where each tenant has its own copy of the database. Balance the workload across databases so as not to allow one database to monopolize all the pool’s resources.
