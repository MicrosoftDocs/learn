After your Azure SQL Database instance or Azure SQL managed instance is secured on the networking, authentication, and data protection levels, the final step is to understand how you're going to manage security on an ongoing basis. Managing security includes auditing, monitoring, data classification, and, in the case of Azure SQL, Microsoft Defender for Cloud.

## Auditing

Auditing can help you maintain regulatory compliance, understand database activity, and gain insight into discrepancies and anomalies that could indicate potential security violations.

Traditional SQL Server auditing by using Transact-SQL (T-SQL) is available, with some differences, only in an Azure SQL managed instance. The primary differences are:  

* With `CREATE SERVER AUDIT`, you can use new syntax `TO URL` and `TO EXTERNAL MONITOR` to specify an Azure Blob storage container and enable event hub and Azure Monitor logs targets, respectively.  
* `TO FILE`, shutdown option, and `queue_delay=0` are not supported in Azure SQL.

As an alternative to SQL Server audit, Azure SQL Database has *Azure SQL auditing*. It's powered by SQL Server audit and, like SQL Server, it supports Audit Action Groups and Actions. Azure SQL auditing tracks database and server events, and it writes events to an audit log in either Azure Blob storage, Azure Monitor logs (also referred to as Log Analytics), or to an event hub. If you point to an Azure Blob storage account, you can store and analyze your results in XEvents files. With Log Analytics, you unlock the ability to query your logs with Kusto Query Language (KQL) and take advantage of the Log Analytics auditing dashboards.

In an earlier exercise, you set up auditing at the server level, but it's also available at the database level. In a future exercise, you'll see how to access and utilize the files that are sent to Azure Blob storage, KQL, and the Log Analytics dashboards.

### Configure auditing

1. In the [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true) search bar, enter **Log analytics**, and then select **Log Analytics workspaces** from the results. The **Log Analytics workspaces** pane appears.

1. Select **Create**. The **Create Log Analytics workspace** appears.
  
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
    
1.  Select **Review + create**, wait until your inputs have been validated, and then select **Create**. Wait until the resource is deployed. 
  
1.  Select **Go to resource**. The **Overview** pane for your Logic App appears.

1. In the Azure portal, go to your **AdventureWorks** SQL Database.

1. On the menu, under **Security**, select **Auditing**. Review the options.

    You can apply auditing at the server level, which applies to all databases within the Azure SQL Database logical server. If you also apply auditing at the database level (which you will do in this unit), both audits occur in parallel; one does not override the other. 

1. Select the slide toggle to **Enable Azure SQL Auditing**. 

1. Select the  **Storage** check box, and then complete the required fields. 
     - For **Subscription**, from the dropdown list, select the Concierge Subscription.
     - For **Storage Account**, from the dropdown list, select the account that starts with **sqlva** followed by a random string of letters and numbers. 
 
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
     - For **Log Analytics**, select the Log Analytics workspace you created earlier in this exercise (asuresql-laNNN).


1. From the command bar, select **Save**.  

    It may take a few minutes for the configuration to process. 
    
1. Select **OK** to save your configuration.
    
    After the configuration is saved, in the breadcrumbs, select AdventureWorks to close the Audit pane.  

You've now enabled auditing for a storage account and an Azure Log Analytics workspace. Later, you'll dive deeper into the auditing capabilities in Azure SQL. You'll see how to analyze the audit logs to view all the changes you've made throughout the module, as well as some other interesting use cases.  




## Monitoring

There are two aspects to monitoring and managing security: the Azure level and the database or server level. In Azure, you can apply tools such as activity logs and role-based access control auditing.

In your Azure SQL managed instance, you can configure SQL Server audit, and the engine can track the failed and successful logins. Failed logins for the Azure SQL managed instance are also tracked in the ERRORLOG. In your Azure SQL Database instance, you can configure Azure SQL auditing and apply dynamic management views, metrics, and alerts to monitor security-related events. For example, `sys.event_log` will allow you to track the number of failed and successful connections and the number of connections blocked by the firewall.  

For both services, Microsoft recommends that you configure Microsoft Defender for Cloud, including setting up alerts for Advanced Threat Protection. These security elements are discussed in the next section and exercise. Finally, you can use Microsoft Defender for Cloud to monitor, manage, and receive recommendations on all the resources in your Azure estate.

### Data Discovery & Classification

The Data Discovery & Classification service forms a new information-protection paradigm for Azure SQL Database and Azure SQL Managed Instance. The service is aimed at protecting the data and not just the database. This paradigm includes:
* Discovery and recommendations for potentially sensitive data that should be classified.
* The ability to persistently add labels to columns by using metadata attributes.
* The ability to audit and query sensitive data access. 

The portal view is available only for Azure SQL, but SQL Server supports similar functionality through a wizard in SQL Server Management Studio.

## Microsoft Defender for Cloud

Microsoft Defender for Cloud is a unified package for advanced SQL security capabilities. It provides a single go-to location for enabling and managing two main capabilities:  

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

In the next two exercises, you'll dive into the capabilities and scenarios that Microsoft Defender for Cloud, and Azure SQL in general, enables and protects against.

### Row-level Security

Row-Level Security enables you to use group membership or execution context to control access to rows in a database table.

Row-Level Security (RLS) helps you implement restrictions on data row access. For example, you can ensure that workers access only those data rows that are pertinent to their department. Another example is to restrict customers' data access to only the data relevant to their company.

The access restriction logic is located in the database tier rather than away from the data in another application tier. The database system applies the access restrictions every time that data access is attempted from any tier. This makes your security system more reliable and robust by reducing the surface area of your security system.

RLS supports two types of security predicates.

- Filter predicates silently filter the rows available to read operations (SELECT, UPDATE, and DELETE).
- Block predicates explicitly block write operations (AFTER INSERT, AFTER UPDATE, BEFORE UPDATE, BEFORE DELETE) that violate the predicate.