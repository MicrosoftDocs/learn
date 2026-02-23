GitHub Copilot integrates with the PostgreSQL extension in Visual Studio Code to provide AI-assisted database development. After connecting to a PostgreSQL database, Copilot can access contextual information from the live connection. This allows the `@pgsql` Copilot chat participant to generate schema-aware SQL queries and insights while developers remain in Visual Studio Code.

Consider the Margie’s Travel scenario. Developers work with PostgreSQL databases that store property listings and customer reviews. Copilot helps them understand database structures, generate SQL queries, and manage schema changes while keeping development work centralized in the editor.

## Identify the Copilot integration surface

The PostgreSQL extension exposes GitHub Copilot capabilities through Copilot Chat. Developers begin by right-clicking a database connection and selecting **Chat with this database**. When the Copilot chat interface opens, developers use the `@pgsql` prefix to ensure that Copilot responds using PostgreSQL database context.

Copilot uses information from the active connection to tailor its responses, enabling more relevant guidance than general-purpose AI assistance.

In addition to Copilot Chat, Copilot features can also be accessed from the editor by selecting SQL code and using right-click context menu options such as **Explain**, **Generate Code**, or **Open Inline Chat**.

## Understand the types of tasks Copilot supports

GitHub Copilot integration for PostgreSQL supports a range of database development tasks. These tasks span both read and write scenarios and are designed to reduce manual effort while keeping developers in control.

Common task categories include:

- **Exploring database structures**, such as tables, columns, and schemas.
- **Generating SQL queries**, including queries for reporting, filtering, and aggregation.
- **Assisting with schema changes**, such as creating or modifying tables and columns.
- **Providing explanations and insights**, such as describing how a query works or identifying potential improvements.
- **Query optimization**, where developers ask for help refining queries or resolving errors.
- **Performance optimization**, such as guidance related to indexing, schema design, or query behavior.
- **App development**, where Copilot helps generate SQL queries or database-related logic used by applications.

These capabilities allow developers to work more efficiently with PostgreSQL databases while staying within their existing development workflow.

## Use Copilot Chat for more than just PostgreSQL

While using `@pgsql` focuses on PostgreSQL-specific tasks, developers can also use Copilot Chat for general coding assistance. This includes writing application code, generating documentation, or addressing non-database-connected questions. The ability to switch between database-focused and general-purpose assistance makes Copilot Chat a versatile tool within Visual Studio Code. 

If you preface your prompts with `@pgsql`, Copilot will respond with PostgreSQL-specific context. If you do not use the prefix, Copilot will provide general coding assistance. For example:

> `@pgsql How do I create an index on the listings table for the price column?`

Would yield a PostgreSQL-specific response, while:

> `How do I write a function in Python to connect to my PostgreSQL database?`

Would yield a general Python coding response.

Because both prompt types are accessible in the same chat interface, developers can fluidly switch between database and application development tasks pointing to the same context.

## Explore GitHub Copilot agent mode

So far we have focused on using Copilot Chat in a question-and-answer format. GitHub Copilot Chat also supports an ***agent mode*** that can autonomously perform multi-step database tasks.

GitHub Copilot Chat agent mode provides a database context aware intelligent assistant that can perform multi-stage tasks, moving beyond the question-and-answer chat experience. Agent mode enables Copilot to draw on additional workspace context and, when allowed, to independently generate and correct code. This capability supports PostgreSQL development by helping with tasks such as building application prototypes, diagnosing issues, adjusting database structures, and improving query performance.

## Understand safeguards and developer responsibility

Because Copilot can propose SQL that reads from or writes to the database, it includes safeguards to prevent unintended changes. For operations that modify data or schemas, Copilot requests explicit permission and confirmation before executing any SQL.

Developers are responsible for reviewing all generated SQL queries and schema changes before approval. This review step is especially important when working in staging or production environments.

At Margie’s Travel, this model ensures that Copilot improves productivity while maintaining control over database integrity and operational risk.

## What you’ve learned

In this unit, you learned how GitHub Copilot integrates with the PostgreSQL extension in Visual Studio Code. You learned where the integration appears, the types of database tasks it supports, and how confirmation and review help developers safely use Copilot for PostgreSQL development.
