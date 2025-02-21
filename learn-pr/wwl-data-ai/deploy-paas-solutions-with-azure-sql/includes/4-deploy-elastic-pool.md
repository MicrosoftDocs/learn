Elastic pools are a deployment option in which you purchase Azure compute resources (CPU, memory, and storage) that is then shared among multiple databases defined as belonging to the same pool. An easy comparison to an on-premises SQL Server is that an elastic pool is like a SQL Server instance that has multiple user databases. By using elastic pools, you can easily manage pool resources while at the same time potentially saving costs. Elastic pools also facilitate easy scalability up to the set limits such that if a single database within the pool needs resources due to an unpredictable workload, the resources are there. If the entire pool needs extra resources, a simple slider option within the Azure portal facilitates scaling the elastic pool up or down.

## Creating new elastic pools

Using the Azure portal, search for *“SQL elastic pools”*. Then select **Create** to open the **Create SQL Elastic pool** page.

:::image type="content" source="../media/module-22-plan-implement-final-17.png" alt-text="Screenshot showing the elastic pool page in Azure portal":::

## Adding a database to an existing pool

1. Using the Azure portal, locate the pool to which you're adding a database.

    :::image type="content" source="../media/module-22-plan-implement-final-18.png" alt-text="Screenshot showing how to add a database to an Elastic Pool in Azure portal":::

1. Select **+ Add databases** to add your database to the pool, then select **Apply**.

    :::image type="content" source="../media/module-22-plan-implement-final-20.png" alt-text="Screenshot showing how to select a database to add to an elastic pool":::

    Your database selection is then added to the **Ready to be added to this pool section**. Select **Save**.

## Managing pool resources

The Azure portal provides comprehensive insights into the state and health of your elastic pool. You can monitor resource utilization and identify which database is consuming the most resources. This information is valuable for identifying performance issues or determining if a database isn't well-suited for the pool, especially if one database is using most of the resources.

:::image type="content" source="../media/module-22-plan-implement-final-21.png" alt-text="Screenshot showing the resource utilization page of an elastic pool":::

To adjust the resources allocated to your elastic pool, use the **Configure** option in the **Settings** section of the elastic pool management side menu. You can perform many changes after the creation of an elastic pool.

- Pool size, including DTUs, vCores, and storage size.
- Service tier.
- Resources per database.
- Databases included in the pool, by adding or removing them.

Some changes, such as the minimum and maximum DTUs or vCores per database are performed online. You can also change the total size of the pool or add and remove databases as needed. Active connections are ended as the resizing completes.

One of the most useful features is the ability to monitor database resource utilization. This feature provides an easy way to assess the performance of databases within the pool.

:::image type="content" source="../media/module-22-plan-implement-final-23.png" alt-text="Utilization per database in an Elastic Pool from the Azure portal":::

An elastic pool is a good fit for multitenant databases where each tenant has its own copy of the database. Balance the workload across databases so as not to allow one database to monopolize all the pool’s resources.
