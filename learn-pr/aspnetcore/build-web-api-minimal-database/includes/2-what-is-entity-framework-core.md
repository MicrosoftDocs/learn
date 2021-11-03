Most non-trivial web applications will need to reliably perform create, read, update, and delete (CRUD) operations on data, and persist these changes between application restarts. While there are a variety of options for persisting data in .NET applications, Entity Framework (EF) Core is a user-friendly solution and a great fit for many .NET applications.

## Understanding Entity Framework (EF) Core

Entity Framework Core is a lightweight, extensible, open source and cross-platform data access technology for .NET applications.

EF Core can serve as an object-relational mapper (O/RM), which:

- Enables .NET developers to work with a database using .NET objects.
- Eliminates the need for most of the data-access code that typically needs to be written.

EF Core supports a large number of popular databases, including SQLite, MySQL, PostgreSQL, Oracle, and Microsoft SQL Server.

## The model

With EF Core, data access is performed using a model. A model is made up of entity classes and a context object that represents a session with the database. The context object allows querying and saving data.

## The entity class

In this scenario, you are implementing a pizza store management API, so you will use a `Pizza` entity class. The pizzas in your store will have a name and a description, and will also need an ID to allow the API and database to identify them. This is the `Pizza` entity class you will be using in your application:

```csharp
namespace PizzaStore.Models 
{
  public class Pizza
  {
      public int Id { get; set; }
      public string? Name { get; set; }
      public string? Description { get; set; }
  }
}
```

### The context class

While this application only has one entity class, most applications will have multiple entity classes. The context class is responsible for querying and saving data to your entity classes, and for creating and managing the database connection.

## Performing CRUD operations with EF Core

Once configured, you can use EF Core to perform CRUD operations on your entity classes. This allows you to develop against C# classes, delegating the database operations to the context class. Database providers in turn translate it to database-specific query language (for example, SQL for a relational database). Queries are always executed against the database even if the entities returned in the result already exist in the context.

### Querying data

The context object exposes a collection class for each entity type. In the above example, the context class exposes a collection of `Pizza` objects as `Pizzas`. Given that we have an instance of the context class, you can query the database for all pizzas:

```csharp
var pizzas = await db.Pizzas.ToListAsync();
```

### Inserting data

You can use the same context object to insert a new pizza:

```csharp
await db.pizzas.AddAsync(
    new Pizza { ID = 1, Name = "Pepperoni", Description = "The classic pepperoni pizza" });
```

### Deleting data

Delete operations are pretty simple, as they only require an ID of the item to be deleted:

```csharp
var pizza = await db.pizzas.FindAsync(id);
if (pizza is null)
{
    //Handle error
}
db.pizzas.Remove(pizza);
```

### Updating data

Similarly, you can update an existing pizza:

```csharp
int id = 1;
var updatepizza = new Pizza { Name = "Pineapple", Description = "Ummmm?" })
var pizza = await db.pizzas.FindAsync(id);
if (pizza is null)
{
    //Handle error
}
pizza.Item = updatepizza.Item;
pizza.IsComplete = updatepizza.IsComplete;
await db.SaveChangesAsync();
```

## Using the EF Core InMemory database

EF Core includes an in-memory database provider that can be used to test your application. This is useful for testing and development, but should not be used in production. In the next exercise, you will use the in-memory database provider to create a database and perform CRUD operations on it.
