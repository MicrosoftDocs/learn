Entity Framework Core is an **object-relational mapper**. ORMs provide a layer between your programming language and the database. With EF Core, the database is abstracted behind .NET POCOs, **P**lain **O**ld **C**LR **O**bjects) As a result, you can focus on your code and EF Core handles direct interaction with the database. 

With EF Core, you can:

- Load data as C# objects (entities).
- Add, modify, and delete data calling methods on those entities.
- Map multiple database tables to a single C# entity.
- Handle concurrency issues that arise when multiple users simultaneously attempt to update the same record.
- Use strongly-typed Language Integrated Query (<xref:System.Linq?displayProperty=nameWithType>) syntax to query the database.
- Access [multiple databases](https://docs.microsoft.com/ef/core/providers/) including SQL Server, Sqlite, Azure Cosmos DB, PostgreSQL, MySQL, and more.
- Build your domain model from an existing database.
- Manage your database schema based on your domain model.

## Review EF Core architecture

The following diagram depicts the architecture behind EF Core.

![EF Core Architecture.](../media/ef-core-architecture.png)

Classes deriving from `DbContext`:

- Represent an active session with the database.
- Save and query instances of entities.
- Include properties of type `DbSet<T>` representing tables in the database. If a table doesn't already exist in the database, it will be created.

The EF Core Provider translates object graph changes to SQL.

The Database Provider:

- Is a plug-in library designed for a specific database engine, such as SQL Server, Azure Cosmos DB, or PostgreSQL.
- Accepts SQL from the EF Core Provider and executes it in the database.
- Extends EF Core to enable functionality that's unique to the database engine.

## The schema "source of truth"

When using an ORM, which system represents the true data domain? Is When writing apps using EF Core, there are three ways to think of where the data schema's "source of truth" resides.

### Model as the source of truth (code-first)

When using the model as the source of truth, you write your entity classes and `DbContext` first. EF Core generates the database schema based on your C# entity classes. This is also referred to as **code-first development**.

### Database as the source of truth (database-first)

In many development scenarios, developers have no control over the database schema. Perhaps the database is part of a legacy application, or the organization has dedicated DBAs to handle all database design. In these cases, you can use EF Core's tools to generate C# entity classes.

### Hybrid

**TODO** Need text here!!! Jeremy or Arthur, please help!!!

## Getting started

In the next unit, you'll get started by downloading the sample web API app. After that, you'll define entity classes and use EF Core to
