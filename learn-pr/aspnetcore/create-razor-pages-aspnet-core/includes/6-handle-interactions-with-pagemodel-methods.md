In this unit, you'll review the structure of a Razor page `PageModel` class and its components. You'll learn how page handlers interact with your Razor page. Finally, you'll walk through the `Pizza` model and its data annotations that drive both client-side and server-side validation.

## Examine the structure of a Razor Pages `PageModel` class

A new `PageModel` class file contains the following C# code:

```csharp
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

A Razor page's `PageModel` class file defines any page handlers for HTTP requests sent to the page, and data used to render the page. The `PageModel` keeps those concerns separate from the Razor page, making your app more modular and easier to maintain. By convention, the `PageModel` class is named *[PageName]Model* and resides in the same namespace as the Razor page. In this case, the `PizzaModel` class in the namespace of `RazorPagesPizza.Pages`.

Currently, the `PizzaModel` class handles the HTTP GET request with an empty `OnGet` page handler. You can add handlers for any HTTP verb. The most common handlers are:

* `OnGet` to initialize state needed for the page.
* `OnPost` to handle form submissions.

The *Pizza* page contains a form and therefore requires an HTTP POST page handler.

## HTTP POST page handlers in a `PageModel`

The `OnPostAsync` page handler needs to perform the following tasks for this app:

* Verify that the user-submitted data posted to the `PageModel` is valid.
* If the attempted `PageModel` changes are invalid, the *Pizza* page is presented again to the user. A message is displayed clarifying the input requirements.
* If the `PageModel` update is valid, then data changes are passed to a service called `PizzaService`. The `PizzaService` will handle the concern of persisting the data.

## Bind the model

The `PizzaModel` class needs access to the `Pizza` model. It will validate and pass `Pizza` entries from the *Pizza* form. It does so by using the `[BindProperty]` attribute in the following code:

```csharp
[BindProperty]
public Pizza NewPizza { get; set; }
```

Binding to properties can reduce the amount of code you have to write. Binding reduces code by using the same property to render fields such as in `<input asp-for="Pizza.Name">`.

## Built-in server-side model validation using ASP.NET Core data annotations

Model binding and validation are available when you create an ASP.NET Core web app. Both automatically occur before the execution of a page handler. So the `OnPostAsync` page handler only needs to verify the outcome of that validation.

```csharp
if (!ModelState.IsValid)
{
    return Page();
}
```

In the preceding code, `ModelState` represents errors from model binding and validation. If the `ModelState` is invalid, then the *Pizza* page is presented again to the user. In the previous unit, you saw how the *Pizza* Razor page uses ASP.NET Core's built-in client-side form input validation to responsively provide the user with input validation feedback.

If the `ModelState` is valid, the `OnPostAsync` page handler calls upon an instance of `PizzaService`. `PizzaService` is responsible for storing the information. In this case, using an in-memory data store.

## Define validation rules for the Pizza model using data annotations

This project uses a central model file *Pizza.cs* for `Pizza` model validation and operations. It's used by all Razor page *PageModels* involved in UI for `Pizza` CRUD operations, and is used to validate Pizza data received from the web API. By convention, it's stored in the *Models* directory. The `Pizza` model's namespace is `RazorPagesPizza.Models`.

Your new `PizzaModel` class gained access to any model types defined in the `RazorPagesPizza.Models` namespace, including the `Pizza` model, with the following `using` directive:

```csharp
using RazorPagesPizza.Models;
```

Examine the `Pizza` model class:

```csharp
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

The `Pizza` model also serves as a Data Transfer Object (DTO). A DTO is an object that defines the data that will be sent over the network, in this case to the web API. In a more advanced version of this application, the *RazorPagesPizza* project's `PizzaService` class would use the `Pizza` model as a DTO that defines valid *Pizza* data that can be sent to and received from the web API or backing database.

Next, you'll update the `PizzaModel` so that it interacts with the `PizzaService` class to list existing pizzas and create new ones.
