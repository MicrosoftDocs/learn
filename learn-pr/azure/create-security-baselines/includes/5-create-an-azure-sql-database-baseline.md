Azure SQL Database is a cloud-based relational database family of products that support many of the same features offered in Microsoft SQL Server. Azure SQL Database provides an easy transition from an on-premises database to a cloud-based database that has built-in diagnostics, redundancy, security, and scalability.

## Azure SQL Database security recommendations

The following sections describe the Azure SQL Database recommendations that are in CIS Microsoft Azure Foundations Security Benchmark v. 3.0.0. Included with each recommendation are the basic steps to complete in the Azure portal. You should complete these steps for your own subscription and by using your own resources to validate each security recommendation.

### Enable auditing - Level 1

Auditing for Azure SQL Database and Azure Synapse Analytics tracks database events and writes them to an audit log in your Azure storage account, Azure Log Analytics workspace, or in Azure Event Hubs. Auditing also:

- Helps you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that might alert you to business concerns or suspected security violations.
- Enables and facilitates adherence to compliance standards, although it doesn't guarantee compliance.

To turn on auditing, complete the following steps for each database in your Azure subscription.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **SQL databases**.

1. In the left menu under **Security**, select **Auditing**.

1. In the **Auditing** pane, enable **Enable Azure SQL Auditing**, and then select at least one audit log destination.

1. If you change any settings, select **Save** in the menu bar.

:::image type="content" source="../media/azure-sql-database/auditing-enable.png" alt-text="Screenshot that shows how to turn on auditing for Azure SQL databases.":::

For more information about auditing, see [Auditing for Azure SQL Database and Azure Synapse Analytics](/azure/azure-sql/database/auditing-overview).

### Enable SQL protections in Microsoft Defender for Cloud - Level 1

Microsoft Defender for Cloud detects anomalous activities that indicate unusual and potentially harmful attempts to access or exploit databases. Defender for Cloud can identify:

- Potential SQL injection.
- Access from an unusual location or datacenter.
- Access from an unfamiliar principal or from a potentially harmful application.
- Brute-force SQL credentials.

You can access and manage SQL threats in the Defender for Cloud menu.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Defender for Cloud**.

1. In the left menu under **Management**, select **Environment settings**.

1. Select your subscription.

1. In the **Defender plans** pane, select **Select types** in the **Databases** row, then set **Azure SQL Databases** to **On**.

1. Select **Continue**.

    :::image type="content" source="../media/azure-sql-database/defender-for-cloud-plans-azure-sql-database.png" alt-text="Screenshot that shows the Defender plans pane with the Azure SQL Databases plan turned on." lightbox="../media/azure-sql-database/defender-for-cloud-plans-azure-sql-database.png":::

1. Return to Azure **Home**. Search for and select **SQL databases**, then select the database you want to view.

1. For each database instance, in the left menu under **Security**, select **Microsoft Defender for Cloud**. View security recommendations, alerts, and vulnerability assessment findings for your SQL Database instance.

### Configure audit retention for more than 90 days - Level 1

Audit logs should be preserved for security and discovery, and to meet legal and regulatory compliance requirements. Complete the following steps for each Azure SQL Database instance in your Azure subscription.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **SQL databases**, then select a database.

1. In the left menu under **Security**, select **Auditing**.

1. Select your **Audit log destination**, and then expand **Advanced properties**.

1. Ensure that **Retention (Days)** is *greater than 90 days*.

1. If you change any settings, select **Save** in the menu bar.

:::image type="content" source="../media/azure-sql-database/auditing-retention.png" alt-text="Screenshot that shows the SQL databases Auditing pane.":::
