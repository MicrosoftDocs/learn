Azure Database for MySQL is a relational database service that's based on MySQL Community Edition. It's a fully managed database-as-a-service offering that can handle mission-critical workloads with predictable performance and dynamic scale.

## Azure Database for MySQL deployment options

To host a MySQL database in Azure, you can use Flexible Server deployment option. The Flexible Server option provides:

- Better control of your database servers and cost optimization.
- The ability to develop applications by customizing the MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows to control the timing of patches and upgrades.
- Configuration parameters for tuning.

## Commands for deploying a Flexible Server instance

The steps in this unit illustrate deploying a Flexible Server instance. You'll actually execute these steps in the next unit.

To deploy a Flexible Server instance of Azure Database for MySQL, you first create a resource group. You then create the instance in the resource group. Finally, to access the instance, you configure a firewall rule.

The following steps outline the commands for those tasks:

1. Sign in to Azure:

   ```azurecli
   az login
   ```

1. Create an Azure resource group.

   `MYSQL_RES_GRP_NAME` must be unique within your subscription. `MYSQL_LOCATION` must be one of the values returned in the `Name` column when you run the command `az account list-locations --output table`.

   ```azurecli
   az group create --name $MYSQL_RES_GRP_NAME --location $MYSQL_LOCATION
   ```

1. Create a Flexible Server instance of Azure Database for MySQL.

   `MYSQL_SERVER_NAME` must be unique within the resource group. The name can contain only lowercase letters, numbers, and the hyphen (-) character. The name must be minimum three characters and maximum 63 characters. For simplicity, you can just use the value of `MYSQL_RES_GRP_NAME`. `MYSQL_PASSWORD` is the password of the administrator. The password must have a minimum eight characters and maximum 128 characters. The password must contain characters from three of the following categories: English uppercase letters, English lowercase letters, numbers, and non-alphanumeric characters. `PUBLIC_IP` is the public IP address of the host name from which you want to allow connections outside of Azure. This is used for testing of the database from your local host.

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

1. Create a firewall rule:

   ```azurecli
   az mysql flexible-server firewall-rule create \
         -g $MYSQL_RES_GRP_NAME \
         -n $MYSQL_SERVER_NAME \
         -r AllowAllAzureIPs \
         --start-ip-address 0.0.0.0 \
         --end-ip-address 255.255.255.255
   ```

## Connect and test the connection by using the Azure CLI

Since MySQL 8.0, the user authentication method has changed to caching_sha2_password, making mysql_native_password authentication unavailable.

Instead, you can use Azure Database for MySQL - Flexible Server to connect to your flexible server by using the `az mysql flexible-server connect` command in the Azure CLI. You can use this command to test connectivity to your database server, create a quick basic database, and run queries directly against your server without installing mysql.exe or MySQL Workbench. You can also use the command in interactive mode to run multiple queries at a time.

1. Create a DB:

```azurecli
az mysql flexible-server db create -d $newdatabase --charset utf8mb4 --collation utf8mb4_unicode_ci
```

1. Connect to the server with Interactive mode:

```azurecli
az mysql flexible-server connect -u $MYSQL_USER -p $MYSQL_PASSWORD -n $MYSQL_SERVER_NAME -g $MYSQL_RES_GRP_NAME -d $newdatabase --interactive
```

1. Run a query from the Azure CLI:

```azurecli
az mysql flexible-server execute -u $MYSQL_USER -p $MYSQL_PASSWORD -n $MYSQL_SERVER_NAME -g $MYSQL_RES_GRP_NAME -d $newdatabase --querytext "select * from table1;"

az mysql flexible-server execute -n <server-name> -u <username> -p "<password>" -d <database-name> --file-path "./test.sql"
```

## Unit summary

You've been shown the basic commands to create an Azure Database for MySQL. In the next unit, you'll perform the steps to actually create and configure the database for use in your Jakarta EE application.
