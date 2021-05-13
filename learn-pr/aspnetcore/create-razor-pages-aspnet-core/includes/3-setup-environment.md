In this unit, you'll set up the development environment for the module and explore the starter project.

## Set up development environment

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

```bash
. <(wget -q -O - https://aka.ms/create-razor-pages-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command:

* Installs a specific version of the .NET Core SDK in the Cloud Shell environment.
* Clones the ASP.NET Core starter code from a GitHub repository.
* Provisions an Azure App Service instance and deploys the web API to it.
* Provisions a separate App Service instance for the Razor Pages app.
* Displays the URL for the web API hosted in App Service.
* Sets environment variables that are required for this module.
* Launches the [Azure Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor) to view the starter code.

The starter code cloned by the setup script consists of two projects. One project is an ASP.NET Core web API that vends product data. The other project is an ASP.NET Core Razor Pages project named *:::no-loc text="ContosoPets.Ui":::*. The Razor Pages project will serve as a web UI for interacting with the web API. This web API will be consumed in a later step.

## Examine the project

The *:::no-loc text="ContosoPets.Ui":::* project directory is currently open in the Cloud Shell editor. The following table outlines noteworthy project files and directories. Examine each of them in the Cloud Shell editor window.

| Name                                        | Description                                                                                                                     |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| *:::no-loc text="Pages/":::*                | Contains Razor Pages and supporting files. Each Razor page is a pair of files:<br>* A *:::no-loc text=".cshtml":::* file that contains markup with C# code using Razor syntax.<br>* A *:::no-loc text=".cshtml.cs":::* `PageModel` class file that defines page handler methods and data used to render the page.                                      |
| *:::no-loc text="wwwroot/":::*              | Contains static asset files, such as HTML, JavaScript, and CSS.                                                                 |
| *:::no-loc text="Models/":::*               | Contains Model files. This project uses one central model file for model validation.                                            |
| *:::no-loc text="ContosoPets.Ui.csproj":::* | Contains configuration metadata for the project, such as dependencies.                                                          |
| *:::no-loc text="Program.cs":::*            | Serves as the app's managed entry point.                                                                                        |
| *:::no-loc text="Startup.cs":::*            | Configures app behavior, such as routing between pages.                                                                         |

### Razor page files and their paired `PageModel` class file

By convention, the *:::no-loc text="Pages":::* directory is where all Razor Pages are stored and organized in an ASP.NET Core app.

A Razor page has a *:::no-loc text=".cshtml":::* file extension. By convention, its associated `PageModel` C# class file uses the same name but with a *:::no-loc text=".cs":::* appended. For example, the Razor page *:::no-loc text="Index.cshtml":::* has an associated `PageModel` class file for *:::no-loc text="Index.cshtml.cs":::*.

A model object defines data properties and encapsulates logic or operations related to those data properties. A `PageModel` is essentially the same thing, but is a model that more specifically encapsulates the data properties and logic operations scoped just to its Razor page. The `PageModel` class:

* Allows for separation of the logic of a Razor page from its presentation.
* Defines page handlers for requests sent to the page and for the data used to render the page.

A *page handler* is the method that's executed as a result of an HTTP request. For example, an `OnGet` method in the Razor page's `PageModel` class is automatically executed for an HTTP GET request.

## Models and the *:::no-loc text="Models":::* directory

By convention, model files are located in a *:::no-loc text="Models":::* directory. As previously mentioned, a model object defines data properties and encapsulates logic or operations related to those data properties.

The project has a `Product` model in *:::no-loc text="Models/Product.cs":::*. The `Product` model is implemented as a C# class that defines the data properties for a product. Each `PageModel` that focuses on CRUD operations for products uses this `Product` model.

### Data annotations

Models in ASP.NET Core often make use of data annotations to constrain or customize model properties. Data annotations are C# attributes used to specify behaviors to enforce on the model properties to which they're applied. For example, a range of minimum and maximum acceptable values. The project has a model file named *:::no-loc text="Product.cs":::* that uses data annotations to define constraints for its data properties. For example, a `Name` property is always required, and a `Price` property must have a value between the range of `0.01` and `9999.99`. Since this module often refers to the `Product` model and its data properties, it's important to understand where that model's class is stored.

## The *Pages/Shared* directory

Partial markup elements that are shared across several Razor pages are located by convention in a *:::no-loc text="Pages/Shared":::* directory. The *:::no-loc text="ContosoPets.Ui":::* app uses two shared partial views, which are included when you create a new **ASP.NET Core Web Application** project:

* *:::no-loc text="_Layout.cshtml":::*: Provides common layout elements across multiple pages.
* *:::no-loc text="_ValidationScriptsPartial.cshtml":::*: Provides validation functionality such as client-side form input validation and cross-site antiforgery validation. This partial view is available to all pages in the project.

### Layouts and partial view files

* Layouts: In ASP.NET Core, layouts are *:::no-loc text=".cshtml":::* files that define a top-level template for views in the app. Apps don't require a layout. Apps can define more than one layout, with different views specifying different layouts. Most web apps have a common layout that provides a consistent user experience. The layout typically includes common UI elements such as the app header, navigation or menu elements, and footer. Common HTML structures such as scripts and stylesheets are also frequently used by many pages within an app. All of these shared elements may be defined in a layout file, which can then be referenced by any view used within the app. Layouts reduce duplicate code in views.

* Partial view: A partial view is a Razor markup file (*:::no-loc text=".cshtml":::*) that renders HTML output within another markup file's rendered output. Partial views are used to break up large markup files into smaller components. They also reduce the duplication of common markup content across markup files. Partial views aren't used to maintain common layout elements. Common layout elements are specified in a *:::no-loc text="_Layout.cshtml":::* file.

Layouts and partial views are outside of the scope of this module. At the end of the module, links are provided to take a deeper dive on features and concepts introduced here.

## The *Pages* directory structure and routing requests

Razor Pages uses the directory structure within the *:::no-loc text="Pages":::* directory as the convention for routing requests by default. An index page located in the root of the *:::no-loc text="Pages":::* directory, for example, is the default page for the app's site. In the *:::no-loc text="ContosoPets.Ui":::* project's *:::no-loc text="Pages/Products":::* directory, you'll find a collection of Razor pages, including an *:::no-loc text="Index.cshtml":::* page. Requests routed to *:::no-loc text="/Product/":::* will be directed to use the default *:::no-loc text="Index.cshtml":::* page physically located at *:::no-loc text="Products/Index.cshtml":::*, for example. The project's Razor pages (*:::no-loc text=".cshtml":::*) and accompanying `PageModel` classes (*:::no-loc text=".cshtml.cs":::*) are grouped conveniently in *:::no-loc text="Pages/Products":::*. Any passed route parameter values are made accessible through a property. ASP.NET Core offers robust routing features.

The following table provides routes to be used in this module's completed project.

| URL                                                  | Maps to this Razor page                            |
|------------------------------------------------------|----------------------------------------------------|
| *:::no-loc text="www.domain.com":::*                 | *:::no-loc text="Pages/Index.cshtml":::*           |
| *:::no-loc text="www.domain.com/index":::*           | *:::no-loc text="Pages/Index.cshtml":::*           |
| *:::no-loc text="www.domain.com/products":::*        | *:::no-loc text="Pages/Products/Index.cshtml":::*  |
| *:::no-loc text="www.domain.com/products/create":::* | *:::no-loc text="Pages/Products/Create.cshtml":::* |

### Organize groups of related Razor pages

The *:::no-loc text="ContosoPets.Ui":::* project's purpose is to provide a UI to execute CRUD operations through your company's web API endpoint to manage product listings. The *:::no-loc text="Pages/Products":::* directory groups all the Razor pages that provide the UI for those CRUD operations and their `PageModel` class files. For the *:::no-loc text="ContosoPets.Ui":::* app, the same model validation will be used for more than one Razor page for HTTP requests to the hosted web API.

### The HTTP request service

This *:::no-loc text="ContosoPets.Ui":::* project has its `Product`-related HTTP request logic and properties encapsulated in a class. It handles all `Product`-related requests to the web API endpoint. It's made available for use throughout the scope of the app as a service. That service's class file has been stored in a *:::no-loc text="Services":::* directory, by convention. You'll examine this service in detail later in this module.
