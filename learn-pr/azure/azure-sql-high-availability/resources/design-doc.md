# Title

Azure SQL - Achieve high availability
(Azure SQL fundamentals learning path 5/6)

## Role(s)

- Data Engineer
- Solution Architect
- Developer
- Technology manager

## Level

- Intermediate to Advanced

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
- Complete the **Introduction to Azure SQL**, **Azure SQL - Deploy and Configure**, **Azure SQL - Securing your data**, and **Azure SQL - Deliver consistent performance** modules as part of the **Azure SQL Learning Path** (highly recommended but not required).  

## Summary

In this hands-on, scenario-driven module, you'll learn how to translate your existing SQL Server expertise to Azure SQL including Azure SQL Database and Azure SQL managed instance. At the end of the module, you should have a foundational knowledge of what to use when, as well as how to configure, monitor, and troubleshoot availability for SQL Server in Azure. Depending on the SLA your business requires, Azure SQL has the options you need including built-in capabilities. You will learn how to translate your knowledge of backup/restore, Always On failover cluster instances, and Always On availability groups with the options for business continuity in Azure SQL.    

## Learning objectives

After this module, you should be able to:
<br>

- Determine which Azure SQL deployment option and service tier should be used for scenarios that meet the needs of your application.
- Deploy, configure, monitor, and troubleshoot availability scenarios in Azure SQL using both familiar and new tools and techniques.
- Harness the "power of the cloud" including automation and intelligent capabilities of Azure SQL.
- Translate your existing SQL Server expertise to Azure SQL expertise.  

The goal of this module is to train experienced SQL Server professionals.  

## Outline the units 

1. **Introduction**

1. **Availability Capabilities and tasks**  
    - Be able to explain the capabilities and tasks related to Azure SQL Database and Managed Instance  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md  

1. **Backup/restore**  
    - Understand how backup and restore is different for Azure SQL Database and Managed Instance compared to SQL Server on premises or in an Azure VM.  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#5.1  
1. **(Bonus) Exercise: Restore to a point in time**  
    - Be able to leverage PITR to undo common errors  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#1  

1. **High availability by Service Tier**  
    - Understand the difference in architecture and availability provided by each of the service tiers for Azure SQL Database and Managed Instance  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#5.2  
1. **Exercise: General purpose high availability**  
    - Take a look at the availability of a General Purpose Azure SQL Database.  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#2  

1. **Exercise: Business critical high availability**  
    - Be able to switch service tiers
    - Evaluate the improvements in availability when moving from General Purpose to Business Critical in Azure SQL Database
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#3  

1. **Configuring Availability**  
    - Be able to configure Azure SQL Database for the uptime you require  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#5.3  

1. **(Bonus) Exercise: Geo-distributed auto-failover groups with read-scale**  
    - Understand the scenarios for geo-replication and auto-failover groups
    - Understand the differences between geo-replication and auto-failover groups
    - Deploy and observe auto-failover groups with read-scale
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/05-Availability.md#4  

1. **Monitoring and troubleshooting availability**  
    - Understand the tools and processes for monitoring and troubleshooting availability in Azure SQL Database and Managed Instance  

1. **Summary of the Azure SQL learning path and next steps**  
    - Summary of the learning path
    - References for further learning


## Notes

This workshop is a port from https://github.com/microsoft/sqlworkshops-azuresqlworkshop. 

GitHub repository for the existing workshop - https://github.com/microsoft/sqlworkshops-azuresqlworkshop
