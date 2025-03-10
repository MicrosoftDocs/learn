Most applications use a database to store the data used by the application. For your Tailwind Traders migration planning, it's important to understand how to migrate databases to Azure to properly support moving data to the cloud. For this process, we examine another component of Azure Migrate, the Azure Database Migration Service.

## Azure Database Migration Service

The [Azure Database Migration Service](/azure/dms/dms-overview) is part of Azure Migrate. Supported scenarios include:

- Azure SQL Database
- Azure SQL Database Managed Instance
- Azure SQL VM
- Azure Cosmos DB 
- Azure Database for MySQL 
- Azure Database for PostgreSQL 

### Things to know about the Database Migration Service

Azure Database Migration Service is a fully managed service. The service enables seamless migrations from multiple database sources to Azure data platforms. You can migrate your databases offline or while they're online.

- **Offline migration**: An offline migration requires shutting down the server at the start of the migration. Use online migration if you can't afford application downtime. 

- **Online migration**: An online migration uses a continuous synchronization of live data, which allows a cut over to the Azure replica database at any time. Online migration minimizes downtime. 

Not all migration scennarios have both offline and online capabilities. 

| Migration scenario | Migration mode |
| --- | --- |
| SQL Server to Azure SQL Managed Instance	| Online or Offline | 
| SQL Server to SQL Server on Azure Virtual Machine	| Online or Offline |
| SQL Server to Azure SQL Database | Offline |

### Things to consider when using the Database Migration Service

When selecting a database migration solution, determine which features are important to you.

- Do you need an assessment to identify compatability issues?
- Do you need a SKU recommendation?
- Do you need to migrate database logins and schemas?
- Do you need to automate the process?
- Do you have a specific product scenarios?
- Do you need to integrate with other migration tools?
