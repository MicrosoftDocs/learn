Your first project with minimal API was well received, now, they want to see an application that does a little more like managing a resource, what resource is up to you. You are feeling hungry, so maybe Pizza?

## Add data

You first need some data. To store and manage data, you will use an in-memory store.

1. Create a file _Db.cs_ and give it the following content:

   ```csharp
    namespace PizzaStore.DB; 

    public record Pizza 
    {
      public int Id {get; set;} 
      public string ? Name { get; set; }
    }

    public class PizzaDB
    {
      private static List<Pizza> _pizzas = new List<Pizza>()
      {
        new Pizza{ Id=1, Name="Montemagno, Pizza shaped like a great mountain" },
        new Pizza{ Id=2, Name="The Galloway, Pizza shaped like a submarine, silent but deadly"},
        new Pizza{ Id=3, Name="The Noring, Pizza shaped like a Viking helmet, where's the mead"} 
      };

      public static List<Pizza> GetPizzas() 
      {
        return _pizzas;
      } 

      public static Pizza ? GetPizza(int id) 
      {
        return _pizzas.SingleOrDefault(pizza => pizza.Id == id);
      } 

      public static Pizza CreatePizza(Pizza pizza) 
      {
        _pizzas.Add(pizza);
        return pizza;
      }
    
      public static Pizza UpdatePizza(Pizza update) 
      {
        _pizzas = _pizzas.Select(pizza =>
        {
          if (pizza.Id == update.Id)
          {
            pizza.Name = update.Name;
          }
          return pizza;
        }).ToList();
        return update;
      }

      public static void RemovePizza(int id)
      {
        _pizzas = _pizzas.FindAll(pizza => pizza.Id == id).ToList();
      }
    }
   ```

Great, now you have your data store, let's have the API use it next.

## Connect data to routes

To connect your in-memory store to the API, you need to do the following steps:

- **Add the namespace**. This addition is as simple as adding the proper `using`.
- **Setup the routes**. Here, you need to make sure you add all the needed route mappings for creating, reading, updating, and deleting.
- **Invoke it in the routes**. Finally, you need to call the in-memory store per each route and pass in any parameters or body from the request, if applicable.

1. At the top of _Program.cs_ file, add the following line of code:

   ```csharp
   using PizzaStore.DB;
   ```

1. Just before `app.Run()`, add the following code:

   ```csharp
   app.MapGet("/pizzas/{id}", (int id) => PizzaDB.GetPizza(id));
   app.MapGet("/pizzas", () => PizzaDB.GetPizzas());
   app.MapPost("/pizzas", (Pizza pizza) => PizzaDB.CreatePizza(pizza));
   app.MapPut("/pizzas", (Pizza pizza) => PizzaDB.UpdatePizza(pizza));
   app.MapDelete("/pizzas/{id}", (int id) => PizzaDB.RemovePizza(id));
   ```

1. Run the app using `dotnet run`:

   ```bash
   dotnet run
   ```

1. Navigate, in your browser, to "http://localhost:5000/swagger"

   You should see the following page rendering:

   :::image type="content" source="../media/swagger-crud.png" alt-text="Create, read, update and delete, Swagger":::