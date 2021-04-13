After your Azure SQL Database instance or Azure SQL managed instance is secured on the networking, authentication, and data protection levels, the final step is to understand how you're going to manage security on an ongoing basis. Managing security includes auditing, monitoring, data classification, and, in the case of Azure SQL, Azure Defender.

## Auditing

Auditing can help you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations.

Traditional SQL Server auditing by using Transact-SQL (T-SQL) is available, with some differences, only in an Azure SQL managed instance. The primary differences are:  

* With `CREATE SERVER AUDIT`, you can use new syntax `TO URL` and `TO EXTERNAL MONITOR` to specify an Azure Blob storage container and enable event hub and Azure Monitor logs targets, respectively.  
* `TO FILE`, shutdown option, and `queue_delay=0` are not supported in Azure SQL.

As an alternative to SQL Server audit, Azure SQL Database has *Azure SQL auditing*. It's powered by SQL Server audit and, like SQL Server, it supports Audit Action Groups and Actions. Azure SQL auditing tracks database and server events, and it writes events to an audit log in either Azure Blob storage, Azure Monitor logs (also referred to as Log Analytics), or to an event hub. If you point to an Azure Blob storage account, you can store and analyze your results in XEvents files. With Log Analytics, you unlock the ability to query your logs with Kusto Query Language (KQL) and take advantage of the Log Analytics auditing dashboards.

In an earlier exercise, you set up auditing at the server level, but it's also available at the database level. In a future exercise, you'll see how to access and utilize the files that are sent to Azure Blob storage, KQL, and the Log Analytics dashboards.

## Monitoring

There are two aspects to monitoring and managing security: the Azure level and the database or server level. In Azure, you can apply tools such as activity logs and role-based access control auditing.

In your Azure SQL managed instance, you can configure SQL Server audit, and the engine can track the failed and successful logins. Failed logins for the Azure SQL managed instance are also tracked in the ERRORLOG. In your Azure SQL Database instance, you can configure Azure SQL auditing and apply dynamic management views, metrics, and alerts to monitor security-related events. For example, `sys.event_log` will allow you to track the number of failed and successful connections and the number of connections blocked by the firewall.  

For both services, Microsoft recommends that you configure Azure Defender, including setting up alerts for Advanced Threat Protection. These security elements are discussed in the next section and exercise. Finally, you can use Azure Security Center to monitor, manage, and receive recommendations on all the resources in your Azure estate.

### Data Discovery & Classification

The Data Discovery & Classification service forms a new information-protection paradigm for Azure SQL Database and Azure SQL Managed Instance. The service is aimed at protecting the data and not just the database. This paradigm includes:
* Discovery and recommendations for potentially sensitive data that should be classified.
* The ability to persistently add labels to columns by using metadata attributes.
* The ability to audit and query sensitive data access. 

The portal view is available only for Azure SQL, but SQL Server supports similar functionality through a wizard in SQL Server Management Studio.

## Azure Defender

Azure Defender is a unified package for advanced SQL security capabilities. It provides a single go-to location for enabling and managing two main capabilities:  

* Vulnerability Assessment
* Advanced Threat Protection


### Vulnerability Assessment

At the highest level, SQL Vulnerability Assessment is a scanning service that provides visibility into your security state and then provides actionable steps to address any potential concerns. When you configure periodic recurring scans, you're enabling the service to scan your databases every seven days and check for any vulnerabilities. You can then choose to send those reports to the admins, subscription owners, or anyone else who might need to be notified of changes. For this service to operate, you have to specify a storage account where the results will be stored.

### Advanced Threat Protection

With Advanced Threat Protection, you can detect and respond to potential threats as they occur by receiving security alerts on anomalous activities. Advanced Threat Protection applies advanced monitoring and machine learning technologies to detect whether any of the following threats have occurred:

* SQL injection
* SQL injection vulnerability
* Data exfiltration
* Unsafe action
* Brute force attempt
* Anomalous client login

In the next two exercises, you'll dive into the capabilities and scenarios that Azure Defender, and Azure SQL in general, enables and protects against.
