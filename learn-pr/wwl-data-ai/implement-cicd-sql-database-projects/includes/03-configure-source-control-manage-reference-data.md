A SQL database project without source control is just a folder of files on someone's machine. The moment that person's laptop breaks, or two developers edit the same stored procedure, you're back to square one. Placing the project in Git gives you change history, collaboration through branching and pull requests, and the foundation every CI/CD pipeline needs.

But source control alone doesn't solve everything. Your database probably has lookup tables, status codes, and default configurations that live alongside the schema. You need a strategy for that data too.

## Set up source control for a SQL database project

Because a SQL database project is just `.sql` files and a `.sqlproj` file, it fits naturally into Git. Each database object lives in its own file, so Git tracks changes at the object level. A commit that modifies the `Customers` table and updates a stored procedure shows exactly those two files in the diff, not a monolithic migration script with dozens of unrelated changes.

To get started, initialize a Git repository in the project folder:

```bash
cd MyDatabaseProject
git init
git add .
git commit -m "Initial commit of database project"
```

### Organize the project folder

A consistent folder structure makes the project navigable at a glance. The most common pattern groups files by object type:

```
MyDatabaseProject/
├── MyDatabaseProject.sqlproj
├── Tables/
│   ├── Customers.sql
│   └── Orders.sql
├── Views/
│   └── vw_ActiveCustomers.sql
├── StoredProcedures/
│   └── usp_GetCustomerOrders.sql
├── Scripts/
│   ├── PostDeployment/
│   │   └── seed-data.sql
│   └── PreDeployment/
│       └── prep-db.sql
└── PostDeploy.sql
```

With SDK-style projects, the default globbing pattern picks up every `.sql` file in the folder automatically. No manual file entries needed.

### Add a .gitignore file

Keep the repository focused on source files by excluding build outputs and user-specific settings:

```
bin/
obj/
*.dacpac
*.user
```

The `.dacpac` gets recreated from the project on every CI/CD build, so there's no reason to track it in Git.

## Manage reference data with predeployment and post-deployment scripts

The declarative model handles schema objects like tables, views, and stored procedures, but some data is as essential as the schema itself. Status codes, lookup tables, default configurations, region lists. If that data disappears, the application breaks. It belongs in the project, versioned alongside the objects that depend on it.

Predeployment and post-deployment scripts solve this problem. They're SQL scripts that execute during deployment but sit outside the compiled database model:

- A **pre-deployment script** runs before the deployment plan. Use it for tasks that must complete before schema changes, such as dropping constraints or migrating data.
- A **post-deployment script** runs after the deployment plan completes. Use it to populate reference data, seed lookup tables, or set application defaults.

### Add scripts to the project

A project supports exactly one predeployment script and one post-deployment script. You declare them in the `.sqlproj` file with `PreDeploy` and `PostDeploy` item entries:

```xml
<ItemGroup>
    <PreDeploy Include="prep-db.sql" />
</ItemGroup>
<ItemGroup>
    <PostDeploy Include="PostDeploy.sql" />
</ItemGroup>
```

### Use SQLCMD includes for multiple data files

One script file doesn't mean one giant file. Use SQLCMD `:r` syntax to pull in multiple files from a single entry point. A typical `PostDeploy.sql` looks like this:

```sql
:r .\Scripts\PostDeployment\seed-statuses.sql
:r .\Scripts\PostDeployment\seed-regions.sql
:r .\Scripts\PostDeployment\seed-app-settings.sql
```

Each referenced file needs to be excluded from the build, otherwise the build process tries to compile it as a schema object and fails. In the `.sqlproj` file, use `Build Remove` to prevent compilation and `None Include` to keep the file visible in the project:

```xml
<ItemGroup>
    <Build Remove="Scripts\PostDeployment\seed-statuses.sql" />
    <None Include="Scripts\PostDeployment\seed-statuses.sql" />
</ItemGroup>
```

&#128221; Repeat this pattern for each referenced file in your predeployment or post-deployment scripts.

### Write idempotent reference data scripts

Post-deployment scripts run on every deployment, not just the first one. If you use plain `INSERT` statements, the second deployment fails with duplicate key violations. Use `MERGE` statements instead to make the scripts safe to run repeatedly:

```sql
MERGE INTO [dbo].[OrderStatuses] AS target
USING (VALUES
    (1, N'Pending'),
    (2, N'Processing'),
    (3, N'Shipped'),
    (4, N'Delivered'),
    (5, N'Cancelled')
) AS source ([StatusID], [StatusName])
ON target.[StatusID] = source.[StatusID]
WHEN MATCHED THEN
    UPDATE SET [StatusName] = source.[StatusName]
WHEN NOT MATCHED THEN
    INSERT ([StatusID], [StatusName])
    VALUES (source.[StatusID], source.[StatusName]);
```

> [!TIP]
> You can validate the predeployment and post-deployment scripts after a project build by changing the `.dacpac` file extension to `.zip` and extracting it. A single `.sql` file for each script type contains the combined T-SQL content from all referenced files.

## Key takeaways

Initialize a Git repository at the solution level and use a `.gitignore` file to exclude build outputs like `bin/`, `obj/`, and `.dacpac` files. Organize schema objects into folders that mirror the database structure, with one file per object. Place reference data in post-deployment scripts and use SQLCMD `:r` includes to keep each script focused on a single table. To prevent data scripts from being compiled as schema objects, use `Build Remove` and `None Include` in the `.sqlproj` file. Write `MERGE` statements instead of plain `INSERT` statements so reference data scripts are idempotent and safe to run on every deployment. Next, you put this repository to work with branching and pull request workflows.
