Azure Database for MySQL is a relational database service that's based on MySQL Community Edition. It's a fully managed database-as-a-service offering that can handle mission-critical workloads with predictable performance and dynamic scale.

## Azure Database for MySQL deployment options

To host a MySQL database in Azure, you can use either the Single Server or Flexible Server deployment option. The Flexible Server option provides:

- Better control of your database servers and cost optimization.
- The ability to develop applications by customizing the MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows to control the timing of patches and upgrades.
- Configuration parameters for tuning.

> [!NOTE]
> The Single Server option is scheduled for retirement by September 16, 2024.

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
         --location $MYSQL_LOCATION \
         --resource-group $MYSQL_RES_GRP_NAME \
         --name $MYSQL_SERVER_NAME \
         --admin-user $MYSQL_USER \
         --admin-password $MYSQL_PASSWORD \
         --sku-name Standard_B1ms \
         --public-access $PUBLIC_IP \
         --storage-size 32 \
         --version 5.7
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

## Unit summary

You've been shown the basic commands to create an Azure Database for MySQL. In the next unit, you'll perform the steps to actually create and configure the database for use in your Jakarta EE application.
