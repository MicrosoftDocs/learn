In this unit, you'll step through the lifecycle of the project's `ProductService` class HTTP request logic.

## Advantages of using a typed *:::no-loc text="HttpClient":::* service architecture

As mentioned in the previous unit, the `ProductService` class is an example of a typed `HttpClient` service architecture and is responsible for managing HTTP requests to the web API.

A typed `HttpClient` service architecture provides the following advantages:

* The service class is injected as a constructor parameter directly into the PageModel classes in this project.
* The framework takes the responsibility of creating an instance of the `HttpClient` class and disposing of it when it's no longer needed. An advantage for a project that makes use of `HttpClient` instances for each CRUD operation.

## Examine the structure of the *:::no-loc text="ProductService":::* class file and walk through its registration and instantiation as a typed service

Open the *:::no-loc text="Services/ProductService.cs":::* file. You should see the following code:

```csharp
using ContosoPets.Ui.Models;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace ContosoPets.Ui.Services
{
    public class ProductService
    {
        private readonly string _route;
        private readonly HttpClient _httpClient;

        public ProductService(
            HttpClient httpClient,
            IConfiguration configuration)
        {
            _httpClient = httpClient;
            _route = configuration["ProductService:ControllerRoute"];
        }

        public async Task<IEnumerable<Product>> GetProducts()
        {
            var response = await _httpClient.GetAsync(_route);
            response.EnsureSuccessStatusCode();

            var products = await response.Content.ReadAsAsync<IEnumerable<Product>>();

            return products;
        }

        public async Task<Product> GetProductById(int productId)
        {
            var response = await _httpClient.GetAsync($"{_route}/{productId}");
            response.EnsureSuccessStatusCode();

            var product = await response.Content.ReadAsAsync<Product>();

            return product;
        }

        public Task UpdateProduct(Product product) =>
            _httpClient.PutAsJsonAsync($"{_route}/{product.Id}", product);

        public Task CreateProduct(Product product) =>
            _httpClient.PostAsJsonAsync(_route, product);

        public Task DeleteProduct(int productId) =>
            _httpClient.DeleteAsync($"{_route}/{productId}");
    }
}
```

Let's examine how `ProductService` is made available as a service at startup.

In the following code, the `ProductService` class constructor accepts a parameter of an instance of `HttpClient` (`System.Net.Http.HttpClient`).

```csharp
public ProductService(
    HttpClient httpClient,
    IConfiguration configuration)
{
    _httpClient = httpClient;
    _route = configuration["ProductService:ControllerRoute"];
}
```

`ProductService` is instantiated and made available to the app when registered as a service at app startup in the `ConfigureServices` method located in *:::no-loc text="Startup.cs":::* as in the following code:

```csharp
services.AddHttpClient<ProductService>(config => {
    config.BaseAddress = new Uri(Configuration["ProductService:BaseAddress"]);
    config.DefaultRequestHeaders.Add("Accept", MediaTypeNames.Application.Json);
});
```

The `BaseAddress` URI that the `HttpClient` instance will use for all requests to the web API are set in a `ProductService` configuration entry in the *:::no-loc text="appsettings.json":::* file, such as in the following example:

```json
  "ProductService": {
    "BaseAddress": "http://localhost:55964",
    "ControllerRoute": "/products"
  },
```

Now that you walked through how `ProductService` is made available to the app as a service at startup, let's walk through the lifecycle of its `CreateProduct` method.

## Examine the lifecycle of the `CreateProduct` method

1. The user posts the product data form in the *:::no-loc text="Create":::* page.
1. The Input Tag Helper uses the data annotation attributes specified in the `Product` model and produces HTML attributes needed for jQuery validation, executed on the client-side. The HTTP POST request is allowed to continue only if the data is valid. In many cases, validation errors would be detected on the client, and never submitted to the server.
1. The `Create` class's `OnPostAsync` method handles the HTTP POST request on the server-side and checks the `ModelState` for validation errors as seen in the following code:
  
    ```csharp
    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
        {
            return Page();
        }

        await _productService.CreateProduct(Product);

        return RedirectToPage("Index");
    }
    ```

    In the preceding code, if the `ModelState` is invalid, the `Page` helper method is called. `Page` returns an instance of `PageResult`.

    If the `ModelState` is valid, then the `OnPostAsync` method calls the `ProductService` class's `CreateProduct` method and passes an instance of `Product` model, as seen in the following code:

    ```csharp
    await _productService.CreateProduct(Product);

    return RedirectToPage("Index");
    ```

1. The `HttpClient` instance sends an HTTP POST request as an asynchronous operation to the specified URI string `_route` with the given value of `product`, serialized as JSON.

    ```csharp
    public Task CreateProduct(Product product) =>
        _httpClient.PostAsJsonAsync(_route, product);
    ```

As pointed out previously, the `ProductService` service was injected directly into `CreateModel` by including it as a constructor parameter, using DI.
  
Once the ASP.NET Core runtime determines the `HttpClient` instance is no longer in use, it automatically disposes of it.

You now have a completed project that includes a new *:::no-loc text="Create":::* Razor page and its `PageModel` class. You've also walked through how the `PageModel` injects and calls the `ProductService` class methods that encapsulate HTTP request logic.

Next let's compile, deploy, and test your updated project.
