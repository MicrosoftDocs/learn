In this exercise, you'll migrate a MySQL database to Azure. You'll migrate an existing MySQL database running on a virtual machine to Azure Database for MySQL.

You work as a database developer for the AdventureWorks organization. AdventureWorks has been selling bicycles and bicycle parts directly to end-consumer and distributors for over a decade. Their systems store information in a database that currently runs using MySQL on an Azure VM. As part of a hardware rationalization exercise, AdventureWorks want to move the database to an Azure managed database. You have been asked to perform this migration.

> [!IMPORTANT]
> Azure Data Migration Service isn't supported in the free Azure sandbox environment. You can perform these steps in your own personal subscription, or just follow along to understand how to migrate your database.

### Setup the environment

Run these Azure CLI commands in the Cloud Shell to create a virtual machine, running MySQL, with a copy of the Adventure works database. The last commands will print the IP address of the new virtual machine.

```azurecli
az account list-locations -o table

az group create \
    --name migrate-mysql \
    --location <CHOOSE A LOCATION FROM ABOVE NEAR YOU>

az vm create \
    --resource-group migrate-mysql \
    --name mysqlvm \
    --admin-username azureuser \
    --admin-password Pa55w.rdDemo \
    --image "Canonical:UbuntuServer:18.04-LTS:latest" \
    --public-ip-address-allocation static \
    --public-ip-sku Standard \
    --size Standard_B2ms 

az vm open-port \
    --resource-group migrate-mysql \
    --name mysqlvm \
    --priority 200 \
    --port '22'

az vm open-port \
    --resource-group migrate-mysql \
    --name mysqlvm \
    --priority 300 \
    --port '3306'

az vm run-command invoke \
    --resource-group migrate-mysql \
    --name mysqlvm \
    --command-id RunShellScript \
    --scripts "
    # MySQL installation
    sudo apt-get update && sudo apt-get upgrade -y
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

    # Disable Ubuntu Firewall bind mysql
    sudo ufw disable
    sudo bash << EOF
        echo "bind-address=0.0.0.0" >> /etc/mysql/mysql.conf.d/mysqld.cnf
        echo "log-bin" >> /etc/mysql/mysql.conf.d/mysqld.cnf
        echo "server-id=99" >> /etc/mysql/mysql.conf.d/mysqld.cnf
    EOF
    sudo service mysql stop
    sudo service mysql start 

    # Clone exercise code
    sudo git clone https://github.com/MicrosoftLearning/DP-070-Migrate-Open-Source-Workloads-to-Azure.git /home/azureuser/workshop
 
    # Add a password to mysql root user
    sudo mysqladmin -u root password Pa55w.rd
    # Use mysql to create users and an empty adventureworks 
    sudo mysql -u root -pPa55w.rd -e \"CREATE USER azureuser IDENTIFIED BY 'Pa55w.rd';GRANT ALL PRIVILEGES ON *.* TO azureuser;CREATE DATABASE adventureworks;\"
    # Use mysql to import the adventureworks database
    sudo mysql --user=azureuser --password=Pa55w.rd --database=adventureworks < /home/azureuser/workshop/migration_samples/setup/mysql/adventureworks/adventureworks.sql
    sudo service mysql restart"
    
MYSQLIP="$(az vm list-ip-addresses \
    --resource-group migrate-mysql \
    --name mysqlvm \
    --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    --output tsv)"

echo $MYSQLIP
```

These commands will take approximately 5 minutes to complete. You don't need to wait, you can continue with the steps below.

### Create the Azure database for MySQL server and database

The first phase of the project needs you create an Azure database for MySQL to host your companies new database.

1. Using a web browser, open a new tab and navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Select **+ Create a resource**.
1. In the **Search the Marketplace** box, type **Azure Database for MySQL**, and press enter.
1. On the **Azure Database for MySQL** page, select **Create**.
1. On the **Select Azure Database for MySQL deployment option** page, under **Single server** select **Create**.
1. On the **Create MySQL server** page, enter the following details, and then select **Review + create**:

    | Property  | Value  |
    |---|---|
    | Resource group | migrate-mysql |
    | Server name | **adventureworks*nnn***, where *nnn* is a suffix of your choice to make the server name unique |
    | Data source | **None** |
    | Location | Select your nearest location |
    | Version | **5.7** |
    | Compute + storage | Select **Configure server**, select the **Basic** pricing tier, and then select **OK** |
    | Admin username | **awadmin** |
    | Password | **Pa55w.rdDemo** |
    | Confirm password | **Pa55w.rdDemo** |

1. On the **Review + create** page, select **Create**. Wait for the service to be created before continuing.
1. When the service has been created, select **Go to resource**.
1. Select **Connection security**.
1. On the **Connection security page**, set **Allow access to Azure services** to **Yes**.
1. In the list of firewall rules, add a rule named **VM**, and set the **START IP ADDRESS** and **END IP ADDRESS** to the IP address of the virtual machine running the MySQL server. It is the IP address listed as the last line in the Cloud Shell.
1. Select **Add current client IP address**, to also enable your client machine to access the database.
1. **Save**, and wait for the firewall rules to be updated.
1. At the Cloud Shell prompt, run the following command to create a new database in your Azure Database for MySQL service. Replace *[nnn]* with the suffix you used when you created the Azure Database for MySQL service. Replace *[resource group]* with the name of the resource group you specified for the service:

    ```bash
    az MySQL db create \
    --name azureadventureworks \
    --server-name adventureworks[nnn] \
    --resource-group migrate-mysql
    ```

    If the database is created successfully, you should see a message similar to the following:

    ```json
    {
          "charset": "latin1",
          "collation": "latin1_swedish_ci",
          "id": "/subscriptions/nnnnnnnnnnnnnnnnnnnnnnnnnnnnn/resourceGroups/nnnnnn/providers/Microsoft.DBforMySQL/servers/adventureworksnnnn/databases/azureadventureworks",
          "name": "azureadventureworks",
          "resourceGroup": migrate-mysql,
          "type": "Microsoft.DBforMySQL/servers/databases"
    }
    ```

### Export the schema to use on the target database

You'll now connect to your existing MySQL VM using the Cloud Shell to export your database schema.

1. Run this Azure CLI command to see the IP address for your existing VM.

    ```bash
    MYSQLIP="$(az vm list-ip-addresses \
        --resource-group migrate-mysql \
        --name mysqlvm \
        --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
        --output tsv)"

    echo $MYSQLIP
    ```

1. Connect to your old database server using SSH. Enter **Pa55w.rdDemo** for the password.

    ```bash
    ssh azureuser@$MYSQLIP
    ```

1. Export the schema for the source database using the mysqldump utility:

    ```bash
    mysqldump -u azureuser -pPa55w.rd adventureworks --no-data > adventureworks_mysql_schema.sql
    ```

### Import the schema into the target database

1. In the Cloud Shell, run the following command to connect to the azureadventureworks[nnn] server. Replace the two instances of *[nnn]* with the suffix for your service. Note that the username has the *@adventureworks[nnn]* suffix. At the password prompt, enter **Pa55w.rdDemo**.

    ```bash
    mysql -h adventureworks[nnn].MySQL.database.azure.com -u awadmin@adventureworks[nnn] -pPa55w.rdDemo
    ```

1. Run the following commands to create a user named **azureuser** and set the password for this user to **Pa55w.rd**. The second statement gives the **azureuser** user the necessary privileges to create objects in the **azureadventureworks** database.

    ```SQL
    GRANT SELECT ON *.* TO 'azureuser'@'localhost' IDENTIFIED BY 'Pa55w.rd';
    GRANT CREATE ON *.* TO 'azureuser'@'localhost';
    ```

1. Run the following commands to create an **adventureworks** database.

    ```SQL
    CREATE DATABASE adventureworks;
    ```

1. Close the mysql utility with the **quit** command.
1. Import the **adventureworks** schema to your Azure Database for MySQL service. You are performing the import as **azureuser**, so enter the password **Pa55w.rd** when prompted.

    ```bash
    mysql -h adventureworks[nnnn].MySQL.database.azure.com -u awadmin@adventureworks[nnn] -pPa55w.rdDemo adventureworks < adventureworks_mysql_schema.sql
    ```

### Perform an online migration using the Database Migration Service

1. Switch back to the Azure portal.
1. Click **All services**, click **Subscriptions**, and then click your subscription.
1. On your subscription page, under **Settings**, click **Resource providers**.
1. In the **Filter by name** box, type **DataMigration**, and then click **Microsoft.DataMigration**.
1. If the **Microsoft.DataMigration** isn't registered, click **Register**, and wait for the **Status** to change to **Registered**. It might be necessary to click **Refresh** to see the status change.
1. Select **Create a resource**, in the **Search the Marketplace** box type **Azure Database Migration Service**, and then press Enter.
1. On the **Azure Database Migration Service** page, select **Create**.
1. On the **Create Migration Service** page, enter the following details, and then select **Next: Networking \>\>**.

    | Property  | Value  |
    |---|---|
    | Select a resource group | migrate-mysql |
    | Migration service name | **adventureworks_migration_service** |
    | Location | Select your nearest location |
    | Service mode | **Azure** |
    | Pricing tier | **Premium, with 4 vCores** |

1. On the **Networking** page, select the **MySQLvnet/mysqlvmSubnet** virtual network. This network was created as part of the setup.
1. Select **Review + create** and then select **Create**. Wait while the Database Migration Service is created. This will take a few minutes.
1. In the Azure portal, go to the page for your Database Migration Service.
1. Select **New Migration Project**.
1. On the **New migration project** page, enter the following details, and then select **Create and run activity**.

    | Property  | Value  |
    |---|---|
    | Project name | **adventureworks_migration_project** |
    | Source server type | **MySQL** |
    | Target Database for MySQL | **Azure Database for MySQL** |
    | Choose type of activity | **Online data migration** |

1. When the **Migration Wizard** starts, on the **Select source** page, enter the following details.

    | Property  | Value  |
    |---|---|
    | Source server name | nn.nn.nn.nn *(The IP address of the Azure virtual machine running MySQL)* |
    | Server port | 3306 |
    | User Name | azureuser |
    | Password | Pa55w.rd |

1. Select **Next: Select target\>\>**.

1. On the **Select target** page, enter the following details.

    | Property  | Value  |
    |---|---|
    | Target server name | adventureworks[nnn].MySQL.database.azure.com |
    | User Name | awadmin@adventureworks[nnn] |
    | Password | Pa55w.rdDemo |

1. Select **Next: Select databases\>\>**.

1. On the **Select databases** page, ensure that both the **Source Database** and the **Target Database** are set to **adventureworks** and then select **Next: Configure migration settings**.
1. On the **Configure migration settings** page, select **Next: Summary\>\>**.
1. On the **Migration summary** page, in the **Activity name** box type **AdventureWorks_Migration_Activity**, and then select **Start migration**.
1. On the **AdventureWorks_Migration_Activity** page, select **Refresh** at 15 second intervals. You will see the status of the migration operation as it progresses.
1. Wait until the **MIGRATION DETAILS** column changes to **Ready to cutover**.

### Modify data, and cutover to the new database

1. Return to the **AdventureWorks_Migration_Activity** page in the Azure portal.
1. Select the **adventureworks** database.
1. On the **adventureworks** page, verify that the status for all tables is marked as **COMPLETED**.
1. Select **Incremental data sync**. Verify that the status for every table is marked as **Syncing**.
1. Switch back to the Cloud Shell.
1. Run the following command to connect to the **adventureworks** database running using MySQL on the virtual machine:

    ```bash
    mysql -pPa55w.rd adventureworks
    ```

1. Execute the following SQL statements to display, and then remove orders 43659, 43660, and 43661 from the database. Note that the database implements a cascading delete on the **salesorderheader** table, which automatically deletes the corresponding rows from the **salesorderdetail** table.

    ```SQL
    SELECT * FROM salesorderheader WHERE salesorderid IN (43659, 43660, 43661);
    SELECT * FROM salesorderdetail WHERE salesorderid IN (43659, 43660, 43661);
    DELETE FROM salesorderheader WHERE salesorderid IN (43659, 43660, 43661);
    ```

1. Close the *mysql* utility with the **quit** command.
1. Return to the **adventureworks** page in the Azure portal, and then select **Refresh**. Scroll to the page for the **salesorderheader** and **salesorderdetail** tables. Verify that the **salesorderheader** table indicates that 3 rows have been deleted, and 29 rows have been removed from the **sales.salesorderdetail** table. If there are no updates applied, check that there are **Pending changes** for the database.
1. Select **Start cutover**.
1. On the **Complete cutover** page, select **Confirm**, and then select **Apply**. Wait until the status changes to **Completed**.
1. Return to the Cloud Shell.
1. Run the following command to connect to the **azureadventureworks** database running using your Azure Database for MySQL service:

    ```bash
    mysql -h adventureworks[nnn].MySQL.database.azure.com -u awadmin@adventureworks[nnn] -pPa55w.rdDemo adventureworks
    ```

1. Run the following SQL statements to display the orders and details for orders 43659, 43660, and 43661. The purpose of these queries is to show that the data has been transferred:

    ```SQL
    SELECT * FROM salesorderheader WHERE salesorderid IN (43659, 43660, 43661);
    SELECT * FROM salesorderdetail WHERE salesorderid IN (43659, 43660, 43661);
    ```

    The first query should return 3 rows. The second query should return 29 rows.

1. Close the *mysql* utility with the **quit** command.

### Clean up the resources you've created

> [!IMPORTANT]
> If you've performed these steps in your own personal subscription, you can delete the resources individually or delete the resource group to delete the entire set of resources. Resources left running can cost you money.

1. Using the Cloud Shell run this command to delete the resource group:

```azurecli
az group delete --name migrate-mysql
```
