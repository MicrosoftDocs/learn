In this unit, you'll write code to interact with the database.

## CRUD methods

Let's complete the `PizzaService` implementation. Complete the following steps in *Services\PizzaService.cs*:

1. Make the following changes as shown in the example below:
    1. Add a `using ContosoPizza.Data;` declaration.
    1. Add a `using Microsoft.EntityFrameworkCore;` declaration.
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
        return _context.Pizzas!
            .AsNoTracking()
            .ToList();
    }
    ```

    In the preceding code:

    - The `Pizzas` collection contains all the rows in the pizzas table.
    - The `!` in the above code is a [null-forgiving operator](/dotnet/csharp/language-reference/operators/null-forgiving) and suppresses a compiler warning. It has no effect at runtime.
    - The `AsNoTracking` extension method instructs EF Core to disable change tracking. Since this operation is read-only, `AsNoTracking` can optimize performance.
    - All of the pizzas are returned with `ToList`;

1. Replace the `GetById` method with the following code:

    ```csharp
    public Pizza? GetById(int id)
    {
        return _context.Pizzas!
            .Include(p => p.Toppings)
            .Include(p => p.Sauce)
            .AsNoTracking()
            .FirstOrDefault(p => p.Id == id);
    }
    ```

    In the preceding code:

    - The `Include` extension method takes a [lambda expression](/dotnet/csharp/language-reference/operators/lambda-expressions) to specify that the `Toppings` and `Sauce` navigation properties are to be included in the result. Without this, EF Core will return null for those properties.
    - The `FirstOrDefault` method returns the first pizza that matches the lambda expression.
        - If no records match, `null` is returned.
        - The lambda expression describes records where the `Id` property is equal to the `id` parameter.

1. Replace the `Create` method with the following code:

    ```csharp
    public Pizza Create(Pizza newPizza)
    {
        _context.Pizzas!.Add(newPizza);
        _context.SaveChanges();

        return newPizza;
    }
    ```

    In the preceding code:

    - The `Add` method adds the `newPizza` entity to EF Core's object graph.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Replace the `Update` method with the following code:

    ```csharp
    public void Update(Pizza updatedPizza)
    {
        _context.Pizzas!.Update(updatedPizza);
        _context.SaveChanges();
    }
    ```

    In the preceding code:

    - The `Update` method replaces the `updatedPizza` entity in EF Core's object graph.
        - For this to work, `updatedPizza.Id` must be populated.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

1. Replace the `DeleteById` method with the following code:

    ```csharp
    public void DeleteById(int id)
    {
        var pizzaToDelete = _context.Pizzas!.Find(id);
        if (pizzaToDelete is not null)
        {
            _context.Pizzas!.Remove(pizzaToDelete);
            _context.SaveChanges();
        }        
    }
    ```

    In the preceding code:

    - The `Find` method retrieves a pizza by the primary key (in this case, `Id`).
    - The `Update` method removes the `pizzaToDelete` entity in EF Core's object graph.
    - The `SaveChanges` method instructs EF Core to persist the object changes to the database.

## Database seeding

1. Add the DbInitializer
1. Add the extension method
1. Call the extension method from Program.cs

## Test the API

1. Install HTTP REPL
1. Get all
1. Get by ID
1. Create new
1. Update existing
1. Delete exiting