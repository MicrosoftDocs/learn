In this unit, you learn how to use the `IHttpClientFactory` to handle the HTTP client creation and disposal, and to use that client to perform REST operations in an ASP.NET Blazor Web app. The code samples used throughout this unit are based on interacting with an API that enables managing a list of fruit stored in a database. The information in this unit is based on using code-behind files in a Razor app.

The following code represents the data model that is referenced in the code examples:

```csharp
public class FruitModel
{
    // An id assigned by the database
    public int id { get; set; }
    // The name of the fruit
    public string? name { get; set; }
    // A boolean to indicate if the fruit is in stock
    public bool instock { get; set; }
}
```

## Register `IHttpClientFactory` in your app

To add `IHttpClientFactory` to your app, register `AddHttpClient` in the *Program.cs* file. The following code example uses the named client type and sets the base address of the API used in REST operations, and is referenced throughout the rest of this unit.

```csharp
// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Add IHttpClientFactory to the container and set the name of the factory
// to "FruitAPI". The base address for API requests is also set.
builder.Services.AddHttpClient("FruitAPI", httpClient =>
{
    httpClient.BaseAddress = new Uri("http://localhost:5050/");
});

var app = builder.Build();
```

## Identify the operation requirements in the API

Before performing operations with an API, you need to identify what the API is expecting:

* **API endpoint:** Identify the endpoint for the operation so you can properly adjust the URI stored in the base address if needed.
* **Data requirements:** Identify if the operation is returning/expecting an enumerable or just a single piece of data.

> [!NOTE]
> The code samples throughout the rest of this unit assume each HTTP operation is handled on a separate page in the solution.

## Perform a `GET` operation

A `GET` operation shouldn't send a body and is used (as the method name indicates) to retrieve data from a resource. To perform an HTTP `GET` operation, given an `HttpClient` and a URI, use the `HttpClient.GetAsync` method. For example, if you wanted to create a table on a Razor Page app's home page (*Home.razor*) to display the results of a `GET` operation you need to add the following to the code-behind (*Home.razor.cs*):

* Use dependency injection to add the `IHttpClientFactory` to the page model.
* Create an instance of the `HttpClient` 
* Perform the `GET`operation and deserialize the results into your data model.

The following code example shows how to perform a `GET` operation. Be sure to read the comments in the code.

```csharp
public partial class Home : ComponentBase
{
    // IHttpClientFactory set using dependency injection 
    [Inject]
    public required IHttpClientFactory HttpClientFactory { get; set; }

    [Inject]
    private NavigationManager? NavigationManager { get; set; }

    /* Add the data model, an array is expected as a response */
    private IEnumerable<FruitModel>? _fruitList;

    // Begin GET operation when the component is initialized
    protected override async Task OnInitializedAsync()
    {
        // Create the HTTP client using the FruitAPI named factory
        var httpClient = HttpClientFactory.CreateClient("FruitAPI");

        // Perform the GET request and store the response. The parameter
        // in GetAsync specifies the endpoint in the API 
        using HttpResponseMessage response = await httpClient.GetAsync("/fruits");

        // If the request is successful deserialize the results into the data model
        if (response.IsSuccessStatusCode)
        {
            using var contentStream = await response.Content.ReadAsStreamAsync();
            _fruitList = await JsonSerializer.DeserializeAsync<IEnumerable<FruitModel>>(contentStream);
        }
        else
        {
            // If the request is unsuccessful, log the error message
            Console.WriteLine($"Failed to load fruit list. Status code: {response.StatusCode}");
        }
    }
}
```

## Perform a `POST` operation

A `POST` operation should send a body and is used to add data to a resource. To perform an HTTP `POST` operation, given an `HttpClient` and a URI, use the `HttpClient.PostAsync` method. If you want to use a form to add items to the data on your home page you need to:

* Use dependency injection to add the `IHttpClientFactory` to the page model.
* Bind the data to the form using either the `EditForm` or `EditContext` model. 
* Serialize the data you want to add using the `JsonSerializer.Serialize` method.
* Create an instance of the `HttpClient` 
* Perform the `POST`operation.

> [!NOTE]
> Following our project model of a separate page for each REST operation the `POST` operation is performed in an *Add.razor* page with the code example in the *Add.razor.cs* code-behind file.

The following code example shows how to perform a `POST` operation. Be sure to read the comments in the code.

```csharp
namespace FruitWebApp.Components.Pages;

public partial class Add : ComponentBase
{
    // IHttpClientFactory set using dependency injection 
    [Inject]
    public required IHttpClientFactory HttpClientFactory { get; set; }

    // NavigationManager set using dependency injection
    [Inject]
    private NavigationManager? NavigationManager { get; set; }

    // Add the data model and bind the form data to it
    [SupplyParameterFromForm]
    private FruitModel? _fruitList { get; set; }

    protected override void OnInitialized() => _fruitList ??= new();

    // Begin POST operation code
    private async Task Submit()
    {
        // Serialize the information to be added to the database
        var jsonContent = new StringContent(JsonSerializer.Serialize(_fruitList),
            Encoding.UTF8,
            "application/json");

        // Create the HTTP client using the FruitAPI named factory
        var httpClient = HttpClientFactory.CreateClient("FruitAPI");

        // Execute the POST request and store the response. The response will contain the new record's ID
        using HttpResponseMessage response = await httpClient.PostAsync("/fruits", jsonContent);

        // Check if the operation was successful, and navigate to the home page if it was
        if (response.IsSuccessStatusCode)
        {
            NavigationManager?.NavigateTo("/");
        }
        else
        {
            Console.WriteLine("Failed to add fruit. Status code: {response.StatusCode}");
        }
    }
}
```

## Perform other REST operations

Other operations like `PUT` and `DELETE` follow the same model as shown previously. The following table defines common REST operations along with the associated `HttpClient` method:

| Request | Method | Definition |
| --- | --- | --- |
| GET | `HttpClient.GetAsync` | Retrieves a resource |
| POST | `HttpClient.PostAsync` | Creates a new resource |
| PUT | `HttpClient.PutAsync` | Updates an existing resource, or creates a new resource if it doesn't exist  |
| DELETE | `HttpClient.DeleteAsync` | Deletes a resource |
| PATCH | `HttpClient.PatchAsync` | Partially updates an existing resource |
