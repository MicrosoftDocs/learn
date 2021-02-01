In this unit, you'll look at how to create an Azure Database for MySql.

## Deploy Azure Database for MySQL

`Azure Database for MySQL` is a relational database service powered by MySQL community edition. It's a fully managed `database-as-a-service` offering that can handle mission-critical workloads with predictable performance and dynamic scale.

You can use either Single Server or Flexible Server (Preview) to host a MySQL database in Azure.

### Azure Database for MySQL Flexible Server

A flexible server provides better control of your database servers, more options for high availability, and cost optimization.

Flexible Server offers control through maintenance windows and configuration parameters for tuning. It allows for zone redundant high availability and controls the timing for patches and upgrades.

Flexible servers are best suited for:

* Application development requiring better control and customizations of MySQL engine.
* Zone redundant high availability
* Managed maintenance windows

### How to create Azure Database for MySQL Flexible Server

To create a MySQL on Azure Flexible server, first create a `Resource Group` then create a flexible `Azure Database for MySQL` instance in the resource group. Finally to access the MySQL instance, you configure a Firewall Rule.
In the below steps, we'll outline the commands to create a Flexible server and in the next unit, we'll create one.

#### Sign in to Azure

Step 1 - Sign in to Azure with following command:

```azurecli
az login
```

#### Create a resource group

Step 2 - Create an Azure Resource Group with following command:

```azurecli
az group create --name $MYSQL_RES_GRP_NAME --location $MYSQL_LOCATION
```

#### Create a MySQL DB instance

Step 3 - Create an Azure Database for MySQL Flexible Server with following command:

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

#### Create a firewall rule

Step 4 - Create a Firewall Rule to MySQL Flexible Server with following command:

```azurecli
az mysql flexible-server firewall-rule create \
      -g $MYSQL_RES_GRP_NAME \
      -n $MYSQL_SERVER_NAME \
      -r AllowAllAzureIPs \
      --start-ip-address 0.0.0.0 \
      --end-ip-address 255.255.255.255
```
