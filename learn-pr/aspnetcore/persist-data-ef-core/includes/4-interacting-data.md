In this unit, you'll write code to interact with the database.

## CRUD methods

Let's complete the `PizzaService` implementation. Complete the following steps in *Services\PizzaService.cs*:

1. Make the following changes as shown in the example below:
    1. Add a `using ContosoPizza.Data;` directive.
    1. Add a `using Microsoft.EntityFrameworkCore;` directive.
    1. Add a class-level field for the `PizzaContext` before the constructor.
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

    When the `PizzaService` instance is created, a `PizzaContext` will be injected as a dependency.

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
    - The `AsNoTracking` extension method instructs EF Core to [disable change tracking](/ef/core/querying/tracking). Since this operation is read-only, `AsNoTracking` can optimize performance.
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

    - The `Include` extension method takes a [lambda expression](/dotnet/csharp/language-reference/operators/lambda-expressions) to specify that the `Toppings` and `Sauce` navigation properties are to be included in the result ([eager loading](/ef/core/querying/related-data/eager)). Without this, EF Core will return null for those properties.
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
    - The `Add` method adds the `newPizza` entity to EF Core's object graph.
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

    - References to an existing `Pizza` and `Sauce` are created using `Find`. `Find` is an optimized method to query records by their primary key. `Find` searches the local entity graph first before querying the database.
    - The `Pizza.Sauce` property is set to the `Sauce` object.
    - An `Update` method call is unnecessary because EF Core detects that we set the `Sauce` property on `Pizza`.
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

    - References to an existing `Pizza` and `Topping` are created using `Find`.
    - The `Topping` is added to the `Pizza.Toppings` collection with the `.Add` method. A new collection is created if it doesn't exist.
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

    - The `Find` method retrieves a pizza by the primary key (in this case, `Id`).
    - The `Remove` method removes the `pizzaToDelete` entity in EF Core's object graph.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Save your changes.

## Database seeding

You've coded the CRUD operations for `PizzaService`, but it will be easier to test the "read" operation if there's good data in the database. Let's modify the app to seed the database on startup.

> [!WARNING]
> Be careful using this database seeding strategy in distributed environments, as it doesn't account for race conditions.

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
    - `Initialize` accepts a `PizzaContext` as a parameter.
    - If there are no records in any of the three tables, `Pizza`, `Sauce`, and `Topping` objects are created.
    - The `Pizza` objects (and their `Sauce` and `Topping` navigation properties) are added to the object graph with `AddRange`.
    - The object graph changes are committed to the database with `SaveChanges`.

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
    - [EnsureCreated](/ef/core/managing-schemas/ensure-created#ensurecreated) ensures the database exists.

        > [!IMPORTANT]
        > `EnsureCreated` creates a new database if one doesn't exist. The new database isn't configured for migrations, so use this with caution.

    - The `DbIntializer.Initialize` method is called, passing the `PizzaContext` as a parameter.

1. In *Program.cs*, replace `// Add the CreateDbIfNotExists method call` comment with the following code:

    ```csharp
    app.CreateDbIfNotExists();
    ```

    This code calls the extension method defined in the previous step whenever the app runs.

1. Save all your changes and build.

You've written all the code you need to do basic CRUD operations and seed the database on startup. In the next unit, you'll test those operations in the app.
