The manager of Contoso Pizza has asked you to add an endpoint to list coupons from an existing database. In this unit, you create scaffolding from an existing database and modify the resulting entity class.

## Inspect the promotions database

Let's take a look at the database you'll use to generate the scaffolded code.

1. On the **Explorer** pane, expand the *Promotions** directory, right-click the *Promotions.db* file, and then select **Open Database**.

    The new database opens in the **SQLite Explorer** folder.
1. In the **SQLite Explorer** folder, expand the *Promotions.db* and *Coupons* nodes. Note the data schema.
1. Right-click the *Coupons* node and select **Show table**. Inspect the coupon data.

## Scaffold the promotions context and coupon model

Now it's time to scaffold the code by using the database.

1. Run the following command:

    ```dotnetcli
    dotnet ef dbcontext scaffold "Data Source=Promotions/Promotions.db" Microsoft.EntityFrameworkCore.Sqlite --context-dir Data --output-dir Models   
    ```

    The preceding command:

    - Scaffolds a `DbContext` and model classes by using the provided connection string.
    - Specifies that the `Microsoft.EntityFrameworkCore.Sqlite` database provider should be used.
    - Specifies directories for the resulting `DbContext` and model classes.

    > [!NOTE]
    > In this exercise, ignore the warning about your connection string being in source code. In real-world code, always store your connection strings in a secure location.

1. Open *Models\Coupon.cs*. The `Expiration` property is defined as a string because SQLite doesn't have a datetime type. Change the `Expiration` type from a `string?` to a `DateTime`. EF Core manages the conversion of datetime to string data.

    ```csharp
    using System;
    using System.Collections.Generic;
    
    namespace ContosoPizza.Models
    {
        public partial class Coupon
        {
            public long Id { get; set; }
            public string Description { get; set; } = null!;
            public DateTime Expiration { get; set; }
        }
    }
    ```

    > [!TIP]
    > If the database changes, you can generate new scaffolded files. The generated files are overwritten each time, but they are created as `partial` classes, so you can extend them with custom properties and behaviors in your own, separate files.

## Add a coupon endpoint

Before you can test the scaffolded code, you need to add an endpoint to the API. Let's add a new API controller.

> [!NOTE]
> To better understand how API controllers work, see [Create a web API by using ASP.NET Core controllers](/training/modules/build-web-api-aspnet-core/).

1. In the *Controllers* folder, add a file named *CouponController.cs* that contains the following code:

    ```csharp
    using ContosoPizza.Data;
    using ContosoPizza.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    
    namespace ContosoPizza.Controllers;
    
    [ApiController]
    [Route("[controller]")]
    public class CouponController : ControllerBase
    {
        PromotionsContext _context;
        
        public CouponController(PromotionsContext context)
        {
            _context = context;
        }
    
        [HttpGet]
        public IEnumerable<Coupon> Get()
        {
            return _context.Coupons
                .AsNoTracking()
                .ToList();
        }
    }
    ```

    In the preceding code:

    - A `PromotionsContext` is injected into the constructor.
    - The `Get` method returns all the coupons.

    This code adds an `api/coupon` endpoint to the API.

1. In *Program.cs*, replace the `// Add the PromotionsContext` comment with the following code:

    ```csharp
    builder.Services.AddSqlite<PromotionsContext>("Data Source=Promotions/Promotions.db");
    ```

    This code registers `PromotionsContext` with the dependency injection system.

1. Save all your changes (GitHub Codespaces saves automatically) and run the app by using `dotnet run`.

## Test the endpoint

Now that the endpoint is added, test the coupon operations.

1. Go to the API's Swagger UI as before (or refresh the existing UI in your browser).

1. Under the **Coupon** heading, expand the **GET** operation and select **Try it out**.
1. Select **Execute**. The response body shows the coupons from the database:

    ```json
    [
    {
        "id": 1,
        "description": "Buy 1 get 1 free",
        "expiration": "2025-01-01T00:00:00"
    },
    {
        "id": 2,
        "description": "4 large pizzas for $40",
        "expiration": "2024-06-30T00:00:00"
    }
    ]
    ```

    Note that `expiration` is a datetime value.

That's it! You've created and modified scaffolding from an existing database!
