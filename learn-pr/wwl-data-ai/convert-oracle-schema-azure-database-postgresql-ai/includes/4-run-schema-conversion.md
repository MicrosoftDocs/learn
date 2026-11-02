With the environment prepared, you're ready to open the Migration Wizard and run the conversion. This unit walks through the complete [Migration Wizard workflow](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-tutorial), explains the scratch database's role in validation, and shows you how to interpret the conversion report.

## Start the migration wizard

The migration wizard is the primary interface for configuring and running a conversion. Access it from the [PostgreSQL extension](https://marketplace.visualstudio.com/items?itemName=ms-ossdata.vscode-pgsql) panel in VS Code.

### Create an Azure Database for PostgreSQL connection

Before you create a migration project, add a connection to your Azure Database for PostgreSQL flexible server in the PostgreSQL extension panel:

1. In the PostgreSQL extension panel, select **Add Connection**.
2. Enter the connection details: host, database name, username, and password.
3. Test and save the connection.

This connection provides access to the scratch database for conversion validation. Deployment to a separate destination database is a later step.

### Open a workspace and create a migration project

The Migration Wizard stores all project files, including artifacts, reports, and generated DDL, in a local workspace folder. Organize migration projects in a dedicated folder rather than a generic workspace.

1. Create a new folder on your local machine for the migration project.
2. Open the folder in VS Code as a new workspace (**File** > **Open Folder**).
3. In the PostgreSQL extension, go to the **Migrations** panel and select **Create Migration Project**.
4. Enter a **project name** in the Migration Wizard, then select **Next**.

### Configure the Oracle connection and load schemas

1. Enter your Oracle connection details: host, port, database or service name, username, and password.
2. Select **Load Schemas**. The tool tests the connection and, if successful, lists all user-defined schemas available in your Oracle database.
3. Select one or more schemas to include in the conversion.
4. Select **Next: Discovery**.

The tool selects thin or thick client mode automatically based on your `sqlnet.ora` settings. If your environment requires thick mode and Oracle Instant Client isn't on the `PATH`, the connection fails at this step, a good reason to verify connectivity before opening the wizard.

:::image type="content" source="../media/oracle-connection.png" alt-text="Screenshot of the Oracle connection step with redacted connection details, the HR schema selected, and the Next: Discovery button.":::

### Review Discovery

Discovery inventories the source without extracting DDL.

1. Review **Source permissions**. Work with your Oracle database administrator to resolve unsuccessful checks, then select **Refresh Discovery**.
2. Review **Discovered**, **To be extracted**, **Excluded**, and **Invalid objects**, including supported and unsupported object types.
3. Review **Dependent schemas**. These references don't mean that the schemas are selected for conversion. If you need to change the scope, select **Previous**, update the schema selection, and review Discovery again.
4. Select **I have reviewed the objects, exclusions and dependent schemas**, then select **Next: PostgreSQL Connection**.

### Configure the scratch database

1. Select the Azure Database for PostgreSQL connection you created earlier.
2. Select an empty or dedicated, unused **target database** from the dropdown list.
3. Select **Verify Extensions**. If required extensions are missing, allow-list and install them in the selected database, then verify again. You can continue with the warning, but dependent objects might require manual changes.
4. Select the checkbox acknowledging that schemas matching the selected Oracle schemas are dropped and recreated, deleting their existing objects and data.
5. Select **Next: Microsoft Foundry Model Configuration**.

> [!WARNING]
> The tool uses `DROP SCHEMA ... CASCADE`, which can also remove dependent objects in other schemas. Don't select a database containing anything you need to preserve. The connection user needs permission to drop and recreate matching schemas, not just database-level `CREATE`.

### Configure Microsoft Foundry

1. Enter your **Microsoft Foundry endpoint URL** (for example, `https://<your-resource>.services.ai.azure.com`) and **deployment name** (the name you assigned to the `gpt-5.2` deployment in Microsoft Foundry).
2. Select the authentication method: **API key** or **Microsoft Entra ID**. If you select API key, enter the key. If you select Microsoft Entra ID, the tool acquires the token from your signed-in Azure Account session automatically.
3. Select **Test Connection** to verify the configuration.
4. After the connection test succeeds, select **Create Migration Project**.

### Run the schema conversion

The Migration Wizard navigates to the main conversion panel.

1. Select **Migrate** to start the schema conversion.
2. Monitor progress in the VS Code interface. The wizard shows conversion stages and object counts as the pipeline runs.

The conversion processes objects in dependency-aware batches. Duration depends on schema size and complexity, and on the token-per-minute capacity of your Microsoft Foundry deployment. For large schemas with heavy PL/SQL, this stage can take several minutes to an hour or more.

When the run finishes, the project shows **Schema conversion is complete** and **Review conversion summary**.

:::image type="content" source="../media/migration-progress.png" alt-text="Screenshot of completed schema conversion showing extraction and conversion progress and the Review conversion summary action.":::

## Review what the scratch database validates

During conversion, the tool attempts compilation and available static checks in the scratch database. These checks can identify:

- **Syntax errors** in generated DDL
- **Unresolved dependencies** between converted objects
- **Target-version incompatibilities** with the scratch server
- **Missing extension dependencies**, such as unresolved `orafce` functions

Review object statuses, definitions, and conversion notes for validation issues. Compilation doesn't test application behavior, and a **Converted** status alone doesn't establish compilation success or deployment readiness.

## Read the conversion report

After conversion completes, the [HTML conversion report](/azure/postgresql/migrate/oracle-conversions-schema/schema-conversions-reports) opens automatically. Reopen it from **Conversion report** on the **Conversion summary** page, or open `reports/report.html` in the conversion session folder.

The **Overall summary** separates the results of each phase:

- **Discovery**: source inventory, including objects planned for extraction, excluded objects, and invalid objects
- **Extraction**: retrieved definitions, failed extractions, and excluded objects
- **Conversion**: **Converted** and **Not converted** counts
- **Conversion rate (%)**: converted objects divided by the conversion total, expressed as a percentage

> [!NOTE]
> Discovery, extraction, and conversion can count different objects. Use the report's conversion total, not the discovery or extraction total, as the conversion-rate denominator. The rate doesn't establish equivalent runtime behavior or production readiness.

Expand **Conversion** and **Object type conversion** to investigate object-level statuses and notes. Review notes for converted objects as well as objects that weren't converted.

**After conversion:** Review the HTML report and identify objects that need attention. Use **Conversion Object Explorer** to inspect and correct their definitions in the next stage.
