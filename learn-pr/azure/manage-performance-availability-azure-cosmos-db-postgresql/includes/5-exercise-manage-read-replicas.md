Woodgrove Bank has expanded their audience to Europe. They have a team in Europe that wants to run analytics on the data. Since their analysis is read-heavy, we're going to create a read replica in Europe for them.

> [!IMPORTANT]
> This exercise relies on the Azure Cosmos DB for PostgreSQL database created in the Scale and Rebalance exercise in this module.

## Create a read replica

1. Navigate to the Azure Cosmos DB for PostgreSQL resource in the Azure portal.
1. From the navigation, under **Cluster management**, select **Replicate data globally**.
1. On the **Replicate data globally** screen, select **Add replica**.

    :::image type="complex" source="../media/replication-add-replica.png" alt-text="Screenshot of the Replicate data globally screen for the resource.":::
        Screenshot of the Replicate data globally screen for the Azure Cosmos DB for PostgreSQL Cluster resource. 'Replicate data globally' in the navigation menu and 'Add replica' are highlighted.
    :::image-end:::

1. On the PostgreSQL server group replica screen, enter the following settings:
    * **Cluster name**: Enter a cluster name for the read replicas.
    * **Subscription**: Confirm this subscription is the desired subscription.
    * **Resource group**: Confirm this resource group is the desired resource group.
    * **Location**: Select a desired region. This location doesn't need to match the region where your primary server group is located.
    * **Scale**: Make note of the compute and storage allocation. Be aware of the price.

    :::image type="complex" source="../media/create-read-replica.png" alt-text="Screenshot of the Add cluster replica dialog.":::
        Screenshot of the Add cluster replica dialog. Cluster name is for the read-only replicas. The Scale shows the number of nodes, the compute + storage resources, and an estimated cost per month. The estimated cost in the screenshot is a placeholder for price.
    :::image-end:::

1. Select **OK**. Once the replicas are created and available, you should see the replicas listed in the **Replicas** section on the primary server group's **Replicate data globally** screen.

    :::image type="content" source="../media/replication-read-replicas.png" alt-text="Screenshot of the Replicate data globally screen for the learn-cosmosdb-postgresql primary server group. learn-cosmosdb-postgresql is in eastus, and the read replica learn-cosmosdb-postgresql-eur is in westeurope.":::

## Get the connection string for the read replica

Once the read replica cluster has been created, you can get the connection string for the European analytics team to use with their reporting tools.

1. Navigate to the read replica cluster by going to the primary cluster, select **Replicate data globally** from the **Cluster management** navigation. Under the **Replicas** section, select the name of the replica you created.

1. On the read replica's resource page, select **Connection strings**. This section is where you find connection strings for various platforms including general PostgreSQL drivers, psql, JDBC, Node.js, Python, Ruby, PHP, C++, and ADO.NET

## Delete the replica

There's a **Delete** option on the table row for each replica when reviewing the replicas in the **Replicate data globally** screen, from either the source cluster or the read replicas. Select the **Delete** option in order to delete the replica.
