In this module, you'll scan open-source components for security vulnerabilities and assess their license ratings.

It's important to have an inventory of the open-source components that your project uses. It's important to understand which libraries have vulnerability issues, when those vulnerabilities were addressed, and what versions you can use. Based on this information, you might even choose to use a different library or write your own.

You also need to understand what licenses these libraries use. Some licenses require you to make public any code that uses that library if you've made changes to the library's code. This requirement is problematic when your source code is not open source as well. You'll need to check with your own legal team to determine which licenses you can use.

In [Scan code for vulnerabilities in your build pipeline](/learn/modules/scan-for-vulnerabilities?azure-portal=true), you used SonarCloud to scan for potential vulnerabilities in your source code during the build process.

In this module, you'll perform a similar process. Here you'll use WhiteSource Bolt, by WhiteSource, to scan open-source components for known vulnerabilities and license ratings.

In this module, you will:

* Learn which tools you can use to inspect open-source software packages for security and license ratings
* Access package and license ratings for open-source components by using WhiteSource Bolt
* Analyze the results of the scan so you can take the appropriate action

## Prerequisites

The prerequisites are the same as the prerequisites for the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline?azure-portal=true) module.

Make sure you have the _Space Game_ project loaded in Visual Studio Code and your _Space Game_ project handy on GitHub.

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps and is helping the team adopt a more automated process by using Azure DevOps.