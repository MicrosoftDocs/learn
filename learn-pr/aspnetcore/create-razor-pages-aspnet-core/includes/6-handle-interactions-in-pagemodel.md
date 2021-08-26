In this unit, you'll review the structure of a Razor page `PageModel` class and its components. You'll add an HTTP POST page handler for the *Create* Razor page form. Finally, you'll walk through the `Pizza` model and its data annotations that drive both client-side and server-side validation.

## Examine the structure of a Razor Pages `PageModel` class

Open the *Pages/Pizza.cshtml.cs* `PageModel` class file. You may remember, that when you created a new Razor page called *Create*, its `PageModel` class file named *Create.cshtml.cs* was generated. Examine the contents. It contains the following C# code:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace RazorPagesPizza.Pages
{
    public class PizzaModel : PageModel
    {
        public void OnGet()
        {
        }
    }
}
```

A Razor page's `PageModel` class file defines any page handlers for HTTP requests sent to the page, and data used to render the page. The `PageModel` keeps those concerns separate from the Razor page, your app more modular, and easier to maintain. By convention, the `PageModel` class is named *<PageName>Model* and resides in the same namespace as the Razor page. In this case, the `PizzaModel` class in the namespace of `RazorPagesPizza.Pages`.

Currently, the `PizzaModel` class handles the HTTP GET request with an empty `OnGet` page handler. You can add handlers for any HTTP verb. The most common handlers are:

* `OnGet` to initialize state needed for the page.
* `OnPost` to handle form submissions.

The *Create* page contains a form and therefore requires an HTTP POST page handler.

## Add an HTTP POST page handler to the `PageModel`

Replace the code in the *Pages/Pizza.cshtml.cs* `PageModel` class with the following code. Save your changes.

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using RazorPagesPizza.Models;
using RazorPagesPizza.Services;
using System.Collections.Generic;

namespace RazorPagesPizza.Pages
{
    public class PizzaModel : PageModel
    {
        public List<Pizza> pizzas;
        public void OnGet()
        {
            pizzas = PizzaService.GetAll();
        }

        public IActionResult OnPostDelete(int id)
        {
            PizzaService.Delete(id);
            return RedirectToAction("Get");
        }

        [BindProperty]
        public Pizza NewPizza { get; set; }

        public IActionResult OnPost()
        {
            PizzaService.Add(NewPizza);
            return RedirectToAction("Get");
        }

        public string GlutenFreeText(Pizza pizza)
        {
            if (pizza.IsGlutenFree)
                return "Gluten Free";
            return "Not Gluten Free";
        }
    }
}
```

The `PizzaModel` class now has an asynchronous `OnPostAsync` page handler. `OnPostAsync` executes when the user posts the *Create* page's form. The *Async* naming suffix is optional but is a common naming convention for asynchronous methods.

The `OnPostAsync` page handler needs to perform the following tasks for this app:

* Verify the user-submitted data posted to the `PageModel` is valid.
* If the attempted `PageModel` changes are invalid, the *Create* page is presented again to the user. A message is displayed clarifying the input requirements.
* If the `PageModel` update is valid, then data changes are passed to a service called `PizzaService`. `PizzaService` will handle the concern of HTTP requests and responses to the web API.

## Bind the model

The `PizzaModel` class needs access to the `Pizza` model. It will validate and pass `Pizza` entries from the *Create* form. It does so by using the `[BindProperty]` attribute in the following code:

```csharp
[BindProperty]
public Pizza Pizza { get; set; }
```

Binding to properties can reduce the amount of code you have to write. Binding reduces code by using the same property to render fields such as in `<input asp-for="Pizza.Name">`.

## Built-in server-side model validation using ASP.NET Core data annotations

Model binding and validation are available when you create a ASP.NET Core web app. Both automatically occur before the execution of a page handler. So the `OnPostAsync` page handler only needs to verify the outcome of that validation.

```csharp
if (!ModelState.IsValid)
{
    return Page();
}
```

In the preceding code, `ModelState` represents errors from model binding and validation. If the `ModelState` is invalid, then the *Create* page is presented again to the user. In the previous unit, you saw how the *Create* Razor page uses ASP.NET Core's built-in client-side form input validation to responsively provide the user with input validation feedback.

If the `ModelState` is valid, the `OnPostAsync` page handler calls upon an instance of `PizzaService`. `PizzaService` is responsible for HTTP requests and responses for the web API.

```csharp
await _PizzaService.CreatePizza(Pizza);

return RedirectToPage("Index");
```

## Define validation rules for the Pizza model using data annotations

This project uses a central model file *Pizza.cs* for `Pizza` model validation and operations. It's used by all Razor page *PageModels* involved in UI for `Pizza` CRUD operations, and is used to validate Pizza data received from the web api. By convention, it's stored in the *Models* directory. The `Pizza` model's namespace is `RazorPagesPizza.Models`.

Your new `PizzaModel` class gained access to any model types defined in the `RazorPagesPizza.Models` namespace, including the `Pizza` model, with the following `using` directive:

```csharp
using RazorPagesPizza.Models;
```

Examine the `Pizza` model class:

```csharp
using System;
using System.ComponentModel.DataAnnotations;

namespace RazorPagesPizza.Models
{
    public class Pizza
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }
        public PizzaSize Size { get; set; }
        public bool IsGlutenFree { get; set; }

        [Range(0.01, 9999.99)]
        public decimal Price { get; set; }
    }

    public enum PizzaSize { Small, Medium, Large }
}
```

Data annotations are attributes that specify behaviors you want to enforce on the model properties to which they're applied.

The `Pizza` class uses the:

* `[Required]` attribute to indicate that a property must have a value.
* `[Range]` attribute to constrain a value to a specific range.

If you decide to enforce more validation rules, you can easily modify attributes in just one place, the `Pizza` model, without being required to modify any of the `PageModel` class files in the project. A significant benefit!

A comprehensive set of data annotation attributes is available to you in the `System.ComponentModel.DataAnnotations` namespace. For the scope of this module, a simplified example is provided.

## The *Pizza* model as a data transfer object

The `Pizza` model also serves as a Data Transfer Object (DTO). A DTO is an object that defines the data that will be sent over the network, in this case to the web API. The *RazorPagesPizza* project's `PizzaService` class that handles all HTTP requests uses the `Pizza` model as a DTO that defines valid *Pizza* data that can be sent to and received from the web API.

## Inject the service that handles HTTP requests

As a final step, the `OnPostAsync` method in your `PizzaModel` class passes the validated data to a service class named `PizzaService`. The `PizzaService` class is an example of a typed `HttpClient` service architecture. The `PizzaService` class manages all HTTP requests to the web API so that code is maintained in one place. Furthermore, it's registered at startup as a service so that it may be injected where needed. It's injected in this project for all `PageModel` classes that require CRUD operations for their Razor pages. You'll walk through an example of `PizzaService` HTTP request logic lifecycle in the next unit.

The `PizzaService` class was made available to the `Create` `PageModel` class with the following `using` statement:

```csharp
using RazorPagesPizza.Services;
```

The `PizzaService` service is injected directly into `PizzaModel` by including it as a constructor parameter, using dependency injection (DI):

```csharp
public class PizzaModel : PageModel
{
    private readonly PizzaService _PizzaService;

    [BindProperty]
    public Pizza Pizza { get; set; }

    public PizzaModel(PizzaService PizzaService)
    {
        _PizzaService = PizzaService;
    }
```

ASP.NET Core supports the Inversion of Control (IoC) principle using DI. DI allows the `PizzaService` service to be injected directly into the constructor of the `PageModel` class that needs it. .NET creates an instance of the `PizzaService` class and disposes of the resulting object when it's no longer needed. DI allows developers to avoid tightly coupling a specific class to another class.

The following code calls the `CreatePizza` method, passing the `Pizza` DTO. The DTO will be sent by HTTP request to the web API:

```csharp
await _PizzaService.CreatePizza(Pizza);
```

The lifecycle of the *RazorPagesPizza* project's `PizzaService` HTTP request logic is explored later in this module.

## Link to the *Create* page

The *Create* page has been created and implemented. Let's allow users to navigate to it.

### Add an Anchor Tag Helper to the *Index* page

1. In *Pages/Pizzas/Index.cshtml*, replace the comment `<!-- Replace with link to Create page -->` with the markup highlighted below:

   [!code-cshtml[](../code/create-pagemodel.cs?highlight=34)]

1. Save your changes.

The preceding highlighted code uses an Anchor Tag Helper. The Tag Helper:

* Directs the user to the *Pages/Pizzas/Create.cshtml* Razor page, located in the same directory as the *Index* page.
* Enhances the standard HTML anchor (`<a>`) tag by adding custom HTML attributes, such as `asp-page-handler`.

The `asp-page-handler` attribute is used to route to a specific page handler for the Razor page defined in the `asp-page` attribute. The `asp-page` attribute is used set an anchor tag's `href` attribute value to a specific Razor page.

Next, you'll explore the lifecycle of the project's `PizzaService` HTTP request logic.
