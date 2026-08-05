Database teams migrating from Oracle to Azure Database for PostgreSQL often spend months manually rewriting schema objects, translating tables, indexes, views, triggers, packages, and stored procedures by hand. This process is time-consuming and error-prone, and even small mistakes in the converted schema can cause failures when the application goes live.

The AI-powered Oracle to Azure Database for PostgreSQL schema conversion capability, built into the [Microsoft PostgreSQL extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-pgsql), addresses this challenge directly. It combines AI-driven DDL translation with scratch-database validation to automate the bulk of schema conversion work, and surfaces items for human review before deployment.

## Explore the migration scenario

You're a database administrator at Contoso Retail, a company that runs a critical inventory management application on an Oracle database. The leadership team decides to migrate the application to Azure Database for PostgreSQL flexible server, and you're responsible for converting the Oracle schema. The schema includes hundreds of tables, dozens of stored procedures, custom types, triggers, and materialized views, far too much to rewrite manually in any reasonable timeframe.

Your goal is to produce a validated, deployment-ready PostgreSQL schema while keeping manual effort focused on items that genuinely require human judgment.

Throughout this module, you explore how the AI-powered conversion works, how to prepare your environment, how to run a conversion with the Migration Wizard, and how to triage and resolve the items the tool flags for review. The module focuses on schema object conversion, not row-level data migration or application-code conversion, which separate tools and modules address.

By the end of this module, you can describe how the AI-powered schema conversion pipeline works, prepare an Oracle source and Azure targets for conversion, run the Migration Wizard end to end, and review and resolve conversion tasks to produce a finalized, deployment-ready schema.
