
The Data Migration Assistant (DMA) facilitates your database migration  by identifying compatibility issues that may affect database functionality in your new version of SQL Server or Azure SQL. DMA also helps diagnosing issues that might either block the upgrade process or require modification to existing scripts or applications due to a breaking change. 

Furthermore, it enables you to seamlessly transfer your database schema, data, users, server roles, SQL Server and Windows logins to a SQL Server instance hosted on-premises or on an Azure virtual machine (VM) that is accessible from your on-premises network.

:::image type="content" border="false" source="../media/4-dma-migration-page.png" alt-text="Screenshot of the Data Migration Assistant tool and a new migration project options.":::

> [!TIP]
> To learn how to assess on-premises SQL Server instance(s) to migrate to Azure SQL, and how to discover new features in the target SQL Server platform that the database can benefit from after an upgrade, see [Assess SQL Server databases for migration to Azure SQL module](/training/modules/assess-sql-server-databases-for-migration-to-azure-sql/).

## Migrate SQL Server logins

Data Migration Assistant allows you to migrate logins based on Windows principals or SQL Server logins to SQL Server on Azure Virtual Machines. However, it currently doesn't support logins associated with stand-alone security certificates, asymmetric keys, or credentials. 

The `sa` login and server principles with names enclosed by double hash marks (##) aren't moved as they are for internal use only. By default, all qualified logins are selected for migration, but you can choose specific logins if needed. 

During migration, user-defined server roles and permissions are also moved, with the role owner set to `sa` principal. After migration, the tool maps permissions to securables on the target SQL Server and only migrates other permissions if the login already exists. It's essential to review migration results and consider any recommended post-migration actions.

## Fine-tune configuration

You can fine-tune certain Data Migration Assistant behavior by changing configuration values in the dma.exe.config file.

The dma.exe.config file for the Data Migration Assistant can be located in the following folders on your machine:

**Desktop Application:** %ProgramFiles%\Microsoft Data Migration Assistant\dma.exe.config

**Command-Line Utility:** %ProgramFiles%\Microsoft Data Migration Assistant\dmacmd.exe.config

### Parallel database migration

Data Migration Assistant migrates multiple databases in parallel. Starting with Data Migration Assistant v2.0, you can prevent timeout failures when handling a large number of databases, adjust the `parallelDatabases` configuration value.

```xml
<advisorGroup>
<workflowSettings>
<migration parallelDatabases="8″ />
</workflowSettings>
</advisorGroup>
```

### Connection timeout

You can adjust the SQL connection timeout for both source and target instances during an assessment or migration. The default value is 15 seconds.

```xml
<appSettings>
<add key="ConnectionTimeout" value="15" />
</appSettings>
```

For more options, see [Configure settings for Data Migration Assistant](/sql/dma/dma-configurationsettings).

## Best practices for running Data Migration Assistant

Consider these best practices while working with the Data Migration Assistant:

- Avoid installing and running the Data Migration Assistant directly on the SQL Server host machine.

- Run assessments on production databases during nonpeak times. If possible, run it on a test environment with a recent copy of your production database.

- Separate **Compatibility issues** and **New feature recommendations** assessments to reduce the assessment duration.

- Perform server migrations during nonpeak times.

- For database migration, use a single shared location accessible by both the source and target servers to avoid unnecessary copy operations. Data Migration Assistant bypasses the copy operation when a single location is provided.

- Ensure correct permissions on the shared folder to prevent migration failures.

- Enable encrypted connections when connecting to the source and target servers.
