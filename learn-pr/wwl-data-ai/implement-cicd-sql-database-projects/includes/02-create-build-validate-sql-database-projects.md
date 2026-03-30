Before you can automate deployments, run tests, or detect schema drift, you need something a pipeline can actually build. That something is a SQL database project.

## Understand SQL database projects

Think of a SQL database project as your database in file form. Every table, stored procedure, view, and function lives in its own `.sql` file. You declare each object once, and when you need to add a column or change a data type, you edit that single file.

If you worked with migration scripts before, the difference is significant. Migration scripts are sequential. You write an `ALTER` statement, hope it runs in the right order, and accumulate a growing chain of changes over time. A SQL database project takes the opposite approach: you maintain the desired end state of each object, and the tooling calculates the difference between the project and the target database at deployment time.

When you build the project, the output is a `.dacpac` file, a compiled model of your entire database schema. You publish that `.dacpac` to create a new database or update an existing one. The build process gives you two things that matter for CI/CD:

- **Validation**: object references and T-SQL syntax are checked against a specific version of SQL before anything gets deployed.
- **A deployable artifact**: the `.dacpac` becomes the single package that flows through your pipeline to every environment.

## Choose between original and SDK-style projects

SQL database projects come in two formats. The **original** format is built on MSBuild (.NET Framework) and ships with SQL Server Data Tools (SSDT) in Visual Studio. The **SDK-style** format is built on the `Microsoft.Build.Sql` project SDK and is the format used by the SQL Database Projects extension for Visual Studio Code.

For new projects, go with SDK-style. It brings capabilities the original format doesn't have:

- **.NET 8+ support**, so you can build cross-platform on Windows, Linux, and macOS. This support matters when your CI runners aren't Windows machines.
- **NuGet package references** for database references, so dependency management follows the same patterns as the rest of the .NET ecosystem.
- **Default globbing** for `.sql` files. Drop a file in the project folder and it automatically is included in the build. No manual file entries needed.

If you have an existing original project, you can convert it to SDK-style by modifying the `.sqlproj` file. Before you convert the project, back up the project file and archive a `.dacpac` from the current project. Compare a "before" and "after" `.dacpac` to confirm the conversion preserved everything.

> [!NOTE]
> SDK-style SQL projects are generally available in Visual Studio Code and in preview in Visual Studio 2022. Visual Studio 2026 supports only the original SQL project format.

## Create and populate a project

You can create a SQL database project from Visual Studio Code, Visual Studio, or the command line. The command line is especially handy for CI/CD scenarios where no graphical environment is available.

To create a new SDK-style project:

```bash
dotnet new sqlproj -n MyDatabaseProject
```

&#128221; This generates a `.sqlproj` file with the SDK-style format. From here, you add database objects by dropping `.sql` files into the project folder. The default globbing pattern picks them up automatically.

For example, to define a table, create `Tables/Customers.sql`:

```sql
CREATE TABLE [dbo].[Customers]
(
    [CustomerID] INT NOT NULL PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Email] NVARCHAR(100) NULL
);
```

Starting with an existing database? Schema comparison tools let you compare a live database against an empty project and import the differences, so you don't have to recreate every object by hand.

## Build and validate the project

Building is where the safety net kicks in. The build process validates every object reference and checks T-SQL syntax against the target platform. If a view references a column that doesn't exist, the build fails. If you use a vector function added in SQL Server 2025 but your project targets SQL Server 2017 (Sql140), the build catches it.

To build from the command line:

```bash
dotnet build MyDatabaseProject.sqlproj
```

&#128221; The build produces a `.dacpac` file in the `bin/Debug` folder by default.

Build output includes **errors** (which block the build) and **warnings** (such as inconsistent casing in object names). Warnings don't stop the build, but they're worth paying attention to. You can also enable SQL code analysis rules to flag best practice violations during the build, catching issues like deprecated join syntax, `SELECT *` in views, or unindexed columns in `IN` predicates.

The target platform is set in the `.sqlproj` file and controls which T-SQL features pass validation. Set it to match your deployment target, whether that's SQL Server 2025 or Azure SQL Database.

## Deploy the project

Once you have a `.dacpac`, SqlPackage handles the deployment. Install it as a .NET global tool:

```bash
dotnet tool install --global microsoft.sqlpackage
```

Then publish to a target database:

```bash
sqlpackage /Action:Publish /SourceFile:bin/Debug/MyDatabaseProject.dacpac /TargetConnectionString:"Server=myserver.database.windows.net;Database=mydb;Authentication=Active Directory Default"
```

&#128221; SqlPackage is cross-platform and runs on Windows, Linux, and macOS.

What happens during deployment depends on the target. For a **new database**, SqlPackage navigates the object dependency graph and creates each object in the correct order, such as referenced tables before foreign keys. For an **existing database**, it calculates the diff between the `.dacpac` and the live schema, then generates only the `ALTER` statements needed to close the gap. Missing two columns? You get one `ALTER TABLE` with both additions. The process is idempotent. Deploy the same `.dacpac` five times and the fifth run changes nothing. You can also fan out a single `.dacpac` across a fleet of databases when upgrading multiple tenants.

Before deploying directly, you can preview the planned changes:

```bash
sqlpackage /Action:Script /SourceFile:bin/Debug/MyDatabaseProject.dacpac /TargetConnectionString:"..." /OutputPath:deploy-script.sql
sqlpackage /Action:DeployReport /SourceFile:bin/Debug/MyDatabaseProject.dacpac /TargetConnectionString:"..." /OutputPath:report.xml
```

The `Script` action produces the exact T-SQL that would run. The `DeployReport` action produces an XML summary of every `CREATE`, `ALTER`, and `DROP`. Review either one before pushing changes to production.

## Key takeaways

A SQL database project stores every database object as a declarative `.sql` file, and the build compiles them into a single `.dacpac` artifact. SDK-style projects (`Microsoft.Build.Sql`) support .NET 8+, cross-platform builds, NuGet package references, and default globbing for `.sql` files. The build process validates object references and T-SQL syntax against the target platform before anything reaches a database. SqlPackage calculates the difference between the `.dacpac` and the target database, generating only the statements needed to close the gap. Use the `Script` and `DeployReport` actions to preview planned changes before deploying to production. The SQL database project, its `.dacpac` artifact, and SqlPackage form the foundation for everything ahead, including source control, CI/CD pipelines, schema drift detection, and testing.
