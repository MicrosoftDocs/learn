
## How are grains implemented?

From a coding perspective, a grain is a class that inherits from the `Grain` base class. The `Grain` class manages various internal behaviors and integration points with the Orleans framework. Your grain classes should also implement one of the grain interface types listed below. Each of these interfaces defines a similar contract, but marks your class with a different data type for the identifier that Orleans uses to track the grain, such as a `string` or `integer`.

- `IGrainWithGuidKey`
- `IGrainWithIntegerKey`
- `IGrainWithStringKey`
- `IGrainWithGuidCompoundKey`
- `IGrainWithIntegerCompoundKey`

The following code demonstrates a simple grain class definition that inherits from the grain base class and implements one of the identifier interfaces.

```csharp
public class ShoppingCartGrain : Grain, IGrainWithStringKey
{
    // Custom grain implementation details
}
```

A grain also usually implements an interface of your design to manage custom data and behavior. A sample grain interface for a shopping cart might look like the following code:

```csharp
public interface IShoppingCartGrain
{
    Task<bool> AddItemAsync(int quantity, ProductDetails product);
    Task RemoveItemAsync(ProductDetails product);
    Task<IEnumerable<CartItem>> GetAllItemsAsync();
    Task<int> GetCartItemsCount();
    Task EmptyCartAsync();
}
```

To implement the `IShoppingCartGrain` interface, consider a more complete version of the `ShoppingCartGrain` class:

```csharp
public sealed class UrlShortenerGrain : Grain, IGrainWithStringKey, IUrlShortenerGrain
{
    public Task<bool> AddItemAsync(int quantity, ProductDetails product)
    {
        // TODO: Implementation details
    }

    public Task RemoveItemAsync(ProductDetails product)
    {
        // TODO: Implementation details
    }

    // Other methods omitted
}
```

## How are silos implemented?

Clusters and silos are configured in the *Program.cs* class of your project as part of the initial Orleans setup. A silo can be configured to store grains in local memory, or to persist them in more permanent storage. Orleans supports different providers for a variety of storage options, and you can even implement your own custom solutions. The following example configures a cluster to run on localhost and persist grains in Azure Blob Storage.

```csharp
builder.Host.UseOrleans(siloBuilder =>
{
    siloBuilder.UseLocalhostClustering();
    siloBuilder.AddAzureBlobGrainStorage("urls",
        options =>
        {
            options.ConfigureBlobServiceClient(new Uri("https://<your-account-name>.blob.core.windows.net"),
                new DefaultAzureCredential());
        });
});
```

## Use grains in your application

Once your grains are created and your silos are configured, you can begin using those grains in your application. For example, consider the following Razor Page in ASP.NET Core, which uses grains to populate a shopping cart page:

```csharp
public class CartModel : PageModel
{
    public IEnumerable<CartItem> CartItems { get; set; } = new IEnumerable<CartItem>();

    private IGrainFactory grainFactory;

    public CartModel(IGrainFactory grainFactory)
    {
        this.grainFactory = grainFactory;
    }

    public async Task<IActionResult> OnGet()
    {
        var cart = this.grainFactory.GetGrain<IShoppingCartGrain>(cartId);
        CartItems = await cart.GetAllItemsAsync();
        return Page();
    }
}

```

The preceding code 
