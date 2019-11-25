# Title

Develop and configure an ASP.NET application that queries an Azure SQL Database

## Role(s)

- Developer
- Solution Architect

## Level

- Beginner

## Product(s)

- Azure SQL Database

## Prerequisites

- Basic familiarity with relational databases
- Basic knowledge of C#

## Summary

Create a database on Azure SQL to store data for an application, and create an ASP.NET application to query data from the database.

## Learning objectives

1. Create, configure, and populate an Azure SQL Database
1. Develop an ASP.NET application that queries an Azure SQL Database

## Chunk your content into subtasks

Identify the subtasks of *Develop and configure an ASP.NET application that queries an Azure SQL Database*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create an Azure SQL database | ...know how to create and manipulate an Azure SQL database... | Exercise | 1 | Yes |
| Manipulate an Azure SQL database | ...know how to create and manipulate an Azure SQL database... | Exercise | 1 | Yes |
| Import data into an Azure SQL database | ...use Azure SQL Database to store data... | Exercise | 1 | No, combine with previous subtask |
| Connect an ASP.NET application to query data from Azure SQL | ...connect an ASP.NET application to query data... | Exercise | 2 | Yes |

## Outline the units

1. **Introduction**

    An educational institution is creating a web application that academic advisors can use to discuss courses and plans of study with students. The development team would like to use Azure SQL Database to store their data, which is currently stored as comma delimited data in text files. They are planning to create a .NET Core app for the advisors to use initially. They need to know how to create and manipulate an Azure SQL Database, and how to connect an ASP.NET application to an Azure SQL Database to query data.

1. **Create tables, bulk import, and query data**

    List the content that will enable the learner to *Manipulate an Azure SQL Database* and *Import data into an Azure SQL Database*:

    - Create database
        - Use the portal to create a database
    - Create tables
        - Discuss tables and schema
        - Use the Query editor in the portal to create tables
        - Use `sqlcmd` in Cloud Shell to create tables
    - Bulk import data with `bcp`
        - Overview of `bcp` utility and how bulk import works
        - Download sample data in Cloud Shell
        - Run `bcp` to bulk import data into the database
    - Query data
        - Use the query editor to query data
        - Use `sqlcmd` in Cloud Shell to query data

1. **Exercise - Create tables, bulk import, and query data**

    1. Create database in the portal
    1. Enable access from Azure services
    1. Connect to database with Query Editor
    1. Download sample data in Cloud shell
    1. Create tables in Query editor or Cloud Shell
    1. Use `bcp` in Cloud Shell to import data
    1. Query data in Cloud Shell
    1. Query data in Query editor

1. **Connect an ASP.NET application to Azure SQL Database**

    List the content that will enable the learner to *Connect an ASP.NET application to query data from Azure SQL*:

    - Use `System.Data.SqlClient` to connect and query data
        - Discuss how SqlClient works and how to use the connection string to to easily connect the application to Azure SQL

1. **Exercise - Connect an ASP.NET application to Azure SQL Database**

    1. Get SQL connection string
    1. Create new ASP.NET web application
    1. Insert application code and code to connect to Azure SQL
    1. Build and run application

1. **Summary**

    You now know how to create, manipulate, and load an Azure SQL database, and can create an ASP.NET application to query the database.

## Notes

Use the following documents as a guide for content. Use the Cloud Shell for command interactivity and the Query Editor in the portal instead of SSMS.

Go through this document first.

https://docs.microsoft.com/azure/sql-database/sql-database-design-first-database

Then go through these two, first for a .NET Core console app and second for an ASP.NET web application. Will need to modify them to query data from the student info.

https://docs.microsoft.com/azure/sql-database/sql-database-connect-query-dotnet-core
https://docs.microsoft.com/azure/app-service/app-service-web-tutorial-dotnet-sqldatabase
