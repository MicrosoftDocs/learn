In this unit, you'll create a basic Quarkus application. You'll use the Azure CLI and an integrated development environment (IDE) of your choice to edit the code. Use a terminal of your choice to run the code.

## Prepare the working environment

Set up some environment variables by using the following commands:

```bash
AZ_RESOURCE_GROUP=azure-spring-workshop
AZ_DATABASE_NAME=<YOUR_DATABASE_NAME>
AZ_LOCATION=<YOUR_AZURE_REGION>
AZ_POSTGRES_USERNAME=spring
AZ_POSTGRES_PASSWORD=<YOUR_MYSQL_PASSWORD>
AZ_LOCAL_IP_ADDRESS=<YOUR_LOCAL_IP_ADDRESS>
```

In your code, replace the placeholders with the values in the following table. These values are used throughout this module.

| Variable | Description |
|-|-|
| <YOUR_DATABASE_NAME> | The name of your PostgreSQL server. It should be unique across Azure. |
| <YOUR_AZURE_REGION> | The Azure region you'll use. You can use `eastus` by default, but we recommend that you use a region close to where you live. To see the full list of available regions, enter `az account list-locations` |
| <YOUR_POSTGRES_PASSWORD> | The password of your PostgreSQL database server. The password should have a minimum of eight characters. The characters should be from three of the following categories: English uppercase letters, English lowercase letters, numbers 0 through 9, and nonalphanumeric characters (!, $, #, %, and so on). |
| <YOUR_LOCAL_IP_ADDRESS> | The IP address of the local computer from which you'll run your Quarkus application. To find the IP address, point your browser to [whatismyip.akamai.com](http://whatismyip.akamai.com/?azure-portal=true). |

Next, create a resource group:

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION \
    | jq
```

> [!NOTE]
> This module uses the `jq` tool, which is installed by default on [Azure Cloud Shell](https://shell.azure.com/) to display JSON data and make it more readable.
>
> If you don't want to use the `jq` tool, you can safely remove the `| jq` part of all commands in this module.

## Create an instance of Azure Database for PostgreSQL

Now you'll create a managed PostgreSQL server.

> [!NOTE]
> To learn more about Azure Database for PostgreSQL, at the end of this module, follow the link to the relevant documentation.

Run the following script to create a small instance of Azure Database for PostgreSQL. The database has 1 CPU and 2 GB of RAM.

```bash
az mysql server create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_NAME \
    --location $AZ_LOCATION \
    --sku-name B_Gen5_1 \
    --storage-size 5120 \
    --admin-user $AZ_POSTGRES_USERNAME \
    --admin-password $AZ_POSTGRES_PASSWORD \
    | jq
```

This script creates a small PostgreSQL server that uses the variables you set up earlier.

### Configure a firewall rule for your PostgreSQL server

Azure Database for PostgreSQL is secured by default. Its firewall allows no incoming connections. So add a firewall rule to allow the local IP address to access the database server.

Run the following command to open the server's firewall:

```bash
az mysql server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_NAME-database-allow-local-ip \
    --server-name $AZ_DATABASE_NAME \
    --start-ip-address $AZ_LOCAL_IP_ADDRESS \
    --end-ip-address $AZ_LOCAL_IP_ADDRESS \
    | jq
```

Run the following command to allow firewall access from Azure resources:

```bash
az mysql server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name allAzureIPs \
    --server-name $AZ_DATABASE_NAME \
    --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0 \
    | jq
```

### Configure a PostgreSQL database

The PostgreSQL server that you created earlier is empty. It has no database that you can use with the Quarkus application. Create a new database called `demo`:

```bash
az mysql db create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name demo \
    --server-name $AZ_DATABASE_NAME \
    | jq
```

