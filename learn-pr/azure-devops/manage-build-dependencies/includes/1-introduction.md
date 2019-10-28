In this module, you'll create a build pipeline that produces a package that can be used by multiple applications.

It's likely that you've used open-source or other third-party components in your software. Using components that are popular in the community and have already been built and tested is often the fastest way to get things done.

You might also have your own application code that you can move into a library or package so that others can use it. This might be an open source project, or software that only your team can access.

There are many ways to build and host your packages. The right solution depends largely on the kinds of programming languages and frameworks you use. Here, you'll continue your work with the Tailspin web team, by creating a NuGet package for .NET that's hosted on Azure Artifacts.

In this module, you will:

- Learn ways to create and share packages that can be used by multiple applications
- Create a build pipeline for your package and publish your package to Azure Artifacts
- Connect an application to your package and build the application in Azure Pipelines
- Push up a change to your package and update your application to use it

## Prerequisites

The prerequisites are the same as the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

Make sure you have Visual Studio Code and your _Space Game_ project on GitHub handy.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps, and is helping the team adopt a more streamlined process by using Azure DevOps.