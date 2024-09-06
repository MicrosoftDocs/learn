In this module, you'll create a build pipeline that produces a package that multiple apps can use.

It's likely that you've used open-source or other third-party components in your software. Using components that are popular in the community and have already been built and tested is often the fastest way to get things done.

You might also have your own app code that you can move into a library or package so that others can use it. This might be an open-source project, or software that only your team can access.

There are many ways to build and host your packages. The right solution depends both on the kinds of programming languages and frameworks you use and who you want to access your packages. Here, you'll continue your work with the Tailspin web team by creating a NuGet package for .NET that's hosted on Azure Artifacts.

After completing this module, you'll be able to:

- Create and share packages that multiple applications can use.
- Create a build pipeline for your package and publish your package to Azure Artifacts.
- Connect an application to your package and build the application in Azure Pipelines.
- Push changes to your package and update your application to use them.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path.

We also recommend you start at the beginning of this learning path, [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

[!include[](../../shared/includes/prerequisites.md)]

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