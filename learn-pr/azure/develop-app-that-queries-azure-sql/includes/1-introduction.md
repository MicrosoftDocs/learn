Azure SQL Database is a service that you use to create a relational database in the cloud that's compatible with Microsoft SQL Server. SQL Database is highly scalable. It can support many thousands of concurrent requests. In SQL Database, you can define tables and then insert, update, delete, and query data.

Imagine that you work as a developer for a university. The university is creating a web application that academic advisors will use to discuss courses and plans of study with students. The development team wants to use SQL Database to store their data, which is currently in comma-delimited text files. They're planning to create a .NET Core app for advisors to use initially. They need to know how to create and manipulate a database and how to connect an ASP.NET application to query the database.

You'll create a single database by using the SQL Database service. You'll see how to import data into the database and query this data. Finally, you'll configure a web application to connect to and query the database.

SQL Database currently supports three deployment options: single, elastic pool, and managed instance. We'll focus on the single-database deployment option.

## Learning objectives

In this module, you will:

- Create, configure, and populate a single database in SQL Database
- Configure an ASP.NET application to query the database

## Prerequisites

- Basic familiarity with relational databases
- Basic knowledge of C#
