# Title

Azure SQL - Deploy and Configure  
(Azure SQL fundamentals learning path 2/6)

## Role(s)

- Data Engineer
- Solution Architect
- Developer
- Technology manager

## Level

- Intermediate

## Product(s)

- Azure SQL Database
- Azure SQL Managed Instance
- Azure VM
- Azure Data Studio
- SSMS
- Azure PowerShell
- Azure CLI

## Prerequisites

- Understand and are experienced in working with, maintaining, and developing with SQL Server. If you are new to this, you can review the following book by Bob Ward: [Pro SQL Server on Linux.](https://www.oreilly.com/library/view/pro-sql-server/9781484241288/) This book (available online) introduces SQL Server on Linux, but in the process walks through fundamental SQL Server topics
- Familiarity with the general structure of Azure will be helpful, but not required. The [Azure fundamentals learning path](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/) will help you understand the fundamentals of Azure at a general level (not data focused).  
- Complete the **Introduction to Azure SQL** module as part of the **Azure SQL Learning Path** (highly recommended but not required).  

## Summary

In this hands-on, scenario-driven module, you'll learn how to translate your existing SQL Server expertise to Azure SQL including Azure SQL Database and Azure SQL managed instance. At the end of the module, you should have a foundational knowledge of how to configure, monitor, and troubleshoot the deployment scenarios for SQL Server in Azure. You will learn about not only the "what", but also the "how" and the "why". We'll cover deployment, configuration, and other getting started tasks for Azure SQL. You'll learn how you should plan for deployment, deploy and verify your deployment, and how it compares to SQL Server. Then, you'll learn how deploying and configuring databases compares among deployment options, plus some insights on loading data.  

## Learning objectives

After this learning path, you should be able to:
<br>

- Deploy, configure, monitor, and troubleshoot deployment scenarios in Azure SQL using both familiar and new tools and techniques.
- Harness the "power of the cloud" including automation and intelligent capabilities of Azure SQL.
- Translate your existing SQL Server expertise to Azure SQL expertise.  

The goal of this module is to train experienced SQL Server professionals.  

## Outline the units

1. **Introduction**

1. **Plan, deploy, and verify**
    - Understand the decision points and choices available when deploying Azure
    - SQL Database and Managed Instance
    - Prepare for deployment by understanding Azure constructs, governance, and space management
    - Understand the various scenarios and what planning is involved
    - Get an overview and further references related to how to migrate
    - https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#2.1 

   **Deploy and verify**
    - Understand the deployment process and architectures for Azure SQL Database and Managed Instance  
    - https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#2.2

1. **Exercise: Deploy Azure SQL Database**

    - Deploy Azure SQL Database with a sample database, and connect to it using common SQL tools
    - https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#1
    - https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#2

1. **Exercise: Verify Azure SQL Database**
    - Verify the Azure SQL deployment selections you made and that the database was deployed properly
    - Understand the differences between various deployment options (SQL Database, SQL Managed Instance, and SQL Server on Azure Virtual Machines)  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#3

1. **Configure**

    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#2.3

1. **(Bonus) Exercise: Configure with Azure CLI**
    - Understand configuration options available and when to use
    - Configure connections policies using the Azure CLI  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#4

1. **Load data**
    - Understand common methods for loading data  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#2.4

1. **(Bonus) Exercise: Load data**
    - Bulk insert from Azure Storage into Azure SQL Database  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/02-DeployAndConfigure.md#5

1. **Summary and next steps**  
    - Summary of the module
    - References for further learning  

## Notes

This workshop is a port from https://github.com/microsoft/sqlworkshops-azuresqlworkshop. 

GitHub repository for the existing workshop - https://github.com/microsoft/sqlworkshops-azuresqlworkshop
