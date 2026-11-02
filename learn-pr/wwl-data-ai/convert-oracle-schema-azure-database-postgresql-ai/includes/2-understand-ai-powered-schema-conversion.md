To tackle Contoso Retail's migration, you first need to understand how the conversion feature works and what role each component plays. Before you open the Migration Wizard, a clear mental model of the pipeline helps you interpret the output and understand where the AI adds value, and where your judgment is required.

## Understand the conversion capability

The [Oracle to Azure Database for PostgreSQL schema conversion feature](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-overview) is built into the [PostgreSQL extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-pgsql) (extension ID: `ms-ossdata.vscode-pgsql`, published by Microsoft). You don't need a separate migration tool or an another cloud service beyond the resources the tool uses. The entire workflow runs within VS Code.

The feature converts Oracle schema objects into PostgreSQL-compatible DDL for review and validation before deployment to Azure Database for PostgreSQL flexible server.

## Identify the architecture components

The conversion involves five components working together:

| Component | Role |
|---|---|
| **Source Oracle database** | The Oracle schema to convert. The tool reads schema metadata from the Oracle data dictionary, never row-level application data. |
| **VS Code PostgreSQL extension** | The primary interface. Manages connections, runs the Migration Wizard, hosts Conversion Object Explorer, and produces all conversion artifacts. |
| **Azure Database for PostgreSQL flexible server** | Hosts the scratch schemas used for validation. The converted DDL runs against this server before the tool generates final output. |
| **Microsoft Foundry** | Hosts the language models that power AI-driven schema translation. Your organization creates a model deployment and the tool calls it during conversion. |
| **Schema conversion agents** | AI agents that orchestrate the conversion process, passing schema context to the language model and processing the results. |

:::image type="content" source="../media/schema-conversion-architecture.png" alt-text="Diagram of the five-component Oracle to Azure Database for PostgreSQL schema conversion architecture and its data flow.":::

## Follow the conversion pipeline

The conversion workflow includes the following stages. Understanding each stage helps you interpret the conversion report and focus your effort after the run completes.

### Discover and extract schema objects

The tool connects to your Oracle database and inventories objects in the selected schemas. Discovery checks source permissions, exclusions, and schema dependencies without extracting DDL. After you review the scope and configure the remaining connections, extraction reads DDL and metadata from the Oracle data dictionary, including views such as `DBA_TABLES`, `DBA_PROCEDURES`, and `DBA_DEPENDENCIES`. These steps are deterministic and prepare the definitions for transformation.

### Transform DDL with AI

Schema conversion agents pass the batched Oracle DDL to language models hosted in [Microsoft Foundry](/azure/foundry/what-is-foundry). The models translate Oracle-specific constructs, such as PL/SQL syntax, Oracle data types, implicit conversions, and Oracle-specific built-in functions, into PostgreSQL-compatible equivalents. The AI takes object relationships, platform best practices, and Azure Database for PostgreSQL–specific behaviors into account when generating the output.

This is the stage where AI adds the most value: translating complex DDL that would take significant time to rewrite manually.

### Validate in scratch schemas

The tool attempts to compile generated DDL in your Azure Database for PostgreSQL flexible server and performs available static checks. It drops schemas matching the selected Oracle schemas with `DROP SCHEMA ... CASCADE` and recreates them. Use an empty or dedicated, unused scratch database with no objects or data you need to preserve, because this operation can also remove dependent objects in other schemas.

This stage can detect syntax errors, unresolved dependencies, target-version incompatibilities, and extension or `search_path` issues. It doesn't establish equivalent application behavior or production readiness.

### Review conversion results

The HTML report and [**Conversion Object Explorer**](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-object-explorer) show object statuses, definitions, and conversion notes. Review both **Converted** and **Not converted** objects, especially:

- Complex PL/SQL logic with no direct PostgreSQL equivalent
- Oracle data types with multiple valid PostgreSQL mappings (for example, `NUMBER` types that could map to `numeric`, `integer`, or `bigint` depending on actual usage)
- Oracle behaviors that differ semantically in PostgreSQL, such as empty-string vs. NULL handling, numeric precision, date and time handling, or transaction control

A **Converted** status doesn't guarantee a complete implementation, successful compilation, or inclusion in deployment SQL. Inspect definitions and notes for missing logic or placeholders.

### Correct objects with guidance

In Conversion Object Explorer, select **Ask** to explain an object's conversion and dependencies, or **Fix** for a Copilot prompt with the object's details. Review and accept or modify the proposed edits.

You can also edit the generated `.sql` file manually. Compile corrections in a nonproduction database where the converted schema is deployed, and confirm that deployment SQL includes the tested corrections.

### Prepare deployment

The conversion generates PostgreSQL `.sql` files, a `deploy.sql` deployment script, reports, and setup instructions. Generating these files doesn't deploy them. Review the output and follow the setup instructions to deploy to a separate nonproduction database before functional and application validation.

## Recognize where AI helps, and where it doesn't

The conversion pipeline uses AI selectively. Microsoft Foundry Models handle the translation work: mapping PL/SQL to PL/pgSQL, converting Oracle data types to PostgreSQL equivalents, and expressing Oracle-specific logic in PostgreSQL idioms. This is context-sensitive work that benefits from language model capability.

The other pipeline stages run as deterministic, rule-based steps. These include source parsing, metadata extraction, dependency ordering, scratch-schema validation, and script generation. This hybrid approach keeps behavior predictable and auditable across the stages where it matters most.

> [!IMPORTANT]
> The same AI that converts schema objects can also assist with reviewing those objects. AI systems can occasionally confirm their own mistakes. You must independently validate all converted objects and corrections before deploying to production. Don't treat AI-generated output as production-ready without independent verification.

## Identify what the tool converts

The tool supports a broad range of Oracle schema and code objects:

**Data definition objects:** tables (with column specifications and table-level constraints), primary keys, foreign keys, unique constraints, check constraints, B-tree indexes, unique indexes, composite indexes, sequences, schemas, and public and private synonyms (with limitations).

**Views and code objects:** standard views, materialized views, triggers (row-level and statement-level), functions, stored procedures, packages (specifications and bodies), and types (object types, `TYPE BODY` member methods, `VARRAY`, nested tables, and `SUBTYPE` declarations).

Support varies by object and feature. Oracle system schemas, Advanced Queuing tables, and Java in the database aren't extracted. Wrapped PL/SQL can produce placeholders without the original business logic. Unit 5 covers how to plan around these limitations.

## Check supported Oracle source versions

The tool supports schema conversion from Oracle 12.1, 12.2, 18c, 19c, and 21c. The target is Azure Database for PostgreSQL flexible server running PostgreSQL version 15 or later.

> [!NOTE]
> Before you run a conversion on a production-complexity schema, list the Oracle features your schema uses most heavily, such as PL/SQL packages, complex triggers, materialized view refresh logic, and Oracle-specific data types. These areas deserve particular attention when you review generated definitions and conversion notes.
