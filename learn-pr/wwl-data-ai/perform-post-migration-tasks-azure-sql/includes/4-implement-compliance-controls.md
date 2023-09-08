Implementing compliance controls after migrating your database is important to ensure that your data remains secure and compliant with relevant regulations. Migrating to a new environment, such as Azure SQL, may introduce new security capabilities and features.

## Explore server and database audit

Azure SQL auditing tracks database events, recording them in an audit log stored within your Azure Storage account, Log Analytics workspace, or Event Hubs. Furthermore, it facilitates the maintenance of regulatory compliance, the analysis of activity patterns, and the detection of deviations that could potentially indicate security violations.

You can define server-level and database-level policies. Server policies automatically cover new and existing databases in Azure. 

- Enabling server auditing triggers auditing for the database, regardless of its individual auditing settings.
- You have the option to enable auditing at the database level, allowing both server and database policies to coexist simultaneously.
- Auditing on read-only replicas is automatically enabled.

It's best not to enable both server auditing and database auditing together, except in the following scenarios::

- You require a distinct storage account, retention period, or Log Analytics workspace for a particular database.

- An audit is needed for a specific database with unique event types or categories distinct from the others on the server.

In all other cases, we recommend that you enable only server-level auditing and keep database-level auditing disabled for all databases.

The default auditing policy for SQL Database includes the following set of action groups:

| Action group | Definition |
|------------|-------------|
|**BATCH_COMPLETED_GROUP** | Audits all the queries and stored procedures executed against the database. |
|**SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP** | This indicates that a principal succeed to log into the database. |
|**FAILED_DATABASE_AUTHENTICATION_GROUP** | This indicates that a principal failed to log into the database. |

To enable auditing for all databases on an Azure SQL server, select **Auditing** in the **Security** section of the main blade for your server.

:::image type="content" source="../media/4-sql-auditing.png" alt-text="Screenshot of auditing option in the Security section of a SQL server.":::

The **Auditing** page allows you to set the audit log destination and also choose whether to track Microsoft support engineer operations on the same log destination as Azure SQL Auditing or select a different one.

:::image type="content" source="../media/4-audit-log-destination.png" alt-text="Screenshot of the Auditing page of a SQL server.":::

You can review the audit logs of Microsoft Support operations in your Log Analytics workspace by running the following query:

```kusto
AzureDiagnostics
| where Category == "DevOpsOperationsAudit"
```

>[!IMPORTANT]
> Azure SQL Database and Azure SQL Managed Instance's auditing services have been fine-tuned for optimal availability and performance. However, it's worth noting that under conditions of exceptionally high activity or significant network congestion, certain audited events may not be logged.

### Audit sensitive labels

When combined with data classification, you can also monitor access to sensitive data. Azure SQL Auditing has been enhanced to include a new field in the audit log called `data_sensitivity_information`.

By logging the sensitivity labels of the data returned by a query, this field provides an easier way to track access to classified columns.

:::image type="content" source="../media/4-sensitive-data.png" alt-text="Screenshot of the Information Protection page from Azure portal.":::

Auditing consists of tracking and recording events that occur in the database engine. Azure SQL auditing simplifies the configuration steps required to enabled it, making it easier to track database activities for SQL Database and SQL Managed Instance.

## Dynamic data masking

[Dynamic Data Masking](/azure/azure-sql/database/dynamic-data-masking-overview) works by obfuscating data in order to limit its exposure. It allows users who don't require access to sensitive information to see the column but not the actual data. Note that Dynamic Data Masking works at the presentation layer, and unmasked data remains visible to highly privileged users.

Dynamic Data Masking offers the advantage of requiring minimal modification to your application or database. You can configure it conveniently through the Azure portal or by using T-SQL.

:::image type="content" source="../media/4-data-masking.png" alt-text="Screenshot of the dynamic data masking T-SQL commands.":::

Both the *PhoneNumber* and *EmailAddress* columns are hidden from the *DDMDemo* user, who only has `SELECT` permission on the table. The user is allowed to see the last four digits of the phone number as it's masked using a *partial function* that replaces all but the last four digits in the column. This masking is considered a custom function. In addition to T-SQL, if you are using Azure SQL Database, you can create dynamic masking rules in the Azure portal.

:::image type="content" source="../media/4-data-masking-configuration.png" alt-text="Screenshot of how to add masking rule in Azure portal.":::

For adding a masking rule, navigate to your database in the Azure portal and select **Dynamic Data Masking** in the **Security** section of the main blade for your database.

Dynamic Data Masking supports the following masking patterns that can be used:

| Masking function | Definition | T-SQL example |
|------------|-------------|-------------|
|**Default** | Masks the data in the column without exposing any part of the values to the user. The user would see XXXX for string values, 0 for numbers, and 01.01.1900 for date values. | `ALTER TABLE [Customer] ALTER COLUMN Address ADD MASKED WITH (FUNCTION = 'default()')` |
|**Credit card** | Masks all but the final four characters, allowing users to view the final four digits. This masking can be useful for customer service agents who need to view the last four digits of a credit card number but who do not need to see the entire number. The data is shown in the usual format of a credit card number XXXX-XXXX-XXXX-1234. | `ALTER TABLE [Customer] ALTER COLUMN Address ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX-XXXX-XXXX-",4)')` |
|**Email** | Only the first letter and the trailing domain suffix are not masked; for example, “aXXX@XXXXXXX.com” | `ALTER TABLE [Customer] ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()')` |
|**Number** | This masking format should be used on numeric columns. It shows a random number as the masked value instead of the actual value. With each query, a different number is displayed. | `ALTER TABLE [Customer] ALTER COLUMN [Month] ADD MASKED WITH (FUNCTION = 'random(1, 12)')` |
|**Custom string** | This option allows text to be masked with any value, and to display a custom number of characters at either end of the masked value. If the length of the value being masked is equal to or less than the number of characters which the mask specifies are to be displayed, then only the masked characters are displayed. | `ALTER TABLE [Customer] ALTER COLUMN [PhoneNumber] ADD MASKED WITH (FUNCTION = 'partial(1,"XXXXXXX",0)')` |

To enable users to retrieve unmasked data from the columns for which masking is defined, you need to explicitly grant the `UNMASK` permission.

>[!NOTE]
> It is possible to identify masked data using inference based on the results. If you are using data masking, you should also limit the ability of the user to run ad hoc queries.
>
> For that reason, we recommend to combine dynamic data masking with other security features like auditing, encryption, and row-level security to enhance the protection of sensitive data.

### Use case

Data masking is a simple and lightweight feature, and it is ideal for a number of scenarios, including:

- Mask data from application users who have no direct access to the database.

- Restricting private information for a group of users.

- Provide masked data to external vendors, where you need to protect sensitive information while still preserving the relationships among items in the data.

- Export a copy of your production database to a lower environment for development purposes, using a user who lacks `UNMASK` permission. The exported data will be in a masked format.

### Import and export data

Copying data from a masked column to another table using `SELECT INTO` or `INSERT INTO` results in masked data in the target table.

When a user without `UNMASK` privilege runs SQL Server Import and Export,  the exported data file will contain masked data, and the imported database will contain inactively masked data.
