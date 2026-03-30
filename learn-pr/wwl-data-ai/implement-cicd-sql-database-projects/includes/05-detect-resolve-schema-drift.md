Your SQL database project says the `Customers` table has 12 columns. Production has 13. Someone added a `LoyaltyTier` column directly through SQL Server Management Studio (SSMS) last Thursday during an incident. Your next deployment will quietly drop that column because the project doesn't know it exists. This type of situation is known as schema drift, and it's one of the ways CI/CD pipelines break production without warning.

## Understand schema drift

Schema drift is the gap between what your project defines and what actually exists in the live database. Common causes include:

- **Manual changes**: someone opens a query window and runs an `ALTER TABLE` outside the normal workflow.
- **Emergency hotfixes**: a production issue gets patched at 2 AM, and the fix never makes it back into the project.
- **Third-party tools**: monitoring agents or Object-Relational Mapping (ORM) frameworks that create or modify objects behind the scenes.

The danger isn't the drift itself. It's what happens next. Your pipeline deploys the `.dacpac`, SqlPackage calculates the diff, and every object the project doesn't know about gets dropped. Detecting drift before that deployment runs is critical.

## Detect drift with schema comparison

Schema comparison tools let you hold two database definitions side by side. You can compare any combination of a live database, a SQL database project, or a `.dacpac` file. When you compare a live database against your project, the results surface every difference, grouped by action type (`Create`, `Alter`, `Delete`) with the source and target definitions shown for each object.

In Visual Studio or Visual Studio Code, launch schema compare from the SQL Server menu or the Database Projects view. Point the source at the live database and the target at the project. The comparison grid shows what's different and what would change if you brought them into alignment.

> [!NOTE]
> The direction is reversible. Compare database-to-project to find drift. Compare project-to-database to preview what a deployment would change. Same tool, opposite perspective.

### Schema comparison options

Not every difference matters. You can tune the comparison to focus on what's meaningful:

- **Ignore whitespace** to skip formatting-only differences.
- **Ignore column order** when column position is irrelevant to your application.
- **Block on possible data loss** to flag destructive operations like dropping columns that contain data.

Save your comparison settings as an `.scmp` file and commit it to your repository. It stores the source, target, comparison options, and excluded object types, making drift checks repeatable across the team.

## Import changes from the database into the project

Once you spotted a drift, you need to decide: does the live database have the right version, or does the project? If production's hotfix was correct, bring it into the project so your source of truth stays accurate.

### Use schema compare to apply changes

In the comparison results, select the specific differences you want to import and apply them. The graphical interface in Visual Studio and Visual Studio Code lets you cherry-pick. Accept the hotfix index but ignore the monitoring agent's temp table, for example.

### Automate with SqlPackage Extract

For CI/CD scenarios or scheduled drift checks, use SqlPackage `Extract` to pull the live schema into files:

```bash
sqlpackage /Action:Extract /SourceConnectionString:"{connection string}" /TargetFile:MyDatabaseProject /p:ExtractTarget=SchemaObjectType
```

&#128221; This extracts database objects into files organized by schema and object type. With the project folder under Git, running `git status` after the extract reveals exactly which files changed. That's your automated drift report.

Three commands give you a drift count:

```bash
rm -rf MyDatabaseProject
sqlpackage /Action:Extract /SourceConnectionString:"{connection string}" /TargetFile:MyDatabaseProject /p:ExtractTarget=SchemaObjectType
git status --porcelain | wc -l
```

&#128221; The output is the number of files that changed, giving you an automated drift count.

## Review deployment changes before applying them

You saw the `Script` and `DeployReport` actions in the earlier unit on building and deploying. In a drift-detection context, these same commands help you verify what SqlPackage would do before you run it against production.

### Generate a deployment script

The `Script` action produces the exact T-SQL that would execute, without actually running it:

```bash
dotnet build MyProject.sqlproj
sqlpackage /Action:Script /SourceFile:bin/Debug/MyProject.dacpac /TargetConnectionString:"{connection string}" /DeployScriptPath:Deployment.sql
```

Review `Deployment.sql` to see every `ALTER`, `CREATE`, and `DROP` that the deployment would execute. Store the script as a pipeline artifact for approval before running it against production.

### Generate a deployment report

The `DeployReport` action produces an XML summary of planned operations:

```bash
sqlpackage /Action:DeployReport /SourceFile:bin/Debug/MyProject.dacpac /TargetConnectionString:"{connection string}" /OutputPath:report.xml
```

The report lists operations like `Create`, `Alter`, `Drop`, and `TableDataMotion`. Parse the XML in your pipeline to trigger alerts on high-impact events like data motion, clustered index rebuilds, or column drops:

```xml
<DeploymentReport xmlns="http://schemas.microsoft.com/sqlserver/dac/DeployReport/2012/02">
    <Alerts />
    <Operations>
        <Operation Name="Create">
            <Item Value="[dbo].[Products].[IX_Products_CategorySlug]" Type="SqlIndex" />
        </Operation>
        <Operation Name="Alter">
            <Item Value="[dbo].[Customers]" Type="SqlTable" />
        </Operation>
    </Operations>
</DeploymentReport>
```

## Verify .dacpac consistency with DacpacVerify

DacpacVerify compares two `.dacpac` files and reports differences between them, including predeployment scripts, post-deployment scripts, SQLCMD variables, database references, properties, and database objects. This comparison is useful when converting from an original SQL Server Data Tools (SSDT) project to SDK-style, or when validating that a pipeline produces the expected artifact.

Install it as a .NET global tool and run it against two `.dacpac` files:

```bash
dotnet tool install -g microsoft.dacpacverify
dacpacverify before.dacpac after.dacpac
```

## Key takeaways

Schema drift occurs when the live database diverges from the SQL project, often caused by hotfixes, manual changes, or direct production edits. Schema comparison tools detect differences between a database and a project, letting you choose which changes to pull into the project or push to the database. Save schema comparison settings in `.scmp` files so the team uses consistent options every time. Automate drift detection by running `SqlPackage /Action:Extract` on a schedule and comparing the extracted project against the repository. Use `SqlPackage /Action:DeployReport` to preview every planned `CREATE`, `ALTER`, and `DROP` before applying changes. The goal isn't to prevent drift entirely, but to detect it early and resolve it before your next deployment turns a hotfix into a rollback. Next, you build the CI/CD pipelines that automate the entire build-and-deploy cycle.
