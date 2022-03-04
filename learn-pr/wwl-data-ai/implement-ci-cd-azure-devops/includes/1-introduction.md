Imagine you are part of a team of data engineers who are collaborating on one or more notebooks within a development environment, using Azure Databricks. When you are ready to deploy your changes to production, you must coordinate with an operations team to copy the notebooks over to a production Azure Databricks workspace since company policy dictates that you and your team are not allowed to manually copy the changed files over. This process causes bottlenecks and extra work. Leadership has asked you to find an automated process that incorporates version control, automated testing capabilities, and controls for deployment approvals if needed.

Automated testing and deployment is a common practice in software development. However, those same principles also apply to data engineering and data science. Data engineers and data scientists need to collaborate on parts of the system and be able to deploy to production without constantly relying on operations.

So how do you do that? What are the options for presenting your advanced and complex analytics results in a way that's easy to interpret by someone from a marketing or sales department?

In this module, we'll discover tools and processes you can use to implement CI/CD in your Azure Databricks environment.

## Learning objectives

In this module, you'll:

- Learn about CI/CD and how it applies to data engineering.
- Use Azure DevOps as a source code repository for Azure Databricks notebooks.
- Create build and release pipelines in Azure DevOps to automatically deploy a notebook from a development to a production Azure Databricks workspace.

## Prerequisites

None