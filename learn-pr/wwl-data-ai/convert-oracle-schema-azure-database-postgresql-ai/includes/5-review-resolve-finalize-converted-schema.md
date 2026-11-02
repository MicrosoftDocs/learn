The conversion report summarizes the run, but Conversion Object Explorer is where you inspect and correct individual objects. This unit covers object review, corrections with GitHub Copilot agent mode or manual edits, output artifacts, limitations, and [best practices](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-best-practices) before deployment.

## Review converted objects

Use [**Conversion Object Explorer**](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-object-explorer) to inspect both **Converted** and **Not converted** objects. Review definitions and conversion notes for:

- Behavioral differences between Oracle and PostgreSQL, such as `NUMBER(p,s)` precision mapping or empty-string and NULL handling
- Definitions that compile but might not preserve Oracle behavior
- Complex PL/SQL logic converted with a fallback pattern
- Partial implementations or placeholders that need manual completion

A **Converted** status doesn't establish a complete implementation, compilation success, deployment inclusion, or equivalent runtime behavior. For example, a generated routine that only raises an error can still appear as **Converted**.

### Navigate Conversion Object Explorer

From **Review conversion summary**, select **Conversion object explorer**. Filter by source object name, source schema, source object type, or status.

Compare the source and target names and types. Select an object to view its Oracle definition on the left, its PostgreSQL definition on the right, and its **Conversion notes**. Expand packages to inspect member definitions individually.

:::image type="content" source="../media/schema-review-pane.png" alt-text="Screenshot of Conversion Object Explorer showing source-object filters, source-to-target mappings, conversion statuses, and Ask and Fix actions.":::

## Correct an object

### Correct with GitHub Copilot agent mode

1. Select an object in Conversion Object Explorer and review its definitions and notes.
2. Select **Ask** if you need an explanation of the conversion or its dependencies.
3. Select **Fix** to open a Copilot prompt with the object's details.
4. Review the proposed edits and apply the corrections to the generated PostgreSQL file.
5. Connect the SQL editor to the nonproduction database where the converted schema is deployed.
6. Confirm the active database and schema references, select complete statements, and execute them to compile the updated definition. Review the execution output and correct any errors.

### Correct manually

1. Open the generated `.sql` file for the object. Files are organized under `postgres_ddl/<schema>/<object_type>/` in the session folder.
2. Edit the file in VS Code.
3. Connect the SQL editor to the nonproduction database where the converted schema is deployed. Confirm the active database and schema references, then execute the complete statements you intend to change.
4. Review the execution output and correct any errors.

> [!IMPORTANT]
> Editing a file, applying the definition to a database, and updating `deploy.sql` are separate actions. Don't assume that editing a per-object file updates deployment SQL. Confirm that deployment SQL includes your tested corrections. If no text is selected, **Execute PostgreSQL Query** runs the entire editor contents.

Validation matters as much when you let AI help correct an object, because the review step introduces its own risk.

> [!IMPORTANT]
> The same AI that converts schema objects can also assist with reviewing those objects through GitHub Copilot agent mode. AI systems can occasionally confirm their own mistakes. Independently validate all converted objects and corrections before deploying to production. Never rely solely on AI-generated or AI-reviewed output to confirm production readiness.

## Locate the output artifacts

The conversion session folder contains the primary output. Under the migration project's `artifacts/oracle/` directory, a single-schema selection uses `<schema-name>/convert/sessions/<session-id>/`, while multiple selected schemas use `_migration/convert/sessions/<session-id>/`.

| Artifact | Purpose | Primary audience |
|---|---|---|
| `reports/report.html` | Discovery, extraction, conversion results, and object-level notes | Start here; share with the migration team |
| `postgres_ddl/<schema>/<object_type>/` | One `.sql` file per converted object | Edit and revalidate individual objects |
| `deploy.sql` | Generated deployment SQL | Review deployment scope and corrections before use |

Open the HTML report first. To deploy to a separate nonproduction database, select **Setup instruction** on **Conversion summary** and follow the generated `setup_instructions.md`. The [Setup Experience](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-setup) provides PowerShell and Bash scripts for readiness checks, deployment, and verification. Generating or opening these files doesn't deploy the schema. Review deployment and verification results before functional testing.

## Plan around limitations

Oracle objects and features have [different conversion limitations](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-limitations). Some aren't extracted or converted. Others produce partial implementations or placeholders. Review Discovery for exclusions and unsupported types, then inspect the HTML report and Conversion Object Explorer for outcomes and notes.

Categories requiring separate planning or manual review include:

- **System schemas**: `SYS`, `SYSTEM`, `XDB`, `MDSYS`, `CTXSYS`, `WMSYS`, and other Oracle built-in schemas
- **Specialized table types**: index clusters, hash clusters, external tables, and blockchain tables aren't extracted. Hybrid partitioned tables convert as ordinary tables without their external partitions.
- **Specialized index types**: bitmap indexes, bitmap join indexes, global partitioned indexes
- **Certain views**: flashback queries (`AS OF TIMESTAMP`, `AS OF SCN`) aren't converted, and materialized view logs aren't extracted. Editioning views need review for loss of edition-specific behavior.
- **System event triggers**: review `LOGON`, `LOGOFF`, `STARTUP`, `SHUTDOWN`, and `SERVERERROR` triggers for target event, scope, and permissions. Compilation doesn't establish equivalent Oracle event handling.
- **Java in the database**: Java stored procedures, Java sources, and classes, external libraries
- **Wrapped PL/SQL**: the tool can't read the implementation and can generate placeholders, even with a **Converted** status. Obtain unwrapped source before conversion, or implement missing logic manually.
- **Scheduler objects**: automated conversion of `DBMS_SCHEDULER` and `DBMS_JOB` jobs isn't supported. Recreate schedules with [`pg_cron`](/azure/postgresql/extensions/concepts-extensions-considerations#pg_cron) or an external scheduler.
- **Oracle Advanced Queuing (AQ)**: replatform to an Azure messaging service such as Azure Service Bus
- **OLAP and analytic objects**: analytic views, attribute dimensions, hierarchies, OLAP dimensions
- **Database links**: recreate using `postgres_fdw` or `oracle_fdw`, or refactor to application-level connections
- **Storage, security, and administration objects**: application contexts, directory objects, fine-grained auditing, and unified audit policies, Information Lifecycle Management (ILM) policies, Resource Manager objects, SQL Translation profiles, and Workspace Manager

For each unsupported object you identify, decide in advance whether to recreate the functionality natively in PostgreSQL, replatform it to an Azure service, or drop it from the migration scope.

## Apply best practices before deployment

**Align scratch and production:** Validate against the same PostgreSQL major version you plan to deploy to, and install the same extensions and `search_path` on the production target. Otherwise, `deploy.sql` fails wherever converted code calls extension functions such as those from `orafce`.

**Correct completed conversions manually:** Rerunning a completed conversion isn't supported. Review and edit the generated definitions, compile corrections manually, and confirm that deployment SQL includes them. Refreshing Discovery before conversion isn't a conversion rerun.

**Size Foundry capacity correctly:** Run one conversion project at a time so concurrent runs don't compete for the same Microsoft Foundry quota, and provision enough TPM for your schema's size and PL/SQL complexity.

**Independently validate all output:** Deploy to a separate nonproduction database, execute converted procedures and functions with representative test data, and verify that business logic and result sets match the Oracle source. Don't use the conversion scratch database for functional or data validation. Compilation and available static checks don't establish semantic equivalence.

**Preserve conversion artifacts:** Keep the complete migration project, including generated SQL, reports, and setup files, as the audit artifact and baseline for tracking manual corrections. The setup scripts reference the conversion session's `deploy.sql`, so preserve the directory structure. Store artifacts in your team's source control or document-management system without credentials or secrets.

**Review your limitations inventory:** Before starting the Contoso Retail conversion, identify which unsupported object categories apply to the inventory management schema. For each one, document your remediation path, whether to recreate, replatform, or drop, before opening the Migration Wizard. A documented plan up front prevents late-stage surprises.
