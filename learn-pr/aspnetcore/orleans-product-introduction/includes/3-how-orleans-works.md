Orleans provided powerful features through approachable patterns. Although you can implement Orleans in various ways, a standard setup generally consists of the following tasks:

- Create grain classes and interfaces to represent your data or entities.
- Configure the necessary silos and storage locations in _Program.cs_.
- Inject grain factories into your app components to create and use grains.

This unit explores each of these tasks more closely.

## How are grains implemented?

From a coding perspective, a grain is a standard C# class that usually implements the following three concepts:

- The implementation inherits from the Orleans <xref:Orleans.Grain> base class, which manages various internal behaviors and integration points with Orleans.

- The grain implements one of the following grain interface types. Each of these interfaces defines a similar contract, but marks your class with a different data type for the identifier that Orleans uses to track the grain, such as a `string` or `integer`.

  - `IGrainWithGuidKey`
  - `IGrainWithIntegerKey`
  - `IGrainWithStringKey`
  - `IGrainWithGuidCompoundKey`
  - `IGrainWithIntegerCompoundKey`

- A grain also usually implements an interface of your design to manage custom data and behavior. A sample grain interface for a shopping cart might look like the following code:

   ```csharp
   public interface IShoppingCartGrain
   {
       Task<bool> AddOrUpdateItemAsync(int quantity, ProductDetails product);

       Task RemoveItemAsync(ProductDetails product);

       Task<IEnumerable<CartItem>> GetAllItemsAsync();

       Task<int> GetCartItemsCount();

       Task EmptyCartAsync();
   }
   ```

With these three concepts in mind, consider the following pseudo code, which represents a `ShoppingCartGrain` class implementation. The class inherits from the grain base class and implements the appropriate interfaces:

```csharp
public sealed class ShoppingCartGrain
    : Grain, IGrainWithStringKey, IShoppingCartGrain
{
    public Task<bool> AddOrUpdateItemAsync(int quantity, ProductDetails product)
    {
        // TODO: Implementation details
    }

    public Task RemoveItemAsync(ProductDetails product)
    {
        // TODO: Implementation details
    }

    // Other methods omitted for brevity...
}
```

You can create as many different types of grains as your application requires. Grains can represent any entity that includes state and behavior. Remember, as you create grains in your application, Orleans stores and manages those grains using silos.

## How are silos implemented?

Clusters and silos are configured in the _Program.cs_ class of your project as part of the initial Orleans setup. A silo can be configured to store grains in local memory, or to persist them in more permanent storage. Orleans supports different providers for various storage options, and you can even implement your own custom solutions. The following example configures a cluster to run on localhost and persist grains in Azure Blob Storage.

```csharp
builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
    siloBuilder.AddAzureBlobGrainStorage("shopping",
        options =>
        {
            options.ConfigureBlobServiceClient(
                new Uri("https://<your-account-name>.blob.core.windows.net"),
                new DefaultAzureCredential());
        });
});
```

## Use grains in your application

After your grains are created and your silos are configured, you can begin using those grains in your application. For example, consider the following Razor Page in ASP.NET Core, which uses grains to populate a shopping cart page:

```csharp
public sealed class CartModel(IGrainFactory grainFactory) : PageModel
{
    public IEnumerable<CartItem> CartItems { get; set; } = [];

    public async Task<IActionResult> OnGet()
    {
        // TODO: Use a unique user identifier instead of
        // their name, perhaps a claim value.
        var userId = User.Identity.Name;

        var cart = grainFactory.GetGrain<IShoppingCartGrain>(userId);
        CartItems = await cart.GetAllItemsAsync();

        return Page();
    }
}
```

The preceding code accomplishes the following tasks:

- Injects an Orleans <xref:Orleans.IGrainFactory> into the [primary constructor](/dotnet/csharp/whats-new/tutorials/primary-constructors) of the Razor Page. Orleans provides a default grain factory implementation, which is made available through the .NET Core dependency resolver.
- The `OnGet` method then uses the grain factory to retrieve the correct shopping cart grain for the current user.
- The `GetAllItemsAsync` method retrieves all of the items currently in the shopping cart and binds them to a `CartItems` property. The Razor Page could then display those items in the UI using the matching Razor syntax template.

Although this example depicts a fairly standard development scenario, by using Orleans your code automatically gains several advantages. Your code continues to work as your application scales across many instances and users without any further changes. Orleans can also handle failures or disruptions in the underlying infrastructure to preserve the state of the shopping cart for the user. In the next step, explore these types of advantages more closely.
