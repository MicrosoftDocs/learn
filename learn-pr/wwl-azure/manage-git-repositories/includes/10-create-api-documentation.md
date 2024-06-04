Documenting the API of a source code repository is essential for providing clarity, accessibility, and ease of use to developers maintaining and consuming the API. Comprehensive documentation serves as a guide for understanding the functionality, inputs, outputs, and usage of the API endpoints. When documenting the API, you should select the most suitable presentation format (such as OpenAPI specification or Markdown), including examples and usage scenarios, keep it up-to-date with code changes, and solicit feedback from API consumers to continually improve its quality.<br>While the general approach to documenting API is platform-agnostic, there are some differences in its implementation between Azure DevOps and GitHub.

## Documenting API in Azure DevOps

To add API documentation to an Azure DevOps project in the most efficient manner, you should consider utilizing a dedicated documentation tool or platform that integrates with your development workflow. Popular choices in this category include Swagger (OpenAPI), API Blueprint, and Markdown-based documentation systems like MkDocs or Docusaurus. Their Azure DevOps integration capabilities help automate the process of generation documentation, keeping it in sync with the codebase. Most documentation tools also support parsing inline comments and including them in the auto-generated documentation.

You should publish the API documentation to a central location accessible to your team members and stakeholders. This could be a dedicated documentation website, a wiki within Azure DevOps, or an external documentation portal.

Alternatively, you can use code annotations or decorators directly within your code to add metadata that describes its API endpoints. Tools like Swagger Codegen or Springfox are able to process these annotations and generate the OpenAPI specification files.

Set up automated processes within your Azure Pipelines to generate API documentation automatically whenever there's a change to the codebase. This ensures that your documentation stays up-to-date and reflects the latest changes in your APIs.

## Documenting API in Github

When using GitHub, consider generating API documentation by leveraging tools that are part of the GitHub ecosystem.

Start by documenting your API endpoints, operations, parameters, responses, and any other relevant information. Consider creating that documentation in the Markdown format to account for its broad support and ease of use. Define a consistent structure of individual documents, dividing each into sections that describe authentication, endpoints, request parameters, response examples, etc.

As with Azure DevOps, you can use documentation generators or static site generators to streamline the process of generating API documentation from Markdown files. Popular choices include Jekyll, MkDocs, Docusaurus, and Hugo. Configure the generator to parse Markdown files and generate static HTML pages. You can customize the layout, theme, and styling to match your project's branding and preferences.

To publish the HTML content, leverage GitHub Pages, which allow you to host static websites directly from your GitHub repository. You can create for this purpose a dedicated branch and push the HTML files into this branch. You can also implement GitHub Actions to automatically build and deploy your API documentation whenever there's a change to the documentation files or the codebase.

Set up GitHub Actions to automatically build and deploy your API documentation whenever there's a change to the documentation files or the codebase. Configure the automation workflow to generate the HTML documentation files using the chosen documentation generator and deploy them to GitHub Pages.
