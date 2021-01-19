In this unit, you'll create and configure an Azure Database for MySql.

## Deploy Azure Database for MySQL

`Azure Database for MySQL` is a relational database service powered by the MySQL community edition. It's a fully managed database as a service offering that can handle mission-critical workloads with predictable performance and dynamic scale.

You can use either Single Server or Flexible Server (Preview) to host a MySQL database in Azure.

### Azure Database for MySQL Flexible Server

A flexible server provides better control of database servers, more options for high availability, and cost optimization controls.

Flexible Server offers control through maintenance windows and configuration parameters for tuning. It allows for zone redundant high availability and controls the timing for patches and upgrades.

Flexible servers are best suited for:

* Application development requiring better control and customizations of MySQL engine.
* Zone redundant high availability
* Managed maintenance windows

### How to create Azure Database for MySQL Flexible Server

To create a MySQL on Azure, at first, you must sign in to Azure. Then you create a `Resource Group` for creating the MySQL Resource. After creating the resource group, you can create a `Azure Database for MySQL` instance in the resource group. Finally to access to the MySQL instance, you need configure a Firewall Rule for it.

#### Sign in to Azure

You can sign in to Azure with following command.

```azurecli
az login
```

#### Create a Resource Group

You can create Azure Resource Group with following command.

```azurecli
az group create --name $MYSQL_RES_GRP_NAME --location $MYSQL_LOCATION
```

#### Create a MySQL DB Instance

You can create Azure Database for MySQL Flexible Server with following command.

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

#### Create a firewall Rule

You can create Firewall Rule to MySQL Flexible Server with following command.

```azurecli
az mysql flexible-server firewall-rule create \
      -g $MYSQL_RES_GRP_NAME \
      -n $MYSQL_SERVER_NAME \
      -r AllowAllAzureIPs \
      --start-ip-address 0.0.0.0 \
      --end-ip-address 255.255.255.255
```
