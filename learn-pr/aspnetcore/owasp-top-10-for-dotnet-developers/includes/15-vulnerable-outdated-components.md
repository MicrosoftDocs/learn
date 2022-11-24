## A05 - Vulnerable and Outdated Components

Occurs when you don’t know all the versions of all the components you use and if the software is vulnerable unsupported or out of date.

Understanding the risk inherited through dependencies helps improve overall security of the codebase. Whenever possible, keep the operating system, container images, frameworks and individual project's dependencies up-to-date.
Remove unused dependencies, unnecessary features, components, files, and documentation.

> [!IMPORTANT]
> Know what your digital components and dependencies are (bill or materials) for the project.

The .NET Framework, for example, is kept up-to-date by Microsoft with the Windows Update service. Individual frameworks can be kept up to date using NuGet.
:::image type="content" source="../media/nuget-updates.png" alt-text="Visual Studio Nuget Updates":::
As Visual Studio prompts for updates, build it into your lifecycle.
With GitHub Dependabot

:::row:::
    :::column:::
        Stay up-to-date with security announcements (for example in [dotnet](https://github.com/dotnet/announcements/issues?q=is%3Aopen+is%3Aissue+label%3ASecurity) or [ASP.NET](https://github.com/aspnet/Announcements/issues?q=is%3Aopen+is%3Aissue+label%3ASecurity)) by watching the Repository on GitHub
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/dotnet-securirty-announcements.png" alt-text="dotnet security announcements on GitHub Issues":::
    :::column-end:::
:::row-end:::

> [!TIP]
> Leverage automation and CI/CD workflows, like Dependabot version updates, to keep dependencies updated.
