In this unit, you'll create the Azure Container Apps environment and set up the PostgreSQL database using the Azure CLI. Use a terminal of your choice to run the commands.

## Prepare the working environment

Set up some environment variables by using the following commands:

```bash
AZ_PROJECT="azure-deploy-quarkus"
AZ_RESOURCE_GROUP="rg-${AZ_PROJECT}"
AZ_LOCATION="eastus"
AZ_CONTAINERAPP="ca-${AZ_PROJECT}"
AZ_CONTAINERAPP_ENV="cae-${AZ_PROJECT}"
AZ_POSTGRES_SERVER_NAME="psql<unique-identifier>"
AZ_POSTGRES_DB_NAME="postgres"
AZ_POSTGRES_USERNAME=<YOUR_POSTGRES_USERNAME>
AZ_POSTGRES_PASSWORD=<YOUR_POSTGRES_PASSWORD>
AZ_LOCAL_IP_ADDRESS=<YOUR_LOCAL_IP_ADDRESS>
```

> [!NOTE]
> You can name your Azure resources the way you want, but we recommend to check [this documentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) that gives you abbreviation for many of the resources in Azure (eg. `rg` for resource group, `ca` for Azure Container Apps, etc.). 


AZ_POSTGRES_SERVER_NAME="psqlazuredeployquarkus"
AZ_POSTGRES_USERNAME=username
AZ_POSTGRES_PASSWORD=password


In your code, replace the placeholders with the values in the following table. These values are used throughout this module.

| Variable | Description |
|-|-|
| `AZ_PROJECT` | The name of the project. |
| `AZ_RESOURCE_GROUP` | The name of the group holding all the other resources. |
| `AZ_LOCATION` | The Azure region you'll use. We recommend that you use a region close to where you live. To see the full list of available regions, enter `az account list-locations` |
| `AZ_CONTAINERAPP` | The name of the Azure Container Apps holding all the containers |
| `AZ_CONTAINERAPP_ENV` | The name of the Azure Container Apps environement |
| `AZ_POSTGRES_SERVER_NAME` | The name of your PostgreSQL server (nonalphanumeric characters are not allowed (-, _, !, $, #, %, etc.)). It should be unique across Azure. |
| `AZ_POSTGRES_DB_NAME` | The name of the default PostgreSQL database is `postgres`. |
| <YOUR_POSTGRES_USERNAME> | The username of your PostgreSQL database server. The username should have a minimum of eight characters. The characters should be from three of the following categories: English uppercase letters, English lowercase letters, numbers 0 through 9, and nonalphanumeric characters (!, $, #, %, and so on). |
| <YOUR_POSTGRES_PASSWORD> | The password of your PostgreSQL database server. The password should have a minimum of eight characters. The characters should be from three of the following categories: English uppercase letters, English lowercase letters, numbers 0 through 9, and nonalphanumeric characters (!, $, #, %, and so on). |

Next, create a resource group:

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION
```

## Create an instance of Azure Database for PostgreSQL

Now you'll create a managed PostgreSQL server. Run the following script to create a small instance of Azure Database for PostgreSQL.

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

This script creates a small PostgreSQL server that uses the variables you set up earlier.

## Configure Quarkus to access the PostgreSQL database

Now let's connect the Quarkus application to the PostgreSQL database. To do this, you'll first need to know the connection String of the database. For that, execute the following command:

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

need to update the `application.properties` file in the `src/main/resources` folder of the project.

You need to append `ssl=true&sslmode=require` to the end of each connect string to force the driver to use ssl. This is required for Azure Database for PostgreSQL.

```properties
%prod.quarkus.hibernate-orm.database.generation=update
%prod.quarkus.datasource.jdbc.url=<the value of the POSTGRES_CONNECTION_STRING appended with ssl=true&sslmode=require>
```

## Execute the Quarkus application locally to test the remote database connection

./mvnv clean package -Dmaven.test.skip=true

java -jar target/quarkus-app/quarkus-run.jar

```shell
__  ____  __  _____   ___  __ ____  ______ 
 --/ __ \/ / / / _ | / _ \/ //_/ / / / __/ 
 -/ /_/ / /_/ / __ |/ , _/ ,< / /_/ /\ \   
--\___\_\____/_/ |_/_/|_/_/|_|\____/___/   
[io.quarkus] (main) todo 1.0.0-SNAPSHOT on JVM (powered by Quarkus 2.14.3.Final) started in 2.369s. Listening on: http://0.0.0.0:8080
[io.quarkus] (main) Profile prod activated. 
[io.quarkus] (main) Installed features: [agroal, cdi, hibernate-orm, hibernate-orm-panache, jdbc-postgresql, narayana-jta, resteasy, resteasy-jackson, smallrye-context-propagation, vertx]
```

Create a few Todos with the following `cURL` commands:


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

Now check that the Todos are in the database with the following Azure CLI command:

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
Description                         Details                                                         Done
----------------------------------  --------------------------------------------------------------  ------
Take Quarkus MS Learn               Take the MS Learn on deploying Quarkus to Azure Container Apps  True
Take Azure Container Apps MS Learn  Take the ACA Learn module                                       False
```

If you have the following output, then you have successfully compiled the Quarkus application in production mode and connected to the remote PostgreSQL database.