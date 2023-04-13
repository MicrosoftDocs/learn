In the previous unit, you learned how to persist data to an in-memory database. Persisting data to an in-memory database is useful in development. But, because all data is lost when the application is restarted, it isn't suitable for production. In production, you should persist data to a database like SQL Server, MySQL, PostgreSQL, or SQLite.

## Database providers abstract database access from the application code

One of the benefits of performing database access through an abstraction layer like Entity Framework (EF) Core is that it decouples your application from the database provider. You can change the database provider without rewriting your database access code. You shouldn't expect to be able to switch database providers without any effect to your application code, but the changes will be minimized and localized.

A related advantage of using EF Core is that you can reuse your code, experience, and data access libraries to work with any other EF Core database provider.

For this tutorial, you'll use [SQLite database](https://www.sqlite.org/index.html?azure-portal=true), but you might also use one that works better for you. EF Core currently supports more than 20 [Database Providers](/ef/core/providers/?tabs=dotnet-core-cli?azure-portal=true).

## Steps to add a new database provider

In general, you'll use the following steps to implement a new database provider:

1. Add one or more NuGet packages to your project to include the database provider.
1. Configure the database connection.
1. Configure the database provider in the ASP.NET Core services.
1. Perform database migrations.

In the next unit, you'll walk through the steps to add the SQLite database provider. Similar steps will apply for other database providers.
