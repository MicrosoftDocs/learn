In this unit, you'll review the structure of a basic Razor Page *:::no-loc text="PageModel":::* class and its elements. You'll add a *:::no-loc text="POST":::* event handler method for the *:::no-loc text="Create":::* Razor Page form. Finally, you'll walk through the `Product` model class and its DataAttributes that drive both client-side and server-side validation.

## Examine the structure of a basic Razor Pages *:::no-loc text="PageModel":::* class file

Open the *:::no-loc text="Create.cshtml.cs":::* *:::no-loc text="PageModel":::* class file located in the *:::no-loc text="ContosoPets.Ui/Pages/Products/":::* directory. You may remember, that when you created a new Razor Page called *:::no-loc text="Create":::*, its *:::no-loc text="PageModel":::* class file named *:::no-loc text="Create.cshtml.cs":::* was generated. Examine the contents. It should contain the following C# code:

 ```csharp
namespace Contoso.UI.Pages.Products
{
    public class CreateModel : PageModel
    {
        public void OnGet()
        {

        }
    }
}
```

A Razor Page's *:::no-loc text="PageModel":::* class file defines any page handlers for requests sent to the page, and data used to render the page. The *:::no-loc text="PageModel":::* keeps those concerns separate from the Razor Page, your application more modular, and much easier to maintain.
By convention, the *:::no-loc text="PageModel":::* class is named *:::no-loc text="<PageName>Model":::* and is in the same namespace as the Razor Page. In this case, the `CreateModel` class in the namespace of `ContosoPets.Ui.Pages.Products`.

Currently, the `CreateModel` class handles the HTTP GET request and does nothing with it.

You can add handler methods for any HTTP verb. The most common handlers are:

* *:::no-loc text="OnGet":::* to initialize state needed for the page.
* *:::no-loc text="OnPost":::* to handle form submissions.

The *:::no-loc text="Create":::* page is a form and requires an *:::no-loc text="OnPost handler method":::*.

## Adding an `OnPost` handler method to the `Create` *:::no-loc text="PageModel":::* class

Replace the code in the *:::no-loc text="Create.cshtml.cs":::* *:::no-loc text="PageModel":::* class file located in the *:::no-loc text="ContosoPets.Ui/Pages/Products/":::* directory with the following, and save your changes:

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

The *:::no-loc text="CreateModel":::* class now has an *:::no-loc text="OnPostAsync":::* handler method. *:::no-loc text="OnPostAsync":::* runs on *:::no-loc text="POST":::* requests (when the user posts the *:::no-loc text="Create":::* form).
The *:::no-loc text="Async":::* naming suffix is optional but is often used by convention for asynchronous functions.

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

The *:::no-loc text="OnPost":::* handler will need to do the following tasks for this application:

* Verify the user-submitted data posted to the *:::no-loc text="PageModel":::* is valid.
* If the attempted *:::no-loc text="PageModel":::* changes are not valid, the *:::no-loc text="Create":::* page is presented again to the user. A message is displayed clarifying the input requirements.
* If the *:::no-loc text="PageModel":::* update is valid, then data changes are passed to a service called *:::no-loc text="ProductService":::*. *:::no-loc text="ProductService":::* will handle the concern of HTTP requests and responses to the web API.

## Binding the `Product` model

The `CreateModel` class needs access to the `Product` model. It will validate and pass `Product` entries from the *:::no-loc text="Create":::* form. It does so by using the *:::no-loc text="[BindProperty]":::* attribute in the following code:

```csharp
[BindProperty]
public Product Product { get; set; }
```

Binding to properties can reduce the amount of code you have to write. Binding reduces code by using the same property to render fields such as in `<input asp-for="Product.Name">`.

## Built-in server-side model validation using ASP.NET Core data annotations

Model binding and validation functionality are built-in when you create a ASP.NET Core web application. Both automatically occur before the execution of a Razor Page's handler method. So the *:::no-loc text="OnPostAsync":::* handler method only needs to verify the outcome of that validation.

```csharp
if (!ModelState.IsValid)
{
    return Page();
}
```

In the preceding code, *:::no-loc text="ModelState":::* represents errors from model binding and validation. If the *:::no-loc text="ModelState":::* isn't valid, then the *:::no-loc text="Create":::* page is presented again to the user. In the previous unit, you saw how the *:::no-loc text="Create":::* Razor Page takes advantage of ASP.NET Core's built-in client-side form input validation to responsively provide the user with input validation feedback.

If the *:::no-loc text="ModelState":::* is valid, then the *:::no-loc text="OnPostAsync":::* handler will proceed to call upon an instance of *:::no-loc text="ProductService":::*. *:::no-loc text="ProductService":::* is responsible for HTTP requests and responses for the web API.

```csharp
await _productService.CreateProduct(Product);

return RedirectToPage("Index");
```

## Defining validation rules for the product model using data annotations

This project uses a central model file *:::no-loc text="Product.cs":::* for `Product` model validation and operations. It's used by all Razor Page *:::no-loc text="PageModels":::* involved in UI for Product CRUD operations, and is used to validate product data received from the web api. By convention it's stored in the *:::no-loc text="Models/":::* directory. The `Product` model class namespace is `ContosoPets.Ui.Models`.

Your new `CreateModel` class gained access to any model types defined in the `ContosoPets.Ui.Models` namespace, including the `Product` model, with the following *:::no-loc text="using":::* directive:

```csharp
using ContosoPets.Ui.Models;
```

Examine the `Product` model class:

```csharp
using System.ComponentModel.DataAnnotations;

namespace ContosoPets.Ui.Models
{
    public class Product
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        [Range(minimum:0.01, maximum:9999.99)]
        public decimal Price { get; set; }
    }
}
```

Data annotations are simple attributes used to specify behavior that you want to enforce on the model properties to which they're applied.

The *:::no-loc text="Product":::* class uses the `[Required]` and the `[Range]` attributes:

* The `[Required]` attribute indicates that a property must have a value.
* The `[Range]` attribute constrains a value to within a specified range.

If you decide to enforce more validation rules, you can easily modify attributes in just one place, the `Product` model, without being required to modify any of the *:::no-loc text="PageModel":::* class files in the project. A significant benefit!

There is a comprehensive set of data annotation attributes available to you through `System.ComponentModel.DataAnnotations`. For the scope of this module, a small and simplified example is provided.

## The *:::no-loc text="Product":::* model as a data transfer object

The `Product` model also serves as a Data Transfer Object (DTO). A DTO is an object that defines the data that will be sent over the network, in this case to the web API. The *:::no-loc text="ContosoPets.UI":::* `ProductService` class that handles all HTTP requests uses the `Product` model as a DTO that defines valid *:::no-loc text="Product":::* data that can be sent to and received from the web API.

## Injecting the ContosoPets.UI ProductService service that handles HTTP requests

As a final step, the *:::no-loc text="OnPost":::* method in your `CreateModel` class passes the validated data to a service class named `ProductService`. The `ProductService` class is an example of a typed *:::no-loc text="HTTPClient":::* service architecture. Simply put, the `ProductService` class is responsible for executing all HTTP requests to the web API so that code is maintained in one place. Furthermore it is registered at startup as a service so that it may be injected where needed. It is injected in this project for all *:::no-loc text="PageModel":::* classes that initiate Crud operations for their Razor Pages. You will walk through an example of `ProductService` HTTP request logic lifecycle in the next unit.

The `ProductService` class was made available to the `Create` *:::no-loc text="PageModel":::* class with the following *:::no-loc text="using":::* statement:

```csharp
using ContosoPets.Ui.Services;
```

The `ProductService` service is injected directly into `CreateModel` by including it as a constructor parameter, using dependency injection:

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

ASP.NET Core supports the Inversion of Control (IoC) pattern using Dependency Injection (DI). This pattern allows the `ProductService` service to be injected directly into the constructor of this class where it's used. The framework takes on the responsibility of creating an instance of the class and disposing of it when it's no longer needed. The `ProductService` class defines a constructor, `CreateModel` that the service provides to the app. This interface is implemented by a concrete type, `ProductService`. This IoC design pattern allows ASP.NET Core developers to avoid the inherent costs of a class taking a direct dependency on another class.

The following code calls the `CreateModel` method, passing the `Product` Data Transfer Object (DTO) which will be sent by HTTP request to the web API.

```csharp
await _productService.CreateProduct(Product);
```

The lifecycle of the *:::no-loc text="ContosoPets.UI":::* project's `ProductService` HTTP request logic is explored later in this module.

## Use an *:::no-loc text="Anchor Tag Helper":::* to link to the new *:::no-loc text="Create":::* Razor Page

Now that the *:::no-loc text="Create.cshtml":::* Razor Page and its *:::no-loc text="CreateModel.cshtml.cs":::* class file are complete. Let's allow users to navigate to it.

### Add an *:::no-loc text="Anchor Tag Helper":::* to the *:::no-loc text="/Pages/Products/Index.cshtml":::* Razor Page

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

1. Open the *:::no-loc text="ContosoPets.Ui/Pages/Products/Index.cshtml":::* Razor Page file and add the `<a>` markup highlighted below:

   [!code-csharp[](../code/7-create-pagemodel.cs?highlight=34)]

1. Save your changes.

The preceding highlighted code uses an *:::no-loc text="Anchor Tag Helper":::* to direct the user to the *:::no-loc text="ContosoPets.Ui/Pages/Products/Create.cshtml":::* Razor Page located in the same directory as the Index page. The *:::no-loc text="Anchor Tag Helper":::* enhances the standard HTML anchor `(<a ... ></a>` tag by adding new attributes, such as the `[asp-page-handler]` attribute used to route to specific page handlers or the `[asp-page]` attribute, as used here, to set an anchor tag's `href` attribute value to a specific page.

Next, you will explore the lifecycle of the *:::no-loc text="ContosoPets.UI":::* project's `ProductService` HTTP request logic.
