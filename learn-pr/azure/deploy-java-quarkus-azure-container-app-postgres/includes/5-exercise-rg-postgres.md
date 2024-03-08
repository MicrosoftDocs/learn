In this unit, you create an Azure resource group that contains the resources for the application. You then set up the PostgreSQL database by using the Azure CLI. Finally, you configure the Quarkus application to access the remote PostgreSQL database. Use a terminal of your choice to run the commands.

## Prepare the working environment

You need to set up some environment variables. Here are some notes about the variables you'll create:

| Variable | Description |
|-|-|
| `AZ_PROJECT` | The name of the project. To keep this value unique, we recommend that you use `AZ_PROJECT_<your initials>`. |
| `AZ_RESOURCE_GROUP` | The name of the resource group that holds the resources. |
| `AZ_LOCATION` | The Azure region. We recommend that you use a region that's close to where you live. To see the list of available regions, enter `az account list-locations` at a command prompt. |
| `AZ_CONTAINERAPP` | The name of the Azure Container Apps instance that holds the containers. |
| `AZ_CONTAINERAPP_ENV` | The name of the Azure Container Apps environment. |
| `AZ_POSTGRES_SERVER_NAME` | The name of your PostgreSQL server. Nonalphanumeric characters aren't allowed: -, _, !, $, #, %. The name should be unique across Azure. Be sure to use a unique identifier. |
| `AZ_POSTGRES_DB_NAME` | The PostgreSQL database name. The default name of the PostgreSQL database is `postgres`. |
| `AZ_POSTGRES_USERNAME` | The default admin user name for your PostgreSQL database server. |
| `AZ_POSTGRES_PASSWORD` | The default password for your PostgreSQL database server. Use a secure password. |

> [!NOTE]
> You can name your Azure resources in any way that you want, but we recommend that you review [Abbreviation examples for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations). This article provides example abbreviations for many Azure resources (for example, `rg` for resource groups and `ca` for container apps).

Use the following commands to set up the variables. Be sure to modify the values as described in the preceding table.

```bash
export AZ_PROJECT_<your initials>="azure-deploy-quarkus"
export AZ_RESOURCE_GROUP="rg${AZ_PROJECT_<your initials>}"
export AZ_LOCATION="eastus"
export AZ_CONTAINERAPP="ca${AZ_PROJECT_<your initials>}"
export AZ_CONTAINERAPP_ENV="cae${AZ_PROJECT_<your initials>}"
export AZ_POSTGRES_DB_NAME="postgres${AZ_PROJECT_<your initials>}"
export AZ_POSTGRES_USERNAME="<user-name>"
export AZ_POSTGRES_PASSWORD="<secure-password>"
export AZ_POSTGRES_SERVER_NAME="psql${AZ_PROJECT_<your initials>}"
```

These environment variables are used throughout the rest of this module.

Next, create a resource group:

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION
```

## Create an instance of Azure Database for PostgreSQL

You'll now create a managed PostgreSQL server. Run the following command to create a small instance of Azure Database for PostgreSQL:

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
    --storage-size 32 \
    --version "16"
```

This command creates a small PostgreSQL server that uses the variables that you set up earlier.

## Configure Quarkus to access the PostgreSQL database

You'll now connect the Quarkus application to the PostgreSQL database. To do so, you first need to obtain the connection string for the database:

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

Note the connection string that's returned.

## Configure the Quarkus application to connect to the PostgreSQL database

Update the `application.properties` file in the `src/main/resources` folder of the project to configure the connection string to the PostgreSQL database. To do so, set the `quarkus.datasource.jdbc.url` property to the previously output `$POSTGRES_CONNECTION_STRING_SSL` value. The `&ssl=true&sslmode=require` part of the connection string forces the driver to use SSL, a requirement for Azure Database for PostgreSQL.

```properties
quarkus.hibernate-orm.database.generation=update
quarkus.datasource.jdbc.url=<the POSTGRES_CONNECTION_STRING_SSL value>
```

## Run the Quarkus application locally to test the remote database connection

Use this command to run the application locally: 

```shell
./mvnw clean quarkus:dev    # On Mac or Linux
mvnw.cmd clean quarkus:dev  # On Windows
```

When Quarkus is running, create a few to-dos by using the following cURL commands in a separate terminal window:

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

Next, check that the to-dos are in the database by accessing the GET endpoint that's defined in the to-do app:

```bash
curl http://127.0.0.1:8080/api/todos
```

You should see the following output:

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

If you see this output, you have successfully run the Quarkus application and connected to the remote PostgreSQL database.
