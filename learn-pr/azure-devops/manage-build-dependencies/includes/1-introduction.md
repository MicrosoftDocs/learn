In this module, you'll create a build pipeline that produces a package that can be used by multiple apps.

It's likely that you've used open source or other third-party components in your software. Using components that are popular in the community and have already been built and tested is often the fastest way to get things done.

You might also have your own app code that you can move into a library or package so that others can use it. This might be an open source project, or software that only your team can access.

There are many ways to build and host your packages. The right solution depends largely on the kinds of programming languages and frameworks you use. Here, you'll continue your work with the Tailspin web team, by creating a NuGet package for .NET that's hosted on Azure Artifacts.

In this module, you will:

- Learn ways to create and share packages that can be used by multiple apps.
- Create a build pipeline for your package, and publish your package to Azure Artifacts.
- Connect an app to your package, and build the app in Azure Pipelines.
- Push up a change to your package, and update your app to use it.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path.

We also recommend you start at the beginning of this learning path, [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 3.1 SDK](https://dotnet.microsoft.com/download/dotnet-core/3.1?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure DevOps for free.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps, and is helping the team adopt a more streamlined process by using Azure DevOps.