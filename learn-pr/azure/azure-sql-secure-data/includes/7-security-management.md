After your Azure SQL Database is secured on the networking, authentication, and data protection levels, the final step is to understand how you're going to manage security on an ongoing basis. Managing security includes auditing, monitoring, and data classification.

## Auditing

Auditing can help you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations. In this activity, you'll set up auditing at the server level, though it's also available at the database level.

As an alternative to SQL Server audit, Azure SQL Database has *Azure SQL auditing*. It's powered by SQL Server audit and, like SQL Server, it supports Audit Action Groups and Actions. The auditing feature tracks database and server events and writes events to an audit log in either Azure storage, Log Analytics, or to an Azure Event Hub. If you point to an Azure Blob storage account, you can store and analyze your results in XEvents files. With Log Analytics, you unlock the ability to query your logs with Kusto Query Language (KQL) and take advantage of the Log Analytics auditing dashboards.

### Configure auditing

In an earlier exercise for deploying SQL Database, you set up auditing at the server level, but it's also available at the database level. In a future exercise, you'll see how to access and utilize the files that are sent to Azure Blob storage, KQL, and the Log Analytics dashboards.

1. In the [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true) search bar, enter **Log analytics**, and then select **Log Analytics workspaces** from the results. The **Log Analytics workspaces** pane appears.

1. Select **Create**. The **Create Log Analytics workspace** menu appears.
  
1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown list, select <rgn>[Sandbox resource group]</rgn> |
    | **Instance Details** |
    | Name | Enter *azuresql-la* |
    | Region | Select a location closest to you from the following list |

    [!INCLUDE [](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)] 

1. Select **Review + create**, wait until your inputs have been validated, and then select **Create**. Wait until the resource is deployed.
  
1. Select **Go to resource**. The **Overview** pane for your Log Analytics workspace appears.

1. In the Azure portal, go to your **AdventureWorks** SQL Database.

1. On the menu, under **Security**, select **Auditing**. Review the options.

    You can apply auditing at the server level, which applies to all databases within the Azure SQL Database logical server. If you also apply auditing at the database level (which you will do in this unit), both audits occur in parallel; one does not override the other.

1. Select the slide toggle to **Enable Azure SQL Auditing**.

1. Select the  **Storage** check box, and then complete the required fields.
     - For **Subscription**, from the dropdown list, select the *Concierge Subscription*.
     - For **Storage Account**, from the dropdown list, select the account that starts with **sqlva** followed by a random string of letters and numbers.
     - **Storage Authentication Type** can be left as the default **Storage Access Keys** option.

   The **sqlva** storage account will be used to collect XEvent log files, which are saved as a collection of blob files within a container named **sqldbauditlogs**. In a later activity, you'll review the container to learn how log files differ from Log Analytics.

    > [!TIP]
    > If you do not see any storage accounts, create a new account. You may need to refresh your page after a couple minutes before it shows up.  

    If you are going to be auditing your production environment, consider having a separate storage account for audit logs.

1. Select **Advanced properties** to expand the section and set the following configuration items:
    - For **Retention (Days)**, enter **7**
    - For **Storage access key**, select **Primary**.

    > [!NOTE]
    > If you do not see an **Advanced properties**, select **Save** from the command bar, and then repeat the configuration instructions for this page.  

1. Select the **Log Analytics** check box, and then complete the required fields.
    - For **Subscription**, select the Concierge Subscription from the dropdown list.
    - For **Log Analytics**, select the Log Analytics workspace you created earlier in this exercise (*asuresql-la*).

1. Select **Save**.  

    It may take a few minutes for the configuration to process.

You've now enabled auditing for a storage account and an Azure Log Analytics workspace. Later, you'll dive deeper into the auditing capabilities in Azure SQL. You'll see how to analyze the audit logs to view all the changes you've made throughout the module, as well as some other interesting use cases.  

## Ledger for Azure SQL Database

The [ledger feature](/sql/relational-databases/security/ledger/ledger-overview) provides tamper-evidence, cryptographic proof of data integrity capabilities in your database. This proof can help streamline the auditing process.

Ledger helps protect data from any attacker or high-privileged user, including database administrators (DBAs), system administrators, and cloud administrators. As with a traditional ledger, the feature preserves historical data. When data is modified by a transaction in a ledger table, the event is cryptographically SHA-256 hashed using a Merkle tree data structure that creates a root hash representing all rows in the transaction. The transactions that the database processes are then also SHA-256 hashed together through a Merkle tree data structure. The result is a root hash that forms a block. The block is then SHA-256 hashed through the root hash of the block, along with the root hash of the previous block as input to the hash function. That hashing forms a blockchain. If a row is updated in the database, its previous value is maintained and protected in a history table. Ledger provides a chronicle of all changes made to the database over time.

Ledger functionality is introduced to tables in two forms:

- Updatable ledger tables, which allow you to update and delete rows in your tables.
- Append-only ledger tables, which only allow insertions to your tables.

Both updatable ledger tables and append-only ledger tables provide tamper-evidence and digital forensics capabilities.

### Exercise using ledger for Azure SQL Database

In the exercise to create the Azure SQL Database, we added a database called `myLedgerDatabase`, and created a table called `Account.Balance`. In this exercise, we're going to insert data, make updates to the data, and query the history table and ledger views to see the tracking that is taking place and the relationship between the tables.

1. Open SSMS and connect to your Azure SQL Database logical server.
1. Open a **New Query** for the `myLedgerDatabase` database.

1. Insert the name `Nick Jones` as a new customer with an opening balance of $50.

   ```sql
   INSERT INTO [Account].[Balance]
   VALUES (1, 'Jones', 'Nick', 50);
   ```

1. Insert the names `John Smith`, `Joe Smith`, and `Mary Michaels` as new customers with opening balances of $500, $30, and $200, respectively.

   ```sql
   INSERT INTO [Account].[Balance]
   VALUES (2, 'Smith', 'John', 500),
   (3, 'Smith', 'Joe', 30),
   (4, 'Michaels', 'Mary', 200);
   ```

1. View the `[Account].[Balance]` updatable ledger table, and specify the [GENERATED ALWAYS](/sql/t-sql/statements/create-table-transact-sql#generate-always-columns) columns added to the table.

   ```sql
   SELECT [CustomerID]
	  ,[LastName]
	  ,[FirstName]
	  ,[Balance]
      ,[ledger_start_transaction_id]
      ,[ledger_end_transaction_id]
      ,[ledger_start_sequence_number]
      ,[ledger_end_sequence_number]
    FROM [Account].[Balance];  
   ```
   In the results window, you'll first see the values inserted by your T-SQL commands, along with the system metadata that's used for data lineage purposes.

   - The `ledger_start_transaction_id` column notes the unique transaction ID associated with the transaction that inserted the data. Because `John`, `Joe`, and `Mary` were inserted by using the same transaction, they share the same transaction ID.
   - The `ledger_start_sequence_number` column notes the order by which values were inserted by the transaction.

1. Update `Nick`'s balance from `50` to `100`.

   ```sql
   UPDATE [Account].[Balance] SET [Balance] = 100
   WHERE [CustomerID] = 1;
   ```

1. View the `[Account].[Balance]` ledger view, along with the transaction ledger system view to identify users that made the changes.

    ```sql
  	SELECT
	t.[commit_time] AS [CommitTime] 
	, t.[principal_name] AS [UserName]
	, l.[CustomerID]
	, l.[LastName]
	, l.[FirstName]
	, l.[Balance]
	, l.[ledger_operation_type_desc] AS Operation
	FROM [Account].[Balance_Ledger] l
	JOIN sys.database_ledger_transactions t
	ON t.transaction_id = l.ledger_transaction_id
	ORDER BY t.commit_time DESC;
    ```

    `Nick`'s account balance was successfully updated in the updatable ledger table to `100`.  
    The ledger view shows that updating the ledger table is a `DELETE` of the original row with `50`. The balance with a corresponding `INSERT` of a new row with `100` shows the new balance for `Nick`.

## Monitoring

There are two aspects to monitoring and managing security:

- The Azure level
- The database or server level

In Azure, you can apply tools such as activity logs and role-based access control auditing.

In your Azure SQL Database, you can configure Azure SQL auditing and apply dynamic management views, metrics, and alerts to monitor security-related events. For example, `sys.event_log` will allow you to track the number of failed and successful connections and the number of connections blocked by the firewall.  

Microsoft recommends that you configure [Microsoft Defender for Cloud](/azure/azure-sql/database/azure-defender-for-sql), including setting up alerts for Advanced Threat Protection. These security elements are discussed in the next section and exercise. Finally, you can use Microsoft Defender for Cloud to monitor, manage, and receive recommendations on all the resources in your Azure estate.

### Data Discovery & Classification

The Data Discovery & Classification service forms a new information-protection paradigm for Azure SQL Database. The service is aimed at protecting the data and not just the database. This paradigm includes:

- Discovery and recommendations for potentially sensitive data that should be classified
- The ability to persistently add labels to columns by using metadata attributes
- The ability to audit and query sensitive data access

Azure SQL offers both SQL Information Protection policy and Microsoft Information Protection policy in data classification, and you can choose either of these two policies based on your requirement.

The portal view is available only for Azure SQL, but SQL Server supports similar functionality through a wizard in SQL Server Management Studio.

For more information, see [Data Discovery & Classification](/azure/azure-sql/database/data-discovery-and-classification-overview).

### Microsoft Defender for Cloud

Microsoft Defender for Cloud is a unified package for advanced SQL security capabilities. It provides a single go-to location for enabling and managing two main capabilities:  

- Vulnerability Assessment
- Advanced Threat Protection

#### Vulnerability Assessment

At the highest level, SQL Vulnerability Assessment is a scanning service that provides visibility into your security state and then provides actionable steps to address any potential concerns. When you configure periodic recurring scans, you're enabling the service to scan your databases every seven days and check for any vulnerabilities. You can then choose to send those reports to the admins, subscription owners, or anyone else who might need to be notified of changes. For this service to operate, you have to specify a storage account where the results will be stored.

#### Advanced Threat Protection

With Advanced Threat Protection, you can detect and respond to potential threats as they occur by receiving security alerts on anomalous activities. Advanced Threat Protection applies advanced monitoring and machine learning technologies to detect whether any of the following threats have occurred:

- SQL injection
- SQL injection vulnerability
- Data exfiltration
- Unsafe action
- Brute force attempt
- Anomalous client login

In the next two exercises, you'll dive into the capabilities and scenarios that Microsoft Defender for Cloud, and Azure SQL in general, enables and protects against.

#### Row-level Security

Row-Level Security enables you to use group membership or execution context to control access to rows in a database table.

Row-Level Security (RLS) helps you implement restrictions on data row access. For example, you can ensure that workers access only those data rows that are pertinent to their department. Another example is to restrict customers' data access to only the data relevant to their company.

The access restriction logic is located in the database tier rather than away from the data in another application tier. The database system applies the access restrictions every time that data access is attempted from any tier. This makes your security system more reliable and robust by reducing the surface area of your security system.

RLS supports two types of security predicates.

- Filter predicates silently filter the rows available to read operations (SELECT, UPDATE, and DELETE)
- Block predicates explicitly block write operations (AFTER INSERT, AFTER UPDATE, BEFORE UPDATE, BEFORE DELETE) that violate the predicate
