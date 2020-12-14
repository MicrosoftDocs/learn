In this unit, you'll review the structure of a Razor page `PageModel` class and its components. You'll add an HTTP POST page handler for the *:::no-loc text="Create":::* Razor page form. Finally, you'll walk through the `Product` model and its data annotations that drive both client-side and server-side validation.

## Examine the structure of a Razor Pages `PageModel` class

Open the *:::no-loc text="Pages/Products/Create.cshtml.cs":::* `PageModel` class file. You may remember, that when you created a new Razor page called *:::no-loc text="Create":::*, its `PageModel` class file named *:::no-loc text="Create.cshtml.cs":::* was generated. Examine the contents. It contains the following C# code:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ContosoPets.Ui.Pages.Products
{
    public class CreateModel : PageModel
    {
        public void OnGet()
        {
        }
    }
}
```

A Razor page's `PageModel` class file defines any page handlers for HTTP requests sent to the page, and data used to render the page. The `PageModel` keeps those concerns separate from the Razor page, your app more modular, and easier to maintain. By convention, the `PageModel` class is named *:::no-loc text="<PageName>Model":::* and resides in the same namespace as the Razor page. In this case, the `CreateModel` class in the namespace of `ContosoPets.Ui.Pages.Products`.

Currently, the `CreateModel` class handles the HTTP GET request with an empty `OnGet` page handler. You can add handlers for any HTTP verb. The most common handlers are:

* `OnGet` to initialize state needed for the page.
* `OnPost` to handle form submissions.

The *:::no-loc text="Create":::* page contains a form and therefore requires an HTTP POST page handler.

## Add an HTTP POST page handler to the `PageModel`

Replace the code in the *:::no-loc text="Pages/Products/Create.cshtml.cs":::* `PageModel` class with the following code. Save your changes.

```csharp
using ContosoPets.Ui.Models;
using ContosoPets.Ui.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Threading.Tasks;

namespace ContosoPets.Ui.Pages.Products
{
    public class CreateModel : PageModel
    {
        private readonly ProductService _productService;

        [BindProperty]
        public Product Product { get; set; }

        public CreateModel(ProductService productService)
        {
            _productService = productService;
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            await _productService.CreateProduct(Product);

            return RedirectToPage("Index");
        }
    }
}
```

The `CreateModel` class now has an asynchronous `OnPostAsync` page handler. `OnPostAsync` executes when the user posts the *:::no-loc text="Create":::* page's form. The *:::no-loc text="Async":::* naming suffix is optional but is a common naming convention for asynchronous methods.

The `OnPostAsync` page handler needs to perform the following tasks for this app:

* Verify the user-submitted data posted to the `PageModel` is valid.
* If the attempted `PageModel` changes are invalid, the *:::no-loc text="Create":::* page is presented again to the user. A message is displayed clarifying the input requirements.
* If the `PageModel` update is valid, then data changes are passed to a service called `ProductService`. `ProductService` will handle the concern of HTTP requests and responses to the web API.

## Bind the model

The `CreateModel` class needs access to the `Product` model. It will validate and pass `Product` entries from the *:::no-loc text="Create":::* form. It does so by using the `[BindProperty]` attribute in the following code:

```csharp
[BindProperty]
public Product Product { get; set; }
```

Binding to properties can reduce the amount of code you have to write. Binding reduces code by using the same property to render fields such as in `<input asp-for="Product.Name">`.

## Built-in server-side model validation using ASP.NET Core data annotations

Model binding and validation are available when you create a ASP.NET Core web app. Both automatically occur before the execution of a page handler. So the `OnPostAsync` page handler only needs to verify the outcome of that validation.

```csharp
if (!ModelState.IsValid)
{
    return Page();
}
```

In the preceding code, `ModelState` represents errors from model binding and validation. If the `ModelState` is invalid, then the *:::no-loc text="Create":::* page is presented again to the user. In the previous unit, you saw how the *:::no-loc text="Create":::* Razor page uses ASP.NET Core's built-in client-side form input validation to responsively provide the user with input validation feedback.

If the `ModelState` is valid, the `OnPostAsync` page handler calls upon an instance of `ProductService`. `ProductService` is responsible for HTTP requests and responses for the web API.

```csharp
await _productService.CreateProduct(Product);

return RedirectToPage("Index");
```

## Define validation rules for the product model using data annotations

This project uses a central model file *:::no-loc text="Product.cs":::* for `Product` model validation and operations. It's used by all Razor page *:::no-loc text="PageModels":::* involved in UI for `Product` CRUD operations, and is used to validate product data received from the web api. By convention, it's stored in the *:::no-loc text="Models":::* directory. The `Product` model's namespace is `ContosoPets.Ui.Models`.

Your new `CreateModel` class gained access to any model types defined in the `ContosoPets.Ui.Models` namespace, including the `Product` model, with the following `using` directive:

```csharp
using ContosoPets.Ui.Models;
```

Examine the `Product` model record:

```csharp
using System.ComponentModel.DataAnnotations;

namespace ContosoPets.Ui.Models
{
    public record Product(
        int Id,
        [Required] string Name,
        [Range(0.01, 9999.99)] decimal Price
    );
}
```

Data annotations are attributes that specify behaviors you want to enforce on the model properties to which they're applied.

The `Product` record uses the:

* `[Required]` attribute to indicate that a property must have a value.
* `[Range]` attribute to constrain a value to a specific range.

If you decide to enforce more validation rules, you can easily modify attributes in just one place, the `Product` model, without being required to modify any of the `PageModel` class files in the project. A significant benefit!

A comprehensive set of data annotation attributes is available to you in the `System.ComponentModel.DataAnnotations` namespace. For the scope of this module, a simplified example is provided.

## The *:::no-loc text="Product":::* model as a data transfer object

The `Product` model also serves as a Data Transfer Object (DTO). A DTO is an object that defines the data that will be sent over the network, in this case to the web API. The *:::no-loc text="ContosoPets.Ui":::* project's `ProductService` class that handles all HTTP requests uses the `Product` model as a DTO that defines valid *:::no-loc text="Product":::* data that can be sent to and received from the web API.

## Inject the service that handles HTTP requests

As a final step, the `OnPostAsync` method in your `CreateModel` class passes the validated data to a service class named `ProductService`. The `ProductService` class is an example of a typed `HttpClient` service architecture. The `ProductService` class manages all HTTP requests to the web API so that code is maintained in one place. Furthermore, it's registered at startup as a service so that it may be injected where needed. It's injected in this project for all `PageModel` classes that require CRUD operations for their Razor pages. You'll walk through an example of `ProductService` HTTP request logic lifecycle in the next unit.

The `ProductService` class was made available to the `Create` `PageModel` class with the following `using` statement:

```csharp
using ContosoPets.Ui.Services;
```

The `ProductService` service is injected directly into `CreateModel` by including it as a constructor parameter, using dependency injection (DI):

```csharp
public class CreateModel : PageModel
{
    private readonly ProductService _productService;

    [BindProperty]
    public Product Product { get; set; }

    public CreateModel(ProductService productService)
    {
        _productService = productService;
    }
```

ASP.NET Core supports the Inversion of Control (IoC) principle using DI. DI allows the `ProductService` service to be injected directly into the constructor of the `PageModel` class that needs it. .NET creates an instance of the `ProductService` class and disposes of the resulting object when it's no longer needed. DI allows developers to avoid tightly coupling a specific class to another class.

The following code calls the `CreateProduct` method, passing the `Product` DTO. The DTO will be sent by HTTP request to the web API:

```csharp
await _productService.CreateProduct(Product);
```

The lifecycle of the *:::no-loc text="ContosoPets.Ui":::* project's `ProductService` HTTP request logic is explored later in this module.

## Link to the *:::no-loc text="Create":::* page

The *:::no-loc text="Create":::* page has been created and implemented. Let's allow users to navigate to it.

### Add an Anchor Tag Helper to the *Index* page

1. In *:::no-loc text="Pages/Products/Index.cshtml":::*, replace the comment `<!-- Replace with link to Create page -->` with the markup highlighted below:

   [!code-cshtml[](../code/create-pagemodel.cs?highlight=34)]

1. Save your changes.

The preceding highlighted code uses an Anchor Tag Helper. The Tag Helper:

* Directs the user to the *:::no-loc text="Pages/Products/Create.cshtml":::* Razor page, located in the same directory as the *:::no-loc text="Index":::* page.
* Enhances the standard HTML anchor (`<a>`) tag by adding custom HTML attributes, such as `asp-page-handler`.

The `asp-page-handler` attribute is used to route to a specific page handler for the Razor page defined in the `asp-page` attribute. The `asp-page` attribute is used set an anchor tag's `href` attribute value to a specific Razor page.

Next, you'll explore the lifecycle of the project's `ProductService` HTTP request logic.
