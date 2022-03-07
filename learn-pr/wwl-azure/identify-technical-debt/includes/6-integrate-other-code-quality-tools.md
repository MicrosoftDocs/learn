Many tools can be used to assess aspects of your code quality and technical debt.

## NDepend

For .NET developers, a common tool is NDepend.

NDepend is a Visual Studio extension that assesses the amount of technical debt a developer has added during a recent development period, typically in the last hour.

With this information, the developer might make the required corrections before ever committing the code.

NDepend lets you create code rules expressed as C\# LINQ queries, but it has many built-in rules that detect a wide range of code smells.

## Resharper Code Quality Analysis

Resharper can make a code quality analysis from the command line. Also, be set to fail builds when code quality issues are found automatically.

Rules can be configured for enforcement across teams.

## Search in Azure DevOps

To find other code quality tools that are easy to integrate with Azure DevOps, search for the word **Quality** when adding a task into your build pipeline.

:::image type="content" source="../media/marketplace-page-term-quality-70755847.png" alt-text="Screenshot of the Marketplace page with a search on the term quality. The results include NDepend and Resharper.":::


For more information, you can see:

 -  [NDepend](https://www.ndepend.com)
 -  Visual Studio marketplace
 -  Resharper Code Quality Analysis
