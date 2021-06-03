Azure SQL Server is a cloud-based relational database server that supports many of the same features as Microsoft SQL Server. It provides an easy transition from an on-premises database into a cloud-based one with built-in diagnostics, redundancy, security and scalability.

## Azure SQL Server recommendations

See the following topics for the security recommendations to set Azure SQL Server policies. Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps on your own subscription with your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Enable auditing - Level 1

Auditing for Azure SQL Database and Azure Synapse Analytics tracks database events and writes them to an audit log in your Azure storage account, OMS workspace or Event Hubs. Auditing also:

- Helps you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate business concerns or suspected security violations.
- Enables and facilitates adherence to compliance standards, although it doesn't guarantee compliance.

To turn on Auditing:

1. Sign in to the Azure portal.

1. On the Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the *Popular services* list. The **Create SQL Database** pane appears.

1. Create an instance of your SQL database.

1. For each DB instance, in the left menu pane, under **Security**, select **Auditing**. The **Auditing** pane appears for your SQL database instance.

1. Ensure that **Enable Azure SQL Auditing** is 'enabled*.

    ![Screenshot the SQL Server setting pane](../media/5-auditing.png)

### Enable a threat detection service - Level 1

Threat detection for single and pooled databases detects anomalous activities indicating unusual and potentially harmful attempts to access or exploit databases. Threat detection can identify Potential SQL injection, Access from unusual location or data center, Access from unfamiliar principal or potentially harmful application, and Brute force SQL credentials. Threat detection is part of the advanced data security (ADS) offering, which is a unified package for advanced SQL security capabilities. Threat detection can be accessed and managed via the central SQL ADS portal.

1. Sign in to the Azure portal.

1. On the Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the *Popular services* list. The **Create SQL Database** pane appears.

1. Create an instance of your SQL database.

1. For each DB instance, in the left menu pane, under **Security**, select **Security Center**. The **Security Center** pane appears for your SQL database instance.

1. Select **View all recommendations in Security Center**.

### Enable all threat detection types - Level 1

Azure SQL Auditing provides a set of advanced SQL security capabilities, including data discovery & classification and vulnerability assessment.

Azure SQL Auditing is part of the advanced data security (ADS) offering, which is part of the defense in depth SQL security strategy. Azure SQL Auditing can be accessed and managed via the portal by selecting **Security** > **Auditing** in the left menu pane.

   ![Screenshot the SQL Server setting pane](../media/5-auditing.png)

### Enable the option to send security alerts - Level 1

You can receive notifications about the detected threats via email notifications or Azure portal.

1. Sign in to the Azure portal.

1. On the Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the *Popular services* list. The **Create SQL Database** pane appears.

1. Create an instance of your SQL database.

1. For each DB instance, in the left menu pane, under **Security**, select **Auditing**. The **Auditing** pane appears for your SQL database instance.

1. Under **Azure SQL Auditing**, ensure **Enable Azure SQL Auditing** is enabled.

### Enable the email service and co-administrators - Level 1

Providing the email address to receive alerts ensures that any detection of anomalous activities is reported as soon as possible, making it more likely to mitigate any potential risk sooner.

1. Sign in to the Azure portal.

1. On the Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the *Popular services* list. The **Create SQL Database** pane appears.

1. Create an instance of your SQL database.

1. For each DB instance, in the left menu pane, under **Security**, select **Auditing**. The **Auditing** pane appears for your SQL database instance.

1. Under **Azure SQL Auditing**, ensure **Enable Azure SQL Auditing** is enabled.

### Configure audit retention for more than 90 days - Level 1

Audit logs should be preserved for security, discovery, and to meet legal and regulatory compliance.

1. Sign in to the Azure portal.

1. On the Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the *Popular services* list. The **Create SQL Database** pane appears.

1. Create an instance of your SQL database.

1. For each DB instance, in the left menu pane, under **Security**, select **Auditing**.

1. Select you Audit log destination, and then select **Configure**.

    ![Screenshot the SQL Server Auditing pane.](../media/5-auditing2.png)

    The **Storage settings** pane appears.

1. Ensure **Retention (days)** is **greater than 90 days**.

1. Select **OK**.

    ![Screenshot the SQL Server Auditing pane again.](../media/5-90days.png)

### Configure threat detection retention for more than 90 days - Level 1

A retention of zero days means logs are kept forever. Otherwise, the value can be any number of days between 1 and 2147483647. You should consider keeping the logs for at least 90 days to be able to go backwards to spot thread patterns.

1. Sign in to the Azure portal.

1. On the Home page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Databases**, then select **SQL Database** from the *Popular services* list. The **Create SQL Database** pane appears.

1. Create an instance of your SQL database.

1. For each DB instance, in the left menu pane, under **Security**, select **Auditing**.

1. Select your audit log destination, and then select **Configure**.

1. Select **Storage Details**.

1. Ensure **Retention (days)** is **greater than 90 days**.

1. Select **OK**.

1. Select **Save**.

    ![Screenshot the SQL Server Auditing pane once more.](../media/5-90days2.png)

    > [!TIP]
    > Remember to select **Save** if you make changes to any of the settings.
