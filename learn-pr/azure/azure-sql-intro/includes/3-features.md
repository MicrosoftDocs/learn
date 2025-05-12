With Azure SQL products, in addition to all the functionality included in the SQL Database Engine, you also benefit from a number of Azure-specific features to help you automate management, secure your data, monitor your performance, scale your resources and ensure availability of your database in the event of a disaster. 

This unit provides a deeper dive into some of the features and capabilities available for the products in the Azure SQL family.  

## Business continuity

Azure SQL products ensure your business continues operating in the face of disruption by providing built-in availability through local redundancy. The default availability solution is designed to ensure that committed data is never lost due to failures, that maintenance operations minimize the impact to workloads, and that the database isn't a single point of failure in your software architecture.

By default, Azure SQL products ensure your database, instance, or virtual machine handles disruptions such as: 

- Customer initiated management operations that result in a brief downtime
- Service maintenance operations
- Issues with the:
   - rack where the machines that power your service are running
   - physical machine that hosts the SQL database engine
- Other problems with the SQL database engine
- Other potential unplanned local outages

Be sure to employ retry logic in your application to handle transient errors that can occur during these operations. 

The availability mechanism differs between the service tiers of Azure SQL Database and Azure SQL Managed Instance. For example, the Business Critical service tier relies on underlying Always On availability group technology to provide replicas available for failover in the event of a failure, while the General Purpose service tier uses the redundancy of remote storage to provide availability. 

While availability is built in for the PaaS services, you need to deploy your virtual machine to an availability set to achieve the same availability for your Azure VM. You can also use existing SQL Server high availability and disaster recovery (HADR) solutions, such as Always On availability groups, to further protection the SQL Server instance running on your Azure VM. 

## High availability

You can also achieve high availability by enabling zone redundancy for your service, which makes your data resilient to failures in an entire region. Without zone redundancy, failovers happen locally within the same data center, which can result in your database, instance, or virtual machine being unavailable until the outage is resolved. Zone-redundant availability ensures your data is spread across three Azure availability zones in the primary region. Each availability zone is a separate physical location with independent power, cooling, and networking. 

With Azure SQL Database and Azure SQL Managed Instance, you can enable zone-redundancy at any point, but an Azure VM needs to be deployed to an availability zone to achieve zone-redundancy - or migrated to an availability zone by using Azure Site Recovery. 

Zone-redundancy has different availability and supportability across the three products so review zone-redundancy specifications for your deployment to be sure your chosen solution meets your needs.

## Automated backups

Database backups are an essential part of any business continuity and disaster recovery strategy because they help protect your data from corruption or deletion. 

Since Azure SQL Database and Azure SQL Managed Instance are PaaS services, backups are automatically managed for you as soon as you deploy your service. Full backups are taken every week, differential backups are taken every 12 hours, and transaction log backups are taken approximately every 10 minutes. These backups are stored in read-access geo-redundant storage (RA-GRS) by default, which means that your backups are replicated to a secondary region. This replication ensures that your backups are available even if the primary region becomes unavailable.

Backups can then be used to restore your database to a point in time within the last 35 days. You can also use long-term backup retention to store your backups in a separate storage account for up to 10 years. 

Automated backups can be configured for SQL Server VMs registered with the SQL IaaS Agent extension, which enables SQL VM manageability in the Azure portal. You can choose between using Azure Backup or Automated Backups, which both allow you to configure the frequency and retention of your backups. 

## Automated patching

Azure SQL Database and Azure SQL Managed Instance automatically apply patches to the underlying operating system and SQL Database Engine. This ensures that your database is always running the latest version of SQL Server, with the latest security updates and performance improvements. Automated patching is automatically available for Azure SQL Database and Azure SQL Managed Instance, but must be enabled for SQL Server on Azure VMs registered with the SQL IaaS Agent extension. 

SQL managed instances configured with the **SQL Server 2022** update policy get the latest patches and updates for SQL Server 2022, while instances configured with the **Always-up-to-date** update policy receive patches and updates for the latest version of SQL Server. 

## Security 

Azure SQL offers a comprehensive suite of security and data governance features to protect your data and ensure compliance with industry standards. 

Azure SQL provides modern authentication to ensure secure access to your database. **Microsoft Entra Identity Management** allows you to centrally manage your organization’s identities and control user access, providing a seamless and secure way to authenticate users. This feature enhances security by using the robust identity management capabilities of Microsoft Entra.
 
Data protection and integrity are critical in safeguarding sensitive information. Azure SQL offers **Transparent Data Encryption (TDE)**, which encrypts your data at rest and protects your data in motion using the latest version of **Transport Layer Security (TLS)**. **Azure Key Vault** integration allows you to manage and control access to your encryption keys, ensuring that sensitive data is protected. Additionally, **Always Encrypted** ensures that sensitive data remains encrypted, protecting data in select columns in use, in motion, and at rest. These features help maintain data confidentiality. For integrity protection, Azure SQL includes the **Ledger** feature, which provides customers with tamper-evidence for their data.  

Network security in Azure SQL is achieved through various mechanisms. **Virtual Network (VNet) integration** provides private IP addresses and full isolation from other tenants. **Network Security Groups (NSGs)** and **Azure Firewalls** allow you to implement advanced filtering and control network traffic. These features ensure that your database is protected from unauthorized access and potential threats. 

Azure SQL supports comprehensive data governance through features like **SQL Data Classification** and **Microsoft Information Protection (MIP) based Data Discovery and Classification** (in preview). Classifying and labeling sensitive data allows data owners to apply the required protection measures and ensure they're enforced. 

Azure SQL offers advanced threat prevention and detection capabilities through integration with Microsoft Defender for SQL. The **threat detection** component of Microsoft Defender identifies anomalous database activities and provides real-time alerts to administrators. The **vulnerability assessment** component of Microsoft Defender discovers, tracks, and helps customers fix potential misconfiguration or gaps in the security protection that could vulnerabilities which can lead to exploits. 
**SQL Auditing** tracks database activities and provides detailed logs for compliance and forensic analysis. 

## Geo-replication 

With Azure SQL products, you can easily replicate your data to another region for disaster recovery or to improve performance by offloading read-only workloads (known as read scale-out). Geo-replication allows you to create readable replicas of your database or instance in the same datacenter (region) or a different one.

With Azure SQL Database, you can choose between the active-geo replication or failover groups feature. Active geo-replication allows you to create up to four readable replicas of your database in different regions, while failover groups are an abstraction on top of the active geo-replication feature, that allow you to fail over groups of databases, provide endpoint redirection, and simplify failover management. 

Failover groups are also available for Azure SQL Managed Instance, which allows you to create a secondary replica of the primary instance. 

While automatic fail over is available for failover groups configured with the Microsoft managed failover policy, it's recommended to use the customer managed failover policy to better control fail over behavior and avoid extended outages based on the failover criteria that Microsoft uses - which might not be appropriate for your business.

To achieve geo-replication with SQL Server on Azure VMs, you can configure an Always On availability group between virtual machines in different regions. 

With each of these solutions, changes made to the primary database are replicated in real-time to their secondary replicas. This means that if the primary becomes unavailable, you can failover to the secondary replica and continue working with minimal downtime. You can also use secondary replicas to offload read-only workloads and reporting. 

## Scalability

Azure SQL products are designed to scale easily and quickly to meet the demands of your applications. With the PaaS services, you can easily add more resources (CPU, memory, storage) without long provisioning times. This means that you can scale up or down as needed, depending on your workload requirements. Adding more resources enables you to quickly react when your database hits the current resource limits and needs more power to handle the incoming workload. Likewise, reducing your resources during periods of low activity can save on cost. 

While scaling activities are manually initiated, databases in the serverless compute tier of Azure SQL Database can be scaled automatically based on workload demands. 

You can also pool resources in elastic pools for Azure SQL Database and instance pools for Azure SQL Managed Instance to share resources among multiple databases or managed instances. This allows you to optimize your resource utilization by allocating resources to databases or instances when they need them during peak performance periods. 

With SQL Server on Azure VMs, you can also scale your virtual machines up or down as needed by changing the VM size. However, this requires more planning and management than with the PaaS services. You need to consider the size of your virtual machine, the type of storage you're using, and the network configuration. In some cases, you must deallocate the VM first. Deallocation might be necessary if the new size isn't available on the same hardware cluster that is currently hosting the VM. It's important to understand that even when deallocation isn't necessary, if the virtual machine is currently running, changing its size causes it to restart. For this reason you should consider changing VM size as a disruptive procedure, especially for stateful workloads that are hosted on the VM - such as SQL Server.

## Automatic tuning

Automatic tuning is a fully managed, intelligent performance service that continuously monitors queries executed on a database, and automatically improves performance. This is achieved through dynamically adapting a database to changing workloads and applying tuning recommendations. Automatic tuning provides peak performance and stable workloads through continuous performance tuning based on AI and machine learning.

Automated tuning recommendations are applied only at the times of a low utilization of CPU, data I/O, and log I/O. The system can also temporarily disable automatic tuning operations to protect workload performance.

Automatic tuning is available for Azure SQL Database and Azure SQL Managed Instance, but not SQL Server on Azure VMs. 

## Built-in monitoring and intelligence

Azure SQL products provide built-in monitoring capabilities to help you understand the performance of your databases and workload. 

Azure Monitor uses predefined metrics to monitor resource consumption and health. You can also use Azure Monitor to create alerts based on these metrics. Azure Monitor is available for all three Azure SQL products.

Database watcher, available for both of the PaaS services, collects in-depth workload monitoring data to give you a detailed view of database performance, configuration, and health. Dashboards in the Azure portal provide a single-pane-of-glass view of your Azure SQL estate and a detailed view of each monitored resource. Database watcher isn't currently available for SQL Server on Azure VMs. 

Query Performance Insights, currently only available for Azure SQL Database, provides intelligent query analysis for single and pooled databases. It helps identify the top resource consuming and long-running queries in your workload.

For SQL Server VMs registered with the SQL IaaS Agent extension, you can use the Azure portal to identify missing best practices, and VM or I/O throttling. 

## Migrating to Azure 

You can use Azure Migrate to discover and assess your SQL data estate at scale. Azure Migrate recommends ideal Azure SQL products for your assessed workload, with target sizing, and monthly estimates. SQL Server instances enabled by Azure Arc also have assessment capabilities that can help prepare you for a migration. 

Azure Database Migration Service (DMS) is a fully managed service that helps you migrate your databases to Azure. It supports both online and offline migrations, and can be used to migrate databases from on-premises SQL Server, other cloud providers, or other database platforms. You can use Azure Database Migration Service to migrate your databases to Azure SQL Database, Azure SQL Managed Instance, or SQL Server on Azure VMs.

Both Azure SQL Database and Azure SQL Managed Instance support migrating data through a dacpac, where you can export your database schema and data to a .dacpac file, and then import it. This is a good option for smaller databases or when you want to migrate only the schema and not the data.

Azure SQL Managed Instance, in addition DMS, also supports migration through the: 
- Log Replay Service, which uses log shipping technology to migrate your data to the cloud. 
- Managed Instance link, which uses Always On availability group technology to synchronize your data between SQL Server and Azure SQL Managed Instance.
- Native backup and restore, which allows you to take a backup of your on-premises SQL Server database directly to Azure storage and then restore it to Azure SQL Managed Instance.

SQL Server on Azure VMs also support migrations via native backup and restore through Azure storage. You can also configure a distributed availability group between your on-premises and SQL VM instance to migrate your data.



