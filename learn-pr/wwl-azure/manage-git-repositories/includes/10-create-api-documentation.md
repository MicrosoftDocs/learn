Creating API documentation for your source code repository is very important. Good documentation helps developers understand, maintain, and use your API easily. Complete documentation explains how the API works, what inputs it needs, what outputs it gives, and how to use the API endpoints. When creating API documentation, you should choose the best format (like OpenAPI specification or Markdown), include examples and usage scenarios, keep it updated when code changes, and ask API users for feedback to make it better. While the general approach to API documentation works everywhere, there are some differences between Azure DevOps and GitHub.

## Creating API documentation in Azure DevOps

To add API documentation to an Azure DevOps project efficiently, you should use a dedicated documentation tool that works with your development workflow. Popular choices include Swagger (OpenAPI), API Blueprint, and Markdown-based documentation systems like MkDocs or Docusaurus. Their Azure DevOps integration helps automate documentation creation and keeps it synchronized with your code. Most documentation tools can also read inline comments and include them in automatically generated documentation.

You should publish the API documentation to a central location that your team members and stakeholders can access. This could be a dedicated documentation website, a wiki within Azure DevOps, or an external documentation portal.

You can also use code annotations or decorators directly in your code to add metadata that describes your API endpoints. Tools like Swagger Codegen or Springfox can process these annotations and create OpenAPI specification files.

Set up automated processes within your Azure Pipelines to create API documentation automatically whenever there's a change to the code. This ensures that your documentation stays current and reflects the latest changes in your APIs.

## Creating API documentation in GitHub

When using GitHub, consider creating API documentation by using tools that are part of the GitHub ecosystem.

Start by documenting your API endpoints, operations, parameters, responses, and any other relevant information. Consider creating that documentation in Markdown format because it's widely supported and easy to use. Define a consistent structure for individual documents, dividing each into sections that describe authentication, endpoints, request parameters, response examples, etc.

As with Azure DevOps, you can use documentation generators or static site generators to make the process of creating API documentation from Markdown files easier. Popular choices include Jekyll, MkDocs, Docusaurus, and Hugo. Set up the generator to read Markdown files and create static HTML pages. You can customize the layout, theme, and styling to match your project's branding and preferences.

To publish the HTML content, use GitHub Pages, which let you host static websites directly from your GitHub repository. You can create a dedicated branch for this purpose and push the HTML files into this branch. You can also use GitHub Actions to automatically build and deploy your API documentation whenever there's a change to the documentation files or the code.

Set up GitHub Actions to automatically build and deploy your API documentation whenever there's a change to the documentation files or the code. Configure the automation workflow to create the HTML documentation files using your chosen documentation generator and deploy them to GitHub Pages.
