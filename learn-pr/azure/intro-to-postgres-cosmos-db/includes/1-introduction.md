PostgreSQL is the world’s most advanced open source relational database.

In 1985, researchers at the University of California, Berkeley, began work on an entirely new database that would fix the problems of contemporary systems. The new system proved so popular that the project was soon overwhelmed by user requests for support and new features. The software was open-sourced in 1994, and subsequent community development has given PostgreSQL - also known as Postgres - an incredibly rich feature set and extraordinary extensibility.

## Flexible by design

PostgreSQL is an object-relational database system, similar to MySQL and Microsoft SQL Server. While you can store data in relational tables, a PostgreSQL database also enables the storage of custom data types, with their own non-relational properties.

By design, Postgres extensions can be loaded into the database and function just like features that are built in. Users can access a trove of extensions, as you would expect from over two decades of open-source community development.

Postgres is used throughout the computing world, in everything from acting as the default database system in macOS Server, to collecting telemetry data from the International Space Station, to powering some of the world’s most well-known applications, like Reddit and Instagram.

## PostgreSQL on Azure

:::row:::
:::column span="2":::

The PostgreSQL layer is based on the popular open-source PostgreSQL Community Edition, giving you access to a wide range of extensions. PostgreSQL is designed to handle a range of workloads, from single machines to data warehouses or Web services with many concurrent users.

PostgreSQL has its own query language called pgsql. This language is a variant of the standard relational query language, SQL, with features that enable you to write stored procedures that run inside the database. However, Azure Cosmos for PostgreSQL allows you to work with popular frameworks and languages such as Ruby on Rails, Python with Django, Java with Spring Boot, .NET, and Node.js.

:::column-end:::
:::column span="2":::

![Diagram explaining Azure Postgres benefits: High availability, fully managed, intelligent performance.](../media/1a-azure-postgres-benefits.png)

:::column-end:::
:::row-end:::

As an example, let’s say you work for Woodgrove Bank. Woodgrove Bank has a contactless payment app that works from six feet away, and the data is stored in a single, on-premises PostgreSQL database. Based on a successful trial of the app, Woodgrove Bank would like to release the app to customers across Europe and the United States. As the app needs to scale, the data will need to scale as well. Azure Cosmos DB for PostgreSQL is built to host PostgreSQL databases and support them at scale. The Woodgrove Bank development team is unfamiliar with a distributed environment, and as their tech lead, you have the most experience to lead them in this growth.

If your app was released, the on-premises server could easily become overloaded, which might cause slow transaction times, or even customer data loss or corruption. To avoid this problem, you need to scale the database solution for both capacity and performance. It's also a good idea to host data in more than one location, which means moving away from your current on-premises database server, without compromising security.

You'll start by looking at how Azure Cosmos DB for PostgreSQL processes a query at a high level and what it means to scale. Once you're aware of those tables, you'll talk through design considerations using Woodgrove Bank's already proven relational model and how it changes in the distributed environment. The devs will have questions along the way, and you'll have the tools to talk through modeling and altering configuration as needed.

As you’re considering cloud-hosted database offerings, consider usability, scalability, and security. In this module, we'll refer back to the payment app scenario to evaluate the qualities of Azure Cosmos DB for PostgreSQL and assess use cases.

## Prerequisites

- Basic knowledge of relational databases

## Learning objectives

In this module, you will:

- Describe the components of Azure Cosmos DB for PostgreSQL
- Identify situations when to use Azure Cosmos DB for PostgreSQL
