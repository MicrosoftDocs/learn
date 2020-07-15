Over the course of the learning path, you've learn a lot about Azure SQL with regards to security, performance, and availability. There are a few things that didn't quite fit in a particular module, but that you should be aware of as you start developing in Azure SQL.

## Job Management

SQL Server Agent provides a scheduling system for SQL Server users. You can achieve equivalent functionality in Azure SQL through the following:

### SQL Agent in Managed Instance

SQL Agent is a fully supported service with Azure SQL Managed Instance. SQL Agent jobs are supported only for T-SQL and SSIS job steps. Command shell steps are not supported. Although alerts are not supported, email notifications are supported through Database mail.

### Elastic Jobs for Azure SQL Database

Azure SQL Database does not support SQL Server Agent. However, you can use the Elastic Job agent Azure service to create and schedule jobs. Jobs are T-SQL scripts that you can run against many database including parallel execution.

### Azure Automation

Azure automation is a service that allows you to orchestrate processes through a concept called a runbook. A runbook can be composed of code like Powershell or Python and can be directed to any Azure resource.

## Other SQL Server capabilities

There are other capabilities you should know about when comparing SQL Server to Azure SQL:

- **External tables** are allowed across Azure SQL Databases but Polybase external tables are not a complete feature available yet in Azure SQL.
- **Linked Servers** and cross-database queries are available in Managed Instance.
- **Database Mail** and **Service Broker** are available in Managed Instance.
- **Full-text search** is supported but also take a look at Azure Search integration.
- **Machine Learning Services** is in Preview for Managed Instance.
- **xp_cmdshell** and **DTC** are not supported for Azure SQL.

## Errors

Error handling for Azure SQL is very much like SQL Server except for a few key considerations:

### New errors unique to Azure

There are errors unique to Azure SQL your application needs to be prepared to handle. For example, when you run out of storage or workers in Azure SQL Database you may encounter a different error than you would in SQL Server. 

In some cases, applications may encounter an error when executing a query or connecting indicating a Managed Instance or Database is unavailable. Therefore, ensuring your application has proper retry logic is important for Azure SQL.

Consult the documentation for how to troubleshoot and develop applications for specific errors and transient failures in Azure SQL.

### Fatal errors that trigger dumps handled by the platform

In some cases, SQL Server will generate a stack dump due to a fatal exception or error. For SQL Server, this could result in users having to work with technical support to obtain a fix and handle the problem. For Azure SQL, any stack dumps are handled by the platform and a failover is initiated if necessary. Furthermore, the Azure SQL engineering team monitors these types of issues and can quickly address them with fixes without the user having to worry about them. This is a great example of why Azure SQL is versionless.