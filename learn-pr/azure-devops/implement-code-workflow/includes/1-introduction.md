In [Create a build pipeline with Azure Pipelines](/training/modules/create-a-build-pipeline?azure-portal=true), you created a basic but complete build configuration for an ASP.NET Core web application.

In this module, you'll extend this build configuration by implementing a code-collaboration strategy that uses Git and GitHub.

Collaboration is a key DevOps value. Developers need a way to work with source code and share their code revisions with others. A source-control system facilitates cooperation among developers and more frequent deployments to improve the product.

Azure DevOps works with different kinds of source control, but many Azure DevOps organizations choose to use Git. Git is a distributed system in which all contributors have their own copy of the work. In this module, you'll use the branching and merging capabilities of Git to more efficiently work with other developers. You'll also use GitHub, a central location for teams to host their projects and share their work.

## Learning objectives

After completing this module, you'll be able to:

- Collaborate with others by choosing an appropriate branching and merging strategy.
- Add a badge to your GitHub repository to show the status of the latest build.
- Add a dashboard widget to help visualize your build history.
- Set up a rule on your GitHub repository to require a review.

## Prerequisites

The modules in this learning path form a progression. Information in one module is the basis for further learning in the next module.

To follow the progression from the beginning, first complete the [Get started with Azure DevOps](../../../paths/evolve-your-devops-practices/index.yml?azure-portal=true) learning path.

We also recommend you start at the beginning of this learning path, [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true).

If you want to complete only this module, you need to set up a development environment on your Windows, macOS, or Linux system. You'll need these prerequisites:

- An [Azure DevOps organization](https://dev.azure.com?azure-portal=true)
- A [GitHub](https://github.com/join?azure-portal=true) account
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet/6.0?azure-portal=true)
- [Git](https://git-scm.com/downloads?azure-portal=true)

You can get started with Azure DevOps for free.

This environment lets you complete the exercises in this and future modules. You can also use it to apply your new skills to your own projects.

[!include[](../../shared/includes/project-details-note.md)]

## Meet the team

In earlier modules, you met the _Space Game_ web team at Tailspin Toys. The _Space Game_ web team is here again to work with you in this module:

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

[!include[](../../shared/includes/meet-padding-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more streamlined process that uses Azure DevOps.
