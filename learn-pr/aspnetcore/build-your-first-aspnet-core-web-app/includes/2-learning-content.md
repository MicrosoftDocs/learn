Starting a new project, including setting up the initial structure and configurations, can be a daunting task. Fortunately, ASP.NET Core provides various project templates that simplify this process. The project templates offer a standardized and efficient way to kickstart your development. This unit explores the different ASP.NET Core project templates available and how to use them to create new projects.

## What the ASP.NET Core project templates provide

The [.NET SDK](https://dotnet.microsoft.com/download) includes [built-in templates](/dotnet/core/tools/dotnet-new-sdk-templates) for creating ASP.NET Core projects and files. ASP.NET Core project templates are used to create new ASP.NET Core projects with the necessary files, folders, and configurations to get a project up and running efficiently. 

With the .NET SDK installed, you can run .NET CLI (Command Line Interface) commands in a terminal or command prompt. To list the built-in templates, run the `dotnet new list` command:

```dotnetcli
dotnet new list
```

Some common ASP.NET Core default project templates include:

`web`
ASP.NET Core Empty: An empty project template for creating an ASP.NET Core application. This template doesn't have any example content in it.

`blazor`
Blazor Web App: A project template for creating a Blazor web app that supports both server-side rendering and client interactivity. This template can be used for web apps with rich dynamic user interfaces (UIs).

`webapi`
ASP.NET Core Web API: A project template for creating a RESTful Web API using ASP.NET Core controllers or minimal APIs, with optional support for OpenAPI and authentication.

`grpc`
ASP.NET Core gRPC Services: A project template for creating a gRPC service using ASP.NET Core. 

## Customization options

All .NET project templates offer customization options to tailor the generated project to specific needs and extend it with additional services. For instance, you can add Entity Framework Core for database access, authentication, OpenAPI, caching, logging, and more, enabling the application to effectively meet specific requirements.

To view all customization options for a specific template, use the following `dotnet new` command with the `--help` option, replacing `<template-name>` with the name of the template you want to explore:

```dotnetcli
dotnet new <template-name> --help
```

## Using the .NET CLI `dotnet new` command to create a project

You can create a new project using the `dotnet new <template-name>` command. For example, to create a new empty ASP.NET Core web app project you can run `dotnet new web`.

Once you create a new .NET project, you can build and run the project using the `dotnet build` and `dotnet run` commands. 

Alternatively you can create, run, and debug .NET projects with tools like Visual Studio and Visual Studio Code which provide convenient user interfaces.
