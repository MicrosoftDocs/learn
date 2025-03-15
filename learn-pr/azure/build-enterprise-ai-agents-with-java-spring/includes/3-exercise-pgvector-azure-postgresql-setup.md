In this exercise, you create an Azure Database for PostgreSQL flexible server instance, enable the `pgvector` extension, and create the required database structure for use with the Spring AI `VectorStore` abstraction.

## Sign in to Azure via the Azure CLI

Use the following command to sign in to Azure:

```azurecli
az login
```

## Set parameter values

Use the following commands to set some environment variables. These values are passed to subsequent commands to create the database and required resources. Be sure to replace the `<...>` placeholders with your own values. The `<server-name>` value must be globally unique across all of Azure. An easy way to ensure uniqueness is to use a combination of your initials, today's date, and some identifier - for example, **abc-031325-spring-ai-postgresql-server**.

```bash
export RESOURCE_GROUP=<resource-group>
export LOCATION=<location>
export DB_SERVER_NAME=<server-name>
```

Next, use the following command to store your public IP address in an environment variable and display it in the console. You use this value later in this unit to limit access to the PostgreSQL server external IP address. By using the public IP address of the computer you're using, only your IP address can access the server.

```bash
export PUBLIC_IP=$(curl -s ipinfo.io/ip)
echo "Start IP: $PUBLIC_IP"
```

This command should work in most Linux distributions and in Git Bash. If it doesn't work, you can alternatively get your public IP address by using [https://whatismyipaddress.com/](https://whatismyipaddress.com/)

> [!NOTE]
> Your IP address can change. If it changes, you must update the corresponding firewall rule accordingly.

### Create a resource group

Create a resource group by using the following command. An Azure resource group is a logical container into which Azure resources are deployed and managed.

```azurecli
az group create --name $RESOURCE_GROUP --location $LOCATION
```

### Create an Azure Database for PostgreSQL flexible server instance

Use the following command to create a database instance for development purposes. The *burstable* tier is a cost-effective tier for workloads that don't require consistent performance.

```azurecli
az postgres flexible-server create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --location $LOCATION \
    --tier Burstable \
    --sku-name standard_b1ms \
    --active-directory-auth enabled \
    --public-access $PUBLIC_IP \
    --version 16
```

This command takes a few minutes to complete. After it completes, it displays output similar to the following example:

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

For testing purposes only, use the following command to create a firewall rule to allow access to a wider IP range:

```azurecli
az postgres flexible-server firewall-rule create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --rule-name allowiprange \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 255.255.255.255
```

### Grant admin access to your Entra ID

Use the following command to get the `object id` for your Entra ID:

```azurecli
export USER_OBJECT_ID=$(az ad signed-in-user show \
    --query id \
    --output tsv \
    | tr -d '\r')
```

Use the following command to grant admin access to your Entra ID:

```azurecli
az postgres flexible-server ad-admin create \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --object-id $USER_OBJECT_ID \
    --display-name azureuser
```

### Allow the required extensions for pgvector

Before you can enable the extensions required by `pgvector`, you need to allow them by using the following command:

```azurecli
az postgres flexible-server parameter set \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --name azure.extensions \
    --value vector,hstore,uuid-ossp
```

## Validate connectivity to your database

Use the following command to get the fully qualified host name for your database server:

```azurecli
export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')
```

Use the following command to get an access token for your user ID:

```azurecli
export PGPASSWORD="$(az account get-access-token \
    --resource https://ossrdbms-aad.database.windows.net \
    --query accessToken \
    --output tsv)"
```

Use the following command to connect to the database:

```bash
psql "host=$PGHOST dbname=postgres user=azureuser sslmode=require"
```

The following output is typical:

```output
psql (14.13, server 16.4)
 WARNING: psql major version 14, server major version 16.
         Some psql features might not work.
 SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
 Type "help" for help.

postgres=>
```

After this rule is created, you can update it by using `az postgres flexible-server firewall-rule update`.

## Unit summary

You now have a vector-enabled PostgreSQL database ready that provides vector similarity search capabilities.
