In the previous exercise, you created entity classes and a database context. You then used EF Core migrations to create the database schema.

In this exercise, you complete the `PizzaService` implementation. The service uses EF Core to perform CRUD operations on the database.

## Code the CRUD operations

To finish the `PizzaService` implementation, complete the following steps in *Services\PizzaService.cs*:

1. Make the following changes as shown in the example:

    1. Add a `using ContosoPizza.Data;` directive.
    1. Add a `using Microsoft.EntityFrameworkCore;` directive.
    1. Add a class-level field for `PizzaContext` before the constructor.
    1. Change the constructor method signature to accept a `PizzaContext` parameter.
    1. Change the constructor method code to assign the parameter to the field.

    ```csharp
    using ContosoPizza.Models;
    using ContosoPizza.Data;
    using Microsoft.EntityFrameworkCore;
    
    namespace ContosoPizza.Services;
    
    public class PizzaService
    {
        private readonly PizzaContext _context;
    
        public PizzaService(PizzaContext context)
        {
            _context = context;
        }
    
        /// ...
        /// CRUD operations removed for brevity
        /// ...
    }
    ```

    The `AddSqlite` method call that you added to *Program.cs* earlier registered `PizzaContext` for dependency injection. When the `PizzaService` instance is created, a `PizzaContext` is injected into the constructor.

1. Replace the `GetAll` method with the following code:

    ```csharp
    public IEnumerable<Pizza> GetAll()
    {
        return _context.Pizzas
            .AsNoTracking()
            .ToList();
    }
    ```

    In the preceding code:

    - The `Pizzas` collection contains all the rows in the pizzas table.
    - The `AsNoTracking` extension method instructs EF Core to [disable change tracking](/ef/core/querying/tracking). Because this operation is read-only, `AsNoTracking` can optimize performance.
    - All of the pizzas are returned with `ToList`.

1. Replace the `GetById` method with the following code:

    ```csharp
    public Pizza? GetById(int id)
    {
        return _context.Pizzas
            .Include(p => p.Toppings)
            .Include(p => p.Sauce)
            .AsNoTracking()
            .SingleOrDefault(p => p.Id == id);
    }
    ```

    In the preceding code:

    - The `Include` extension method takes a [lambda expression](/dotnet/csharp/language-reference/operators/lambda-expressions) to specify that the `Toppings` and `Sauce` navigation properties are to be included in the result by using [eager loading](/ef/core/querying/related-data/eager). Without this expression, EF Core returns null for those properties.
    - The `SingleOrDefault` method returns a pizza that matches the lambda expression.
        - If no records match, `null` is returned.
        - If multiple records match, an exception is thrown.
        - The lambda expression describes records where the `Id` property is equal to the `id` parameter.

1. Replace the `Create` method with the following code:

    ```csharp
    public Pizza Create(Pizza newPizza)
    {
        _context.Pizzas.Add(newPizza);
        _context.SaveChanges();

        return newPizza;
    }
    ```

    In the preceding code:

    - `newPizza` is assumed to be a valid object. EF Core doesn't do data validation, so any validation must be handled by the ASP.NET Core runtime or user code.
    - The `Add` method adds the `newPizza` entity to the EF Core object graph.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Replace the `UpdateSauce` method with the following code:

    ```csharp
    public void UpdateSauce(int pizzaId, int sauceId)
    {
        var pizzaToUpdate = _context.Pizzas.Find(pizzaId);
        var sauceToUpdate = _context.Sauces.Find(sauceId);

        if (pizzaToUpdate is null || sauceToUpdate is null)
        {
            throw new InvalidOperationException("Pizza or sauce does not exist");
        }

        pizzaToUpdate.Sauce = sauceToUpdate;

        _context.SaveChanges();
    }
    ```

    In the preceding code:

    - References to existing `Pizza` and `Sauce` objects are created by using `Find`. `Find` is an optimized method to query records by their primary key. `Find` searches the local entity graph first before it queries the database.
    - The `Pizza.Sauce` property is set to the `Sauce` object.
    - An `Update` method call is unnecessary because EF Core detects that you set the `Sauce` property on `Pizza`.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Replace the `AddTopping` method with the following code:

    ```csharp
    public void AddTopping(int pizzaId, int toppingId)
    {
        var pizzaToUpdate = _context.Pizzas.Find(pizzaId);
        var toppingToAdd = _context.Toppings.Find(toppingId);

        if (pizzaToUpdate is null || toppingToAdd is null)
        {
            throw new InvalidOperationException("Pizza or topping does not exist");
        }

        if(pizzaToUpdate.Toppings is null)
        {
            pizzaToUpdate.Toppings = new List<Topping>();
        }

        pizzaToUpdate.Toppings.Add(toppingToAdd);

        _context.SaveChanges();
    }
    ```

    In the preceding code:

    - References to existing `Pizza` and `Topping` objects are created by using `Find`.
    - The `Topping` object is added to the `Pizza.Toppings` collection with the `.Add` method. A new collection is created if it doesn't exist.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Replace the `DeleteById` method with the following code:

    ```csharp
    public void DeleteById(int id)
    {
        var pizzaToDelete = _context.Pizzas.Find(id);
        if (pizzaToDelete is not null)
        {
            _context.Pizzas.Remove(pizzaToDelete);
            _context.SaveChanges();
        }        
    }
    ```

    In the preceding code:

    - The `Find` method retrieves a pizza by the primary key (which is `Id` in this case).
    - The `Remove` method removes the `pizzaToDelete` entity in EF Core's object graph.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Save all your changes and run `dotnet build`. Fix any errors that occur.

## Seed the database

You've coded the CRUD operations for `PizzaService`, but it's easier to test the read operation if the database contains good data. You decide to modify the app to seed the database on startup.

> [!WARNING]
> This database seeding code doesn't account for race conditions, so be careful when using it in a distributed environment without mitigating changes.

1. In the *Data* folder, add a new file named *DbInitializer.cs*.
1. Add the following code to *Data\DbInitializer.cs*:

    ```csharp
    using ContosoPizza.Models;
    
    namespace ContosoPizza.Data
    {
        public static class DbInitializer
        {
            public static void Initialize(PizzaContext context)
            {
    
                if (context.Pizzas.Any()
                    && context.Toppings.Any()
                    && context.Sauces.Any())
                {
                    return;   // DB has been seeded
                }
    
                var pepperoniTopping = new Topping { Name = "Pepperoni", Calories = 130 };
                var sausageTopping = new Topping { Name = "Sausage", Calories = 100 };
                var hamTopping = new Topping { Name = "Ham", Calories = 70 };
                var chickenTopping = new Topping { Name = "Chicken", Calories = 50 };
                var pineappleTopping = new Topping { Name = "Pineapple", Calories = 75 };
    
                var tomatoSauce = new Sauce { Name = "Tomato", IsVegan = true };
                var alfredoSauce = new Sauce { Name = "Alfredo", IsVegan = false };
    
                var pizzas = new Pizza[]
                {
                    new Pizza
                        { 
                            Name = "Meat Lovers", 
                            Sauce = tomatoSauce, 
                            Toppings = new List<Topping>
                                {
                                    pepperoniTopping, 
                                    sausageTopping, 
                                    hamTopping, 
                                    chickenTopping
                                }
                        },
                    new Pizza
                        { 
                            Name = "Hawaiian", 
                            Sauce = tomatoSauce, 
                            Toppings = new List<Topping>
                                {
                                    pineappleTopping, 
                                    hamTopping
                                }
                        },
                    new Pizza
                        { 
                            Name="Alfredo Chicken", 
                            Sauce = alfredoSauce, 
                            Toppings = new List<Topping>
                                {
                                    chickenTopping
                                }
                            }
                };
    
                context.Pizzas.AddRange(pizzas);
                context.SaveChanges();
            }
        }
    }
    ```

    In the preceding code:

    - The `DbInitializer` class and `Initialize` method are both defined as `static`.
    - `Initialize` accepts a `PizzaContext` object as a parameter.
    - If there are no records in any of the three tables, `Pizza`, `Sauce`, and `Topping` objects are created.
    - The `Pizza` objects (and their `Sauce` and `Topping` navigation properties) are added to the object graph by using `AddRange`.
    - The object graph changes are committed to the database by using `SaveChanges`.

The `DbInitializer` class is ready to seed the database, but it needs to be called from *Program.cs*. The following steps create an extension method for `IHost` that calls `DbInitializer.Initialize`:

1. In the *Data* folder, add a new file named *Extensions.cs*.
1. Add the following code to *Data\Extensions.cs*:

    ```csharp
    namespace ContosoPizza.Data;
    
    public static class Extensions
    {
        public static void CreateDbIfNotExists(this IHost host)
        {
            {
                using (var scope = host.Services.CreateScope())
                {
                    var services = scope.ServiceProvider;
                    var context = services.GetRequiredService<PizzaContext>();
                    context.Database.EnsureCreated();
                    DbInitializer.Initialize(context);
                }
            }
        }
    }
    ```

    In the preceding code:

    - The `CreateDbIfNotExists` method is defined as an extension of `IHost`.
    - A reference to the `PizzaContext` service is created.
    - [EnsureCreated](/ef/core/managing-schemas/ensure-created#ensurecreated) ensures that the database exists.

        > [!IMPORTANT]
        > If a database doesn't exist, `EnsureCreated` creates a new database. The new database isn't configured for migrations, so use this method with caution.

    - The `DbIntializer.Initialize` method is called. The `PizzaContext` object is passed as a parameter.

1. Finally, in *Program.cs*, replace the `// Add the CreateDbIfNotExists method call` comment with the following code to call the new extension method:

    ```csharp
    app.CreateDbIfNotExists();
    ```

    This code calls the extension method that you defined earlier each time the app runs.

1. Save all your changes and run `dotnet build`.

You've written all the code you need to do basic CRUD operations and seed the database on startup. In the next exercise, you test those operations in the app.
