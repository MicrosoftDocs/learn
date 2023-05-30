In this unit, you create the Azure Resource Group that contains all our resources, and set up the PostgreSQL database using the Azure CLI.
Then, you configure the Quarkus application to access the remote PostgreSQL database. Use a terminal of your choice to run the commands.

## Prepare the working environment

We need to set up some environment variables:

```bash
export AZ_PROJECT="azure-deploy-quarkus"
export AZ_RESOURCE_GROUP="rg-${AZ_PROJECT}"
export AZ_LOCATION="eastus"
export AZ_CONTAINERAPP="ca-${AZ_PROJECT}"
export AZ_CONTAINERAPP_ENV="cae-${AZ_PROJECT}"
export AZ_POSTGRES_DB_NAME="postgres-${AZ_PROJECT}"
export AZ_POSTGRES_USERNAME="postgres"
export AZ_POSTGRES_PASSWORD="postgres"
export AZ_POSTGRES_SERVER_NAME="psql-${AZ_PROJECT}"
```

> [!NOTE]
> You can name your Azure resources the way you want, but we recommend [this documentation](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) that gives you abbreviations for many Azure resources (for example, `rg` for Resource Groups or `ca` for Azure Container Apps).

Make sure to replace the placeholders when needed. These environment variables are used throughout this module.

| Variable | Description |
|-|-|
| `AZ_PROJECT` | The name of the project. To keep this value unique, we suggest using *AZ_PROJECT_\[*your initials*\]*. |
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
    --public-access "All" \
    --tier "Burstable" \
    --sku-name "Standard_B1ms" \
    --storage-size 256 \
    --version "14"
```

This command creates a small PostgreSQL server that uses the variables you set up earlier.

## Configure Quarkus to access the PostgreSQL database

Now let's connect the Quarkus application to the PostgreSQL database. To do so, you first need to obtain the connection string for the database:

```bash
export POSTGRES_CONNECTION_STRING=$(
    az postgres flexible-server show-connection-string \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --query "connectionStrings.jdbc" \
    --output tsv
)

export POSTGRES_CONNECTION_STRING_SSL="$POSTGRES_CONNECTION_STRING&ssl=true&sslmode=require"

echo "POSTGRES_CONNECTION_STRING_SSL=$POSTGRES_CONNECTION_STRING_SSL"
```

## Configure the Quarkus application to connect to the PostgreSQL database

Update the `application.properties` file in the `src/main/resources` folder of the project to configure the connection string to the PostgreSQL database. To do so, set the `quarkus.datasource.jdbc.url` property with the value of `$POSTGRES_CONNECTION_STRING_SSL` output previously. The `&ssl=true&sslmode=require` portion of the connection string forces the driver to use SSL, a requirement for Azure Database for PostgreSQL.

```properties
quarkus.hibernate-orm.database.generation=update
quarkus.datasource.jdbc.url=<the value of the POSTGRES_CONNECTION_STRING_SSL>
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

Now check that the to-dos are in the database by accessing the GET endpoint defined in the to-do app:

```bash
curl http://127.0.0.1:8080/api/todos
```

You should have the following output:

```json
[
   {
      "description" : "Take Quarkus MS Learn",
      "details" : "Take the MS Learn on deploying Quarkus to Azure Container Apps",
      "done" : true,
      "id" : 1
   },
   {
      "description" : "Take Azure Container Apps MS Learn",
      "details" : "Take the ACA Learn module",
      "done" : false,
      "id" : 2
   }
]
```

If you have the following output, you have successfully executed the Quarkus application and connected to the remote PostgreSQL database.
