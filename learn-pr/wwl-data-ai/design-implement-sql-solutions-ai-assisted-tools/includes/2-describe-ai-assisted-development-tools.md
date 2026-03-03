AI-assisted development tools are transforming how database professionals work with Microsoft SQL platforms. Instead of manually writing every query, debugging complex T-SQL code, or searching through documentation, you can now leverage AI assistants that understand your database context and provide intelligent suggestions in real time.

## What are AI-assisted development tools?

AI-assisted development tools use large language models (LLMs) to help you write, understand, and optimize code. AI-assisted tools analyze your code context, database schema, and natural language prompts to generate relevant suggestions. For database development on SQL platforms, two primary AI assistants are available:

- **GitHub Copilot** works directly in your development environment—whether that's Visual Studio Code, Visual Studio, or SQL Server Management Studio (SSMS). It provides code completions, answers questions about your database, and helps you write T-SQL queries by understanding your schema and the patterns you use.

- **Fabric Copilot** is integrated into Microsoft Fabric workspaces and provides AI assistance for data engineering, data science, and analytics workloads. When working with SQL databases in Fabric, Copilot can help you explore data, generate queries, and understand your lakehouse structures.

## How GitHub Copilot and Fabric Copilot enhance database development

Consider a scenario where you need to write a complex query joining multiple tables with specific filtering conditions. Traditionally, you might spend time reviewing table schemas, checking column names and data types, and testing different query approaches. With AI-assisted tools, you can describe what you need in natural language, and the assistant generates a starting query based on your actual database schema.

:::image type="content" source="../media/workflow.png" alt-text="Diagram showing the Copilot workflow: write prompt or code, context sent to AI, AI generates suggestion, review and accept.":::

GitHub Copilot and Fabric Copilot provide several key capabilities:

- **Code completion**: As you type T-SQL, the assistant suggests complete statements, column names, and table references based on your connected database
- **Natural language to SQL**: Describe what you want to retrieve or modify, and the assistant generates the corresponding T-SQL code
- **Code explanation**: Highlight existing code and ask the assistant to explain what it does—useful when working with unfamiliar stored procedures or complex queries
- **Query optimization**: Get suggestions for improving query performance based on best practices and your specific schema
- **Error assistance**: When queries fail, the assistant can help diagnose issues and suggest fixes

## AI assistants across Microsoft SQL platforms

Each Microsoft SQL platform has specific AI integration capabilities:

**SQL Server and Azure SQL Database** are supported through GitHub Copilot in SSMS and Visual Studio Code. You can install the [GitHub Copilot extension in SSMS](/ssms/github-copilot/installation-state?azure-portal=true) to get AI assistance while managing databases, writing queries, and troubleshooting performance issues.

**Azure SQL Managed Instance** also supports GitHub Copilot through the same development tools, allowing you to maintain consistency in your workflow whether you're working with on-premises SQL Server or managed cloud instances.

**SQL databases in Microsoft Fabric** benefit from both Fabric Copilot within the Fabric portal and GitHub Copilot when connecting from external tools. This dual approach means you can use the tool that best fits your current task—Fabric Copilot for quick data exploration in the portal, or GitHub Copilot for more intensive development work in your preferred IDE.

## The role of Model Context Protocol (MCP)

Model Context Protocol (MCP) extends AI assistant capabilities by allowing them to connect directly to your data sources. When you configure an MCP server for your SQL database, the AI assistant can query your actual schema, sample data, and metadata to provide more accurate and contextual suggestions.

With MCP, your AI assistant isn't just working with generic SQL knowledge—it understands your specific tables, columns, relationships, and data types. This contextual awareness significantly improves the relevance and accuracy of generated code. You'll learn how to [configure MCP tool options](/sql/mcp/?azure-portal=true) and connect to MCP server endpoints in later units.

## Responsible AI considerations

When using AI-assisted tools for database development, you're working with systems that apply [responsible AI principles](/azure/machine-learning/concept-responsible-ai?azure-portal=true). Both GitHub Copilot and Fabric Copilot are designed with safeguards to help ensure generated code is appropriate and doesn't include harmful content.

> [!IMPORTANT]
> AI-generated code suggestions should always be reviewed before execution, especially for queries that modify data or affect database security. The assistant provides helpful starting points, but you remain responsible for validating that generated code meets your requirements and follows your organization's standards.

Understanding GitHub Copilot and Fabric Copilot prepares you to make informed decisions about enabling and configuring them for your database development workflows. The following units guide you through the security considerations, setup process, and advanced configuration options that help you get the most value from AI-assisted development.
