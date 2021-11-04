In the previous unit, you learned how to persist data to an in-memory database. This is useful in development, but since all data is lost when the application is restarted, it is not at all suitable for production. In production, you should persist data to a database like SQL Server, MySQL, PostgreSQL, SQLite, etc.

## Database providers abstract database access from the application code

One of the benefits of performing database access through an abstraction layer like EF Core is that it decouples your application from the database provider. This means that you can change the database provider without rewriting your database access code. You shouldn't expect to be able to switch database providers without any impact to you application code, but the changes will be minimized and localized.

A related advantage of using EF Core is that you can reuse your code, experience, and data access libraries to work with any other EF Core database provider.

For this tutorial, you will be using [SQLite database](https://www.sqlite.org/index.html?azure-portal=true) but, you may use one that works better for you. EF Core currently supports over 20 database providers, listed in the [documentation](/ef/core/providers/?tabs=dotnet-core-cli).

## Steps to add a new database provider

In general, you will use the following steps to implement a new database provider:

1. Add one or more NuGet packages to your project to include the database provider.
1. Configure the database connection.
1. Configure the database provider in the ASP.NET Core services.
1. Perform database migrations.

In the following exercise, you will walk through the steps to add the SQLite database provider. Similar steps will apply for other database providers.
