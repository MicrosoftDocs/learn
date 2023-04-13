Entity Framework Core is an **object-relational mapper**. ORMs provide a layer between the domain model you implement in code and the database. EF Core is a data access API that allows you to interact with the database using .NET POCOs (**P**lain **O**ld **C**LR **O**bjects) and strongly typed LINQ. This allows you to spend less time translating requests to and from the database and writing SQL, giving you more time to focus on important business logic.

With EF Core, the database is abstracted behind .NET POCOs. As a result, you can focus on your code, and EF Core handles direct interaction with the underlying database.

With EF Core, you can:

- Load data as C# objects (entities).
- Add, modify, and delete data by calling methods on those entities.
- Map multiple database tables to a single C# entity.
- Handle concurrency issues that arise when multiple users simultaneously attempt to update the same record.
- Use strongly typed Language Integrated Query (<xref:System.Linq?displayProperty=nameWithType>) syntax to query the database.
- Access [multiple databases](/ef/core/providers/) including SQL Server, SQLite, Azure Cosmos DB, PostgreSQL, MySQL, and more.
- Build your domain model from an existing database.
- Manage your database schema based on your domain model.
- Commit changes to complex, deep, and/or wide object graphs of related entities with a single method call.

## Review EF Core architecture

The following diagram depicts the architecture behind EF Core.

![Diagram of EF Core Architecture.](../media/ef-core-architecture.png)

The [DbContext](/ef/core/dbcontext-configuration) is a special class that represents a unit of work and provides methods to configure options, connection strings, logging, and the model used to map your domain to the database. Classes deriving from `DbContext`:

- Represent an active session with the database.
- Save and query instances of entities.
- Include properties of type `DbSet<T>` representing tables in the database.

The EF Core Provider translates object graph changes to SQL.

The Database Provider:

- Is a plug-in library designed for a specific database engine, such as SQL Server, Azure Cosmos DB, or PostgreSQL.
- Translates method calls and LINQ queries to the database's native SQL dialect.
- Extends EF Core to enable functionality that's unique to the database engine.

## Manage database schemas

EF Core provides two primary ways of keeping your EF Core model and database schema in sync. To choose between the two, decide whether your EF Core model or the database schema is the *source of truth*.

### Migrations (Model as the source of truth)

In real world projects, data models change as app features get implemented. As new entities are added and removed, the database schemas need to be changed accordingly. EF Core migrations provide a way to incrementally update the database schema to keep it in sync with the application's data model while preserving existing data in the database.

When a data model change is introduced, the developer uses EF Core tools to add a corresponding migration. EF Core compares the current model against a snapshot of the old model to determine the differences. C# code to implement the changes is generated. The C# files can be modified for custom behaviors or to seed data, and are tracked in your project's source control like any other source file.

Once a new migration has been generated, it can be applied to a database in various ways. EF Core records all applied migrations in a special history table. The history table keeps a record of which migrations have been applied.

### Reverse engineering (Database as the source of truth)

Reverse engineering is the process of scaffolding entity model classes and a `DbContext` class based on a database schema. This approach is often used with existing or shared databases that are managed by a DBA.

## Get started

In the next unit, you'll get started with EF Core by using migrations.
