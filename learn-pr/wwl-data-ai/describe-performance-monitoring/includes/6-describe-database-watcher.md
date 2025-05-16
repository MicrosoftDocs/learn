One of the benefits of using any of the products part of the Azure SQL family is the monitoring capability that is built into Azure platform. 

[Database watcher](/azure/azure-sql/database-watcher-overview) is a robust monitoring solution designed specifically for [Azure SQL Database](https://azure.microsoft.com/products/azure-sql/database/) and [Azure SQL Managed Instance](https://azure.microsoft.com/products/azure-sql/managed-instance/). This tool provides comprehensive insights into the performance, configuration, and overall health of your databases. It collects detailed monitoring data from various sources, including databases, elastic pools, and SQL managed instances, and ensures that you have a clear and detailed view of your SQL estate.

> [!NOTE]
> Database watcher is currently in preview.

## How database watcher works

One of the key features of Database watcher is its ability to gather and store monitoring data in a central data store within your Azure subscription. This data can then be analyzed using tools like Azure Data Explorer or Real-Time Analytics in Microsoft Fabric, allowing for quick ingestion and analysis of time-series monitoring data.

Database watcher enables you to set targets, datasets, frequency, and retention according to your specific needs. It supports low latency, with data collection and ingestion happening within seconds. This ensures that you always have up-to-date information about your database's performance and health.

This tool also offers a range of dashboards in the Azure portal, providing a single-pane-of-glass view of your entire SQL estate. These dashboards offer detailed insights into each monitored resource, allowing you to quickly identify and address any issues. Additionally, Database Watcher supports parameterized templates for common alert rules, and the ability to create custom alerts, ensuring that you're always notified of critical events.

:::image type="content" source="../media/database-watcher.png" alt-text="Diagram showing database watcher components and data flow from monitored resources to watcher to data store to Azure portal dashboards.":::

Database watcher requires a data store for the monitoring data it collects. You can use a database on an [Azure Data Explorer](/azure/data-explorer/data-explorer-overview) cluster or on a free Azure Data Explorer cluster or you can use a [Real-Time Analytics](/fabric/real-time-intelligence/overview) database in Microsoft Fabric.

## Configure database watcher

Here's a simple guide to configure database watcher for Azure SQL Database and Azure SQL Managed Instance:

1. Go to the Azure portal and sign in with your credentials.

1. In the Azure portal, search for "Database Watchers" and select it. Select **Create**.

1. Select your subscription and resource group. Provide a name, and select the region where you want to deploy the database watcher.

1. On the **Data store** tab, configure the data store for the monitoring data.

1. On the **SQL targets** tab, choose the Azure SQL Database or Azure SQL Managed Instance you want to monitor.

1. Review your configuration settings and select **Create** to deploy the database watcher resource.

To learn more about database watcher, see [Quickstart: Create a database watcher to monitor Azure SQL](/azure/azure-sql/database-watcher-quickstart).