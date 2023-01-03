In this unit, you'll add an HTTP POST page handler for the *Pizza* Razor page form. Finally, you'll walk through the `Pizza` model and its data annotations that drive both client-side and server-side validation.

## Examine the structure of a Razor Pages `PageModel` class

Open the *Pages/Pizza.cshtml.cs* `PageModel` class file. You may remember, that when you created a new Razor page called *Pizza*, its `PageModel` class file named *Pizza.cshtml.cs* was generated. Examine the contents. It contains the following C# code:

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

## Update the HTTP Get page handler to display the list of Pizzas

Currently, the `PizzaModel` class handles the HTTP GET request with an empty `OnGet` page handler. Let's update the handler to display a list of pizzas from the `PizzaService`.

### Update the `OnGet` page handler

Update the `OnGet` method as follows:

```csharp
public void OnGet()
{
    pizzas = PizzaService.GetAll();
}
```

Add a `List<Pizza>` variable named `pizzas` to the `PizzaModel` class:

```csharp
public List<Pizza> pizzas = new();
```

When the `OnGet` method is called, it will assign the results of the `PizzaService.GetAll()` method to the `pizzas` variable. This variable will be accessible to the Razor page template, where it will be written to the table listing the available pizzas.

These statements are referencing the `PizzaService` and `Pizza` classes, so you'll need to add the following using statements to the top of the `PizzaModel` class:

```csharp
using RazorPagesPizza.Models;
using RazorPagesPizza.Services;
```

### Use a utility method to format the Gluten Free information in the list

The `IsGlutenFree` property is a boolean value. You can use a utility method to format the boolean value as a string. Add the following utility method to the `PizzaModel` class:

```csharp
public string GlutenFreeText(Pizza pizza)
{
    return pizza.IsGlutenFree ? "Gluten Free": "Not Gluten Free";
}
```

## Add an HTTP POST page handler to the `PageModel`

Add the following method to the *Pages/Pizza.cshtml.cs* `PageModel` class.

```csharp
public IActionResult OnPost()
{
    if (!ModelState.IsValid)
    {
        return Page();
    }
    PizzaService.Add(NewPizza);
    return RedirectToAction("Get");
}
```

The `PizzaModel` class now has an asynchronous `OnPost` page handler. `OnPost` executes when the user posts the *Pizza* page's form. You can also use the optional *Async* naming suffix, `OnPostAsync`.

The `OnPost` page handler needs to perform the following tasks for this app:

* Verify that the user-submitted data posted to the `PageModel` is valid.
* If the attempted `PageModel` changes are invalid, the *Pizza* page is presented again to the user. A message is displayed clarifying the input requirements.
* If the `PageModel` update is valid, then data changes are passed to a service called `PizzaService`. `PizzaService` will handle the concern of HTTP requests and responses to the web API.

## Bind the model

The `PizzaModel` class needs access to the `Pizza` model. It will validate and pass `Pizza` entries from the *Pizza* form using the `[BindProperty]` attribute. Add the following code to your `PizzaModel` class:

```csharp
[BindProperty]
public Pizza NewPizza { get; set; } = new();
```

## Add an HTTP POST handler for the Delete buttons

A Razor page can include multiple forms. Since the Delete buttons in your list of pizzas modifies data, an HTTP POST rather that an HTTP GET is required.

Add the following `OnPostDelete` method to the `PizzaModel` class:

```csharp
public IActionResult OnPostDelete(int id)
{
    PizzaService.Delete(id);
    return RedirectToAction("Get");
}
```

> [!TIP]
> Your `PizzaModel` class should look similar to this:
>
> ```csharp
> public class PizzaModel : PageModel
> {
>     public List<Pizza> pizzas = new();
>     [BindProperty]
>     public Pizza NewPizza { get; set; } = new();
> 
>     public void OnGet()
>     {
>         pizzas = PizzaService.GetAll();
>     }
>     
>     public string GlutenFreeText(Pizza pizza)
>     {
>         return pizza.IsGlutenFree ? "Gluten Free": "Not Gluten Free";
>     }
> 
>     public IActionResult OnPost()
>     {
>         if (!ModelState.IsValid)
>         {
>             return Page();
>         }
>         PizzaService.Add(NewPizza);
>         return RedirectToAction("Get");
>     }
> 
>     public IActionResult OnPostDelete(int id)
>     {
>         PizzaService.Delete(id);
>         return RedirectToAction("Get");
>     }
> }
> ```

## Link to the *Pizza* page

The *Pizza* page has been created and implemented. Let's allow users to navigate to it.

### Add an Anchor Tag Helper to the *Index* page

1. In *Pages/Shared/_Layout_.cshtml*, add the following code to the `<nav>` section between the `Home` and `Privacy` links:

```razor
<li class="nav-item">
    <a class="nav-link text-dark" asp-area="" asp-page="/Pizza">Pizza List</a>
</li>
```

The result will appear as follows:

   [!code-cshtml[](../code/layout.cs?highlight=24-26)]

The preceding highlighted code uses an Anchor Tag Helper. The Tag Helper:

* Directs the user to the *Pages/Pizzas/Create.cshtml* Razor page, located in the same directory as the *Index* page.
* Enhances the standard HTML anchor (`<a>`) tag by adding custom HTML attributes, such as `asp-page-handler`.

The `asp-page-handler` attribute is used to route the Razor page defined in the `asp-page` attribute to a specific page handler. The `asp-page` attribute is used to set an anchor tag's `href` attribute value to a specific Razor page.

## Test the app

That's it! You've implemented the Pizza List page completely. Let's test it with the following steps:

1. Ensure you've saved all your changes, and then run the following .NET CLI command in the terminal:

    ```dotnetcli
    dotnet run
    ```

    The app builds and runs. If there are any build errors, resolve them, and then attempt to run again.

1. Open the app in your browser by browsing to the HTTPS URL.

1. Navigate to the new *Pizza* page by selecting the `Pizza List` link in the navigation bar.

1. Fill in the form to create a new pizza and select the `Add` button. Your new pizza should appear in the list of pizzas.

1. Test the validation by entering an invalid pizza information, such as a blank pizza name or a price of 10000 or greater. You should see the validation error message displayed.

1. Delete a pizza from the list by selecting the `Delete` button. The pizza should disappear from the list.

1. When you're done testing the app, stop the application by pressing the **Ctrl+C** key combination (**Command+C** on Mac) in the terminal window.
