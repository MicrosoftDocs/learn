In the previous unit, you created a Razor Page that displays a list of pizzas. You used the `@` symbol to switch contexts between HTML and C#. In this unit, you'll learn about *tag helpers*. Tag helpers are a special kind of HTML element that can contain C# code. You'll also learn about *page handlers*. Page handlers are methods that handle browser requests. You'll use page handlers in the next unit to add and delete pizzas.

## Tag helpers

Tag helpers are used to address the inefficiencies of context switching between HTML and C#. Most of ASP.NET Core's built-in Tag helpers extend standard HTML elements. Tag helpers provide extra server-side attributes for HTML elements, making the elements more robust.

There are four tag helpers you should know for this project: **Partial**, **Label**, **Input**, and **Validation Summary Message**.

### Partial Tag Helper

```cshtml
<partial name="_ValidationScriptsPartial" />
```

This injects the contents of the `_ValidationScriptsPartial.cshtml` file into a page. The `_ValidationScriptsPartial.cshtml` file contains JavaScript that's used to validate form input, so it needs to be included on every page that contains a form.

### Label tag helper

```cshtml
<label asp-for="Foo.Id" class="control-label"></label>
```

This extends the standard HTML `<label>` element. Like many tag helpers, it uses an `asp-for` attribute. The attribute accepts a property from the `PageModel`. In this case, the name of the `PageModel`'s `Foo.Id` property (specifically, the string `"Id"`) will be rendered as the content for an HTML `<label>` element.

### Input tag helper

```cshtml
<input asp-for="Foo.Id" class="form-control" />
```

Similar to the previous example, this extends the standard HTML `<input>` element. It also uses an `asp-for` attribute to specify a `PageModel` property. In this case, the value of the `Foo.Id` property will be rendered as the `value` attribute for an HTML `<input>` element.

### Validation Summary Tag Helper

```cshtml
<div asp-validation-summary="All"></div>
```

The Validation Summary Tag Helper displays a validation message for a single property on the model.

> [!NOTE]
> Things like validation rules and property display names are defined in the `PageModel` class. We'll point out where to find them in the code in the next unit.

## Page handlers

The `PageModel` class defines page handlers for HTTP requests and data used to render the page. In the previous exercise, the `PizzaListModel` class handled the HTTP GET request by setting the value of the `PizzaList` property to the value of `_service.GetPizzas()`.

Common handlers include `OnGet` for page initialization and `OnPost` for form submissions. To handle an HTTP POST, a page handler might verify the user-submitted data, present the input form page again if invalid, or send the valid data to a service or database for persistence.

In the next unit, you'll add a form to create new pizzas using several tag helpers. You'll also add page handlers to handle the form submission and deletion of pizzas.
