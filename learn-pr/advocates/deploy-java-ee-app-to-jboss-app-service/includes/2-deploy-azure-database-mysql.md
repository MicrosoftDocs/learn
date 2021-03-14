Azure Database for MySQL is a relational database service that's based on MySQL Community Edition. It's a fully managed database-as-a-service offering that can handle mission-critical workloads with predictable performance and dynamic scale.

## Azure Database for MySQL deployment options

To host a MySQL database in Azure, you can use either the Single Server or Flexible Server (Preview) deployment option. The Flexible Server option provides:

- Better control of your database servers and cost optimization.
- The ability to develop applications by customizing the MySQL engine.
- Zone-redundant high availability.
- Managed maintenance windows to control the timing of patches and upgrades.
- Configuration parameters for tuning.

## Commands for deploying a Flexible Server instance

To deploy a Flexible Server instance of Azure Database for MySQL, you first create a resource group. You then create the instance in the resource group. Finally, to access the instance, you configure a firewall rule.

The following steps outline the commands for those tasks:

1. Sign in to Azure:

   ```azurecli
   az login
   ```

1. Create an Azure resource group:

   ```azurecli
   az group create --name $MYSQL_RES_GRP_NAME --location $MYSQL_LOCATION
   ```

1. Create a Flexible Server instance of Azure Database for MySQL:

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
