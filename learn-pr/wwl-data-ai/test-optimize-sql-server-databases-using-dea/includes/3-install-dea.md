The **Database Experimentation Assistant (DEA)** is installed and runs locally on your machine. After installation, you just need the credentials and network connections to run it against your company's SQL Server instances.

You provide database support for a call center, and need to assess the potential impact of a database upgrade. You'll use the DEA to test the workload of your databases on SQL Server 2019. After installing the DEA, you'll connect to SQL Server 2019 and run a trace to replay a typical workload then assess database performance. Start by working through the steps to install and prepare the DEA.

In this unit, you'll see how to install the DEA, and the information you need to run it in different scenarios.

## What must be installed?

The DEA can be downloaded and installed on the machine from which you currently administer SQL Server. DEA is a standalone application with no dependencies other than credentials for the SQL Servers you want to run your traces on.

## How to install the Microsoft Database Experimentation Assistant

Download the latest version of the installation package from the Microsoft website to your local machine. Supported client operating system versions include Windows 10, Windows 8.1, and Windows 8. The DEA is supported on Windows Server 2012 and Windows Server 2016, but it's best practice to install the software on your local machine. The DEA requires the .NET Framework 4.5, or above.

After downloading and installing DEA, you'll connect to the SQL Server on which you want to run the trace capture. You must have SQL Server 2014 or later. The DEA has to access a folder location for storing trace captures, and the SQL Server account you use to run the trace needs write permissions on this folder. If you run the trace on Azure SQL Database or SQL Server on an Azure virtual machine, you'll supply the Azure Blob storage account's SAS URI.

The Microsoft DEA can be installed on your client machine. You then connect to your on-premises SQL Server instances and cloud-based Azure SQL Databases. It's recommended to run the DEA against your development test databases, before running DEA on your production servers.