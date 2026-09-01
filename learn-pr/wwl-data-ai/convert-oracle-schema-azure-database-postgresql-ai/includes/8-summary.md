This module explored the AI-powered Oracle to Azure Database for PostgreSQL schema conversion feature in the [Visual Studio Code PostgreSQL extension](https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-pgsql), from understanding the pipeline to running a complete conversion and finalizing the output for deployment.

## Review what you learned

- **AI-powered schema conversion pipeline**: The capability combines Foundry language models for DDL translation with deterministic scratch-schema validation and structured review-task generation. AI handles the complex translation work; parsing, metadata extraction, dependency ordering, validation, and script generation remain rule-based and verifiable.
- **Environment preparation**: A successful conversion requires the PostgreSQL extension installed in VS Code, an Azure Database for PostgreSQL flexible server (version 15 or later) configured with the required extensions and `search_path`, an Oracle source with minimum required privileges, the appropriate Oracle connectivity mode (thin or thick), and a Foundry resource with a `gpt-5.2` deployment.
- **Running the Migration Wizard**: The Migration Wizard guides you through creating a migration project, loading Oracle schemas, configuring the scratch database and Foundry connection, and running the conversion. Start your review with `reports/customer_summary.md`, which provides the overall conversion status, success percentage, and the next actions for each run.
- **Reviewing and resolving tasks**: Review tasks are flagged items where human judgment is required. You triage them in the Schema Review pane by criticality, whether Mandatory, Recommended, or Optional, resolve them using GitHub Copilot agent mode or manual edits, and validate each fix against the scratch database before marking it resolved.
- **Planning around limitations and deploying**: Certain Oracle objects, such as Advanced Queuing, Java in the database, wrapped PL/SQL, system event triggers, database links, and others, are outside the tool's supported scope and require a separate remediation plan. Use `deploy.sql` as the final deployment artifact, and validate the complete schema in a nonproduction environment before promoting to production.

The AI accelerates conversion and focuses your effort where it matters most. The DBA owns the validation, the review-task resolution, and the final production sign out.

## Learn more

- [Oracle to Azure Database for PostgreSQL flexible server schema conversion overview](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-overview)
- [Tutorial: Convert Oracle schemas to Azure Database for PostgreSQL](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-tutorial)
- [Best practices for Oracle to Azure Database for PostgreSQL schema conversion](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-best-practices)
- [Review tasks and output folders for Oracle to Azure Database for PostgreSQL schema conversion](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-review-tasks-artifacts)
- [Schema conversion reports for Oracle to Azure Database for PostgreSQL](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-reports)
- [Oracle to Azure Database for PostgreSQL schema conversion limitations](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-limitations)
- [FAQ: Oracle to Azure Database for PostgreSQL schema conversion](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-faq)
- [Oracle to Azure Database for PostgreSQL application conversion](/azure/postgresql/migrate/oracle-conversions-application/)
- [Migrate to Azure Database for PostgreSQL](/azure/postgresql/migrate/)
