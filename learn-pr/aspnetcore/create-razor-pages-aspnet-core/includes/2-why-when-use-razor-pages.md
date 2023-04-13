In this unit, you'll learn when and why to use Razor Pages for your ASP.NET Core app.

## What Razor Pages are and the benefit they provide

Razor Pages is a server-side, page-centric programming model for building web UI with ASP.NET Core. Razor Pages provide the following benefits:

* Makes it easy to get started building dynamic web apps when all you need is to define UI logic using a combination of HTML, CSS, and C#.
* Encourages organization of files by feature, which eases maintenance of your app.
* Can be broadly described as an HTML file in which you work with markup as you're used to. You also have the advantage of adding server-side C# code by using Razor syntax.

Razor Pages use a markup language called *[Razor](/aspnet/core/mvc/views/razor)* for embedding server-based code into webpages. Razor syntax is a combination of HTML and [C#](https://dotnet.microsoft.com/languages/csharp) where the C# code defines the dynamic rendering logic for the page. In a webpage that uses the Razor syntax, there can be two kinds of content: client content and server code:

* Client content: Contains what you're used to in webpages. For example, HTML markup (elements), style information such as CSS, maybe some client script such as JavaScript, and plain text.
* Server code: Razor enables you to add server code to your client content. If there's server code in the page, the server runs that code first, before it sends the page to the browser. Pages with server code can perform more complex tasks than using client content alone. For example, securely accessing databases. Most importantly, server code can dynamically create client content&mdash;it can generate HTML markup or other content and send it to the browser along with any static HTML that the page might contain. From the browser's perspective, client content generated on the server is no different than any other client content.

### Separation of concerns in the `PageModel`

Razor Pages enforces separation of concerns for page-related data properties and logic operations in a C# `PageModel` class. A model object typically defines data properties and encapsulates any logic or operations related to those data properties. More specifically, a `PageModel`:

* Encapsulates the data properties and logic operations scoped just to its Razor page.
* Defines page handlers for HTTP requests sent to the page and for the data used to render the page.

## When to use Razor Pages

Use Razor Pages in your ASP.NET Core app when you:

* Want to generate dynamic web UI from your ASP.NET Core app.
* Prefer a page-focused approach to developing web apps, where the page markup and `PageModel` are in close proximity.
* Want your page-focused ASP.NET Core app to use partial views&mdash;mechanisms for reducing duplication of common markup across the site.

Razor Pages allow you to keep your ASP.NET Core pages organized in a simpler way:

* All view (page) specific logic and page properties defined in the Razor page's (`PageModel`) can be kept together in their own namespace and directory.
* Groups of related pages can be kept in their own namespace and directory.

> [!NOTE]
>ASP.NET Core also supports the [MVC pattern](/aspnet/core/mvc/overview) for building web apps. The *Model* defines the fundamental behaviors and data for the app and its components. The *View* uses HTML and Razor syntax to provide the UI. The *Controller* is a class that receives HTTP requests and handles user actions.
>
>Use ASP.NET Core MVC when you prefer to build web apps with a clear separation between the Model, View, and Controller.
>
>Razor Pages is built on the same infrastructure as ASP.NET Core MVC. Both Razor Pages and MVC can be used within the same ASP.NET Core app. ASP.NET Core MVC is outside of the scope for this module.
