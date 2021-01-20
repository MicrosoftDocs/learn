In this exercise, you'll migrate a PostgreSQL database to Azure. You'll migrate an existing PostgreSQL database running on a virtual machine to Azure Database for PostgreSQL.

You work as a database developer for the AdventureWorks organization. AdventureWorks has been selling bicycles and bicycle parts directly to end-consumer and distributors for over a decade. Their systems store information in a database that currently runs using PostgreSQL on an Azure VM. As part of a hardware rationalization exercise, AdventureWorks want to move the database to an Azure managed database. You have been asked to perform this migration.

### Setup the environment

Run these Azure CLI commands in the Cloud Shell to create a virtual machine, running PostgreSQL, with a copy of the adventureworks database. The last commands will print the IP address of the new virtual machine.

```azurecli
az vm create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name postgresqlvm \
    --admin-username azureuser \
    --admin-password Pa55w.rdDemo \
    --image UbuntuLTS \
    --public-ip-address-allocation static \
    --public-ip-sku Standard \
    --vnet-name postgresqlvnet \
    --nsg ""

az vm run-command invoke \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name postgresqlvm \
    --command-id RunShellScript \
    --scripts "
# Install PostgreSQL
sudo echo deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main > /etc/apt/sources.list.d/pgdg.list
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install postgresql-10
# Clone exercise code
sudo git clone https://github.com/MicrosoftLearning/DP-070-Migrate-Open-Source-Workloads-to-Azure.git /home/azureuser/workshop    
# Configure PostgreSQL
sudo service postgresql stop
sudo bash << EOF
    printf \"listen_addresses = '*'\nwal_level = logical\nmax_replication_slots = 5\nmax_wal_senders = 10\n\" >> /etc/postgresql/10/main/postgresql.conf
    printf \"host    all             all             0.0.0.0/0               md5\n\" >> /etc/postgresql/10/main/pg_hba.conf
EOF
sudo service postgresql start

# Add the azureuser role and adventure works
sudo bash << EOF
su postgres << EOC
printf \"create role azureuser with login;alter role azureuser createdb;alter role azureuser password 'Pa55w.rd';alter role azureuser superuser;create database adventureworks;grant all privileges on database adventureworks to azureuser; \" | psql
EOC
EOF

PGPASSWORD=Pa55w.rd psql -h localhost -U azureuser adventureworks -E -q -f /home/azureuser/workshop/migration_samples/setup/postgresql/adventureworks/adventureworks.sql
"

az vm open-port \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name postgresqlvm \
    --priority 200 \
    --port '22'

az vm open-port \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name postgresqlvm \
    --priority 300 \
    --port '5432'

echo Setup Complete

SQLIP="$(az vm list-ip-addresses \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name postgresqlvm \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"

echo $SQLIP
```

These commands will take approximately 5 minutes to complete. You don't need to wait, you can continue with the steps below.

## Create the Azure Database for PostgreSQL server

1. Using a web browser, open a new tab and navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Select **+ Create a resource**.
1. In the **Search the Marketplace** box, type **Azure Database for PostgreSQL**, and press enter.
1. On the **Azure Database for PostgreSQL** page, select **Create**.
1. On the **Select Azure Database for PostgreSQL deployment option** page, in the **Single server** box, select **Create**.
1. On the **Single server** page, enter the following details, and then select **Review + create**:

    | Property  | Value  |
    |---|---|
    | Resource group | **<rgn>[sandbox resource group name]</rgn>** |
    | Server name | **adventureworks*nnn***, where *nnn* is a suffix of your choice to make the server name unique |
    | Data source | **None** |
    | Location | Select your nearest location |
    | Version | **10** |
    | Compute + storage | Select **Configure server**, select the **Basic** pricing tier, and then select **OK** |
    | Admin username | **awadmin** |
    | Password | **Pa55w.rdDemo** |
    | Confirm password | **Pa55w.rdDemo** |

1. On the **Review + create** page, select **Create**. Wait for the service to be created before continuing.
1. When the service has been created, select **Go to resource**.
1. Select **Connection security**.
1. On the **Connection security page**, set **Allow access to Azure services** to **Yes**.
1. In the list of firewall rules, add a rule named **VM**, and set the **START IP ADDRESS** and **END IP ADDRESS** to the IP address of the virtual machine running the PostgreSQL server you created earlier.
1. Select **Add current client IP address**, to enable your client machine to connect to the database.
1. **Save**, and wait for the firewall rules to be updated.
1. At the Cloud Shell prompt, run the following command to create a new database in your Azure Database for PostgreSQL service. Replace *[nnn]* with the suffix you used when you created the Azure Database for PostgreSQL service. Replace *[resource group]* with the name of the resource group you specified for the service:

    ```bash
    az postgres db create \
      --name azureadventureworks \
      --server-name adventureworks[nnn] \
      --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    If the database is created successfully, you should see a message similar to the following:

    ```text
    {
      "charset": "UTF8",
      "collation": "English_United States.1252",
      "id": "/subscriptions/nnnnnnnnnnnnnnnnnnnnnn/resourceGroups/nnnnnnnn/providers/Microsoft.DBforPostgreSQL/servers/adventureworksnnn/databases/azureadventureworks",
      "name": "azureadventureworks",
      "resourceGroup": "<rgn>[sandbox resource group name]</rgn>",
      "type": "Microsoft.DBforPostgreSQL/servers/databases"
    }
    ```

### Export the schema to use on the target database

You'll now connect to your existing PostgreSQL VM using the Cloud Shell to export your database schema.

1. Run this Azure CLI command to see the IP address for your existing VM.

    ```bash
    SQLIP="$(az vm list-ip-addresses \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name postgresqlvm \
        --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
        --output tsv)"

    echo $SQLIP
    ```

1. Connect to your old database server using SSH. Enter **Pa55w.rdDemo** for the password.

    ```bash
    ssh azureuser@$SQLIP
    ```

1. Run the following command to connect to the database on the virtual machine. The password for the **azureuser** user in the PostgreSQL server running on the virtual machine is **Pa55w.rd**:

    ```bash
    psql adventureworks
    ```

1. Grant replication permission to azureuser:

    ```SQL
    ALTER ROLE azureuser REPLICATION;
    ```

1. Close the **psql** utility with the **\q** command.

1. At the bash prompt, run the following command to export the schema for the **adventureworks** database to a file named **adventureworks_schema.sql**

    ```bash
    pg_dump -o  -d adventureworks -s > adventureworks_schema.sql
    ```

### Import the schema into the target database

1. Run the following command to connect to the azureadventureworks[nnn] server. Replace the two instances of *[nnn]* with the suffix for your service. Note that the username has the *@adventureworks[nnn]* suffix. At the password prompt, enter **Pa55w.rdDemo**.

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U awadmin@adventureworks[nnn] -d postgres
    ```

1. Run the following commands to create a user named **azureuser** and set the password for this user to **Pa55w.rd**. The third statement gives the **azureuser** user the necessary privileges to create and manage objects in the **azureadventureworks** database. The **azure_pg_admin** role enables the **azureuser** user to install and use extensions in the database.

    ```SQL
    CREATE ROLE azureuser WITH LOGIN;
    ALTER ROLE azureuser PASSWORD 'Pa55w.rd';
    GRANT ALL PRIVILEGES ON DATABASE azureadventureworks TO azureuser;
    GRANT azure_pg_admin TO azureuser;
    ```

1. Close the **psql** utility with the **\q** command.
1. Import the schema for the **adventureworks** database to the **azureadventureworks** database running on your Azure Database for PostgreSQL service. You are performing the import as **azureuser**, so enter the password **Pa55w.rd** when prompted.

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks -E -q -f adventureworks_schema.sql
    ```

    You will see a series of messages as each item is created. The script should complete without any errors.

1. Run the following command. The **findkeys.sql** script generates another SQL script named **dropkeys.sql** that will remove all the foreign keys from the tables in the **azureadventureworks** database. You will run the **dropkeys.sql** script shortly:

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks -f workshop/migration_samples/setup/postgresql/adventureworks/findkeys.sql -o dropkeys.sql -t
    ```

1. Run the following command. The **createkeys.sql** script generates another SQL script named **addkeys.sql** that will recreate all the foreign keys. You will run the **addkeys.sql** script after you have migrated the database:

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks -f workshop/migration_samples/setup/postgresql/adventureworks/createkeys.sql -o addkeys.sql -t
    ```

1. Run the *dropkeys.sql* script:

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks -f dropkeys.sql
    ```

    You will see a series **ALTER TABLE** messages displayed, as the foreign keys are dropped.

1. Stat the psql utility again and connect to the **azureadventureworks** database.

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks
    ```

1. Run the following query to find the details of any remaining foreign keys:

    ```SQL
    SELECT constraint_type, table_schema, table_name, constraint_name
    FROM information_schema.table_constraints
    WHERE constraint_type = 'FOREIGN KEY';
    ```

    This query should return an empty result set. However, if any foreign keys still exist, for each foreign key, run the following command:

    ```SQL
    ALTER TABLE [table_schema].[table_name] DROP CONSTRAINT [constraint_name];
    ```

1. After you have removed any remaining foreign keys, execute the following SQL statement to display the triggers in the database:

    ```bash
    SELECT trigger_name
    FROM information_schema.triggers;
    ```

    This query should also return an empty result set, indicating that the database contains no triggers. If the database did contain triggers, you would have to disable them before migrating the data, and re-enable them afterwards.

1. Close the *psql* utility with the **\q** command.

## Perform an online migration using the Database Migration Service

1. Switch back to the Azure portal.
1. Select **All services**, select **Subscriptions**, and then select your subscription.
1. On your subscription page, under **Settings**, select **Resource providers**.
1. In the **Filter by name** box, type **DataMigration**, and then select **Microsoft.DataMigration**.
1. If the **Microsoft.DataMigration** isn't registered, select **Register**, and wait for the **Status** to change to **Registered**. It might be necessary to select **Refresh** to see the status change.
1. Select **Create a resource**, in the **Search the Marketplace** box type **Azure Database Migration Service**, and then press Enter.
1. On the **Azure Database Migration Service** page, select **Create**.
1. On the **Create Migration Service** page, enter the following details, and then select **Next: Networking\>\>**.

    | Property  | Value  |
    |---|---|
    | Select a resource group | **<rgn>[sandbox resource group name]</rgn>** |
    | Service name | **adventureworks_migration_service** |
    | Location | Select your nearest location |
    | Service mode | **Azure** |
    | Pricing tier | **Premium, with 4 vCores** |

1. On the **Networking** page, select the **postgresqlvnet/posgresqlvmSubnet** virtual network. This network was created as part of the setup.
1. Select **Review + create** and then select **Create**. Wait while the Database Migration Service is created. This will take a few minutes.
1. When the service has been created, select **Go to resource**.
1. Select **New Migration Project**.
1. On the **New migration project** page, enter the following details, and then select **Create and run activity**.

    | Property  | Value  |
    |---|---|
    | Project name | **adventureworks_migration_project** |
    | Source server type | **PostgreSQL** |
    | Target Database for PostgreSQL | **Azure Database for PostgreSQL** |
    | Choose type of activity | **Online data migration** |

1. When the **Migration Wizard** starts, on the **Select source** page, enter the following details, and then select **Next: Select target\>\>**.

    | Property  | Value  |
    |---|---|
    | Source server name | nn.nn.nn.nn *(The IP address of the Azure virtual machine running PostgreSQL)* |
    | Server port | **5432** |
    | Database | **adventureworks** |
    | User Name | **azureuser** |
    | Password | **Pa55w.rd** |
    | Trust server certificate | **Selected** |
    | Encrypt connection | **Selected** |

1. On the **Select target** page, enter the following details, and then select **Next: Select databases\>\>**.

    | Property  | Value  |
    |---|---|
    | Azure PostgreSQL | **adventureworks[nnn]** |
    | Database | **azureadventureworks** |
    | User Name | **azureuser@adventureworks[nnn]** |
    | Password | **Pa55w.rd** |

1. on the **Select databases** page, select the **adventureworks** database and map it to **azureadventureworks**. Deselect the **postgres** database. Select **Next: Select tables\>\>**.
1. On the **Select tables** page, select **Next: Configure migration settings\>\>**.
1. On the **Configure migration settings** page, expand the **adventureworks** dropdown, expand the **Advanced online migration settings dropdown**, verify that **Maximum number of instances to load in parallel** is set to 5, and then select **Next: Summary\>\>**.
1. On the **Summary** page, in the **Activity name** box type **AdventureWorks_Migration_Activity**, and then select **Start migration**.
1. On the **AdventureWorks_Migration_Activity** page, select **Refresh** at 15 second intervals. You will see the status of the migration operation as it progresses. Wait until the **MIGRATION DETAILS** column changes to **Ready to cutover**.
1. Switch back to the Cloud Shell.
1. Run the following command to recreate the foreign keys in the **azureadventureworks** database. You generated the **addkeys.sql** script earlier:

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks -f addkeys.sql
    ```

    You will see a series of **ALTER TABLE** statements as the foreign keys are added. You may see an error concerning the *SpecialOfferProduct* table, which you can ignore for now. This is due to a UNIQUE constraint that doesn't get transferred correctly. In the real world, you should retrieve the details of this constraint from the source database using the following query:

    ```SQL
    SELECT constraint_type, table_schema, table_name, constraint_name
    FROM information_schema.table_constraints
    WHERE constraint_type = 'UNIQUE';
    ```

    You could then manually reinstate this constraint in the target database in Azure Database for PostgreSQL.

    There should be no other errors.

## Modify data, and cut over to the new database

1. Return to the **AdventureWorks_Migration_Activity** page in the Azure portal.
1. Select the **adventureworks** database.
1. On the **adventureworks** page, verify that the **Full load completed** value is **66** and that all other values are **0**.
1. Switch back to the Cloud Shell.
1. Run the following command to connect to the **adventureworks** database running using PostgreSQL on the virtual machine:

    ```bash
    psql adventureworks
    ```

1. Execute the following SQL statements to display, and then remove orders 43659, 43660, and 43661 from the database. Note that the database implements a cascading delete on the **salesorderheader** table, which automatically deletes the corresponding rows from the **salesorderdetail** table.

    ```SQL
    SELECT * FROM sales.salesorderheader WHERE salesorderid IN (43659, 43660, 43661);
    SELECT * FROM sales.salesorderdetail WHERE salesorderid IN (43659, 43660, 43661);
    DELETE FROM sales.salesorderheader WHERE salesorderid IN (43659, 43660, 43661);
    ```

1. Close the **psql** utility with the **\q** command.
1. Return to the **adventureworks** page in the Azure portal, and select **Refresh**. Verify that 32 changes have been applied.
1. Select **Start Cutover**.
1. On the **Complete cutover** page, select **Confirm**, and then select **Apply**. Wait until the status changes to **Completed**.
1. Return to the Cloud Shell.
1. Run the following command to connect to the **azureadventureworks** database running using your Azure Database for PostgreSQL service:

    ```bash
    psql -h adventureworks[nnn].postgres.database.azure.com -U azureuser@adventureworks[nnn] -d azureadventureworks
    ```

    The password is **Pa55w.rd**.

1. Execute the following SQL statements to display the orders and order details in the database. Quit after the first page of each table. The purpose of these queries is to show that the data has been transferred:

    ```SQL
    SELECT * FROM sales.salesorderheader;
    SELECT * FROM sales.salesorderdetail;
    ```

1. Run the following SQL statements to display the orders and details for orders 43659, 43660, and 43661.

    ```SQL
    SELECT * FROM sales.salesorderheader WHERE salesorderid IN (43659, 43660, 43661);
    SELECT * FROM sales.salesorderdetail WHERE salesorderid IN (43659, 43660, 43661);
    ```

    Both queries should return 0 rows.

1. Close the *psql* utility with the **\q** command.
