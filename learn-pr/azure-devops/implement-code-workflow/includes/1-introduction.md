In [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true), you created a basic but complete build configuration for an ASP.NET Core web application.

In this module, you extend this build configuration by implementing a code collaboration strategy that uses Git and GitHub.

Elite performers deploy code more frequently and experience much faster lead times than other performers. To become elite performers, developers need a way to work with source code and share their changes with others. Collaboration is a key DevOps value, and a source control system that fosters cooperation is a great DevOps tool.

Although Azure DevOps works with various kinds of source control, many developers choose Git because it's a distributed system that enables all contributors to have their own copy of the work. In this module, you use Git's branching and merging capabilities to more efficiently work with other developers. You also use GitHub, because it provides a central location for teams to host their projects and share their work.

## Learning objectives

In this module, you:

* Collaborate with others by choosing an appropriate branching and merging strategy.
* Add a badge to your GitHub repository to show the status of the latest build.
* Add a dashboard widget to visualize your build history.
* Set up a rule on your GitHub repository to require a reviewer.

## Prerequisites

The modules in this learning path form a progression.

To follow the progression from the beginning, be sure to first complete the [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true) learning path.

We also recommend you start at the beginning of this learning path, [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true).

If you want to go through just this module, you need to set up a development environment on your Windows, macOS, or Linux system. You need:

* An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
* A [GitHub](https://github.com/join?azure-portal=true) account
* [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
* [.NET Core 3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1?azure-portal=true)
* [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Microsoft Azure DevOps for free.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

[!include[](../../shared/includes/meet-padding-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process that uses Azure DevOps.
