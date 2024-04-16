In this unit, you learn how to use the `IHttpClientFactory` to handle the HTTP client creation and disposal, and to use that client to perform REST operations in an ASP.NET Razor Pages app. The code samples used throughout this unit are based on interacting with an API that enables managing a list of fruit stored in a database. 

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

To add `IHttpClientFactory` to your app, register the `AddHttpClient` in the *Program.cs* file. The following code example uses the named client type and sets the base address of the API used in REST operations, and is referenced throughout the rest of this unit.

```csharp
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

// Add IHttpClientFactory to the container and sets the name of the factory
// to "FruitAPI", and the also sets the base address used in calls
builder.Services.AddHttpClient("FruitAPI", httpClient =>
{
    httpClient.BaseAddress = new Uri("https://www.example.com");
});


var app = builder.Build();
```

## Identify the operation requirements in the API

Before performing operations with an API, you need to identify what the API is expecting:

* **API endpoint:** Identify the endpoint for the operation so you can properly adjust the URI stored in the base address if needed.
* **Data requirements:** Identify if the operation is returning/expecting an array or just a single piece of data.

For example, a `GET` operation could return an array if the endpoint returns all of the data, or any number greater than one, stored in the database. A `GET` operation could also return a single piece of data.

> [!NOTE]
> The code samples throughout the rest of this unit assume each HTTP operation is handled on a separate page in the solution.

## Handler methods in Razor Pages

In Razor Pages, handler methods are methods that handle HTTP requests and events. They're defined in the code-behind file for a Razor Page and are used to perform actions in response to user input or other events. Handler methods follow the naming convention of the word "On" added to the beginning of the HTTP request verb. The following table lists some of the most commonly used handler methods in Razor Pages:

| Handler method | Description |
|--|--|
| `OnGet()` | This method is called when the page is requested using the HTTP GET method. |
| `OnPost()` | This method is called when the page is submitted using the HTTP POST method. |
| `OnGetAsync()` | This method is called asynchronously when the page is requested using the HTTP GET method. |
| `OnPostAsync()` | This method is called asynchronously when the page is submitted using the HTTP POST method. |
| `OnGetHandler()` | This method is called when a specific handler is requested using the HTTP GET method. |
| `OnPostHandler()` | This method is called when a specific handler is requested using the HTTP POST method. |

There are also other handler methods that can be used for handling HTTP requests and events, and you can define your own custom handler methods as well.

> [!NOTE]
> You can only have one page handler method for a specific HTTP operation. For example, an exception will be thrown if you have both `OnGet()` and `OnGetAsync()` in the same code-behind file.

## Perform a `GET` operation

A `GET` operation shouldn't send a body and is used (as the method name indicates) to retrieve data from a resource. To perform an HTTP `GET` operation, given an `HttpClient` and a URI, use the `HttpClient.GetAsync` method. For example, if you wanted to create a table on a Razor Page app's home page (*Index.cshtml*) to display the results of a `GET` operation you need to add the following to the code-behind (*Index.cshtml.cs*):

* Use dependency injection to add the `IHttpClientFactory` to the page model.
* Use the `[BindProperty]` attribute to bind the pages form data to the data model properties. 
* Create an instance of the `HttpClient` 
* Perform the `GET`operation and deserialize the results into your data model.

The following code example shows how to perform a `GET` operation. Be sure to read the comments in the code.

```csharp
namespace FruitWebApp.Pages
{
        public class IndexModel : PageModel
    {
        // IHttpClientFactory set using dependency injection 
        private readonly IHttpClientFactory _httpClientFactory;

        public IndexModel(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        // Adds the data model and binds the form data to the model properties
        // Enumerable since an array is expected as a response
        [BindProperty]
        public IEnumerable<FruitModel> FruitModels { get; set; }

        // OnGet() is async since HTTP operations should be performed async
        public async Task OnGet()
        {
            // Create the HTTP client using the FruitAPI named factory
            var httpClient = _httpClientFactory.CreateClient("FruitAPI");

            // Execute the GET operation and store the response, the empty parameter
            // in GetAsync doesn't modify the base address set in the client factory 
            using HttpResponseMessage response = await httpClient.GetAsync("");

            // If the operation is successful deserialize the results into the data model
            if (response.IsSuccessStatusCode)
            {
                using var contentStream = await response.Content.ReadAsStreamAsync();
                FruitModels = await JsonSerializer.DeserializeAsync<IEnumerable<FruitModel>>(contentStream);
            }
        }
    }
}
```

## Perform a `POST` operation

A `POST` operation should send a body and is used to add data to a resource. To perform an HTTP `POST` operation, given an `HttpClient` and a URI, use the `HttpClient.PostAsync` method. Following our project model of a separate page for eachIf you want to add items to the data on your home page you need to:

For example, if you wanted to create a table on a Razor Page app's home page (*Index.cshtml*) to display the results of a `GET` operation you need to add the following to the code-behind (*Index.cshtml.cs*):

* Use dependency injection to add the `IHttpClientFactory` to the page model.
* Use the `[BindProperty]` attribute to bind the pages form data to the data model properties. 
* Serialize the data you want to add using the `JsonSerializer.Serialize` method.
* Create an instance of the `HttpClient` 
* Perform the `POST`operation.

> [!NOTE]
> Following our project model of a separate page for each REST operation the `POST` operation is performed in an *Add.cshtml* page with the code example in the *Add.cshtml.cs* code-behind file.

The following code example shows how to perform a `POST` operation. Be sure to read the comments in the code.

```csharp
namespace FruitWebApp.Pages
{
	public class AddModel : PageModel
    {
        // IHttpClientFactory set using dependency injection 
        private readonly IHttpClientFactory _httpClientFactory;

        public AddModel(IHttpClientFactory httpClientFactory) => _httpClientFactory = httpClientFactory;

        // Add the data model and bind the form data to the page model properties
        [BindProperty]
        public FruitModel FruitModels { get; set; }

		// OnPost() is async since HTTP operations should be performed async
        public async Task<IActionResult> OnPost()
		{
            // Serialize the information to be added to the database
            var jsonContent = new StringContent(JsonSerializer.Serialize(FruitModels),
                Encoding.UTF8,
                "application/json");

			// Create the HTTP client using the FruitAPI named factory
            var httpClient = _httpClientFactory.CreateClient("FruitAPI");

            // Execute the POST operation and store the response. The parameters in 
            // PostAsync direct the POST to use the base address and passes the 
            // serialized data to the API
            using HttpResponseMessage response = await httpClient.PostAsync("",jsonContent);

			// If the POST was successful return to the home (Index) page 
            if (response.IsSuccessStatusCode)
            {
                return RedirectToPage("Index");
            }
            return Page();

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
