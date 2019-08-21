In this unit, you'll set up the development environment for the module, and explore *:::no-loc text="ContosoPets.UI":::* starter project.

## Set up development environment

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

```bash
. <(wget -q -O - https://aka.ms/create-razor-pages-aspnet-core-setup)
```

When the development environment has completed set up, the project *:::no-loc text="ContosoPets.UI":::* project directory opens in the [Azure Cloud Shell editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor).

You'll see the following list of *:::no-loc text="ContosoPets.UI":::* project directories and files:

* *:::no-loc text="bin":::*
* *:::no-loc text="Extensions/":::*
* *:::no-loc text="Models/":::*
* *:::no-loc text="obj/":::*
* *:::no-loc text="Pages/":::*
* *:::no-loc text="Services/":::*
* *:::no-loc text="wwwroot/":::*
* *:::no-loc text=".gitignore":::*
* *:::no-loc text="appsettings.Development.json":::*
* *:::no-loc text="appsettings.json":::*
* *:::no-loc text="ContosoPets.UI.csproj":::*
* *:::no-loc text="Program.cs":::*
* *:::no-loc text="Startup.cs":::*

In addition, a web API has been deployed to a public endpoint. The *:::no-loc text="ContosoPets.UI":::* project will provide a client front end for the web API. This endpoint will be called in a later step.

## Examine the *:::no-loc text="ContosoPets.UI":::* project files and directories

The *:::no-loc text="ContosoPets.UI":::* project directory should be currently open in the [Azure Cloud Shell editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor). If it isn't, then repeat the set-up steps in the previous unit.

Examine the following *:::no-loc text="ContosoPets.UI":::* files and directories by clicking on them in the Azure Cloud Shell window on the right:

|Name                   |Description                                                                          |
|-----------------------|-------------------------------------------------------------------------------------|
|*:::no-loc text="Pages/":::*                   |Contains Razor Pages and supporting files. Each Razor page is a pair of files:       |
|                       | * A *:::no-loc text=".cshtml":::* file that contains markup with C# code using Razor syntax.                  |
|                       | * A *:::no-loc text=".cshtml.cs":::* `PageModel` class file that defines:                                  |
|                       |   * Page handlers for requests sent to the page.                                        |
|                       |   * Data used to render the page.                                                       |
|*:::no-loc text="wwwroot/":::*               |Contains static assets, such as HTML files, JavaScript files, and CSS files.         |
|*:::no-loc text="Models/":::*                |Contains Model files. This project uses one central model file for model validation. |
|*:::no-loc text="Program.cs":::*             |Contains a *Main* method, the app's managed entry point.                             |
|*:::no-loc text="ContosoPets.UI.csproj":::*  |Contains configuration metadata for the project, such as dependencies.               |
|*:::no-loc text="Startup.cs":::*             |Configures app behavior, such as routing between pages.                              |

### Razor page files and their paired *PageModel* class file

The *:::no-loc text="Pages":::* directory is where all Razor Pages are stored and organized in your ASP.NET Core application.

A Razor page has a *:::no-loc text=".cshtml":::* file extension. By convention, its associated *:::no-loc text="PageModel":::* C# class file uses the same name but with a *:::no-loc text=".cs":::* appended. For example, the Razor page *:::no-loc text="Index.cshtml":::* has an associated *:::no-loc text="PageModel":::* class file for *:::no-loc text="Index.cshtml.cs":::*.

A model object defines data properties and encapsulates logic or operations related to those data properties. A *:::no-loc text="PageModel":::* is essentially the same thing, but is a model that more specifically encapsulates the data properties and logic operations scoped just to its Razor page. The `PageModel` class allows separation of the logic of a Razor page from its presentation. It defines page handler methods for requests sent to the page and for the data used to render the page. A handler method is the method that is executed as a result of a request. For example, an `OnGet` method in the Razor pages's `PageModel` class would be automatically executed for an HTTP GET request.

## Models and the *:::no-loc text="Models":::* directory

By convention, model class files are located in a *:::no-loc text="Models/":::* directory. As previously mentioned, a model object defines data properties and encapsulates logic or operations related to those data properties.

The *:::no-loc text="ContosoPets.UI":::* project has a model class file named *:::no-loc text="Product.cs":::* stored in the *:::no-loc text="Models/":::* directory. The `Product` model class defines the data properties for a product. All PageModels in the project that center on CRUD operations for products use this single `Product` model.

### DataAnnotations

Models in ASP.NET Core often make use of data annotations to constrain or customize model properties. Data annotations are attributes used to specify behavior that you want to enforce on the model properties to which they're applied. For example, a range of minimum and maximum acceptable values. The *:::no-loc text="ContosoPets.UI":::* project has a model class file named *:::no-loc text="Product.cs":::* that uses data annotations to define constraints for its data properties. For example, a `Name` property is always required, and a `Price` property must have a value between the range of `0.01` and `9999.99`. Since this module often refers to the `Product` model and its data properties, it's important to understand where that model class is stored.

## The *Pages/Shared/* directory

Partial markup elements that are shared across several Razor pages are located by convention in a *:::no-loc text="Pages/Shared":::* directory.

The *:::no-loc text="ContosoPets.UI":::* application uses three shared partial Razor Pages, which are included automatically when you create a new *ASP.NET Core Web Application* project:

* *:::no-loc text="_Layout.cshtml":::*: Provides common layout elements across multiple Razor Pages.
* *:::no-loc text="_CookieConsentPartial.cshtml":::*: Provides a cookie consent alert and functionality incorporated in all Razor Pages in this project.
* *:::no-loc text="_ValidationScriptsPartial.cshtml":::*: Provides validation functionality such as client-side form input validation and cross-site antiforgery validation, available to all Razor Pages in this project.

### Layouts and partial view files

* Layouts: In ASP.NET Core, layouts are *:::no-loc text=".cshtml":::* files that define a top-level template for views in the app. Apps don't require a layout. Apps can define more than one layout, with different views specifying different layouts. Most web apps have a common layout that provides a consistent user experience. The layout typically includes common UI elements such as the app header, navigation or menu elements, and footer. Common HTML structures such as scripts and stylesheets are also frequently used by many pages within an app. All of these shared elements may be defined in a layout file, which can then be referenced by any view used within the app. Layouts reduce duplicate code in views.

* Partial view: A partial view is a Razor markup file (*:::no-loc text=".cshtml":::*) that renders HTML output within another markup file's rendered output. Partial views are used to break up large markup files into smaller components. They also reduce the duplication of common markup content across markup files. Partial views are not used to maintain common layout elements. Common layout elements are specified in a *:::no-loc text="Layout.cshtml":::*

Layouts and partial views are outside of the scope of this module. At the end of the module, links are provided that will allow you to take a deeper dive on features and concepts introduced here.

## The *Pages* directory structure and routing requests

Razor Pages uses the directory structure within the *:::no-loc text="Pages":::* directory as the convention for routing requests by default. An index page located in the root of the *:::no-loc text="Pages":::* directory, for example, is the default page for the app's site. In the *:::no-loc text="ContosoPets.UI":::* *:::no-loc text="Pages/Products":::* directory, you'll find a collection of Razor pages, including an *:::no-loc text="Index.cshtml":::* page. Requests routed to *:::no-loc text="/Product/":::* will be directed to use the default *:::no-loc text="index.cshtml":::* page physically located at *:::no-loc text="/Products/Index.cshtml":::* for example. The *:::no-loc text="ContosoPets.UI":::* project has all of its Razor Pages (*:::no-loc text=".cshtml":::*) and related *:::no-loc text="PageModel":::* class files (*:::no-loc text=".cshtml.cs":::*) grouped conveniently in *:::no-loc text="/Pages/Products/":::*. Any passed route parameter values are made accessible through a property. ASP.NET Core offers robust routing features. For the scope of this project, you are using simple project directory for route mapping.

The following are routing examples for this completed project:

|  URL                              |  Maps to this Razor Page          |
|-----------------------------------|-----------------------------------|
|*:::no-loc text="www.domain.com":::*                   |*:::no-loc text="/Pages/Index.cshtml":::*               |
|*:::no-loc text="www.domain.com/index":::*              |*:::no-loc text="/Pages/Index.cshtml":::*               |
|*:::no-loc text="www.domain.com/products":::*            |*:::no-loc text="/Pages/Products/Index.cshtml":::*     |                                                  
|*:::no-loc text="www.domain.com/products/create":::*     |*:::no-loc text="/Pages/Products/Create.cshtml":::*    |

### Organize groups of related Razor pages

The *:::no-loc text="ContosoPets.UI":::* project's purpose is to provide a basic UI client to execute CRUD operations through your company's web API endpoint to manage product listings.
The *:::no-loc text="Pages/Product":::* directory groups all the Razor pages that provide the UI for those CRUD operations and their *:::no-loc text="PageModel":::* class files.
For the *:::no-loc text="ContosoPets.UI":::* application, the same model validation will be used for more than one Razor page for HTTP requests to the hosted web API.

### The HTTP request service

This *:::no-loc text="ContosoPets.UI":::* project has its `Product`-related HTTP request logic and properties encapsulated in a class. It handles all `Product`-related requests to the web API endpoint. It's made available for use throughout the scope of the application as a service. The class file for that service has been stored in a *:::no-loc text="Services/":::* directory, by convention. You'll examine this service in detail later in this module.
