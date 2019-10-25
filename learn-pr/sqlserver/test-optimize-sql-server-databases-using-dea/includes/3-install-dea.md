The **Database Experimentation Assistant (DEA)** is installed and run locally on your machine. Once installed all you need are the credentials and network connections to run it against your companies SQL Servers instances.

Suppose you provide database support for a call center, and you need to assess the potential impact of a database upgrade. You have decided to use the DEA to test the workload of your databases on SQL Server 2017. After installing the DEA, you can connect to SQL Server 2017 and run a trace to replay a typical workload and assess the performance of the database. You'll start by working through the steps to install and prepare the DEA.

In this unit, you'll see how to install the DEA, and the information you need to run it in different scenarios.

## What must be installed?

The DEA can be downloaded and installed on the machine from which you currently administer SQL Server. DEA is a standalone application with no dependencies other than credentials for the SQL Servers you want to run your traces on.

## How to install the Microsoft Database Experimentation Assistant

Download the latest version of the installation package from the Microsoft website to your local machine. Supported client operating system versions include Windows 10, Windows 8.1, and Window 8. The DEA is supported on Windows Server 2012 and Windows Server 2016, but it is best practice to install the software on your local machine. The DEA requires the .NET Framework 4.5, or above.

After downloading and installing DEA, you will connect to the SQL Server on which you want to run the trace capture. This must be SQL Server 2014 or later. The DEA requires access to a folder location for storing trace captures, and the SQL Server account you use to run the trace needs write permissions on this folder. If you run the trace on Azure SQL Database or SQL Server on an Azure virtual machine, you need to supply the Azure blob storage account's SAS URI.

## Summary

The Microsoft DEA can be installed on your client machine, which enables you to connect to your on-premise SQL Servers instances and cloud-based Azure SQL Databases. As best practice, you should first run the DEA against your development test databases, prior to running DEA on your production servers.
