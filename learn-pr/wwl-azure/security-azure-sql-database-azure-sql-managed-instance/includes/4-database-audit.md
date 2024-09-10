Auditing for Azure Structured Query Language (SQL) Database and Azure Synapse Analytics tracks database events and writes them to an audit log in your Azure storage account, Log Analytics workspace or Event Hubs.

Auditing also:

 -  Helps you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate business concerns or suspected security violations.
 -  Enables and facilitates adherence to compliance standards, although it doesn't guarantee compliance.

## Overview

You can use SQL database auditing to:

 -  Retain an audit trail of selected events. You can define categories of database actions to be audited.
 -  Report on database activity. You can use pre-configured reports and a dashboard to get started quickly with activity and event reporting.
 -  Analyze reports. You can find suspicious events, unusual activity, and trends.

Auditing for Azure SQL Database, Azure Synapse Analytics SQL pools, and Azure SQL Managed Instance is optimized for availability and performance of the database or instance being audited. During periods of very high activity or high network load, the auditing feature may allow transactions to proceed without recording all of the events marked for auditing.

Shown below is the configuration of auditing using the Azure portal.

:::image type="content" source="../media/azure-database-auditing-baa1d767.png" alt-text="Screenshot showing an example of an auditing configuration using the Azure portal.":::


## Auditing limitations

 -  Enabling auditing on a paused Azure Synapse SQL pool isn't supported. To enable auditing, resume the Synapse SQL pool.
 -  Enabling auditing by using User Assigned Managed Identity (UAMI) isn't supported on Azure Synapse.
 -  Auditing for Azure Synapse SQL pools supports default audit action groups only.
 -  When you configure auditing for a logical server in Azure or Azure SQL Database with the log destination as a storage account, the authentication mode must match the configuration for that storage account. If using storage access keys as the authentication type, the target storage account must be enabled with access to the storage account keys. If the storage account is configured to only use authentication with Microsoft Entra ID (formerly Azure Active Directory), auditing can be configured to use managed identities for authentication.

## Remarks

 -  Premium storage with BlockBlobStorage is supported. Standard storage is supported. However, for audit to write to a storage account behind a VNet or firewall, you must have a general-purpose v2 storage account. If you have a general-purpose v1 or Blob Storage account, upgrade to a general-purpose v2 storage account. For specific instructions see, Write audit to a storage account behind VNet and firewall.
 -  Hierarchical namespace for all types of standard storage account and premium storage account with BlockBlobStorage is supported.
 -  Audit logs are written to Append Blobs in an Azure Blob Storage on your Azure subscription
 -  Audit logs are in .xel format and can be opened with SQL Server Management Studio (SSMS).
 -  To configure an immutable log store for the server or database-level audit events, follow the instructions provided by Azure Storage. Make sure you have selected Allow additional appends when you configure the immutable blob storage.
 -  You can write audit logs to an Azure Storage account behind a VNet or firewall.
 -  For details about the log format, hierarchy of the storage folder, and naming conventions, see the Blob Audit Log Format Reference.
 -  Auditing on Read-Only Replicas is automatically enabled.
 -  When using Microsoft Entra authentication, failed logins records don't appear in the SQL audit log. To view failed login audit records, you need to visit the Microsoft Entra admin center, which logs details of these events.
 -  Logins are routed by the gateway to the specific instance where the database is located. With Microsoft Entra logins, the credentials are verified before attempting to use that user to sign into the requested database. In the case of failure, the requested database is never accessed, so no auditing occurs. With SQL logins, the credentials are verified on the requested data, so in this case they can be audited. Successful logins, which obviously reach the database, are audited in both cases.
 -  After you've configured your auditing settings, you can turn on the new threat detection feature and configure emails to receive security alerts. When you use threat detection, you receive proactive alerts on anomalous database activities that can indicate potential security threats.
 -  After a database with auditing enabled is copied to another logical server, you may receive an email notifying you that the audit failed. This is a known issue and auditing should work as expected on the newly copied database.
