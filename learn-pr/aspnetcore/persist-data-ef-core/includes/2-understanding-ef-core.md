Entity Framework Core (EF Core) is an *object-relational mapper (ORM)*. An ORM provides a layer between the domain model that you implement in code and a database. EF Core is a data access API that allows you to interact with the database by using .NET *plain old Common Runtime Language (CLR) objects (POCOs)* and strongly typed *Language Integrated Query (LINQ)* syntax.

In EF Core, the database is abstracted behind .NET POCOs. EF Core handles direct interaction with the underlying database. When you use this API, you can spend less time translating requests to and from the database and writing SQL, and more time focusing on important business logic.

With EF Core, you can:

- Load data as C# objects (entities).
- Add, modify, and delete data by calling methods on the entities.
- Map multiple database tables to a single C# entity.
- Handle concurrency issues that arise when multiple users simultaneously attempt to update the same record.
- Use strongly typed LINQ (<xref:System.Linq?displayProperty=nameWithType>) syntax to query the database.
- Access [multiple databases](/ef/core/providers/), including SQL Server, SQLite, Azure Cosmos DB, PostgreSQL, MySQL, and more.
- Build your domain model from an existing database.
- Manage your database schema based on your domain model.
- Commit changes to complex, deep, or wide object graphs of related entities by using a single method call.

## Review EF Core architecture

The following diagram depicts the architecture of EF Core:

:::image type="content" source="../media/ef-core-architecture.png" border="false" alt-text="Diagram that shows components and processes in the Entity Framework Core architecture.":::

[DbContext](/ef/core/dbcontext-configuration) is a special class that represents a unit of work. `DbContext` provides methods that you can use to configure options, connection strings, logging, and the model that's used to map your domain to the database.

Classes that derive from `DbContext`:

- Represent an active session with the database.
- Save and query instances of entities.
- Include properties of type `DbSet<T>` that represent tables in the database.

The EF Core Provider translates object graph changes to SQL.

The database provider:

- Is a plug-in library that's designed for a specific database engine, such as SQL Server, Azure Cosmos DB, or PostgreSQL.
- Translates method calls and LINQ queries to the database's native SQL dialect.
- Extends EF Core to enable functionality that's unique to the database engine.

## Manage database schemas

EF Core provides two primary ways of keeping your EF Core model and database schema in sync:

- **Migrations** (*model* as source of truth)
- **Reverse engineering** (*database* as source of truth)

To choose between these options, decide whether your EF Core model or the database schema is the *source of truth*.

### Migrations

In real-world projects, data models change as app features are implemented. As new entities are added and removed, the database schemas need to be changed accordingly. The EF Core migrations feature provides a way to incrementally update the database schema to keep it in sync with the application's data model while preserving existing data in the database.

When a data model change is introduced, the developer uses EF Core tools to add a corresponding migration. EF Core compares the current model against a snapshot of the previous model to determine the differences. C# code to implement the changes is generated. The C# files can be modified for custom behaviors or to seed data. The files are tracked in your project's source control like any other source file.

After a new migration is generated, it can be applied to a database in various ways. EF Core records all applied migrations in a special history table. The history table keeps a record of which migrations have been applied.

### Reverse engineering

Reverse engineering is the process of scaffolding entity model classes and a `DbContext` class based on a database schema. This approach is often used with existing or shared databases that are managed by a database administrator.

In the next unit, you'll get started with EF Core by using a migration.
