## Creating a new ASP.NET Core project from a template

Starting a new project can be a daunting task of setting up the initial structure and configurations. Fortunately, ASP.NET Core provides a variety of project templates that simplify this process. The project templates offer a standardized and efficient way to kickstart your development, ensuring that you quickly have all the necessary components in place. This unit explores different ASP.NET Core project templates available and how to use them to create new projects.

### The ASP.NET core Project Templates

The [.NET SDK](https://dotnet.microsoft.com/download) includes [built-in templates](/dotnet/core/tools/dotnet-new-sdk-templates) for creating ASP.NET Core projects and files.

ASP.NET Core project templates are used to create new ASP.NET Core projects with the necessary files, folders, and configurations to get a project up and running efficiently. The projects can also be customized to fit specific needs and extended with additional services like Entity Framework Core for database access, authentication, OpenAPI, caching, logging, and more, allowing developers to tailor the application to their unique requirements.

With the .NET SDK installed, you can run .NET CLI (Command Line Interface) commands in a terminal or command prompt. To list the built-in templates, run the `dotnet new list` command:

```dotnetcli
dotnet new list
```

Some common ASP.NET Core default project templates include:

`blazor`
Blazor Web App: A project template for creating a Blazor web app that supports both server-side rendering and client interactivity. This template can be used for web apps with rich dynamic user interfaces (UIs).

`web`
ASP.NET Core Empty: An empty project template for creating an ASP.NET Core application. This template doesn't have any example content in it.

`webapp`
ASP.NET Core Web App: A project template for creating an ASP.NET Core application with example ASP.NET Core Razor Pages content.

`mvc`
ASP.NET Core Web App (Model-View-Controller): A project template for creating an ASP.NET Core application with example ASP.NET Core MVC Views and Controllers.

`webapi`
ASP.NET Core Web API: A project template for creating a RESTful Web API using ASP.NET Core controllers or minimal APIs, with optional support for OpenAPI and authentication.

`grpc`
ASP.NET Core gRPC Services: A project template for creating a gRPC service using ASP.NET Core. 

### Using the .NET CLI `dotnet new` command to create a project

You create a new project using the `dotnet new <template-name>` command. For example, to create a new empty ASP.NET Core web app project you can run `dotnet new web`.

Once you create a new .NET project, you can build and run the project using the `dotnet build` and `dotnet run` commands. 

Alternatively you can create, run, and debug .NET projects with tools like Visual Studio and Visual Studio Code which provide convenient user interfaces.
