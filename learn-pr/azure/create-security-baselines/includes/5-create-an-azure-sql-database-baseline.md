Azure SQL is a cloud-based relational database family of products that support many of the same features as Microsoft SQL Server. It provides an easy transition from an on-premises database into a cloud-based one with built-in diagnostics, redundancy, security and scalability.

## Azure SQL recommendations

See the following topics for security recommendations to set Azure SQL policies. Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps with your own subscription using your own resources to validate the security for each.

### Enable auditing - Level 1

Auditing for Azure SQL Database and Azure Synapse Analytics tracks database events and writes them to an audit log in your Azure storage account, Log Analytics workspace, or Event Hubs. Auditing also:

- Helps you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate business concerns or suspected security violations.
- Enables and facilitates adherence to compliance standards, although it doesn't guarantee compliance.

To turn on auditing:

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane displays.

1. In the left menu pane, select **Databases**, and then select **SQL Database** from the **Popular services** list. The **Create SQL Database** pane displays.

1. Create an instance of your SQL database.

1. For each database instance, in the left menu pane, under **Security**, select **Auditing**. The **Auditing** pane displays for your SQL database instance.

1. Enable **Enable Azure SQL Auditing**, and then select at least one audit log destination.

    ![Screenshot the SQL Server setting pane.](../media/5-auditing.png)

For more information on auditing, go to [Auditing for Azure SQL Database and Azure Synapse Analytics](/azure/azure-sql/database/auditing-overview).

> [!TIP]
> Remember to select **Save** if you make changes to any of the settings.

### Enable SQL protections in Microsoft Defender for Cloud - Level 1

Defender for Cloud detects anomalous activities indicating unusual and potentially harmful attempts to access or exploit databases. Defender for Cloud can identify:

- Potential SQL injection
- Access from unusual location or data center
- Access from unfamiliar principal or potentially harmful application
- Brute force SQL credentials.

SQL threats can be accessed and managed via the Defender for Cloud menu.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, search for and select **Microsoft Defender for Cloud**.

1. In the left menu pane, under **Management** select **Environment settings**. The **Settings | Defender plans** pane displays.

1. Scroll down, and under **Microsoft Defender for**, turn **Azure SQL Databases** to **On**.

    :::image type="content" source="../media/5-create-an-azure-sql-database-baseline/defender-for-cloud-plans-turn-on-azure-sql-database.png" alt-text="Screenshot that shows the Defender plans pane with the Azure SQL Databases plan turned on." lightbox="../media/5-create-an-azure-sql-database-baseline/defender-for-cloud-plans-turn-on-azure-sql-database.png":::

1. Return to the Azure **home** page. Under **Azure services**, select **Create a resource**. The **Create a resource** pane displays.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the **Popular services** list. The **Create SQL Database** pane displays.

1. Create an instance of your SQL database.

1. In the left menu pane, under **Security**, select **Microsoft Defender for Cloud**. The **Microsoft Defender for Cloud** pane displays for your SQL database instance. Here, you can view security recommendations, alerts, and vulnerability assessment findings.

### Configure audit retention for more than 90 days - Level 1

Audit logs should be preserved for security, discovery, and to meet legal and regulatory compliance.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane displays.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the **Popular services** list. The **Create SQL Database** pane displays.

1. Create an instance of your SQL database.

1. For each database instance, in the left menu pane, under **Security**, select **Auditing**. The **Auditing** pane displays for your SQL database instance.

1. Select your **Audit log destination**, and then expand **Advanced properties**.

1. Ensure **Retention (Days)** is *greater than 90 days*.

    ![Screenshot the SQL Server Auditing pane.](../media/5-auditing2.png)

1. On the top menu bar, select **Save**.
