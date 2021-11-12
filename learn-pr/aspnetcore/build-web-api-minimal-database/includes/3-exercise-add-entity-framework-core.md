You're a developer for a company, and you and your company have heard about the new minimal API. Your manager has asked you to create a project for it so that you can discuss whether to use it on your next project.

## Set up the project

First, you need to create a project. You've installed .NET 6 and you're ready to go. In this unit, you'll add data persistence to a pizza management API.

1. Create a web API by running `dotnet new`:

   ```bash
   dotnet new web -o PizzaStore -f net6.0
   ```

   You should see the _PizzaStore_ directory.

1. Go to the _PizzaStore_ directory by entering the following command:

   ```bash
   cd PizzaStore
   ```

1. Install the Swashbuckle package:

    ```bash
    dotnet add package Swashbuckle.AspNetCore --version 6.2.3
    ```

1. Create a _Pizza.cs_ file and give it the following content:

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

   The preceding `Pizza` class is a simple object that represents a pizza. This code is your data model. Later, you'll use Entity Framework (EF) Core to map this data model to a database table.

1. Open _Program.cs_ and add the highlighted code:

   :::code language="csharp" source="../code/ef-core-setup.cs" highlight="1, 5-12, 15-19":::

1. At the top of the _Program.cs_ file, add the following line of code:

   ```csharp
   using PizzaStore.DB;
   ```

## Add EF Core to the project

To store the items in the to-do list, install the `EntityFrameworkCore.InMemory` package.

1. In your terminal window, enter the following code to add the EF Core InMemory package:

   ```console
   dotnet add package Microsoft.EntityFrameworkCore.InMemory --version 6.0
   ```

1. Add `using Microsoft.EntityFrameworkCore;` to the top of your *Program.cs* file.

Now that you have EF Core added to the project, you can wire up your code to the data you want to save and query it. To do this step, you create a `PizzaDb` class. The `PizzaDb` class will do the following tasks:

- Expose your `Pizzas` property from your list of `Pizza` in the database.
- Use `UseInMemoryDatabase` to wire the in-memory database storage. Your data is stored here as long as the app is running.

1. To set up your in-memory database, add the following code to the bottom of the `Pizza.cs` class:

   ```csharp
   class PizzaDb : DbContext
   {
       public PizzaDb(DbContextOptions options) : base(options) { }
       public DbSet<Pizza> Pizzas { get; set; }
   
       protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
       {
           optionsBuilder.UseInMemoryDatabase("Pizzas");
       }
   }
   ```

   `DbContext` represents a connection or session that's used to query and save instances of entities in a database.

1. In *Program.cs*, before the call to `AddSwaggerGen`, add the following code:

    ```csharp
    builder.Services.AddDbContext<PizzaDb>(options => options.UseInMemoryDatabase("items"));
    ```

## Return a list of items

1. To read from a list of items in the pizza list, replace  the `"/pizza"` route with the `"/pizzas"` route:

    ```csharp
    app.MapGet("/pizzas", async (PizzaDb db) => await db.pizzas.ToListAsync());
    ```

1. In your browser, go to *https://localhost:{PORT}/swagger*. Select the `GET /pizzas` button, and you'll see that the list is empty under `Response body`.

## Create new items

Let's POST new tasks to the pizzas list under `app.MapGet` that you created earlier.

   ```csharp
   app.MapPost("/pizza", async (PizzaDb db, pizzaItem pizza) =>
   {
       await db.pizzas.AddAsync(pizza);
       await db.SaveChangesAsync();
       return Results.Created($"/pizza/{pizza.Id}", pizza);
   });
   ```

## Test the API

Go back to Swagger and now you should see `POST/pizza`. To add new items to the pizza list:

1. Select `POST /pizza`.
1. Select `Try it out`.
1. Update `id`, `item`, and `isComplete`.
1. Select `Execute`.

## Read the items in the list

To read the items in the list:

1. Select `GET /pizza`.
1. Select `Try it out`.
1. Select `Execute`.

The `Response body` will include the items just added.

```json
[
  {
    "id": 1,
    "name": "Pepperoni",
  },
  {
    "id": 2,
    "name": "Cheese",
  }
]
```

To GET an item by `id`, add the code under the `app.MapPost` route you created earlier.

```csharp
app.MapGet("/pizza/{id}", async (PizzaDb db, int id) => await db.pizzas.FindAsync(id));
```

To check this out, you can either go to *https://localhost:{PORT}/pizza/1* or use the Swagger UI.

## Update an item

1. To update an existing item, add the code under the `GET /pizza/{id}` route you created:

   ```csharp
   app.MapPut("/pizza/{id}", async ( PizzaDb db, pizzaItem updatepizza ,int id) =>
   {
       var pizza = await db.pizzas.FindAsync(id);
       
       if (pizza is null) return NotFound();
       
       pizza.Item = updatepizza.Item;
       pizza.IsComplete = updatepizza.IsComplete;
   
       await db.SaveChangesAsync();
   
       return Results.NoContent();
   });
   ```

1. Select `PUT /pizza/{id}`.
1. Select `Try it out`.
1. In the `id` text box, enter **2**.
1. Finally, update `Request body`. Paste the following JSON and change `name` to `Pineapple`.

   ``` json
    {
       "id": 2,
       "name": "Pineapple",
     }
   
   ```

1. Select `Execute`.

To test the code, scroll back to `GET /pizza/{id}`. The second pizza now has the name `Pineapple`.

## Delete an item

1. To delete an existing item, add the code under `PUT /pizza/{id}` that you created earlier:

   ```csharp
   app.MapDelete("/pizza/{id}", async (PizzaDb db, int id) =>
   {
       var pizza = await db.pizzas.FindAsync(id);
       if (pizza is null)
       {
           return NotFound();
       }
       db.pizzas.Remove(pizza);
       await db.SaveChangesAsync();
   
       return Results.Ok();
   });
   ```

1. Now, try deleting an item by using the Swagger interface.

In this unit, you added EF Core to an existing minimal API application and used an in-memory database to store the data. Next, you'll learn how to use a real database to store the data so that it persists between application shutdowns.
