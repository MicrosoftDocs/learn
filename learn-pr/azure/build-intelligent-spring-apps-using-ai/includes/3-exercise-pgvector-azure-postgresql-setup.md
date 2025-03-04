In this exercise, we create Azure Database for PostgreSQL Flexible Server, enable `pgvector` extension, and create required database structure for use with Spring AI `VectorStore` abstraction.

## Sign in to Azure via Azure CLI

Sign in to Azure:

```azurecli
az login
```

## Set parameter values

The following values are used in subsequent commands to create the database and required resources. Server names need to be globally unique across all of Azure so the `$RANDOM` function is used to create the server name. Change the location as appropriate for your environment.

```bash
ID=$RANDOM
LOCATION="eastus2"
RESOURCE_GROUP="spring-ai-postgresql-rg"
DB_SERVER_NAME="spring-ai-postgresql-server-$ID"
```

You can limit access by specifying to the PostgreSQL server external IP appropriate IP address values for your environment. Use the public IP address of the computer you're using to restrict access to the server to only your IP address. Intialize the `start` and `end` IP values as follows:

```bash
PUBLIC_IP=$(curl -s ipinfo.io/ip)
echo "Start IP: $$PUBLIC_IP"
```

![Note]
!The IP address may change and the corresponding firewall rule needs to be updated accordingly
![Tip]
!This command should work in most Linux distributions and git bash. If it doesn't work, you can alternatively get your public IP address using [https://whatismyipaddress.com/](https://whatismyipaddress.com/)

### Create a resource group

Create a resource group with the following command. An Azure resource group is a logical container into which Azure resources are deployed and managed.

   ```azurecli
   az group create --name $RESOURCE_GROUP --location $LOCATION
   ```

### Create Azure Database for PostgreSQL Server

Use the following command to create a database instance for development purposes. The **burstable** tier is a cost-effective tier for workloads that don't require consistent performance.

   ```azurecli
   az postgres flexible-server create \
     --name $DB_SERVER_NAME \
     --resource-group $RESOURCE_GROUP \
     --location $LOCATION \
     --tier Burstable \
     --sku-name standard_b1ms \
     --active-directory-auth enabled \
     --public-access $PUBLIC_IP \
     --version 16
   ```

This command takes a few minutes to complete. Once completed, a similar output is displayed:

```json
{
"connectionString": "postgresql://<admin-user>:<admin-password>@<name>.postgres.database.azure.com/None?sslmode=require",
"databaseName": null,
"firewallName": "FirewallIPAddress_<timestamp>",
"host": "<name>.postgres.database.azure.com",
"id": "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.DBforPostgreSQL/flexibleServers/<name>",
"location": "<region>",
"password": "<admin-password>",
"resourceGroup": "<resource-group>",
"skuname": "<sku-name>",
"username": "<admin-user>",
"version": "<version>"
}
```

### Grant admin access to your Azure Entra ID

Run the following command to get the `object id` for your Entra ID:

```bash
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv | tr -d '\r')
```

Run the following command to grant admin access to your Entra ID:

```azurecli
az postgres flexible-server ad-admin create --server-name $DB_SERVER_NAME -g $RESOURCE_GROUP \
   --object-id $USER_OBJECT_ID --display-name AzureAdmin
```

### Whitelist required extensions for pgvector

Before we can enable extensions required by pgvector, we need to allow them using this `az` command:

```azurecli
az postgres flexible-server parameter set --resource-group $RESOURCE_GROUP \
   --server-name $DB_SERVER_NAME --name azure.extensions --value vector,hstore,uuid-ossp
```

## Validate connectivity to your database

Use this command to get the fully qualified host name for your database server:

```bash
export PGHOST=$(az postgres flexible-server show --resource-group $RESOURCE_GROUP \
  --name $DB_SERVER_NAME --query fullyQualifiedDomainName --output tsv)
```

Run this command to get access token for your user ID:

```bash
export PGPASSWORD="$(az account get-access-token \
  --resource https://ossrdbms-aad.database.windows.net \
  --query accessToken --output tsv)" 
```

Connect to database using `psql` client with this command:

```bash
psql "host=$PGHOST dbname=postgres user=AzureAdmin sslmode=require"
```

Example PSQL output:

```bash
psql (14.13, server 16.4)
 WARNING: psql major version 14, server major version 16.
         Some psql features might not work.
 SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
 Type "help" for help.

postgres=>
```

If the above command times out or you're having difficulty connecting from your IP, you can use the following command to create a firewall rule to allow access to a wider IP range:

   ```azurecli
   az postgres flexible-server firewall-rule create \
     --rule-name allowiprange \
     --resource-group $RESOURCE_GROUP \
     --name $DB_SERVER_NAME \
     --start-ip-address 0.0.0.0 \
     --end-ip-address 255.255.255.255
   ```

Once this rule is created, you can update using `az postgres flexible-server firewall-rule update`

## Unit Summary

We now have a vector-enabled PostgreSQL database ready with these capabilities:

1. Implements vector storage in our Spring application
2. Applies similarity search functionality
3. Enables our RAG implementation
