Contoso Pizza's manager has asked you to add an endpoint to list coupons from an existing database. In this unit, you'll create scaffolding from an existing database and modify the resulting entity class.

## Inspect promotions database

Let's take a look at the database we'll use for generating the scaffolded code.

1. In the **EXPLORER**, expand the *Promotions** directory, right-click on *Promotions.db* file, and then select **Open Database**. The new database opens in the **SQLITE EXPLORER** pane.
1. In the **SQLITE EXPLORER** pane, expand the *Promotions.db* and *Coupons* nodes. Note the data schema.
1. Right-click the *Coupons* node and select **Show table**. Inspect the coupon data.

## Scaffold the promotions context and coupon model

Now it's time to scaffold the code using the database.

1. Run the following command:

    ```dotnetcli
    dotnet ef dbcontext scaffold "Data Source=Promotions/Promotions.db" Microsoft.EntityFrameworkCore.Sqlite --context-dir Data --output-dir Models   
    ```

    The preceding command:

    - Scaffolds a `DbContext` and model classes using the provided connection string.
    - Specifies the `Microsoft.EntityFrameworkCore.Sqlite` database provider should be used.
    - Specifies directories for the resulting `DbContext` and model classes.

    > [!NOTE]
    > For the purposes of this exercise, ignore the warning about your connection string being in source code. For real-world code, always store your connection strings in a secure location.

1. Open *Models\Coupon.cs*. The `Expiration` property is defined as a string, since SQLite doesn't have a datetime type. Change `Expiration`'s type from a `string?` to a `DateTime`. EF Core will manage the conversion of datetime to string data.

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
    > New scaffolded files can be generated if the database changes. The generated files are overwritten each time, but are created as `partial` classes so you can extend them with custom properties and behaviors in your own, separate files.

## Add coupon endpoint

Before we can test the scaffolded code, we need to add an endpoint to the API. Let's add a new API controller.

> [!NOTE]
> This module doesn't spend much time explaining API controllers. To better understand how API controllers work, see [Create a web API with ASP.NET Core controllers](/training/modules/build-web-api-aspnet-core/).

1. In the *Controllers* folder, add a file named *CouponController.cs* containing the following code:

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

    This adds a `api/coupon` endpoint to the API.

1. In *Program.cs*, replace the `// Add the PromotionsContext` comment with the following code:

    ```csharp
    builder.Services.AddSqlite<PromotionsContext>("Data Source=Promotions/Promotions.db");
    ```

    The preceding registers `PromotionsContext` with the dependency injection system.

1. Save all your changes (GitHub Codespaces saves automatically) and run the app as before with `dotnet run`.

## Test the endpoint

Now that the endpoint is added, let's test the coupon operations.

1. Navigate to the API's Swagger UI as before (or refresh the existing UI in your browser).

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

    Note `expiration` is a datetime.

That's it! You've created and modified scaffolding from an existing database!
