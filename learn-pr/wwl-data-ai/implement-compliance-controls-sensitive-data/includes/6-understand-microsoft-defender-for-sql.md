Microsoft Defender for SQL offers a suite of protections for Azure SQL Database and Azure SQL Managed Instance as part of the advanced SQL security features, including SQL vulnerability assessment and Advanced Threat Protection. 

## SQL vulnerability assessment

SQL vulnerability assessment is a service that uses a knowledge base of security rules to flag items that don't comply when they're scanned. It checks your database for security best practices, and providing visibility into your security state, such as misconfigurations, excessive permissions, and exposure of sensitive data.

To see recommendations for SQL Database and SQL Managed Instance, you must enable Microsoft Defender for SQL at the subscription level (recommended). You also need to provide a storage account. Alternatively, you can choose to receive emails with a summary of the scan results.

:::image type="content" source="../media/module-33-security-final-23.png" alt-text="Screenshot of Advanced Threat Protection page in Azure portal.":::

The vulnerability assessment feature can detect potential risks in your environment, and help you enhance database security. It also provides insight into your security state and actionable steps to resolve security alerts.

To learn more about SQL vulnerability assessment, see [SQL vulnerability assessment helps you identify database vulnerabilities](/azure/azure-sql/database/sql-vulnerability-assessment).

## Advanced Threat Protection

Advanced Threat Protection monitors the database connections and the queries that are executed in order to detect potentially harmful activities. You can manage and access Advanced Threat Protection via the central Microsoft Defender for SQL portal.

The following threats are supported by Advanced Threat Protection:

| Alerts | Definition |
|------------|-------------|
|**Vulnerability to SQL injection** | This alert looks for T-SQL code coming into your database that may be vulnerable to SQL injection attacks. An example would be a stored procedure call that didn't sanitize user inputs. |
|**Potential SQL injection** | This alert is triggered when an attacker is actively attempting to execute a SQL injection attack. |
|**Access from unusual location** | This alert is triggered when a user logs in from an unusual geographic location. |
|**Access from unusual Azure data center** | This alert is looking for attacks from an Azure data center that isn't normally accessed. |
|**Access from unfamiliar principal** | This alert is raised when a user or applications log on to a database that they haven't previously accessed. |
|**Access from a potentially harmful application** | This alert detects common tools that are used to attack databases. |
|**Brute force SQL credentials** | This alert is triggered when there a high number of log in failures with different credentials. |

To get maximum benefit out of it, you want to enable auditing on your databases. Although it isn't required, enabling auditing allows for deeper investigation into the source of the problem if Advanced Threat Protection detects an anomaly.

The following audit action groups are recommended:

- **BATCH_COMPLETED_GROUP**
- **SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP**
- **FAILED_DATABASE_AUTHENTICATION_GROUP**

## How to enable Microsoft Defender for SQL

You must belong to either the SQL security manager role, or one of the database or server admin role to manage Microsoft Defender for SQL settings.

Enable Microsoft Defender for SQL for SQL Database or SQL Managed Instance from the server main blade by selecting **Microsoft Defender for Cloud**, and then the **(Configure)** link.

:::image type="content" source="../media/module-33-security-final-22.png" alt-text="Screenshot of how to enable Microsoft Defender for SQL.":::

On the **Server settings** page, make sure the **MICROSOFT DEFENDER FOR SQL** property is set to **ON**.

:::image type="content" source="../media/module-33-security-final-24.png" alt-text="Screenshot of the server settings page to enable Microsoft Defender for SQL.":::

Once Microsoft Defender for SQL is enabled, you can view recommendations by selecting **Microsoft Defender for Cloud** on the server blade.

:::image type="content" source="../media/module-33-security-final-25.png" alt-text="Screenshot of Microsoft Defender for SQL recommendations at the server level.":::

Microsoft Defender for SQL provides advanced built-in features to identify and handle threats to the database without the need to be a security expert.
