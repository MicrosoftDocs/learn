In this unit, you'll create a form in the *:::no-loc text="ContosoPets.Ui":::* project using Razor Pages to separate the logic of the page from its presentation.

## Create a page

The *:::no-loc text="ContosoPets.Ui":::* project directory is currently open in the [Azure Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor). Run the following .NET CLI command in the command shell:

```dotnetcli
dotnet new page --name Create \
    --namespace ContosoPets.Ui.Pages.Products \
    --output Pages/Products
```

The preceding command:

* Creates the following files in the `ContosoPets.Ui.Pages.Products` namespace:
  * *:::no-loc text="Create.cshtml":::*&mdash;The Razor page
  * *:::no-loc text="Create.cshtml.cs":::*&mdash;The accompanying `PageModel` class
* Stores both files in the project's *:::no-loc text="Pages/Products":::* directory.

## Examine the Razor page's structure

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

1. Open the new *:::no-loc text="Pages/Products/Create.cshtml":::* Razor page. Examine the file's markup:

	```cshtml
	@page
	@model ContosoPets.Ui.Pages.Products.CreateModel
	@{
	}
	```

    The preceding Razor page contains reserved Razor keywords:

    * The `@page` directive is what makes the page a Razor page. It indicates the page can handle HTTP requests. The `@page` directive must be the first directive on a Razor page.
    * The `@model` directive specifies the model type made available to the Razor page. In this case, the type is the `PageModel`-derived class name, prefixed with its namespace. As you recall, that class is defined in *:::no-loc text="Pages/Products/Create.cshtml.cs":::*.

## Render HTML and transition to C#

The following markup is an example of an `@` symbol followed by C# code. The code sets the `ViewData` collection's `Title` key value to `Create`. Razor syntax uses the `@` symbol to transition from HTML to C#. If the `@` symbol is followed by a Razor reserved keyword, it transitions into Razor-specific markup; otherwise, it transitions to C#. Razor evaluates the C# expressions and renders them in the HTML output.

```cshtml
@{
    ViewData["Title"] = "Create";
}
```

A Razor page supports Razor syntax, which is HTML and C# combined. The C# code defines the dynamic rendering logic for the page on the server. The default Razor language is HTML. Rendering HTML from Razor markup is no different than rendering HTML from an HTML file. HTML markup in *:::no-loc text=".cshtml":::* Razor page files is rendered by the server unchanged. In Razor Pages, HTML can be used as you're used to. At the same time, you can take advantage of powerful and time-saving Razor features as you learn to use them.

## Add form markup to the *Create* Razor page

Replace the contents of *:::no-loc text="Pages/Products/Create.cshtml":::* with the following markup. Save your changes.

```cshtml
@page
@model ContosoPets.Ui.Pages.Products.CreateModel
@{
    ViewData["Title"] = "Create";
}

<h1>Create Product</h1>

<form method="post">
    <div class="form-group">
        <label asp-for="Product.Name" class="control-label"></label>
        <input asp-for="Product.Name" class="form-control" />
        <span asp-validation-for="Product.Name" class="text-danger"></span>
    </div>
    <div class="form-group">
        <label asp-for="Product.Price" class="control-label"></label>
        <input asp-for="Product.Price" class="form-control" />
        <span asp-validation-for="Product.Price" class="text-danger"></span>
    </div>
    <div class="form-group">
        <input type="submit" value="Save" class="btn btn-primary" />
    </div>
</form>

@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}
```

[!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

The *:::no-loc text="Create":::* Razor page uses HTML and Razor to support a product creation form. The form accepts **:::no-loc text="Name":::** and **:::no-loc text="Price":::** values for the product to be created. With relatively little markup, dynamic features have been provided through Razor Tag Helpers. Client-side form input validation is enabled via the inclusion of the *:::no-loc text="Pages/Shared/_ValidationScriptsPartial.cshtml":::* partial view. The partial view's contents are injected into the layout page's `Scripts` section.

## Review Razor Tag Helpers

Tag Helpers address the inefficiencies of context switching between HTML and C#. Most of ASP.NET Core's built-in Tag Helpers extend standard HTML elements. Tag Helpers provide additional server-side attributes for HTML elements, making the elements more robust.

There are four Tag Helpers on this page:

* Partial
* Label
* Input
* Validation Message

### Partial Tag Helper

The following markup uses the Partial Tag Helper to asynchronously render a partial view:

```cshtml
<partial name="_ValidationScriptsPartial" />
```

The Partial Tag Helper's `name` attribute accepts the partial view name without the file extension. A view discovery process locates the partial view in the project.

This Tag Helper syntax is an alternative to the following HTML Helper syntax:

```cstml
@{await Html.RenderPartialAsync("_ValidationScriptsPartial");}
```

### Label Tag Helper

The following markup uses the Label Tag Helper:

```cshtml
<label asp-for="Product.Name" class="control-label"></label>
```

The Label Tag Helper extends the standard HTML `<label>` element. As is common for many Tag Helpers, it uses an `asp-for` attribute. The attribute accepts a specified `PageModel` property. In this case, the value of the `PageModel` `Name` property will be rendered as the content for an HTML `<label>` element. The `asp-for` attribute is scoped to the `PageModel` for the Razor page, so the `@` symbol isn't used. The label is dynamic as is needed here, but remains compact and easy to add in your markup.

### Input Tag Helper

The following markup uses the Input Tag Helper. It extends the standard HTML `<input>` element. It also uses an `asp-for` attribute to specify a `PageModel` property.

```cshtml
<input asp-for="Product.Name" class="form-control" />
```

The Input Tag Helper:

* Evaluates the `Product.Name` property, like the Label Tag Helper.
* Adds an `id` and `name` HTML attribute based on that property.
* Sets the input type appropriately. For example, if the specified property type is `bool`, an input type of `checkbox` is used in the generated HTML. In this case, the `Product.Name` property type is `string`. The `Product.Name` property is set by the model's data annotation attributes, which will be reviewed later in this module.
* Provides client-side validation using jQuery, based on the model's data annotation attributes provided through the `PageModel`.
* Prompts the Razor engine to provide additional, more robust server-side validation, if client-side validation was successful. The *:::no-loc text="Create":::* Razor page's HTTP POST event lifecycle, which includes client-side and server-side input validation, is walked through later in this module.

The following HTML output is generated from the Input Tag Helper located in the *:::no-loc text="Create":::* page:

```html
<input name="Product.Name" class="form-control" id="Product_Name" type="text" value="" data-val-required="The Name field is required." data-val="true">
```

### Validation Message Tag Helper

The following markup uses the Validation Message Tag Helper. It displays a validation message for a single property on the model.

```cshtml
<span asp-validation-for="Product.Price" class="text-danger"></span>
```

The Input Tag Helper adds HTML5 `data-` attributes to input elements. The attributes are based on properties in the C# model classes. While responsive client-side validation occurs, validation is also done on the server, which is more secure.

The following HTML is rendered by the Validation Message Tag Helper:

```html
<input name="Product.Price" class="form-control" id="Product_Price" type="text" value="" data-val-required="The Price field is required." data-val="true" data-val-range-min="0.01" data-val-range-max="9999.99" data-val-range="The field Price must be between 0.01 and 9999.99." data-val-number="The field Price must be a number.">
```

The `type`, `data-val-range-min`, `data-val-range-max`, and error response are dynamically set by the model's data annotations for the model's `Product.Price` property.

The product creation Razor page has been created. Let's explore its `PageModel` class and modify it to handle the form's HTTP POST request.
