Imagine you receive an alert from your company's security administrator that a potential security breach has been detected on your network. It's suspected that an unauthorized individual may have accessed your database through malicious activity. How would you track this down? You know you need to be actively monitoring your database for suspicious activity, but what can you do to not only gain visibility into what's happening in your database, but to also prevent malicious activity from occurring?

Azure SQL Database has built-in features that can help you track what's happening in your database, and will monitor and alert you if malicious activity is identified.

## Azure SQL Database auditing

By enabling auditing, operations that occur on the database are stored for later inspection or to have automated tools analyze them. Auditing is also used for compliance management or understanding how your database is used. Auditing is also required if you wish to use Azure threat detection on your Azure SQL database.

You can use SQL database auditing to:

- Retain an audit trail of selected events. You can define categories of database actions to be audited.
- Report on database activity. You can use pre-configured reports and a dashboard to get started quickly with activity and event reporting.
- Analyze reports. You can find suspicious events, unusual activity, and trends.

Audit logs are written to Append Blobs in an Azure Blob storage account that you designate. Audit policies can be applied at the server-level or database-level. Once enabled, you can use the Azure portal to view the logs, or send them to Log Analytics or Event Hubs for further processing and analysis.

## Auditing in practice

As a best practice, avoid enabling both server blob auditing and database blob auditing together, unless:

- You want to use a different storage account or retention period for a specific database.
- You want to audit event types or categories for a specific database that differs from the rest of the databases on the server. For example, you might have table inserts that need to be audited but only for a specific database.

Otherwise, it's recommended you enable only server-level blob auditing and leave the database-level auditing disabled for all databases.

Let's look at the steps you take to set up auditing on your system.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the search bar at the top of the portal, search for **serverNNNN** (replacing `NNNN` with the number from your server name), then select the server in the portal.

1. In the left menu pane, under **Security**, select **Auditing**.

1. Auditing is turned off by default. To enable it on your database server, toggle **Enable Azure AQL Auditing** to **ON**.

1. After the ON button is selected, select the **Storage** checkbox.

1. Select your subscription. You can select an existing storage account, or create a new storage account to store your audits. The storage account must be configured to use the same region as your server. In this case, we'll define a new storage account. Under **Storage account**, select **Create new**. The **Create storage account** pane displays. Name the storage account `serverNNNNauditing`, replacing the `NNNN` with the number from your logical server name. Leave the rest of the options at their defaults, and select **OK**. Back in the **Storage settings** pane, leave the defaults, and select **OK**.

1. Select **Save** in the toolbar to save your changes and enable auditing on your database server.

Now let's generate some audit records and take a look at what you can expect.

1. Let's log back in to the database as the _ApplicationUser_ user.

    ```bash
    sqlcmd -S tcp:serverNNNN.database.windows.net,1433 -d marketplaceDb -U 'ApplicationUser' -P '[password]' -N -l 30
    ```

1. Run the following query.

    ```sql
    SELECT FirstName, LastName, EmailAddress, Phone FROM SalesLT.Customer;
    GO
    ```

1. Back in the portal on your SQL server, select **SQL databases** in the left menu pane, and select the _marketplace_ database.

1. In the left menu pane on your _marketplace_ database, under **Security**, select **Auditing**.

1. Because we enabled auditing at the server-level, you should see that it's enabled here. Select **View audit logs** in the top menu bar to view the logs.

1. You should see one or more audit records with **PRINCIPAL NAME** of _ApplicationUser_ and **EVENT TYPE** of **BATCH COMPLETED**. One of them should contain the details of the query you executed. You might also see other events such as authentication failures and success. Select any record to see the full details of the event.

![An example showing an event in the audit log.](../media/5-audit-log.png)

These actions configure the audits at the database server level, and will apply to all databases on the server. You can also configure auditing at a database level.

Let's take a look at another feature that uses these logs to increase the security of your database.

## Advanced Data Security for Azure SQL Database

Advanced Data Security (ADS) provides a set of advanced SQL security capabilities, including data discovery & classification, vulnerability assessment, and Advanced Threat Protection.

- **Data discovery & classification** (currently in preview) provides capabilities built into Azure SQL Database for discovering, classifying, labeling & protecting the sensitive data in your databases. It can be used to provide visibility into your database classification state, and to track the access to sensitive data within the database and beyond its borders.
- **Vulnerability assessment** is an easy to configure service that can discover, track, and help you remediate potential database vulnerabilities. It provides visibility into your security state, and includes actionable steps to resolve security issues, and enhance your database fortifications.
- **Advanced Threat Protection** detects anomalous activities indicating unusual and potentially harmful attempts to access or exploit your database. It continuously monitors your database for suspicious activities, and provides immediate security alerts on potential vulnerabilities, SQL injection attacks, and anomalous database access patterns. Advanced Threat Protection alerts provide details of the suspicious activity and recommend action on how to investigate and mitigate the threat.

### Setup and configuration

Let's enable ADS on our database. ADS is a server-level setting, so we'll start there.

1. Back in the portal, go to your SQL server. In the search bar at the top of the portal, search for **serverNNNN**, and then select the server.

1. In the left menu pane, under **Security**, select **Microsoft Defender for Cloud**.

1. Select **Enable Microsoft Defender for SQL**.

1. Select **Configure** next to the message **Enabled at the subscription-level**. The **Server settings** pane displays.

1. **Periodic recurring scans** is on by default. When a weekly scan is triggered, a scan result summary is sent to the email address you provide. In this case, we'll turn this off. **Also send email notification to admins and subscription owners** is enabled by default to send the threats to the service administrators. Select **Save** at the top to save your settings.

1. Under **Advanced Threat Protection Settings**, select **Add your contact details...** to open the Defender for Cloud **Email notifications** pane. Here, you can optionally define where notification emails will be delivered for both the vulnerability assessment and Advanced Threat Protection as a list of semicolon separated email addresses. **Also send email notification to admins and subscription owners** is enabled by default to send the threats to the service administrators.

1. You can also select **Enable Auditing....** to turn on **Azure SQL Auditing**.

1. Select **Save** to apply the changes.

You'll receive email notifications as vulnerabilities are detected. The email will outline what occurred and the actions to take.

![An example notification warning from Microsoft Defender for Cloud.](../media/5-email-with-warning.png)

### Data discovery & classification

1. Go to your marketplace database. In the search bar at the top of the portal, search for marketplace, and then select the database in the portal.

1. In the left menu pane, under **Security**, select **Data Discovery & Classification**.

The **Classification** tab shows columns within your tables that need to be protected. Some of the columns may have sensitive information or might be considered classified in different countries or regions.

:::image type="content" source="../media/5-azure-sql-database-data-classification.png" alt-text="Screenshot that shows the Classification tab in the Data Discovery and Classification pane." lightbox="../media/5-azure-sql-database-data-classification.png":::

A message appears if any columns need protection configured. This message will be formatted like *15 columns with classification recommendations*. You can select the text to view the recommendations.

Select the columns that you want to classify by selecting the checkmark next to the column, or select the checkbox to the left of the schema header. Select the **Accept selected recommendations** button to apply the classification recommendations.

Next, you'll edit the columns and then define the information type and the sensitivity label for the database. Select **Save** to save the changes.

No active recommendations should be listed once you've managed the recommendations successfully.

### Security vulnerabilities

In the left menu pane, under **Security**, select **Microsoft Defender for Cloud**.

The **Recommendations** section lists configuration issues on your database and the associated risk.

Select a recommendation. On the recommendation pane, you'll see the details, such as the risk level, which database it applies to, a description of the vulnerability, and the recommended remediation to fix the issue. Apply the remediation to fix the issue or issues. Make sure to address all the vulnerabilities.

### Security incidents and alerts

This section displays a list of detected threats.

Address any issues by following the recommendations. For issues such as the SQL injection warnings, you'll be able to look at the query and work backward to where the query is being executed in code. Once found, you should rewrite the code so it will no longer have the issue.
