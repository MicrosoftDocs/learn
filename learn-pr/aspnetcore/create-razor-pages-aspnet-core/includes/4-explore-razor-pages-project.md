In this unit, you'll tour the running app to understand the UI experience it provides.

## Examine the project

The *RazorPagesPizza* project directory is currently open in the Visual Studio Code editor. The following table outlines noteworthy project files and directories. Examine each of them in the Visual Studio Code editor window.

| Name                                        | Description                                                                                                                     |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| *Pages/*                | Contains Razor Pages and supporting files. Each Razor page is a pair of files:<br>* A *.cshtml* file that contains markup with C# code using Razor syntax.<br>* A *.cshtml.cs* `PageModel` class file that defines page handler methods and data used to render the page.                                      |
| *wwwroot/*              | Contains static asset files, such as HTML, JavaScript, and CSS.
| *RazorPagesPizza.csproj* | Contains configuration metadata for the project, such as dependencies.                                                          |
| *Program.cs*            | Serves as the app's managed entry point and configures app behavior, such as routing between pages.                                                                         |

### Razor page files and their paired `PageModel` class file

By convention, the *Pages* directory is where all Razor Pages are stored and organized in an ASP.NET Core app.

A Razor page has a *.cshtml* file extension. By convention, its associated `PageModel` C# class file uses the same name but with a *.cs* appended. For example, the Razor page *Index.cshtml* has an associated `PageModel` class file for *Index.cshtml.cs*.

A model object defines data properties and encapsulates logic or operations related to those data properties. A `PageModel` is essentially the same thing, but is a model that more specifically encapsulates the data properties and logic operations scoped just to its Razor page. The `PageModel` class:

* Allows for separation of the logic of a Razor page from its presentation.
* Defines page handlers for requests sent to the page and for the data used to render the page.

A *page handler* is the method that's executed as a result of an HTTP request. For example, an `OnGet` method in the Razor page's `PageModel` class is automatically executed for an HTTP GET request.

## The *Pages/Shared* directory

Partial markup elements that are shared across several Razor pages are located by convention in a *Pages/Shared* directory. The *RazorPagesPizza* app uses two shared partial views, which are included when you create a new **ASP.NET Core Web Application** project:

* *_Layout.cshtml*: Provides common layout elements across multiple pages.
* *_ValidationScriptsPartial.cshtml*: Provides validation functionality such as client-side form input validation and cross-site antiforgery validation. This partial view is available to all pages in the project.

### Layouts and partial view files

* Layouts: In ASP.NET Core, layouts are *.cshtml* files that define a top-level template for views in the app. Apps don't require a layout. Apps can define more than one layout, with different views specifying different layouts. Most web apps have a common layout that provides a consistent user experience. The layout typically includes common UI elements such as the app header, navigation or menu elements, and footer. Common HTML structures such as scripts and stylesheets are also frequently used by many pages within an app. All of these shared elements may be defined in a layout file, which can then be referenced by any view used within the app. Layouts reduce duplicate code in views.

* Partial view: A partial view is a Razor markup file (*.cshtml*) that renders HTML output within another markup file's rendered output. Partial views are used to break up large markup files into smaller components. They also reduce the duplication of common markup content across markup files. Partial views aren't used to maintain common layout elements. Common layout elements are specified in a *_Layout.cshtml* file.

Layouts and partial views are outside of the scope of this module. At the end of the module, links are provided to take a deeper dive on features and concepts introduced here.

## The *Pages* directory structure and routing requests

Razor Pages uses the directory structure within the *Pages* directory as the convention for routing requests by default. An index page located in the root of the *Pages* directory, for example, is the default page for the app's site. In the *RazorPagesPizza* project's *Pages/Products* directory, you'll find a collection of Razor pages, including an *Index.cshtml* page. Requests routed to */Product/* will be directed to use the default *Index.cshtml* page physically located at *Products/Index.cshtml*, for example. The project's Razor pages (*.cshtml*) and accompanying `PageModel` classes (*.cshtml.cs*) are grouped conveniently in *Pages/Products*. Any passed route parameter values are made accessible through a property. ASP.NET Core offers robust routing features.

The following table provides routes to be used in this module's completed project.

| URL                                                  | Maps to this Razor page                            |
|------------------------------------------------------|----------------------------------------------------|
| `www.domain.com`                 | *Pages/Index.cshtml*           |
| `www.domain.com/index`           | *Pages/Index.cshtml*           |
| `www.domain.com/products`        | *Pages/Products/Index.cshtml*  |
| `www.domain.com/products/create` | *Pages/Products/Create.cshtml* |
