Azure Database for MySQL is a relational database service powered by the MySQL community edition. You can use Azure Database for MySQL to host a MySQL database in Azure. It's a fully managed Database as a Service (DBaaS) offering that can handle mission-critical workloads with predictable performance and dynamic scalability.

## Azure Database for MySQL deployment options

To host a MySQL database in Azure, you can use Azure Database for MySQL - Flexible Server. This option provides the following capabilities:

- Better control of your database servers, and cost optimization.
- Application development by customizing the MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows to control the timing of patches and upgrades.
- Configuration parameters for tuning.

## Commands for deploying a server instance

The steps in this unit illustrate deploying an Azure Database for MySQL - Flexible Server instance. You execute these steps in the next unit. Use the following steps to create a resource group, create a server instance in the group, and configure a firewall rule in the instance:

1. Sign in to the Azure CLI by using the following command:

    ```azurecli
    az login
    ```

1. Create an Azure resource group by using the following command:

    > [!IMPORTANT]
    > `MYSQL_RES_GRP_NAME` must be unique within your subscription. `MYSQL_LOCATION` must be one of the values returned in the `Name` column when you run the command `az account list-locations --output table`.

    ```azurecli
    az group create \
        --name $MYSQL_RES_GRP_NAME \
        --location $MYSQL_LOCATION
    ```

1. Create an Azure Database for MySQL - Flexible Server instance by using the following command:

    > [!IMPORTANT]
    > `MYSQL_SERVER_NAME` must be unique within the resource group. The name can contain only lowercase letters, numbers, and the hyphen (-) character. The name must be between three and 63 characters long, inclusively, and if it's convenient, you can just use the value of `MYSQL_RES_GRP_NAME`. `MYSQL_PASSWORD` is the password of the administrator. The password must be between eight and 128 characters long, inclusively, and it must contain characters from three of the following categories: English uppercase letters, English lowercase letters, numbers, and non-alphanumeric characters. `PUBLIC_IP` is the public IP address of the host name from which you want to allow connections outside of Azure, which is used for testing the database from your local host.

    ```azurecli
    az mysql flexible-server create \
        --resource-group $MYSQL_RES_GRP_NAME \
        --name $MYSQL_SERVER_NAME \
        --admin-user $MYSQL_USER \
        --admin-password $MYSQL_PASSWORD \
        --sku-name Standard_B1ms \
        --tier Burstable \
        --public-access $PUBLIC_IP  \
        --storage-size 32 \
        --storage-auto-grow Enabled \
        --iops 500 \
        --version 8.0.21
    ```

1. Create a firewall rule by using the following command:

    ```azurecli
    az mysql flexible-server firewall-rule create \
        --resource-group $MYSQL_RES_GRP_NAME \
        --name $MYSQL_SERVER_NAME \
        --rule-name AllowAllAzureIPs \
        --start-ip-address 0.0.0.0 \
        --end-ip-address 255.255.255.255
    ```

## Connect and test the connection by using the Azure CLI

Since MySQL 8.0, the user authentication method changed to `caching_sha2_password`, making `mysql_native_password` authentication unavailable. As an alternative, you can use the `az mysql flexible-server connect` command in the Azure CLI to test connectivity to your database server, quickly create a basic database, and run queries directly against your server without installing **mysql.exe** or MySQL Workbench. You can also use the command in interactive mode to run multiple queries at a time.

Use the following steps to create a database, connect to the server, and run a query:

1. Use the following command to create a database:

    ```azurecli
    az mysql flexible-server db create \
            --resource-group  $MYSQL_RES_GRP_NAME \
            --server-name $MYSQL_SERVER_NAME \
            --database-name $newdatabase \
            --charset utf8mb4 \
            --collation utf8mb4_unicode_ci
    ```

1. Connect to the server with interactive mode by using the following command:

    ```azurecli
    az mysql flexible-server connect \
        --name $MYSQL_SERVER_NAME \
        --admin-user $MYSQL_USER \
        --admin-password $MYSQL_PASSWORD \
        --database-name $newdatabase \
        --interactive
    ```

1. Use the following command to run a query:

    ```azurecli
    az mysql flexible-server execute \
        --name $MYSQL_SERVER_NAME \
        --admin-user $MYSQL_USER \
        --admin-password $MYSQL_PASSWORD \
        --database-name $newdatabase \
        --querytext "select * from table1;"
    az mysql flexible-server execute \
        --name <server-name> \
        --admin-user <username> \
        --admin-password "<password>" \
        --database-name <database-name> \
        --file-path "./test.sql"
    ```

## Unit summary

You learned the commands to create an Azure Database for MySQL - Flexible Server instance. In the next unit, you create and configure the database for use in your Jakarta EE application.
