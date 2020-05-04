# Title

Azure SQL - Securing your data    
(Azure SQL fundamentals learning path 3/6)

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
- Complete the **Introduction to Azure SQL** and **Azure SQL - Deploy and Configure** modules as part of the **Azure SQL Learning Path** (highly recommended but not required).  

## Summary

In this hands-on, scenario-driven module, you'll learn how to translate your existing SQL Server expertise to Azure SQL including Azure SQL Database and Azure SQL managed instance. At the end of the module, you should have a foundational knowledge of what to use when, as well as how to configure, monitor, and troubleshoot the Security topics related to SQL Server in Azure. Ensuring security and compliance of your data is always a top priority. You'll learn how to use Azure SQL to secure your data, how to configure logins and users, how to use tools and techniques for monitoring security, how to ensure your data meets industry and regulatory compliance standards, and how to leverage the extra benefits and intelligence that is only available in Azure. We'll also cover some of the networking considerations for securing SQL.

## Learning objectives

After this module, you should be able to:
<br>

- Deploy, configure, monitor, and troubleshoot security scenarios in Azure SQL using both familiar and new tools and techniques.
- Harness the "power of the cloud" including automation and intelligent capabilities of Azure SQL.
- Translate your existing SQL Server expertise to Azure SQL expertise.  

The goal of this module is to train experienced SQL Server professionals.  

## Outline the units

1. **Introduction**

1. **Security Capabilities and Tasks**  
    - Understand the capabilities and tasks required to secure Azure SQL Database and Managed Instance  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md  

1. **Exercise: Configure Auditing**  
    - Understand the auditing configurations available for Azure SQL Database and Managed Instance
    - Configure auditing for Azure SQL Database
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#1  

1. **Exercise: Authentication**  
    - Understand the authentication methods available for Azure SQL Database and Managed Instance
    - Walk through several authentication scenarios, including Azure Active Directory  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#3.2  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#4  

1. **Exercise: Network Security**  
    - Understand the network security options and scenarios related to Azure SQL Database and Managed Instance
    - Set and manage firewall rules, virtual network rules, and Private Link  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#3.1  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#2  

1. **Data protection**  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#3.3    
    Include confirm TDE here   
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#5    

1. **Security management**  
    - Be able to configure and understand monitoring, auditing, and logging features in Azure SQL Database and Managed Instance  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#3.4  

1. **Exercise: Security management and Advanced data security**  
    - Be able to monitor and configure Advanced data security capabilities including DMVs, metrics, and alerts
    - Understand some of the common scenarios and how Advanced data security can help  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#3.4  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#6  

1. **(Bonus) Exercise: Data classification, Dynamic data masking, and SQL Audit**  
    - Combine technologies from the module to a scenario where you need to configure and track access to sensitive data  
    https://github.com/microsoft/sqlworkshops-azuresqlworkshop/blob/master/azuresqlworkshop/03-Security.md#7  

1. **Summary and next steps**  
    - Summary of the module
    - References for further learning


## Notes

This workshop is a port from https://github.com/microsoft/sqlworkshops-azuresqlworkshop. 

GitHub repository for the existing workshop - https://github.com/microsoft/sqlworkshops-azuresqlworkshop
