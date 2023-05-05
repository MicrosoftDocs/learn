In this unit, you will explore the structure of a Razor page `PageModel` class, learn about page handlers, and examine the `Pizza` model with its data annotations for validation.

## Razor Pages `PageModel` Class Structure

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

The `PageModel` class defines page handlers for HTTP requests and data used to render the page. The `PizzaModel` class currently handles the HTTP GET request with an empty `OnGet` page handler. Common handlers include `OnGet` for page initialization and `OnPost` for form submissions.

## HTTP POST Page Handlers in a `PageModel`

The `OnPostAsync` page handler verifies the user-submitted data, presents the *Pizza* page again if invalid, or sends the valid data to `PizzaService` for persistence.

## Model Binding

The `PizzaModel` class needs access to the `Pizza` model using the `[BindProperty]` attribute:

```csharp
[BindProperty]
public Pizza NewPizza { get; set; }
```

## Server-side Model Validation with ASP.NET Core Data Annotations

Model binding and validation occur before the execution of a page handler:

```csharp
if (!ModelState.IsValid)
{
    return Page();
}
```

If `ModelState` is valid, the `OnPostAsync` page handler calls `PizzaService`.

## Define Validation Rules for the Pizza Model

The `Pizza` model class uses data annotations for validation:

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

The `Pizza` model also serves as a Data Transfer Object (DTO) for network communication.

In the next section, you will update the `PizzaModel` to interact with the `PizzaService` class.
