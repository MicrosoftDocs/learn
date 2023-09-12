
This type of vulnerability occurs when you don’t know all the versions of all the components you use and if the software is vulnerable, unsupported, or out of date.

Understanding the risks inherited through dependencies helps improve the overall security of the codebase. 

> [!IMPORTANT]
> Know what your digital components and dependencies are (bill or materials) for the project.

:::row:::
    :::column:::
        Whenever possible, keep the operating system, container images, frameworks, and individual project dependencies up-to-date.
        Remove unused dependencies, unnecessary features, components, files, and documentation.

        The .NET, for example, is kept up-to-date by Microsoft with the Windows Update service.

    :::column-end:::
    :::column:::
        :::image type="content" source="../media/sec updates.png" alt-text="Windows Update":::
    :::column-end:::
:::row-end:::



:::row:::
    :::column:::
        :::image type="content" source="../media/nuget-updates.png" alt-text="Visual Studio NuGet Updates":::
    :::column-end:::
    :::column:::
        Individual components and dependencies can be kept up-to-date using NuGet -package manager, enabling .NET developers to create, share, and consume .NET libraries.

Most modern integrated development environments (IDEs) streamline update processes. Visual Studio informs developers about updates available to the dependencies across the entire solution.
    :::column-end:::
:::row-end:::

### Code review notes

To prevent vulnerable and outdated components in .NET applications, you should remove any unused or unnecessary components from your application.

Plan and schedule regular updates of your product's components.

Manually monitoring sources like Common Vulnerability and Exposures (CVE) and National Vulnerability Database (NVD) for vulnerabilities in the components you use is tedious and time consuming. Apply automation and tooling, like GitHub Dependabot version updates or [Snyk](https://snyk.io/) to keep up with dependencies updated and security risks.