<!-- ## A06: Vulnerable and Outdated Components -->

Occurs when you don’t know all the versions of all the components you use and if the software is vulnerable unsupported or out of date.

Understanding the risk inherited through dependencies helps improve overall security of the codebase. Whenever possible, keep the operating system, container images, frameworks and individual project's dependencies up-to-date.
Remove unused dependencies, unnecessary features, components, files, and documentation.

> [!IMPORTANT]
> Know what your digital components and dependencies are (bill or materials) for the project.

The .NET, for example, is kept up-to-date by Microsoft with the Windows Update service. Individual components and dependencies can be kept up to date using NuGet.

:::image type="content" source="../media/nuget-updates.png" alt-text="Visual Studio Nuget Updates":::

Cater for, with plan and schedule, regular updates of your product's components. As you develop your app you might already have a habit of checking Visual Studio prompts for updates.

:::row:::
    :::column:::
        Stay up-to-date with security announcements (for example in [dotnet](https://github.com/dotnet/announcements/issues?q=is%3Aopen+is%3Aissue+label%3ASecurity) or [ASP.NET](https://github.com/aspnet/Announcements/issues?q=is%3Aopen+is%3Aissue+label%3ASecurity)) by watching the Repository on GitHub
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/dotnet-securirty-announcements.png" alt-text="dotnet security announcements on GitHub Issues":::
    :::column-end:::
:::row-end:::


### Code Review Notes

To prevent vulnerable and outdated components in .NET applications, you should remove any unused or unnecessary components from your application.

Manually monitoring sources like Common Vulnerability and Exposures (CVE) and National Vulnerability Database (NVD) for vulnerabilities in the components you use is is tedious and time consuming, hence you looking to apply automation, or like GitHub Dependabot version updates or [Snyk](https://snyk.io/) to keep up with dependencies updated and security risks.
