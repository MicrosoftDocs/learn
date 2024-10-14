You're a developer for a company, and you and your company have heard about the new minimal API. Your manager has asked you to create a project for it so that you can discuss whether to use it on your next project.

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet8-sdk-version.md)]

## Set up the project

First, you need to create a project. You've installed .NET 6 and you're ready to go. In this unit, you'll add data persistence to a pizza management API.

1. In a terminal, create a web API by running `dotnet new`:

   ```dotnetcli
   dotnet new web -o PizzaStore -f net8.0
   ```

   You should see the _PizzaStore_ directory.

1. Go to the _PizzaStore_ directory by entering the following command:

   ```bash
   cd PizzaStore
   ```

1. Install the Swashbuckle package:

   ```dotnetcli
   dotnet add package Swashbuckle.AspNetCore --version 6.5.0
   ```

1. Open the project in Visual Studio Code.
1. Using Visual Studio Code, create a _Pizza.cs_ file in the project root and give it the following content:

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

   :::code language="csharp" source="../code/ef-core-setup.cs" highlight="1, 5-12, 15-22":::

   You might receive a prompt from Visual Studio Code to add assets to debug the project. Select `Yes` in the dialog.

## Add EF Core to the project

To store the items in the to-do list, install the `EntityFrameworkCore.InMemory` package.

1. Press **Ctrl+\`** to open a terminal in Visual Studio Code. In the new terminal, enter the following code to add the EF Core InMemory package:

   ```console
   dotnet add package Microsoft.EntityFrameworkCore.InMemory --version 8.0
   ```

1. Add `using Microsoft.EntityFrameworkCore;` to the top of your _Program.cs_ and _Pizza.cs_ files.

   Now that you have EF Core added to the project, you can wire up your code to the data you want to save and query it. To do this step, you create a `PizzaDb` class. The `PizzaDb` class will do the following tasks:

      - Expose your `Pizzas` property from your list of `Pizza` in the database.
      - Use `UseInMemoryDatabase` to wire the in-memory database storage. Your data is stored here as long as the app is running.

1. To set up your in-memory database, add the following code to the bottom of the _Pizza.cs_ file (above the final `}`). You'll have two class definitions within the `PizzaStore.Models` namespace.

   ```csharp
   class PizzaDb : DbContext
   {
       public PizzaDb(DbContextOptions options) : base(options) { }
       public DbSet<Pizza> Pizzas { get; set; } = null!;
   }
   ```

   `DbContext` represents a connection or session that's used to query and save instances of entities in a database.

1. Add `using PizzaStore.Models;` to the top of your _Program.cs_ file.

1. In _Program.cs_, before the call to `AddSwaggerGen`, add the following code:

    ```csharp
    builder.Services.AddDbContext<PizzaDb>(options => options.UseInMemoryDatabase("items"));
    ```

## Return a list of items

- To read from a list of items in the pizza list, add the following code above the call to `app.Run();` to add a "/pizzas" route:

    ```csharp
    app.MapGet("/pizzas", async (PizzaDb db) => await db.Pizzas.ToListAsync());
    ```

## Run the application

1. Make sure you've saved all your changes. Run the app by calling `dotnet run` in the terminal. This action will build the app and host it on a port from 5000-5300. HTTPS will have a port selected for it in the range 7000-7300.

   > [!NOTE]
   > If you want to override the random port selection behavior, you can set the ports to use in _launchSettings.json_.

   ```dotnetcli
   dotnet run
   ```

   Here's what the output can look like in the terminal:

   ```output
   Building...
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: https://localhost:7200
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5100
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
          Content root path: /<path>/PizzaStore
   ```

1. In your browser, go to *https://localhost:{PORT}/swagger*. Select the `GET /pizzas` button, followed by **Try it out** and **Execute**. You'll see that the list is empty under `Response body`.

1. In the terminal, press **Ctrl+C** to stop running the program.

## Create new items

Let's add the code to `POST` new items to the pizzas list. In _Program.cs_, add the following code under the `app.MapGet` that you created earlier.

   ```csharp
   app.MapPost("/pizza", async (PizzaDb db, Pizza pizza) =>
   {
       await db.Pizzas.AddAsync(pizza);
       await db.SaveChangesAsync();
       return Results.Created($"/pizza/{pizza.Id}", pizza);
   });
   ```

## Test the API

Make sure you've saved all your changes and run the app again. Go back to the Swagger UI and now you should see `POST/pizza`. To add new items to the pizza list:

1. Select **POST /pizza**.
1. Select **Try it out**.
1. Replace the request body with the following JSON:

   ```json
   {
       "name": "Pepperoni",
       "description": "A classic pepperoni pizza"
   }
   ```

1. Select **Execute**.

To read the items in the list:

1. Select **GET /pizzas**.
1. Select **Try it out**.
1. Select **Execute**.

    The `Response body` will include the items just added.

    ```json
    [
      {
        "id": 1,
        "name": "Pepperoni",
        "description": "A classic pepperoni pizza"
      }
    ]
    ```

1. Press **Ctrl+C** in the terminal to stop running the app. For the rest of this exercise, stop and restart the app as desired to test your changes. Be sure to save all your changes before you `dotnet run`!

## Get a single item

To GET an item by `id`, add the code under the `app.MapPost` route you created earlier.

```csharp
app.MapGet("/pizza/{id}", async (PizzaDb db, int id) => await db.Pizzas.FindAsync(id));
```

### Test GET by ID

To test this operation, you can either go to *https://localhost:{PORT}/pizza/1* or use the Swagger UI. Since you're using an in-memory database, the pizza you previously created won't be listed if you've restarted the application. So, you'll need to use your POST operation to add it again.

## Update an item

To update an existing item, add the code under the `GET /pizza/{id}` route you created:

```csharp
app.MapPut("/pizza/{id}", async (PizzaDb db, Pizza updatepizza, int id) =>
{
      var pizza = await db.Pizzas.FindAsync(id);
      if (pizza is null) return Results.NotFound();
      pizza.Name = updatepizza.Name;
      pizza.Description = updatepizza.Description;
      await db.SaveChangesAsync();
      return Results.NoContent();
});
```

### Test PUT

1. Select **PUT /pizza/{id}** in the Swagger UI.
1. Select **Try it out**.
1. In the **id** text box, enter **1**.
1. Finally, update `Request body`. Paste the following JSON and change `name` to `Pineapple`.

   ``` json
   {
      "id": 1,
      "name": "Pineapple"
   }
   ```

1. Select **Execute**.

To test the code, scroll back to `GET /pizza/{id}`. The pizza now has the name `Pineapple`.

## Delete an item

To delete an existing item, add the code under `PUT /pizza/{id}` that you created earlier:

```csharp
app.MapDelete("/pizza/{id}", async (PizzaDb db, int id) =>
{
   var pizza = await db.Pizzas.FindAsync(id);
   if (pizza is null)
   {
      return Results.NotFound();
   }
   db.Pizzas.Remove(pizza);
   await db.SaveChangesAsync();
   return Results.Ok();
});
```

### Testing DELETE

Now try deleting an item by using the Swagger interface.

In this unit, you added EF Core to an existing minimal API application and used an in-memory database to store the data. Next, you'll learn how to use a real database to store the data so that it persists between application shutdowns.
