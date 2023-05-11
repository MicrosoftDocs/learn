In this unit, you'll explore the project structure and learn about key files and directories.

## Examine the project

Noteworthy project files and directories:

| Name                     | Description                                                                                       |
|--------------------------|---------------------------------------------------------------------------------------------------|
| *Pages/*                | Contains Razor Pages and supporting files, each Razor page has a *.cshtml* file and a *.cshtml.cs* `PageModel` class file. |
| *wwwroot/*              | Contains static asset files like HTML, JavaScript, and CSS.                                       |
| *RazorPagesPizza.csproj* | Contains project configuration metadata, such as dependencies.                                    |
| *Program.cs*            | Serves as the app's entry point and configures app behavior, like routing.                       |

### Razor page files and their paired `PageModel` class file

Razor pages are stored in the *Pages* directory. A `PageModel` class allows separation of a Razor page's logic and presentation, defines page handlers for requests, and encapsulates data properties and logic scoped to its Razor page.

## The *Pages/Shared* directory

This directory contains shared partial views:

* *_Layout.cshtml*: Provides common layout elements across multiple pages.
* *_ValidationScriptsPartial.cshtml*: Provides validation functionality to all pages.

### Layouts and partial view files

* Layouts: *.cshtml* files defining top-level templates for views, reducing duplicate code in views.
* Partial view: Razor markup files (*.cshtml*) rendering HTML output within another markup file's rendered output, used to break up large markup files and reduce duplicate content.

## The *Pages* directory structure and routing requests

Razor Pages uses the *Pages* directory structure as the convention for routing requests. The following table shows routes for the completed project.

| URL                      | Maps to Razor page                         |
|--------------------------|-------------------------------------------|
| `www.domain.com`         | *Pages/Index.cshtml*                      |
| `www.domain.com/index`   | *Pages/Index.cshtml*                      |
| `www.domain.com/products`| *Pages/Products/Index.cshtml*             |
| `www.domain.com/products/create` | *Pages/Products/Create.cshtml*    |
