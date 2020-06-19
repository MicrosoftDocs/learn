Once your Azure SQL Database or Azure SQL Managed Instance is secured one the networking, authentication, and data protection levels, the final step is to understand how you're going to manage security on an ongoing basis. This includes auditing, monitoring, and, in the case of Azure SQL, Advanced data security.

## Auditing

Auditing helps maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations.

Traditional SQL Server Auditing using T-SQL is only available (with some differences) in Azure SQL Managed Instance. The primary differences are:  

* With `CREATE AUDIT`, you have new syntax `TO URL` and `TO EXTERNAL MONITOR` allow you to specify an Azure Blob storage container and enable Event Hub and Azure Monitor logs target, respectively.  
* `TO FILE`, shutdown option, and `queue_delay=0` are not supported in Azure SQL.

As an alternative to SQL Server Audit, in Azure SQL Database there is *Azure SQL Auditing*. It is powered by SQL Server Audit, and supports Audit Action Groups and Actions, like SQL Server. Azure SQL Auditing tracks database and server events and writes events to an audit log in either Azure Blob storage, Azure Monitor logs (also referred to as Log Analytics), or to an Event hub. If you point to an Azure Blob storage account, you can store and analyze your results in XEvents files. With Log Analytics, you unlock the ability to query your logs with Kusto Query Language (KQL) and leverage the auditing Log Analytics dashboards.

In an earlier exercise, you set up Auditing at the server level, but it is also available at the database level. In a future exercise, you will see how to take access and utilize the files sent to Azure Blob storage, KQL, and the Log Analytics dashboards.

## Monitoring

There are two aspects to monitoring and managing security: the Azure level and the database/server level. In Azure, you can leverage tools like the Activity Logs and RBAC auditing.

In Azure SQL Managed Instance, you can configure SQL Server audit, and the engine can track the failed and successful logins. In Azure SQL Database, you can configure Azure SQL Auditing and leverage DMVs, Metrics, and Alerts in order to monitor security-related events (for example, `sys.event_log` will allow you to track the number of failed and successful connections and the number of connections blocked by the firewall).  

For both services, Microsoft recommends you configure Advanced data security including setting up alerts for Advanced Threat Protection (discussed in the next section and exercise). Finally, you can leverage the Azure Security Center to monitor, manage, and receive recommendations on all the resources in your Azure estate.

## Advanced data security

Advanced data security (ADS) is a unified package for advanced SQL security capabilities, providing a single go-to location for enabling and managing three main capabilities:  

* Data discovery & classification
* Vulnerability assessment
* Advanced Threat Protection

In the next two exercises, you'll dive into the capabilities and scenarios that Advanced data security enables.
