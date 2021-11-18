Entity Framework Core is an object-relational mapper, or ORM. The purpose of an ORM is to provide a layer between your programming language and the database. It is designed to allow you to focus on your programming strengths without having to learn a new language. It also keeps you from getting stuck with unnecessary overhead by eliminating much of the ritual and ceremony involved with connecting to a database. 

Another goal is to simplify certain tasks. For example, one approach to managing data is to work with a _graph_ or a network of object relationships. Imagine a point-of-sale system that tracks an order. An order has individual items that include a quantity and price. How do you know when the user changes the quantity of an order detail? Instead of writing code to figure out the differences between the original order and the updated one, ORMs like Entity Framework Core track these changes for you. They automatically batch the changes together and apply them to the database in a single transaction.

With Entity Framework Core, you are able to:

- Load data as C# classes.
- Add, modify, and delete data.
- Map multiple database tables to a single C# entity.
- Handle concurrency issues that arise when multiple users attempt to update the same record at the same time.
- Use strongly-typed Language Integrated Query (<xref:System.Linq?displayProperty=nameWithType>) syntax to query the database.
- Work with [multiple databases](https://docs.microsoft.com/ef/core/providers/) including SQL Server, Sqlite, Azure Cosmos DB, PostgreSQL, MySQL, and more.
- Build your domain model from an existing database.
- Manage your database schema based on your domain model.

## EF Core terminology

As you learn EF Core and browse the documentation, you may come across some unfamiliar terms. Don't be concerned if you aren't familiar with a particular concept. EF Core is designed with flexibility in mind. You can build simple apps with only a few lines of code. However, for larger and more complex projects, EF Core provides APIs to configure and use advanced features. This makes it perfect for projects of all sizes. These terms will become more familiar as you work through this module.

- __DbContext__: A special class that is used to configure and map a set of entities to the database.
- __Connection string__: A set of instructions for connecting to the database that includes information like the database name and user credentials.
- __DbContextOptions__: A special class that is used to configure EF Core by specifying information such as the database connection, logging, and tracing.
- __Entity__: A business object represented in .NET by a class and in the database as a table or tables.
- __Model__: A representation of the mapping or translation between your classes and the database.
- __Concurrency__: The state when two or more users simultaneously access the same resources.
- __Migration__: A migration represents a set of changes to the database schema and related code that should be deployed as a unit to keep the code and database in sync.
- __Optimistic concurrency__: A method of dealing with concurrency issues by assuming they are rare and treating them as an exception case.
- __Query__: A database request that may contain filters, aggregation, and sort criteria.
- __Server evaluation__: The part of the query that is handled by the database.
- __Client evaluation__: The part of the query that is handled by the client or your application.
- __Tracked entity__: An entity that EF Core will track changes on to automatically manage updates.
- __Change tracking__: A set of APIs that handle tracked entities.
- __Provider__: A plug-in to EF Core that manages a particular database. For example, if your target database is SQL Server then you would use the SQL Server provider.

## How to build a blog database

Imagine you've been assigned the task to create a set of corporate blogs. You decide to try out Entity Framework Core. You determine that the domain model is a collection of department-specific blogs that each contain a collection of posts. A typical workflow for Entity Framework Core looks like this:

1. Build your domain classes.
1. Add a package reference to your project to `Microsoft.EntityFrameworkCore.<provider>` where `<provider>` represents the database you will use. For example, to use SQlite you reference `Microsoft.EntityFrameworkCore.Sqlite`.
1. Create a class named `BlogContext` that inherits from `[DbContext](xref:Microsoft.EntityFrameworkCore.DbContext)`.
1. Add a constructor that takes configuration options and exposes a special property called a `DbSet` for each entity you are tracking.
1. Choose your approach to manage the database. The three main options are:
    1. The database is created separately and EF Core simply uses the database already there. Your code is manually updated to reflect the relationships.
    1. The database is used to automatically generate your C# classes. This is referred to as _database-first_.
    1. The database is created from code (_code-first_).

After you have the foundation is in place, you can easily query your database to find the first blog post in or after September:

```csharp
using var context = new BlogContext();
var filter = new DateTime(2021, 09, 01);
var firstPost = await context.Posts.Where(p => p.Posted >= filter)
    .OrderBy(p => p.Posted)
    .FirstOrDefaultAsync();
```

Updating the category is then as simple as:

```csharp
firstPost.Category = "Fall";
await context.SaveChangesAsync();
```

EF Core can do much more than query or update database records. Next, let's look at how EF Core works.
