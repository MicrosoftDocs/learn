This module explored the AI-powered Oracle to Azure Database for PostgreSQL schema conversion feature in the [Visual Studio Code PostgreSQL extension](https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-pgsql), from understanding the pipeline to running a complete conversion and finalizing the output for deployment.

## Review what you learned

- **AI-powered schema conversion pipeline**: The capability combines Foundry language models for DDL translation with compilation attempts and available static checks. Discovery inventories source scope without extracting DDL. Metadata extraction, dependency ordering, validation checks, and script generation remain rule-based.
- **Environment preparation**: Conversion requires the PostgreSQL extension installed in VS Code, an Azure Database for PostgreSQL flexible server (version 15 or later) configured with the required extensions and `search_path`, an Oracle source with the required privileges, the appropriate Oracle connectivity mode, and a Foundry resource with a `gpt-5.2` deployment. Use an empty or dedicated, unused scratch database: matching schemas are dropped with `CASCADE` and recreated.
- **Running the Migration Wizard**: Review Discovery permissions, exclusions, and dependencies before configuring the scratch database and Foundry connection. After conversion, start with the HTML report, `reports/report.html`. Its conversion rate uses the conversion total, not discovery or extraction counts, and doesn't establish production readiness.
- **Reviewing and correcting objects**: Inspect both **Converted** and **Not converted** objects in Conversion Object Explorer. Compare definitions and read conversion notes. Use **Ask**, **Fix**, or manual edits, then compile corrections in a nonproduction database where the schema is deployed. Confirm that deployment SQL includes the tested corrections. Rerunning completed conversions isn't supported.
- **Planning around limitations and deploying**: Some Oracle objects aren't extracted or converted, while others produce partial implementations or placeholders. Follow the generated setup instructions to deploy to a separate nonproduction database, review deployment results, and independently test behavior before production use.

The AI accelerates conversion and focuses your effort where it matters most. The DBA owns validation, object corrections, and the final production sign-off.

## Learn more

- [Oracle to Azure Database for PostgreSQL flexible server schema conversion overview](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-overview)
- [Tutorial: Convert Oracle schemas to Azure Database for PostgreSQL](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-tutorial)
- [Best practices for Oracle to Azure Database for PostgreSQL schema conversion](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-best-practices)
- [Review converted objects in Conversion Object Explorer](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-object-explorer)
- [View the HTML report for Oracle schema conversion](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-reports)
- [Oracle to Azure Database for PostgreSQL schema conversion limitations](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-limitations)
- [FAQ: Oracle to Azure Database for PostgreSQL schema conversion](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-faq)
