If you can afford to take the database offline while you migrate to Azure, you have a few tools you can use.

In our bicycle manufacturing scenario, the HR database is considered business-critical but is rarely used at weekends. You've planned to execute an offline migration between Friday evening and Monday morning, but you want to assess the best migration method.

It's assumed that all pre-migration checks have been done with [Azure Migrate](/azure/migrate/migrate-services-overview). This process ensures that feature and compatibility issues are addressed.

## Migrate using Azure Database Migration Service with Azure CLI

[Azure Database Migration Service](/azure/dms/dms-overview) is a fully managed service designed to enable seamless migrations from multiple database sources to Azure data platforms with minimal downtime. You can use Azure CLI or PowerShell to automate database migrations, making it ideal for migrating databases at scale.

The Azure CLI `az datamigration` extension provides commands to create and manage database migrations to Azure SQL Database. This approach is particularly useful for:

- Automating migrations as part of CI/CD pipelines
- Migrating multiple databases at scale
- Scripting repeatable migration processes

### Prerequisites

Before starting the migration, ensure you have:

1. **Azure CLI installed** with the `datamigration` extension
2. **Azure Database Migration Service** created in your subscription
3. **Target Azure SQL Database** provisioned with the schema already deployed
4. **Self-hosted integration runtime** configured for connectivity to your source SQL Server

To install the Azure CLI datamigration extension, run:

```azurecli
az extension add --name datamigration
```

### Create the Database Migration Service

First, create an Azure Database Migration Service to orchestrate your migration activities:

```azurecli
# Create the Azure Database Migration Service
az datamigration sql-service create \
    --resource-group "<YourResourceGroup>" \              # Name of your Azure resource group
    --sql-migration-service-name "<YourMigrationService>" \  # Name for the migration service
    --location "<YourLocation>"                            # Azure region (e.g., eastus2, westus)
```

### Migrate the database schema

Before migrating data, you need to migrate the database schema from the source to the target. Use the `az datamigration sql-server-schema` command:

```azurecli
# Migrate schema from source to target database
az datamigration sql-server-schema \
    --action "MigrateSchema" \
    --src-sql-connection-str "Server=<YourSourceServer>;Initial Catalog=<YourSourceDB>;User ID=<YourSourceUser>;Password=<YourSourcePassword>" \
    --tgt-sql-connection-str "Server=<YourTargetServer>.database.windows.net;Initial Catalog=<YourTargetDB>;User ID=<YourTargetUser>;Password=<YourTargetPassword>"
```

### Start the database migration

Create a new database migration to copy data from the source to target:

```azurecli
# Create a database migration to Azure SQL Database
az datamigration sql-db create \
    --resource-group "<YourResourceGroup>" \            # Name of your Azure resource group
    --sqldb-instance-name "<YourTargetServer>" \        # Name of the target Azure SQL Database server
    --target-db-name "<YourTargetDB>" \                 # Name of the target database
    --source-database-name "<YourSourceDB>" \           # Name of the source database
    --source-sql-connection authentication="SqlAuthentication" \
        data-source="<YourSourceServer>" \              # Source SQL Server hostname or IP
        user-name="<YourSourceUser>" \                  # Source SQL Server username
        password="<YourSourcePassword>" \               # Source SQL Server password
        encrypt-connection=true \
        trust-server-certificate=true \
    --target-sql-connection authentication="SqlAuthentication" \
        data-source="<YourTargetServer>.database.windows.net" \  # Target Azure SQL Database server
        user-name="<YourTargetUser>" \                  # Target database username
        password="<YourTargetPassword>" \               # Target database password
        encrypt-connection=true \
        trust-server-certificate=true \
    --scope "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.Sql/servers/<YourTargetServer>" \
    --migration-service "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.DataMigration/sqlMigrationServices/<YourMigrationService>"
```

### Migrate specific tables

To migrate only specific tables, use the `--table-list` parameter:

```azurecli
# Create a database migration for specific tables
az datamigration sql-db create \
    --resource-group "<YourResourceGroup>" \
    --sqldb-instance-name "<YourTargetServer>" \
    --target-db-name "<YourTargetDB>" \
    --source-database-name "<YourSourceDB>" \
    --source-sql-connection authentication="SqlAuthentication" \
        data-source="<YourSourceServer>" \
        user-name="<YourSourceUser>" \
        password="<YourSourcePassword>" \
        encrypt-connection=true \
        trust-server-certificate=true \
    --target-sql-connection authentication="SqlAuthentication" \
        data-source="<YourTargetServer>.database.windows.net" \
        user-name="<YourTargetUser>" \
        password="<YourTargetPassword>" \
        encrypt-connection=true \
        trust-server-certificate=true \
    --table-list "[Person].[Person]" "[Person].[EmailAddress]" "[Sales].[Customer]" \  # Specify tables to migrate
    --scope "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.Sql/servers/<YourTargetServer>" \
    --migration-service "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.DataMigration/sqlMigrationServices/<YourMigrationService>"
```

The Database Migration Service optimizes the migration process by skipping empty tables, even if you select them.


### Migration status

There are a few statuses that keep you updated on the progress of the migration.

- **Preparing for copy**: The service is in the process of disabling autostats, triggers, and indexes in the target table.

- **Copying**: The data copy from the source database to the target database is in progress.

- **Copy finished**: Data copy is finished, and the service is waiting on other tables to finish copying.

- **Rebuilding indexes**: The service is rebuilding indexes on target tables.

- **Succeeded**: All data is copied and the indexes are rebuilt.

## Monitor migration using Azure CLI

You can check the status of your migration using the `az datamigration sql-db show` command:

```azurecli
# Check the status of the database migration
az datamigration sql-db show \
    --resource-group "<YourResourceGroup>" \
    --sqldb-instance-name "<YourTargetServer>" \
    --target-db-name "<YourTargetDB>" \
    --expand "MigrationStatusDetails"                   # Include detailed migration status
```

This command returns detailed information about the migration, including the current status and any errors encountered.

### Wait for migration completion

You can use the `wait` command to pause script execution until the migration completes:

```azurecli
# Wait for the migration to complete before continuing
az datamigration sql-db wait \
    --resource-group "<YourResourceGroup>" \
    --sqldb-instance-name "<YourTargetServer>" \
    --target-db-name "<YourTargetDB>" \
    --created                                           # Wait until migration is created/completed
```

### Cancel a migration

If you need to stop an in-progress migration:

```azurecli
# Cancel an in-progress migration
az datamigration sql-db cancel \
    --resource-group "<YourResourceGroup>" \
    --sqldb-instance-name "<YourTargetServer>" \
    --target-db-name "<YourTargetDB>" \
    --migration-operation-id "<YourMigrationOperationId>"  # ID from the migration operation
```

## Monitor migration from the Azure portal

You can also monitor the migration activity using Azure Database Migration Service in the Azure portal.

To monitor your database migration, go to the Azure portal and find your instance of the Database Migration Service. Once you've located the service, you can view its instance overview. Select **Monitor migrations** to access detailed information about your ongoing database migration.

:::image type="content" border="false" source="../media/3-database-migration-service-azure-portal.png" alt-text="Screenshot of the monitoring page in Azure Database Migration Services in Azure portal.":::

After the migration status is **Succeeded**, navigate to the target server, and validate the target database. Check the database schema and data.

## Performance considerations

Migration speed heavily depends on the target Azure SQL Database SKU and the self-hosted Integration Runtime host. We strongly recommend that you scale up your Azure SQL Database compute resources before initiating the migration process for an optimal migration experience.

When deciding on the server to install the self-hosted integration runtime, make sure this machine can handle the CPU and memory load of the data copy operation.

Azure SQL Database migration can be slow with a large volume of tables due to the time Azure Data Factory (ADF) takes to start activities, even for small tables.

Tables with large blob columns may fail to migrate due to timeout.

We recommend up to 10 concurrent database migrations per self-hosted integration runtime on a single computer. Scale out the self-hosted runtime or create separate instances on different computers to increase the concurrent database migrations.

## Migrate at scale using PowerShell

You can also perform an offline migration of the database from SQL Server on-premises to an Azure SQL Database by using PowerShell.

The following example migrates the *AdventureWorks* database to Azure SQL Database.

```powershell
# Set up secure credentials for source and target connections
$sourcePass = ConvertTo-SecureString "<YourSourcePassword>" -AsPlainText -Force
$targetPass = ConvertTo-SecureString "<YourTargetPassword>" -AsPlainText -Force

# Start the database migration to Azure SQL Database
New-AzDataMigrationToSqlDb `
    -ResourceGroupName "<YourResourceGroup>" `              # Name of your Azure resource group
    -SqlDbInstanceName "<YourTargetServer>" `               # Name of the target Azure SQL Database server
    -Kind "SqlDb" `
    -TargetDbName "<YourTargetDB>" `                        # Name of the target database
    -SourceDatabaseName "<YourSourceDB>" `                  # Name of the source database
    -SourceSqlConnectionAuthentication SQLAuthentication `
    -SourceSqlConnectionDataSource "<YourSourceServer>" `   # Source SQL Server hostname or IP
    -SourceSqlConnectionUserName "<YourSourceUser>" `       # Source SQL Server username
    -SourceSqlConnectionPassword $sourcePass `
    -Scope "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.Sql/servers/<YourTargetServer>" `
    -TargetSqlConnectionAuthentication SQLAuthentication `
    -TargetSqlConnectionDataSource "<YourTargetServer>.database.windows.net" `
    -TargetSqlConnectionUserName "<YourTargetUser>" `       # Target database username
    -TargetSqlConnectionPassword $targetPass `
    -MigrationService "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.DataMigration/SqlMigrationServices/<YourMigrationService>"
```

The following example migrates a subset of tables from the *AdventureWorks* database.

```powershell
# Migrate specific tables from source to target database
New-AzDataMigrationToSqlDb `
    -ResourceGroupName "<YourResourceGroup>" `
    -SqlDbInstanceName "<YourTargetServer>" `
    -Kind "SqlDb" `
    -TargetDbName "<YourTargetDB>" `
    -SourceDatabaseName "<YourSourceDB>" `
    -SourceSqlConnectionAuthentication SQLAuthentication `
    -SourceSqlConnectionDataSource "<YourSourceServer>" `
    -SourceSqlConnectionUserName "<YourSourceUser>" `
    -SourceSqlConnectionPassword $sourcePass `
    -Scope "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.Sql/servers/<YourTargetServer>" `
    -TargetSqlConnectionAuthentication SQLAuthentication `
    -TargetSqlConnectionDataSource "<YourTargetServer>.database.windows.net" `
    -TargetSqlConnectionUserName "<YourTargetUser>" `
    -TargetSqlConnectionPassword $targetPass `
    -TableList "[Person].[Person]", "[Person].[EmailAddress]" `  # Specify tables to migrate
    -MigrationService "/subscriptions/<YourSubscription>/resourceGroups/<YourResourceGroup>/providers/Microsoft.DataMigration/SqlMigrationServices/<YourMigrationService>"
```

To learn more about database migration commands, refer to the following links: [PowerShell module for data migration](/powershell/module/az.datamigration) and [Azure CLI for data migration](/cli/azure/datamigration).
