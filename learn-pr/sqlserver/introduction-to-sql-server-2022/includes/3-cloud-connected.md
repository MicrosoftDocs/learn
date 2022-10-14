SQL Server 2022 enables rich hybrid data platform capabilities to connect to the Azure cloud for disaster recovery, analytics, and security.

## SQL Server is a hybrid data platform

SQL Server 2022 connects to the cloud with the following Azure services as seen in the following figure:

<!-- TODO: Put in image here showing overall hybrid data platform story -->

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

## Central governance with Microsoft Purview

## Central authentication using Azure Active Directory

## Stay protected with Microsoft Defender for SQL