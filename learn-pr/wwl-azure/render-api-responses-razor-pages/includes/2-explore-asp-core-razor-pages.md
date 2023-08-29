Razor Pages is a server-side, page-centric programming model for building web UI with ASP.NET Core. Benefits include:

*   Easy setup for dynamic web apps using HTML, CSS, and C#.
*   Organized files by feature for easier maintenance.
*   Combines markup with server-side C# code using Razor syntax.

Razor syntax combines HTML and C# to define the dynamic rendering logic. You can use C# variables and methods within your HTML markup to generate dynamic web content on the server at runtime. Razor Pages aren't a replacement for HTML, CSS, or JavaScript. They're a way to combine these technologies to create dynamic web content.

## Razor Pages project structure

The following table describes the project structure that is generated when creating a new Razor Pages project, such as running `dotnet new webapp` command.

| Name | Description |
| --- | --- |
| *Pages/* | Contains Razor Pages and supporting files. |
| *wwwroot/* | Contains static asset files like images, HTML, JavaScript, and CSS. |
| *<project_name>.csproj* | Contains project configuration metadata, such as dependencies. |
| *Program.cs* | Serves as the app's entry point and configures app behavior. |

Following is more information on the project structure, request routing, and shared resources:

*   **Razor page files and their paired `PageModel` class file:** Razor pages are stored in the *Pages* directory. Each Razor page has a *.cshtml* file and a *.cshtml.cs* `PageModel` class file. The `PageModel` class allows separation of a Razor page's logic and presentation, defines page handlers for requests, and encapsulates data properties and logic scoped to its Razor page.

*   **The *Pages* directory structure:** Razor Pages uses the *Pages* directory structure as the convention for routing requests. The following table shows how URLs map to filenames:

    | URL | Maps to Razor page |
    | --- | --- |
    | `www.example.com` | *Pages/Index.cshtml* |
    | `www.example.com/Index` | *Pages/Index.cshtml* |
    | `www.example.com/Privacy` | *Pages/Privacy.cshtml* |
    | `www.example.com/Error` | *Pages/Error.cshtml* |

* **Layout and other shared files:** There are several files that are shared across multiple pages. These files determine common layout elements and page imports. The following table describes the purpose of each file.

    | File | Description |
    | --- | --- |
    | *_ViewImports.cshtml* | Imports namespaces and classes that are used across multiple pages. |
    | *_ViewStart.cshtml* | Specifies the default layout for all Razor pages. |
    | *Pages/Shared/_Layout.cshtml* | The layout specified by the *_ViewStart.cshtml* file. Implements common layout elements across multiple pages. |
    | *Pages/Shared/_ValidationScriptsPartial.cshtml* | Provides validation functionality to all pages. |

