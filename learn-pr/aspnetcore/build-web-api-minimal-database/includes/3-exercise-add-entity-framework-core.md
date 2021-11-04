You are a developer on a company, you and the company have heard all this hype about the new minimal API, is it better than sliced bread? Your manager has asked you to create a project for it so you can discuss whether to use it on your next project.

## Set up the project

First, you need to create a project. You've installed .NET 6 and you are ready to go. In this module, we will add data persistence to a pizza management API.

1. Create a web api by running `dotnet new`:

   ```bash
   dotnet new web -o PizzaStore -f net6.0
   ```

   You should see the directory _PizzaStore_.

1. Go to the _PizzaStore_ directory by typing the following command:

   ```bash
   cd PizzaStore
   ```

1. Install the `Swashbuckle` package:

    ```bash
    dotnet add package Swashbuckle.AspNetCore --version 6.2.3
    ```

1. Create a file _Pizza.cs_ and give it the following content:

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

   The above `Pizza` class is a simple object that represents a pizza. This code is our data model, and later, you will use EF Core to map this data model to a database table.

1. Open  _Program.cs_ and add the following code (in bold):

   :::code language="csharp" source="../code/ef-core-one.cs" highlight="1, 5-12, 15-19"::: 

   <pre>
   <b>using Microsoft.OpenApi.Models;</b>

   var builder = WebApplication.CreateBuilder(args);

   <b>builder.Services.AddEndpointsApiExplorer();
   builder.Services.AddSwaggerGen(c =>
   {
        c.SwaggerDoc("v1", new OpenApiInfo {
            Title = "PizzaStore API",
            Description = "Making the Pizzas you love",
            Version = "v1" });
   });</b>

   var app = builder.Build();
   <b>app.UseSwagger();
   app.UseSwaggerUI(c =>
   {
      c.SwaggerEndpoint("/swagger/v1/swagger.json", "PizzaStore API V1");
   });</b>

   app.MapGet("/", () => "Hello World!");

   app.Run();
   </pre>

1. At the top of _Program.cs_ file, add the following line of code:

   ```csharp
   using PizzaStore.DB;
   ```

## Add EF Core to the project

To store the items in the to-do list, install  the `EntityFrameworkCore.InMemory` package.

1. In your terminal window, type the following to add the EF Core InMemory package:

   ```console
   dotnet add package Microsoft.EntityFrameworkCore.InMemory --version 6.0.0-rc.*
   ```

1. Add `using Microsoft.EntityFrameworkCore;` to the top of your `Program.cs` file.

Now that we have EntityFramework added to the project, we can now wire up our code to the data we want to save and query it. To do this, we are going to create a `PizzaDb` class. The `PizzaDb` class is going to do the following tasks:

- Expose our `Pizzas` property from our list of `Pizza` in the database.
- `UseInMemoryDatabase` wires the in-memory database storage. Your data is stored here as long the app is running.

1. To set up your in-memory database, add the following to the bottom of the `Pizza.cs` class:

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

`DbContext` represents a connection/session that is used to query and save instances of entities in a database.

1. In `Program.cs`, before the call to `AddSwaggerGen`, add the following code:

    ```csharp
    builder.Services.AddDbContext<PizzaDb>(options => options.UseInMemoryDatabase("items"));
    ```

## Return a list of items

1. To read from a list of items in the pizza list, replace  the "/pizza" route with the "/pizzas" route:

    ```csharp
    app.MapGet("/pizzas", async (PizzaDb db) => await db.pizzas.ToListAsync());
    ```

1. In your browser, go to `https://localhost:{PORT}/swagger`. Select the `GET /pizzas` button and you will see that the list is empty under `Response body`.

## Create new items

1. Let's `POST` new tasks to the pizzas list below `app.MapGet` you create earlier.

   ```csharp
   app.MapPost("/pizza", async (PizzaDb db, pizzaItem pizza) =>
   {
       await db.pizzas.AddAsync(pizza);
       await db.SaveChangesAsync();
       return Results.Created($"/pizza/{pizza.Id}", pizza);
   });
   ```

## Test the API

Go back to `Swagger` and now you should see  `POST/pizza`. To add new items to the pizza list:

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

To `GET` an item by `id`, add the code below the `app.MapPost` route you created earlier.

```csharp
app.MapGet("/pizza/{id}", async (PizzaDb db, int id) => await db.pizzas.FindAsync(id));
```

To check this out, you can either go to `https://localhost:{PORT}/pizza/1` or use the Swagger UI.

## Update an item

1. To update an existing item, add the code below `GET /pizza/{id}` route you created:

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
1. In the `id` text box, enter 2.
1. Finally, update `Request body`. Paste the following JSON and change `name` to `Pineapple`.

   ``` json
    {
       "id": 2,
       "name": "Pineapple",
     }
   
   ```

1. Select `Execute`.

To test the code, scroll back to `GET /pizza/{id}`. The second pizza now has the name `Pineapple` (an affront to many pizza fans).

## Delete an item

1. To delete an existing item, add the code below the `PUT /pizza/{id}` you created earlier:

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

1. Now, try deleting an item using the Swagger interface.

In this exercise, you added EF Core to an existing Minimal API application and used an in-memory database to store the data. Next, you will learn how to use a real database to store the data so that it persists between application shutdowns.
