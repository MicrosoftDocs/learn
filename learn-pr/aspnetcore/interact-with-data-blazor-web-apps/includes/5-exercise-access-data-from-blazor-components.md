The current hard-coded pizzas in the app need to be replaced with a database. You can use the Microsoft Entity Framework to add connections to data sources. In this app, we'll use a SQLite database to store the pizzas.

In this exercise, you'll add packages to support database functionality, connect classes to a back-end database, and add a helper class to preload data for the company's pizzas.

## Add packages to support database access

1. In Visual Studio Code, select **Terminal** > **New Terminal**.
1. Run these commands to add the **Microsoft.EntityFrameworkCore**, **Microsoft.EntityFrameworkCore.Sqlite** and **System.Net.Http.Json** packages:

    ```powershell
    dotnet add package Microsoft.EntityFrameworkCore
    dotnet add package Microsoft.EntityFrameworkCore.Sqlite
    dotnet add package System.Net.Http.Json
    ```
    
    These commands add package references to your BlazingPizza.csproj file:

    ```xml
      <ItemGroup>
        <PackageReference Include="Microsoft.EntityFrameworkCore" Version="6.0.1" />
        <PackageReference Include="Microsoft.EntityFrameworkCore.Sqlite" Version="6.0.1" />
        <PackageReference Include="System.Net.Http.Json" Version="6.0.0" />
      </ItemGroup>
    ```

## Add a database context and controller

1. In Visual Studio Code, select **File** > **New File**.
1. For the language, select **C#**.
1. Enter this code for the class:

    ```csharp
    using Microsoft.EntityFrameworkCore;
    
    namespace BlazingPizza;
    
    public class PizzaStoreContext : DbContext
    {
        public PizzaStoreContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<PizzaSpecial> Specials { get; set; }
    }    
    ```

    This class creates a database context we can use to register a database service. The context also allows us to have a controller that accesses the database.

1. Select <kbd>Ctrl</kbd> + <kbd>S</kbd>. In the **Save As** dialog, for **File name** enter **PizzaStoreContext.cs**, and then select **Save**.
1. Select **File** > **New File**.
1. For the language, select **C#**.
1. Enter this code for the class:

    ```csharp
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    
    namespace BlazingPizza;

    [Route("specials")]
    [ApiController]
    public class SpecialsController : Controller
    {
        private readonly PizzaStoreContext _db;

        public SpecialsController(PizzaStoreContext db)
        {
            _db = db;
        }

        [HttpGet]
        public async Task<ActionResult<List<PizzaSpecial>>> GetSpecials()
        {
            return (await _db.Specials.ToListAsync()).OrderByDescending(s => s.BasePrice).ToList();
        }
    }
    ```

    This class creates a controller that allows us to query the database for pizza specials and returns them as JSON at the [http://localhost:5000/specials](http://localhost:5000/specials) URL.

1. Select <kbd>Ctrl</kbd> + <kbd>S</kbd>. In the **Save As** dialog, for **File name** enter **SpecialsController.cs**, and then select **Save**.

## Load data into the database

The app checks to see if there's an existing SQLite database and creates one with some premade pizzas.

1. Select **File** > **New File**.
1. For the language, select **C#**.
1. Enter this code for the class:

    ```csharp
    namespace BlazingPizza;

    public static class SeedData
    {
        public static void Initialize(PizzaStoreContext db)
        {
            var specials = new PizzaSpecial[]
            {
                new PizzaSpecial()
                {
                    Name = "Basic Cheese Pizza",
                    Description = "It's cheesy and delicious. Why wouldn't you want one?",
                    BasePrice = 9.99m,
                    ImageUrl = "img/pizzas/cheese.jpg",
                },
                new PizzaSpecial()
                {
                    Id = 2,
                    Name = "The Baconatorizor",
                    Description = "It has EVERY kind of bacon",
                    BasePrice = 11.99m,
                    ImageUrl = "img/pizzas/bacon.jpg",
                },
                new PizzaSpecial()
                {
                    Id = 3,
                    Name = "Classic pepperoni",
                    Description = "It's the pizza you grew up with, but Blazing hot!",
                    BasePrice = 10.50m,
                    ImageUrl = "img/pizzas/pepperoni.jpg",
                },
                new PizzaSpecial()
                {
                    Id = 4,
                    Name = "Buffalo chicken",
                    Description = "Spicy chicken, hot sauce and bleu cheese, guaranteed to warm you up",
                    BasePrice = 12.75m,
                    ImageUrl = "img/pizzas/meaty.jpg",
                },
                new PizzaSpecial()
                {
                    Id = 5,
                    Name = "Mushroom Lovers",
                    Description = "It has mushrooms. Isn't that obvious?",
                    BasePrice = 11.00m,
                    ImageUrl = "img/pizzas/mushroom.jpg",
                },
                new PizzaSpecial()
                {
                    Id = 7,
                    Name = "Veggie Delight",
                    Description = "It's like salad, but on a pizza",
                    BasePrice = 11.50m,
                    ImageUrl = "img/pizzas/salad.jpg",
                },
                new PizzaSpecial()
                {
                    Id = 8,
                    Name = "Margherita",
                    Description = "Traditional Italian pizza with tomatoes and basil",
                    BasePrice = 9.99m,
                    ImageUrl = "img/pizzas/margherita.jpg",
                },
            };
            db.Specials.AddRange(specials);
            db.SaveChanges();
        }
    }
    ```

    The class uses a passed database context, creates some `PizzaSpecial` objects in an array, and then saves them.

1. Select <kbd>Ctrl</kbd> + <kbd>S</kbd>. In the **Save As** dialog, for **File name** enter **SeedData.cs**, and then select **Save**.
1. In the file explorer, select **Program.cs**.
1. At the top, add a reference to a new `PizzaStoreContext`:

    ```csharp
    using BlazingPizza;
    ```

    This statement allows the app to use the new service.

1. Insert this segment above the `app.Run();` method:

    ```csharp
    ...
    // Initialize the database
    var scopeFactory = app.Services.GetRequiredService<IServiceScopeFactory>();
    using (var scope = scopeFactory.CreateScope())
    {
        var db = scope.ServiceProvider.GetRequiredService<PizzaStoreContext>();
        if (db.Database.EnsureCreated())
        {
            SeedData.Initialize(db);
        }
    }

    app.Run();
    ```

    This change creates a database scope with the `PizzaStoreContext`. If there isn't a database already created, it calls the `SeedData` static class to create one.

    At the moment, the app won't work because we haven't initialized the `PizzaStoreContext`. This code should be added to **Startup.cs**.

1. In the `Add Services to the container` section higher in the `Program.cs` file, add this code under the current services:

    ```csharp
      builder.Services.AddHttpClient();
      builder.Services.AddSqlite<PizzaStoreContext>("Data Source=pizza.db");

    ```

    This code registers two services. The first `AddHttpClient` statement allows the app to access HTTP commands. The app uses an HttpClient to get the JSON for pizza specials. The second statement registers the new `PizzaStoreContext` and provides the filename for the SQLite database.

1. Visual Studio Code highlights `UseSqlite` as an error, so you must add a reference to the `EntityFrameworkCore` package. At the top of the file, under the existing `using` block, add:

    ```csharp
    using Microsoft.EntityFrameworkCore;
    ```

## Use the database to display pizzas

We can now replace the hard-coded pizza in the **index.razor** page.

1. In the file explorer, select **Index.razor**.
1. Replace the existing `OnInitialized()` method with:

    ```csharp
    protected override async Task OnInitializedAsync()
    {
        specials = await HttpClient.GetFromJsonAsync<List<PizzaSpecial>>(NavigationManager.BaseUri + "specials");
    }
    ```

    > [!NOTE]
    > This code has replaced `OnInitialized()` with `OnInitializedAsync()`. Specials are now going to be returned as JSON from the app asynchronously.

1. There are some errors that you need to fix. Add these `@inject` statements under the `@page` directive:

    ```razor
    @inject HttpClient HttpClient
    @inject NavigationManager NavigationManager
    ```

   To fix the last error, we need to make the app aware of `GetFromJsonAsync`.
1. In the file explorer, select **_Imports.razor**.
1. Add this new `@using` statement at the bottom:

    ```razor
    @using System.Net.Http.Json
    ```

1. Select <kbd>F5</kbd> or select **Run**. Then select **Start Debugging**.

    There's a runtime error when you run the app. The **JsonReader** raised an exception.

1. Remember that the app should be creating JSON at [http://localhost:5000/specials](http://localhost:5000/specials). Go to that URL.

   The app doesn't know how to route this request. You'll learn about routing in the module on Blazor routing. Let's fix the error now.
1. Select <kbd>Shift</kbd> + <kbd>F5</kbd>, or select **Stop Debugging**.
1. In the file explorer, select **Program.cs**.
1. Near the bottom of the file, after the `Configure the HTTP request pipeline` comment and the `app.UseEndpoints` block, add this endpoint:

    ```csharp
    app.MapControllerRoute("default", "{controller=Home}/{action=Index}/{id?}");
    ```

    The code should now be:

    ```csharp
    ...
    app.MapRazorPages();
    app.MapBlazorHub();
    app.MapFallbackToPage("/_Host");
    app.MapControllerRoute("default", "{controller=Home}/{action=Index}/{id?}");
    ...
    ```

1. Select <kbd>F5</kbd> or select **Run**. Then select **Start Debugging**.

   The app should now work, but let's check that the JSON is being created correctly.
1. Go to [http://localhost:5000/specials](http://localhost:5000/specials) to see:

    :::image type="content" source="../media/5-returned-json.png" alt-text="Screenshot showing the browser that shows JSON for pizzas.":::

    The JSON has the pizzas listed in descending order of price as specified in the special pizza controller.


    :::image type="content" source="../media/5-more-blazing-pizzas.png" alt-text="Screenshot showing even more blazing pizzas.":::
