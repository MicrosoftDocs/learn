Many tools can help you find and fix technical debt in your code. Here are some popular options that work well with Azure DevOps.

## NDepend for .NET projects

NDepend is a powerful tool for .NET developers that helps you:

- **Track debt in real-time** - See how much technical debt you've added in the last hour
- **Fix issues early** - Catch problems before you commit code
- **Create custom rules** - Write your own quality checks using C# LINQ queries
- **Use built-in rules** - Get started quickly with pre-made rules that detect common code smells

NDepend works as a Visual Studio extension, making it easy to use during development. This helps you maintain code quality throughout your development process.

## ReSharper Code Quality Analysis

ReSharper provides automated code quality checks that can:

- **Run from command line** - Integrate easily into build pipelines
- **Fail builds automatically** - Stop poor code from reaching production
- **Enforce team standards** - Configure rules that everyone follows
- **Provide consistent feedback** - Give the same quality checks across your team

This tool helps ensure your entire team follows the same quality standards.

## Find tools in Azure DevOps Marketplace

To discover more code quality tools for your pipeline:

1. Go to your build pipeline in Azure DevOps
2. Add a new task
3. Search for "Quality" in the marketplace
4. Browse available tools and extensions

:::image type="content" source="../media/marketplace-page-term-quality-70755847.png" alt-text="Screenshot of the Marketplace page with a search on the term quality. The results include NDepend and Resharper.":::

### Choose the right tool for your project

Consider these factors when selecting a code quality tool:

- **Programming language** - Make sure the tool supports your tech stack
- **Team size** - Some tools work better for larger or smaller teams
- **Integration needs** - Check how well it works with your existing pipeline
- **Budget** - Consider both tool costs and setup time

### Next steps

Want to learn more? Check out these resources:

- [NDepend documentation](https://www.ndepend.com)
- Visual Studio marketplace for more tools
- ReSharper Code Quality Analysis guides
