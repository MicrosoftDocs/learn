SQL Server 2022 enables rich hybrid data platform capabilities to connect to the Azure cloud for disaster recovery, analytics, and security.

## SQL Server is a hybrid data platform

SQL Server 2022 connects to the cloud with the following Azure services as seen in the following figure:

**TODO: Put in image here showing overall hybrid data platform story**

The SQL Server 2022 engine has been enhanced to integrate with all of these Azure services but also can require additional software or configuration:

- Distributed Availability Group (DAG)

Managed disaster recovery using the Link feature for Azure SQL Managed instance requires setting up a Distributed Availability Group (DAG). SQL Server Management Studio (SSMS) provides graphical interfaces to assist in this configuration.
 
- Self-hosted integration runtime (SHIR)

The Self-hosted integration runtime is a Windows program that must be installed on your network to connect to SQL Server for Synapse Link for SQL Server.

- Azure extension for SQL Server

The Azure extension for SQL Server is used to setup Azure Arc agents and extensions to enable SQL Server 2022 as an Azure Arc-enabled SQL Server. This extension is required to setup Microsoft Purview, Azure Active Directory (AAD), and Microsoft Defender integration with SQL Server 2022.

Let's look at each of these Azure connected scenarios in more detail.

## Managed Diaster Recovery using the Link feature for Azure SQL Managed Instance

The Link feature for Azure SQL Managed Instance provides a new managed disaster recovery solution for SQL Server 2022.

## The challenge

Having a diaster recovery site and plan are critical to ensuring your business and application are available at any time. While SQL Server has all the features and capabilities to support various disaster recovery options, a user or admin must do all the configuration, setup, and maintenance.

## The solution

The link feature for Azure SQL Managed Instance allows you to link a SQL Server 2022 database to Azure SQL Managed Instance using built-in Availability Group technology in SQL Server.

Using documented scripts or graphical wizards with SQL Server Management Studio (SSMS) you can connect an existing Availability Group in SQL Server 2022 or create a new one (no replica required) to create a Distributed Availability Group (DAG) between SQL Server 2022 and Azure SQL Managed Instance.

Initial data is seeded to create a synchronized database in Azure SQL Managed Instance. Any changes made to the primary SQL Server will now be reflected in the database in Azure SQL Managed Instance.

A planned or forced failover could then be done should a disaster scenario arise for the application to then use Azure SQL Managed Instance as the primary. Azure SQL Managed Instance offers a compatibility option so that the instance and database are compatible witH SQL Server 2022.

This would allow for an offline diaster recovery scenario so that you could restore a copy of the database from Azure SQL Managed Instance *back* to SQL Server 2022.

You can learn more about the Link feature for Azure SQL Managed Instance at https://aka.ms/milink.

## Near real-time analytics with Synapse Link for SQL Server

Synapse link for SQL Server allows you to offload read workloads in Azure Synapse for near real-time analytics.

## The challenge

Azure Synapse has become a very popular service for analytics for data of all types. In addition, many customers are looking to offload their read intensive applications from their primary SQL Server to ensure the primary application has plenty of resources. In order to use Azure Synapse for this purpose you typically have to build Extract Transform Load (ETL) applications or scrips to copy data out of SQL Server to synchronize into Synapse. This method can introduce challenges because the data is often out of date in Synapse and it can be costly to build and maintain ETL applications.

## The solution

Synapse Link for SQL Server provides a seamless and tight integration between SQL Server 2022 and Synapse. You can now define a **linked service** for SQL Server in Synapse to setup a connection to SQL Server 2022 including the setup of the Self-hosted Integration Runtime (SHIR) on the network to discover and connect to SQL Server 2022. In addition, you can setup a linked service with an Azure Storage account called the **Landing Zone**.

You can then use Synapse through Synapse Studio or PowerShell to create a **linked connection** using the linked services. This linked connection defines which tables you want to keep synchronized from SQL Server 2022 to Synapse and a **SQL dedicated pool** which will be the target of the data.

When you start the linked connection, Synapse will coordinate with SHIR to start a synchronization with SQL Server using the specified tables to copy parquet files into the Landing Zone. Synapse will ingest the parquet files from the Landing Zone to create new tables in a SQL dedicated pool with a snapshot of SQL Server table data.

Now when committed transactions are made in SQL Server 2022 for affected tables, the SQL Server engine will capture changes automatically with a process called **change feed** and place files in the Landing Zone to reflect incremental changes. Synapse will pick up these files and make the necessary changes in near real-time to tables in the SQL dedicated pool.

You can now use the power of Synapse with PowerBI, Spark, or other analytics to read SQL Server 2022 data in near real-time offloaded from the primary SQL Server database.

You can learn more about Synapse link for SQL Server at https://aka.ms/synapselinksql

## Central governance with Microsoft Purview

Microsoft Purview provides services for central governance by allowing you to create policies for authentication and authorization to SQL Server 2022.

## The challenge

SQL Server provides a rich system to create logins and users for authentication to connect and roles and permissions for authorization for specific tasks or access to data. One challenge is to integrate the SQL Server security system with other aspects for an organization's security policies and also to establish SQL Server security policies across multiple SQL Server instances.

## The solution

Microsoft Purview allows you to create **access policies** against one or more SQL Server 2022 instances. You must have the proper Azure Role-Based Access Control (RBAC) permissions with a Microsoft Purview Account to create access policies. An access policy defines specific permissions for an Azure Active Directory (AAD) account for a SQL Server instance. Access policies include two different types:

- **Data**

A data access policy allows an Azure Active Directory (AAD) account to login to SQL Server and have access to **read** data from user tables in any database for the instance.

- **DevOps**

A DevOps access policy allows an Azure Active Directory (AAD) account to login to SQL Server and perform specific tasks such as **Performance Monitoring** or **Security Auditing**.

You do not need to create a login or user account for the AAD account to apply the access policy. SQL Server 2022 must be configured as an Azure Arc-enabled SQL Server to use Microsoft Purview access policies. The Azure extension for SQL Server stores information on SQL Server that allows the database engine to connect to Microsoft Purview to retrieve access policies, cache them inside SQL Server, and apply a policy when an AAD account attempts to login to SQL Server.

You can delete the access policy from Microsoft Purview to remove the authentication and authorization of the AAD account at any time. You can also apply an access policy across multiple SQL Server 2022 instances thereby providing a central governance method.

You can learn more about Microsoft Purview access policies for SQL Server 2022 at https://aka.ms/purviewsqlaccesspolicies.

## Central authentication using Azure Active Directory (AAD)

Azure Active Directory (AAD) provides a cloud-based central authentication authority for any organization and advanced authentication methods. SQL Server 2022 supports logins or users based on AAD account.

## The challenge

SQL Server supports authentication for SQL Server or Windows accounts. Many users are looking to centralize their authentication systems using the cloud and to support advanced authentication methods like Multi-Factor Authentication (MFA).

## The solution

SQL Server 2022 now supports AAD account based logins and users. SQL Server 2022 must be configured as an Azure Arc-enabled SQL Server to use AAD. The Azure extension for SQL Server stores information on SQL Server that allows the database engine to authenticate an AAD account.

Like Azure SQL Managed Instance and Azure SQL Database, SQL Server 2022 supports a new syntax for CREATE LOGIN to support an EXTERNAL PROVIDER which is an AAD account. In addition, the CREATE USER T-SQL statement supports an EXTERNAL PROVIDER with an AAD account to provide authentication to users in a database without the need for a login. In addition. AAD groups are also supported.

One of the benefits of AAD is support for advanced authentication methods such as Multi-factor authentication. SQL Server 2022 supports the following AAD authentication methods:

- Azure Active Directory Password
- Azure Active Directory Integrated
- Azure Active Directory Universal with Multi-Factor Authentication
- Azure Active Directory access token

You can learn more about SQL Server and Azure Active Directory (AAD) authentication at https://aka.ms/sqlserveraad.

## Stay protected with Microsoft Defender for SQL

Microsoft Defender for SQL, part of the Microsoft Defender for Cloud, supports Defender for SQL Server on machines including an Azure Arc-enabled SQL Server.

## The challenge

Ensuring your SQL Server and data is protected is critical to any business. Security professionals are always looking to find ways to stay ahead of security threats to SQL Server in a robust and reliable fashion.

## The solution

Microsoft Defender for SQL provides a reliable and industry-proven method to detect security vulnerabilities and provide advanced threat protection for SQL Server. You can enable Microsoft Defender for SQL by registering SQL Server 2022 using the Azure extension for SQL Server to make the instance an Azure Arc-enabled SQL Server.

Microsoft Defender for SQL Server provides two main capabilities:

### Vulnerability Assessment

Microsoft Defender will scan your SQL Server configuration and provide recommendations on possible security vulnerabilities based industry standards such as CIS and FedRAMP.

### Advanced Threat Protection

Microsoft Defender will monitor possible security threats to your SQL Server instance and alert you including SQL injection attacks, suspicious login activity, and brute force attacks among others.

You can learn more about Microsoft Defender for SQL at https://aka.ms/defendersqlserver.