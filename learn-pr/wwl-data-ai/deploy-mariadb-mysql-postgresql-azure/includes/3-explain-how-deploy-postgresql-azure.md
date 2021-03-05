Just like the Azure SQL offerings, deployment for MariaDB, MySQL, and PostgreSQL is supported using all of the standard Azure methods including the Azure portal, PowerShell, Azure Resource Manager templates, and the Azure CLI. There is limited support for PowerShell cmdlets for these platforms.

## Single database

In the Azure portal, click on Create a Resource on the main portal blade as shown. Search for Azure Database for PostgreSQL and click create. The portal will launch the screen shown below.

Select Single Server or Hyperscale. Hyperscale is typically used for large-scale databases that scale out across multiple nodes. Click the appropriate Create button.

:::image type="content" source="../media/module-22-plan-implement-final-24.png" alt-text="Azure Database for PostgreSQL Creation Page":::

You will supply the Resource Group, Server Name, Region, Version, Username, and Password as shown in the image below.

:::image type="content" source="../media/module-22-plan-implement-final-25.png" alt-text="Configuration Page for Azure Database for PostgreSQL":::

Click on Configure Server. Select the appropriate service tier for your applications and/or workloads as shown in the image below. Click OK.

:::image type="content" source="../media/module-22-plan-implement-final-26.png" alt-text="Creation and Tier Selection for Azure Database for PostgreSQL":::

The image above also shows you that you can configure the amount of storage and properties of the storage.

As mentioned above you can use the Azure CLI to deploy Azure Database for PostgreSQL as shown here.

```azurecli
az postgres server create --resource-group myresourcegroup --name mydemoserver `

--location westus --admin-user myadmin --admin-password <server_admin_password> `

--sku-name GP_Gen4_2 --version 9.6
```

## Azure Database for PostgreSQL Hyperscale

While Hyperscale shares a name with Azure SQL Database and while they both offer horizontal scalability supporting very large data volumes, the Hyperscale technology for PostgreSQL is implemented differently. Hyperscale allows the servers for Azure Database for PostgreSQL (called nodes) to work together in a “shared nothing” architecture design. Nodes are added to a server group, and each server group has a coordinator node, and multiple workers nodes. Applications send their queries to the coordinator node, which relays the query to relevant worker nodes and gathers the results.

Hyperscale databases are sharded, which means that the data in a single table can be split across multiple nodes, using a type of table called a distributed table. This sharding allows for both parallelization and distribution of queries across nodes. The worker nodes and coordinator nodes can be scaled independently of each other.

Creating a Hyperscale PostgreSQL deployment is different than deploying a single instance of the service. In this case, Hyperscale allows you to deploy additional worker nodes along with a coordinator node. You can deploy up to 20 worker nodes by default (this number is a soft limit; for additional nodes, you can contact Microsoft support). You can also configure high availability for each node to ensure that any disruptions have minimal impact on your applications.
