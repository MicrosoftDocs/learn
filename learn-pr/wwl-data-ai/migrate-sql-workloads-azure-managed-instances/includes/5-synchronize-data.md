Many migrations involve a period when the on-premises and the cloud database must be kept synchronized. For example, there might be a time when clients make changes to both databases.

You've migrated the sports retail products database into Azure SQL Managed Instance. The website is already using the cloud database. You're starting to reconfigure clients to use the new database. You’ve decided to transition users to the new system in batches. For each team, you'll take time to resolve any problems before migrating the next users. This approach allows for troubleshooting and problem resolution without disrupting all users at once. Next, you'll reconfigure the data analysis system to use the new database in Azure. During this time, you want to ensure that the cloud and on-premises databases are synchronized every hour.

You'll explore various methods for implementing data synchronization. These methods can also be employed to selectively migrate data, should you require only a subset of the tables to be transferred. This flexibility allows for a more tailored approach to data migration.

## Connectivity options with on-premises servers

Often, you want to keep data in on-premises databases synchronized with Azure SQL Managed Instance. You might want to stage the migration of client applications to the new database, for example, which means there's a period when clients connect to both databases. 

Before you choose a data synchronization method, it's important to ensure you have connectivity that's secure. There are three different connectivity options available to establish communication between computers on-premises and resources in Azure.

- **Point-to-Site**. A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer.
- **Site-to-Site**. A Site-to-Site VPN gateway is used to connect an entire on-premises site to the Azure network. 
- **ExpressRoute**. Azure ExpressRoute enables you to create private connections between Azure datacenters and on-premises infrastructure, or infrastructure in a colocation environment. ExpressRoute connections don't go over the public internet, and offer more reliability, faster speeds, lower latencies, and higher security than typical internet connections. 

### Public endpoint

Public endpoint for SQL Managed Instance helps you connect to the database from the internet without using a VPN, and is designed for data communication only. Public endpoint for data can simultaneously coexist with the private endpoint. For security reasons, the implementation allows for Separation of Duties (SoD) between a database administrator and a network administrator when enabling the public endpoint.

To enable public endpoint for managed instance, two steps are required. For SoD, you'll need two separate roles, with the following database and network permissions, to complete these steps:

1. A database administrator who has role-based access control permissions in scope Microsoft.Sql/managedInstances/* must run a PowerShell script to enable public endpoint for managed instance.
1. A network administrator who has role-based access control permissions in scope Microsoft.Network/* must open the port 3342 used by the public endpoint on the network security group (NSG), and provide a UDR route to avoid asymmetric routing.

:::image type="content" source="../media/4-public-endpoint-secure-access.png" alt-text="Diagram showing how public endpoint works for Azure SQL Managed Instance.":::

## Choose a synchronization method

You can use many methods to synchronize data from a SQL Database managed instance to an on-premises server and back.

### Native backup and restore

You can restore a database in Azure SQL Managed Instance from an Azure Blob Storage file using Shared Access Signature (SAS). 

This involves creating a credential with access to Azure Blob Storage, and then using the `BACKUP DATABASE` command with the `COPY_ONLY` option. If your database is larger than 200 GB, you can use a striped backup by providing several URL locations.

```sql
BACKUP DATABASE YourDatabase TO URL = 'https://youraccount.blob.core.windows.net/yourcontainer/yourdatabase.bak' WITH COPY_ONLY
```

To restore the database in SQL Managed Instance:

```sql
RESTORE DATABASE YourDatabase FROM URL = 'https://youraccount.blob.core.windows.net/yourcontainer/yourdatabase.bak'
```

### BACPAC file using SqlPackage

A BACPAC file is essentially a zipped version of both your database’s metadata and data. While this deployment method is compatible with SQL Database, SQL Managed Instance doesn't support migration via BACPAC within the Azure portal. As an alternative, the [SQLPackage utility](/sql/tools/sqlpackage/sqlpackage?azure-portal=true) should be used with the BACPAC file.

### Bulk Copy Program (BCP)

The [BCP utility](/sql/tools/bcp-utility?azure-portal=true) is a command-line tool that exports tables to files so you can import them. Use this approach to migrate from a single SQL Database to SQL Managed Instance and back.

### Azure Data Factory (ADF)

[Azure Data Factory](/azure/data-factory/introduction?azure-portal=true) is built for data movement and orchestration, with the focus on ingestion. ADF has the integration runtime support to run SSIS packages, and the public internet support for SQL Managed Instance.

### Transactional replication 

[Transactional replication](/sql/relational-databases/replication/transactional/transactional-replication) is a way to move data between continuously connected database servers. 

The process begins with a snapshot of the publication database objects and data. Once the initial snapshot is taken, any subsequent changes to the data or schema at the Publisher are typically delivered to Azure SQL Managed Instance in near real-time as they occur.

SQL Managed Instance is flexible because it can be a publisher, distributor, and subscriber.

Replication is one of the few technologies that allows you to replicate parts of a table. We refer to these table parts as *articles*. This data is then sent to a distributor, which is a supplier of the data to any number of subscribers.

**Requirements**

- Connectivity uses SQL Authentication between replication participants.
- An Azure Storage Account share for the working directory used by replication.
- Open port 445 (TCP outbound) in the security rules of the managed instance subnet to access the Azure file share.
- Open port 1433 (TCP outbound) if the publisher or distributor is on a managed instance and the subscriber is on-premises.

## Connecting applications to a SQL managed instance

A SQL managed instance must be placed inside an Azure virtual network subnet that's dedicated to managed instances. This deployment gives you a secure private IP address and the ability to connect to on-premises networks. 

:::image type="content" source="../media/4-connectivity-architecture-example.png" alt-text="Diagram showing how connectivity takes place in Azure SQL Managed Instance.":::

Users and client applications can connect to the managed instance database through the Azure portal, PowerShell, Azure CLI, and the REST API.

All communications are encrypted and signed using certificates. To check the trustworthiness of communicating parties, managed instances constantly verify these certificates through certificate revocation lists. If the certificates are revoked, the SQL managed instance closes the connections to protect the data.
