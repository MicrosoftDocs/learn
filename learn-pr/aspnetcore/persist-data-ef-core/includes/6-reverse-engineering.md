ContosoPizza's manager has asked you to add an endpoint to list coupons from an existing database. In this unit, you'll create scaffolding from an existing database and modify the resulting entity class.

## Inspect promotions database

1. In the **EXPLORER** pane, right-click on *Promotions/Promotions.db* file and select **Open Database**.
1. In the **SQLITE EXPLORER** pane, expand the *Promotions.db* and *Coupons* nodes. Note the data schema.
1. Right-click the *Coupons* node and select **Show table**. Inspect the coupon data.

## Scaffold the promotions context and coupon model

1. Run the following command:

    ```dotnetcli
    dotnet ef dbcontext scaffold "Data Source=.\Promotions\Promotions.db" Microsoft.EntityFrameworkCore.Sqlite --context-dir .\Data --output-dir .\Models   
    ```

    The preceding command:

    - Scaffolds a `DbContext` and model classes using the provided connection string.
    - Specifies the `Microsoft.EntityFrameworkCore.Sqlite` database provider should be used.
    - Specifies directories for the resulting `DbContext` and model classes.

1. Open *Models/Coupon.cs*. The `Expiration` property is defined as a string, since Sqlite doesn't have a datetime type.
1. Change `Expiration` to a `DateTime`. EF Core will manage the conversion of datetime to string data.

    > [!TIP]
    > New scaffolded files can be generated if the database changes. However, be aware that any manual changes you've made to the original scaffolded files will need to be recreated in the replacement files.

## Add coupon endpoint

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
            return _context.Coupons!
                .AsNoTracking()
                .ToList();
        }
    }
    ```

    In the preceding code:

    - A `PromotionsContext` is injected into the constructor.
    - The `Get` method returns all the coupons.

1. In *Program.cs*, replace the `// Add the PromotionsContext` comment with the following code:

    ```csharp
    builder.Services.AddDbContext<PromotionsContext>(options =>
        options.UseSqlite("Data Source=./Promotions/Promotions.db"));
    ```

    The preceding registers `PromotionsContext` with the dependency injection system.

1. Save your changes and run the app.

    ```dotnetcli
    dotnet run --urls=https://localhost:5101
    ```

## Test the endpoint

1. In another terminal, run the HttpRepl command.

    ```dotnetcli
    httprepl https://localhost:5101
    ```

1. Switch to the `Coupon` endpoint.

    ```dotnetcli
    cd Coupon
    ```

1. Retrieve the coupons from the database.

    ```dotnetcli
    get
    ```

    Note `expiration` is a datetime.

That's it! You've created and modified scaffolding from an existing database!
