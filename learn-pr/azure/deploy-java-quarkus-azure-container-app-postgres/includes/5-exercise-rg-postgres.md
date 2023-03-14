In this unit, you create the Azure Resource Group that contains all our resources, and set up the PostgreSQL database using the Azure CLI.
Then, you configure the Quarkus application to access the remote PostgreSQL database. Use a terminal of your choice to run the commands.

## Prepare the working environment

We need to set up some environment variables:

```bash
AZ_PROJECT="azure-deploy-quarkus"
AZ_RESOURCE_GROUP="rg-${AZ_PROJECT}"
AZ_LOCATION="eastus"
AZ_CONTAINERAPP="ca-${AZ_PROJECT}"
AZ_CONTAINERAPP_ENV="cae-${AZ_PROJECT}"
AZ_POSTGRES_DB_NAME="postgres"
AZ_POSTGRES_USERNAME="postgres"
AZ_POSTGRES_PASSWORD="postgres"
AZ_POSTGRES_SERVER_NAME="psql<unique-identifier>"
```

> [!NOTE]
> You can name your Azure resources the way you want, but we recommend to check [this documentation](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) that gives you abbreviations for many Azure resources (for example, `rg` for Resource Groups or `ca` for Azure Container Apps).

Make sure to replace the placeholders when needed. These environment variables are used throughout this module.

| Variable | Description |
|-|-|
| `AZ_PROJECT` | The name of the project |
| `AZ_RESOURCE_GROUP` | The name of the group holding all the other resources |
| `AZ_LOCATION` | The Azure region you use. We recommend that you use a region close to where you live. To see the full list of available regions, enter `az account list-locations` |
| `AZ_CONTAINERAPP` | The name of the Azure Container Apps holding all the containers |
| `AZ_CONTAINERAPP_ENV` | The name of the Azure Container Apps environment |
| `AZ_POSTGRES_SERVER_NAME` | The name of your PostgreSQL server (nonalphanumeric characters aren't allowed (-, _, !, $, #, %)). It **should be unique across Azure make sure to use a unique-identifier** |
| `AZ_POSTGRES_DB_NAME` | The name of the default PostgreSQL database is `postgres` |
| `AZ_POSTGRES_USERNAME` | The default username of your PostgreSQL database server |
| `AZ_POSTGRES_PASSWORD` | The default password of your PostgreSQL database server |

Next, create a resource group:

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION
```

## Create an instance of Azure Database for PostgreSQL

Now you create a managed PostgreSQL server. Run the following command to create a small instance of Azure Database for PostgreSQL.

```bash
az postgres flexible-server create \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --location "$AZ_LOCATION" \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --public all \
    --tier "Burstable" \
    --sku-name "Standard_B1ms" \
    --storage-size 256 \
    --version "14"
```

This command creates a small PostgreSQL server that uses the variables you set up earlier.

## Configure Quarkus to access the PostgreSQL database

Now let's connect the Quarkus application to the PostgreSQL database. To do this, you first need to know the connection String of the database. For that, execute the following command:

```bash
POSTGRES_CONNECTION_STRING=$(
az postgres flexible-server show-connection-string \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --query "connectionStrings.jdbc" \
    --output tsv
)

echo "POSTGRES_CONNECTION_STRING=$POSTGRES_CONNECTION_STRING"
```

## Configure the Quarkus application to connect to the PostgreSQL database

Update the `application.properties` file in the `src/main/resources` folder of the project to configure the connection String to the PostgreSQL database. For that, set the `quarkus.datasource.jdbc.url` property with the value of the `$POSTGRES_CONNECTION_STRING` and append `&ssl=true&sslmode=require` to the end of the connection string to force the driver to use ssl. This is required for Azure Database for PostgreSQL.

```properties
quarkus.hibernate-orm.database.generation=update
quarkus.datasource.jdbc.url=<the value of the POSTGRES_CONNECTION_STRING appended with>&ssl=true&sslmode=require
```

## Execute the Quarkus application locally to test the remote database connection

```shell
./mvnw clean quarkus:dev
```

Once Quarkus is up and running, create a few to-dos with the following `cURL` commands in a separate terminal window:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done": "true"}' \
    http://127.0.0.1:8080/api/todos

curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Take Azure Container Apps MS Learn","details":"Take the ACA Learn module","done": "false"}' \
    http://127.0.0.1:8080/api/todos
```

Now check that the to-dos are in the database with the following Azure CLI command:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

You should have the following output:

```bash
Createdat                   Description                         Details                                                         Done
--------------------------  ----------------------------------  --------------------------------------------------------------  ------
2022-12-30T16:50:56.182820  Take Quarkus MS Learn               Take the MS Learn on deploying Quarkus to Azure Container Apps  True
2022-12-30T16:51:08.789207  Take Azure Container Apps MS Learn  Take the ACA Learn module                                       False
```

If you have the following output, then you've successfully executed the Quarkus application and connected to the remote PostgreSQL database.
