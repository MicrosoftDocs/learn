Once your Azure SQL Database or Azure SQL Managed Instance is secured on the networking, authentication, and data protection levels, the final step is to understand how you're going to manage security on an ongoing basis. Managing security includes auditing, monitoring, and, in the case of Azure SQL, Advanced data security.

## Auditing

Auditing helps maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations.

Traditional SQL Server Auditing using T-SQL is only available (with some differences) in Azure SQL Managed Instance. The primary differences are:  

* With `CREATE SERVER AUDIT`, you have new syntax `TO URL` and `TO EXTERNAL MONITOR` allow you to specify an Azure Blob storage container and enable Event Hub and Azure Monitor logs target, respectively.  
* `TO FILE`, shutdown option, and `queue_delay=0` are not supported in Azure SQL.

As an alternative to SQL Server Audit, in Azure SQL Database there is *Azure SQL Auditing*. It is powered by SQL Server Audit, and supports Audit Action Groups and Actions, like SQL Server. Azure SQL Auditing tracks database and server events and writes events to an audit log in either Azure Blob storage, Azure Monitor logs (also referred to as Log Analytics), or to an Event hub. If you point to an Azure Blob storage account, you can store and analyze your results in XEvents files. With Log Analytics, you unlock the ability to query your logs with Kusto Query Language (KQL) and leverage the auditing Log Analytics dashboards.

In an earlier exercise, you set up Auditing at the server level, but it is also available at the database level. In a future exercise, you will see how to take access and utilize the files sent to Azure Blob storage, KQL, and the Log Analytics dashboards.

## Monitoring

There are two aspects to monitoring and managing security: the Azure level and the database/server level. In Azure, you can leverage tools like the Activity Logs and RBAC auditing.

In Azure SQL Managed Instance, you can configure SQL Server audit, and the engine can track the failed and successful logins. Failed logins for Azure SQL Managed Instance are also tracked in the ERRORLOG. In Azure SQL Database, you can configure Azure SQL Auditing and leverage DMVs, Metrics, and Alerts in order to monitor security-related events (for example, `sys.event_log` will allow you to track the number of failed and successful connections and the number of connections blocked by the firewall).  

For both services, Microsoft recommends you configure Advanced data security including setting up alerts for Advanced Threat Protection (discussed in the next section and exercise). Finally, you can leverage the Azure Security Center to monitor, manage, and receive recommendations on all the resources in your Azure estate.

## Advanced data security

Advanced data security (ADS) is a unified package for advanced SQL security capabilities, providing a single go-to location for enabling and managing three main capabilities:  

* Data discovery & classification
* Vulnerability assessment
* Advanced Threat Protection

### Data discovery & classification

Data Discovery & Classification forms a new information-protection paradigm for Azure SQL Database and Azure SQL Managed Instance, aimed at protecting the data and not just the database. This paradigm includes discovery and recommendations for potentially sensitive data that should be classified, the ability to persistently add labels to columns using metadata attributes, and the ability to audit and query sensitive data access. The portal view is only available for Azure SQL, but SQL Server supports similar functionality through a wizard in SSMS.

### Vulnerability assessment

At the highest level, SQL Vulnerability Assessment (VA) is a scanning service that provides visibility into your security state. It then provides actionable steps to address any potential concerns. When you configure periodic recurring scans, you're enabling the service to scan your databases every seven days and check for any vulnerabilities. You can then choose to send those reports to the admins, subscription owners, or anyone else that might need to be made notified of changes. In order for this service to operate, you have to specify a storage account for the results to be stored.

### Advanced Threat Protection

Advanced Threat Protection (ATP) enables you to detect and respond to potential threats as they occur by providing security alerts on anomalous activities. ATP leverages advanced monitoring and machine learning technologies to detect if any of the following threats have occurred:

* SQL injection
* SQL injection vulnerability
* Data exfiltration
* Unsafe action
* Brute force attempt
* Anomalous client login

In the next two exercises, you'll dive into the capabilities and scenarios that Advanced data security enables and protects against.
