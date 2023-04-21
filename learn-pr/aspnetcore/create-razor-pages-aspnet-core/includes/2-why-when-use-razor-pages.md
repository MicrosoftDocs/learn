In this unit, you'll learn when and why to use Razor Pages for your ASP.NET Core app.

## What Razor Pages are and the benefits they provide

Razor Pages is a server-side, page-centric programming model for building web UI with ASP.NET Core. Benefits include:

* Easy setup for dynamic web apps using HTML, CSS, and C#.
* Organized files by feature for easier maintenance.
* Combines markup with server-side C# code using Razor syntax.

Razor Pages utilize *[Razor](/aspnet/core/mvc/views/razor)* for embedding server-based code into webpages. Razor syntax combines HTML and [C#](https://dotnet.microsoft.com/languages/csharp) to define the dynamic rendering logic.

### Separation of concerns in the `PageModel`

Razor Pages enforces separation of concerns with a C# `PageModel` class, encapsulating data properties and logic operations scoped to its Razor page, and defining page handlers for HTTP requests.

## When to use Razor Pages

Use Razor Pages in your ASP.NET Core app when you:

* Want to generate dynamic web UI.
* Prefer a page-focused approach.
* Want to reduce duplication with partial views.

Razor Pages simplifies ASP.NET Core page organization by keeping related pages and their logic together in their own namespace and directory.

> [!NOTE]
>ASP.NET Core also supports the [MVC pattern](/aspnet/core/mvc/overview) for building web apps. Use MVC when you prefer a clear separation between Model, View, and Controller. Both Razor Pages and MVC can coexist within the same app. MVC is outside the scope of this module.
