Azure Database for MySQL is a relational database service powered by the MySQL community edition. It's a fully managed database-as-a-service (DBaaS) offering that can handle mission-critical workloads with predictable performance and dynamic scalability.

## Azure Database for MySQL deployment options

To host a MySQL database in Azure, you can use the Flexible Server deployment option. The Flexible Server option provides the following capabilities:

- Better control of your database servers and cost optimization.
- The ability to develop applications by customizing the MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows to control the timing of patches and upgrades.
- Configuration parameters for tuning.

## Commands for deploying a server instance

This unit describes the steps to deploy an Azure Database for MySQL - Flexible Server instance. You actually execute similar steps in the next unit, including running a script that performs some steps for you.

To deploy an Azure Database for MySQL - Flexible Server instance, you first create a resource group. You then create the server instance in the resource group. Finally, to access the instance, you configure a firewall rule.

The following steps outline the commands for those tasks:

1. To sign in to the Azure CLI, you use the following command:

    ```azurecli
    az login
    ```

1. To create an Azure resource group, you use the following command:

    ```azurecli
    az group create \
        --name <resource-group-name> \
        --location <location>
    ```

    The following list describes the values you use for the `<...>` placeholders:

    - `<resource-group-name>` must be unique within your subscription.
    - `<location>` must be one of the values returned in the `Name` column when you use the command `az account list-locations --output table`.

1. To create an Azure Database for MySQL - Flexible Server instance, use the following command:

    ```azurecli
    az mysql flexible-server create \
        --resource-group <resource-group-name> \
        --name <MySQL-server-name> \
        --admin-user <MySQL-user> \
        --admin-password <MySQL-password> \
        --sku-name Standard_B1ms \
        --tier Burstable \
        --public-access <public-IP> \
        --storage-size 32 \
        --storage-auto-grow Enabled \
        --iops 500 \
        --version 8.0.21
    ```

    The following list describes the values you use for the `<...>` placeholders, in addition to the values previously described:

    - `<MySQL-server-name>` must be unique within the resource group. The name can contain only lowercase letters, numbers, and the hyphen (-) character. The name must be between 3 and 63 characters long, inclusively, and if it's convenient, you can just use the same value you use for `<resource-group-name>`.
    - `<MySQL-password>` is the password of the administrator. The password must be between 8 and 128 characters long, inclusively, and it must contain characters from three of the following categories: English uppercase letters, English lowercase letters, numbers, and non-alphanumeric characters.
    - `<public-IP>` is the public IP address of the host name from which you want to allow connections outside of Azure, which is used for testing the database from your local host.

1. To create a firewall rule, use the following command with the same placeholder values from the previous commands:

    ```azurecli
    az mysql flexible-server firewall-rule create \
        --resource-group <resource-group-name> \
        --name <MySQL-server-name> \
        --rule-name AllowAllAzureIPs \
        --start-ip-address 0.0.0.0 \
        --end-ip-address 255.255.255.255
    ```

## Connect and test the connection by using the Azure CLI

Since MySQL 8.0, the user authentication method changed to `caching_sha2_password`, making `mysql_native_password` authentication unavailable. As an alternative, you can use the `az mysql flexible-server connect` command in the Azure CLI to test connectivity to your database server, quickly create a basic database, and run queries directly against your server without installing **mysql.exe** or MySQL Workbench. You can also use the command in interactive mode to run multiple queries at a time.

Use the following commands to create a database, connect to the server, and run a query, using the same placeholder values from the previous commands and the new `<database-name>` value to name the database.

1. To create a database, use the following command:

    ```azurecli
    az mysql flexible-server db create \
        --resource-group <resource-group-name> \
        --server-name <MySQL-server-name> \
        --database-name <database-name> \
        --charset utf8mb4 \
        --collation utf8mb4_unicode_ci
    ```

1. To connect to the server with interactive mode, use the following command:

    ```azurecli
    az mysql flexible-server connect \
        --name <MySQL-server-name> \
        --admin-user <MySQL-user> \
        --admin-password <MySQL-password> \
        --database-name <database-name> \
        --interactive
    ```

1. To run a query, use the following command:

    ```azurecli
    az mysql flexible-server execute \
        --name <MySQL-server-name> \
        --admin-user <MySQL-user> \
        --admin-password <MySQL-password> \
        --database-name <database-name> \
        --querytext "select * from table1;"
    ```

    You can alternatively put the query into a file and use the following command to run the query:

    ```azurecli
    az mysql flexible-server execute \
        --name <MySQL-server-name> \
        --admin-user <MySQL-user> \
        --admin-password <MySQL-password> \
        --database-name <database-name> \
        --file-path "./test.sql"
    ```

## Unit summary

You learned the commands to create an Azure Database for MySQL - Flexible Server instance. In the next unit, you create and configure the database for use in your Jakarta EE application.
