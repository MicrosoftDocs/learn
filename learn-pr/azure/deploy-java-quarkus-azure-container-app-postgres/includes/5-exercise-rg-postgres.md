In this unit, you create an Azure resource group that contains the resources for the application. You then set up the PostgreSQL database by using the Azure CLI. Finally, you configure the Quarkus application to access the remote PostgreSQL database. Run the commands in the local Bash environment configured in the prerequisites. On Windows, use your configured WSL 2 distribution.

## Prepare the working environment

Return to the Bash shell you used for the earlier Maven commands, in the generated `todo` project directory. If Quarkus development mode is still running, press **Ctrl+C** before continuing. Use this shell for the following exports and keep it open through application startup, packaging, and deployment.

Use Azure CLI 2.87.0 or later. You need permission to create the resource group and resources and [register their resource providers](/azure/azure-resource-manager/management/resource-providers-and-types), such as Contributor or Owner at subscription scope. Subscription policy and quota can impose additional restrictions.

Sign in to Azure in this local Bash environment by using the [interactive Azure CLI sign-in flow](/cli/azure/authenticate-azure-cli-interactively), including any required multifactor authentication. Replace `<subscription-id>` with your intended subscription ID, then select and display that subscription:

```bash
az login
az account set --subscription "<subscription-id>"
az account show --query "{name:name,id:id}" --output table
```

Confirm that the displayed subscription is the one you intend to use before creating chargeable resources. Signing in to Cloud Shell doesn't sign in a separate local CLI. Complete each Azure command successfully before continuing.

You need to set up some environment variables. Here are some notes about the variables you'll create:

| Variable | Description |
|-|-|
| `AZ_PROJECT` | A short, lowercase project value with a uniqueness suffix. Keep the variable name unchanged; the suffix belongs in its value. |
| `AZ_RESOURCE_GROUP` | The name of the resource group that holds the resources. |
| `AZ_LOCATION` | The Azure region. We recommend that you use a region that's close to where you live. To see the list of available regions, enter `az account list-locations` at a command prompt. |
| `AZ_CONTAINERAPP` | The name of the Azure Container Apps instance that holds the containers. |
| `AZ_CONTAINERAPP_ENV` | The name of the Azure Container Apps environment. |
| `AZ_POSTGRES_SERVER_NAME` | The globally unique name of the PostgreSQL flexible server. Use 3-63 characters consisting of lowercase letters, numbers, and hyphens. The generated `psql${AZ_PROJECT}` value follows these rules; choose a different suffix if that name is unavailable. |
| `AZ_POSTGRES_DB_NAME` | The application database name. You create this database explicitly after creating the server. |
| `AZ_POSTGRES_USERNAME` | The administrator user name for your PostgreSQL database server. |
| `AZ_POSTGRES_PASSWORD` | The administrator password for your PostgreSQL database server. Enter a secure password at the silent prompt. |

> [!NOTE]
> You can name your Azure resources in any way that you want, but we recommend that you review [Abbreviation examples for Azure resources](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations). This article provides example abbreviations for many Azure resources (for example, `rg` for resource groups and `ca` for container apps).

Run the following block once to set up the variables. Select a region appropriate for your subscription and enter a password that meets the [PostgreSQL service requirements](/cli/azure/postgres/flexible-server). The password prompt doesn't display what you type.

```bash
export AZ_PROJECT="quarkus-${RANDOM}${RANDOM}"
export AZ_RESOURCE_GROUP="rg${AZ_PROJECT}"
export AZ_LOCATION="eastus"
export AZ_CONTAINERAPP="ca${AZ_PROJECT}"
export AZ_CONTAINERAPP_ENV="cae${AZ_PROJECT}"
export AZ_POSTGRES_DB_NAME="postgres${AZ_PROJECT}"
export AZ_POSTGRES_SERVER_NAME="psql${AZ_PROJECT}"
export AZ_POSTGRES_USERNAME="pgadmin"

read -r -s -p "PostgreSQL administrator password: " AZ_POSTGRES_PASSWORD
printf '\n'
export AZ_POSTGRES_PASSWORD
```

The random suffix reduces resource-name collisions; it doesn't guarantee global availability. If the PostgreSQL server name is unavailable, choose another suffix for `AZ_POSTGRES_SERVER_NAME` before creating the server. Keep the other resource identifiers unchanged.

These environment variables are used throughout the rest of this module. Retain them in this Bash shell, and don't rerun the random-name and password block between units. The separate terminal used for HTTP requests doesn't need the database password.

Next, create a resource group:

```bash
az group create \
    --name "$AZ_RESOURCE_GROUP" \
    --location "$AZ_LOCATION"
```

## Create an instance of Azure Database for PostgreSQL

You'll now create an ordinary managed PostgreSQL 16 server with the Burstable B1ms SKU and 32 GiB of Premium SSD storage. The selected region must support this version and SKU and have available subscription capacity. Resolve any quota or policy failure before continuing.

Register the PostgreSQL provider and wait for registration to complete:

```bash
az provider register --namespace Microsoft.DBforPostgreSQL --wait
```

> [!IMPORTANT]
> This exercise temporarily allows database connection attempts from all public IPv4 addresses. Authentication is still required. Use a new server and resource group dedicated to the exercise, complete the later firewall restriction, and delete the exercise resources when finished. This initial network setting isn't a production recommendation.

Create the PostgreSQL server:

```bash
az postgres flexible-server create \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --location "$AZ_LOCATION" \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password="$AZ_POSTGRES_PASSWORD" \
    --public-access All \
    --tier Burstable \
    --sku-name Standard_B1ms \
    --storage-type Premium_LRS \
    --storage-size 32 \
    --version 16 \
    --yes \
    --output none
```

The `--public-access All` option enables the public endpoint and creates the single all-addresses firewall rule used later in this module. The later [Azure-services exception](/azure/postgresql/security/security-firewall-rules) still uses that public endpoint and permits connection attempts from Azure resources, including other customers' subscriptions. It isn't private or application-only access.

After server creation succeeds, explicitly [create the application database](/cli/azure/postgres/flexible-server/db):

```bash
az postgres flexible-server db create \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --name "$AZ_POSTGRES_DB_NAME" \
    --output none
```

Verify that the database exists before starting the application:

```bash
az postgres flexible-server db show \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --name "$AZ_POSTGRES_DB_NAME" \
    --query name \
    --output tsv
```

The returned name must match the value of `AZ_POSTGRES_DB_NAME`. These database commands use `--server-name` for the server and `--name` for the database.

## Configure Quarkus to access the PostgreSQL database

Get the server's fully qualified domain name (FQDN) and build a JDBC URL without credentials:

```bash
export AZ_POSTGRES_HOST=$(
    az postgres flexible-server show \
        --resource-group "$AZ_RESOURCE_GROUP" \
        --name "$AZ_POSTGRES_SERVER_NAME" \
        --query fullyQualifiedDomainName \
        --output tsv
)
export AZ_POSTGRES_JDBC_URL="jdbc:postgresql://${AZ_POSTGRES_HOST}:5432/${AZ_POSTGRES_DB_NAME}?sslmode=require"
```

This URL uses `sslmode=require` to require encrypted transport. Username and password are supplied separately through the datasource properties, so characters such as `&` in a password aren't parsed as URL parameters. Don't print or trace credential values.

Encryption isn't certificate identity verification. `sslmode=require` doesn't verify the server certificate and hostname. If you need that verification, follow the [pgJDBC `verify-full` guidance](https://jdbc.postgresql.org/documentation/ssl/) and [Azure certificate-trust instructions](/azure/postgresql/security/security-tls-how-to-connect), including trusted root configuration. Merely changing the mode without configuring trust isn't a complete certificate-validation procedure.

## Configure the Quarkus application to connect to the PostgreSQL database

In `src/main/resources/application.properties`, replace the existing unprofiled datasource URL and schema-generation entries with the following four lines. Remove any unprofiled datasource username or password entries too. Keep the `${...}` expressions literal in the file; don't replace them with credential values. Leave unrelated settings unchanged.

```properties
%dev,prod.quarkus.hibernate-orm.database.generation=update
%dev,prod.quarkus.datasource.jdbc.url=${AZ_POSTGRES_JDBC_URL}
%dev,prod.quarkus.datasource.username=${AZ_POSTGRES_USERNAME}
%dev,prod.quarkus.datasource.password=${AZ_POSTGRES_PASSWORD}
```

These settings apply to the `dev` and `prod` profiles, not automated tests. Development mode uses the Azure database for this unit, and the deployed application uses it in production mode. Tests use a separate [PostgreSQL Dev Service](https://github.com/quarkusio/quarkus/blob/3.18.4/docs/src/main/asciidoc/databases-dev-services.adoc). Keep Docker running when testing or packaging the application. The Maven `package` lifecycle runs the tests; it must not add test records to the Azure database.

Don't export unprofiled `QUARKUS_DATASOURCE_*` overrides. If you previously set any in this shell, remove them before testing or packaging because they override this separation. The `AZ_` variables are resolved only by the profile-scoped expressions. For more information, see the [Quarkus 3.18.4 configuration reference](https://github.com/quarkusio/quarkus/blob/3.18.4/docs/src/main/asciidoc/config-reference.adoc).

## Run the Quarkus application locally to test the remote database connection

A process [inherits environment variables when it starts](https://www.gnu.org/software/bash/manual/html_node/Environment.html). Exporting `AZ_POSTGRES_*` in another terminal doesn't update an already-running Quarkus process, and editing `application.properties` alone isn't sufficient for this transition.

Ensure that the earlier development process has stopped by pressing **Ctrl+C** in its terminal if needed. From the `todo` directory in the Bash shell containing the exported resource and database variables, start the application:

```bash
./mvnw clean quarkus:dev
```

When Quarkus is running, create a few to-dos by using the following cURL commands in a second local Bash terminal. Leave the variable-owning shell running Quarkus:

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

The response should contain the descriptions you submitted, similar to the following output. Identifiers, timestamps, and order can vary, and repeating a POST creates another item.

```json
[
  {
    "id": 1,
    "description": "Take Quarkus MS Learn",
    "details": "Take the MS Learn on deploying Quarkus to Azure Container Apps",
    "done": true,
    "createdAt": "2025-02-26T08:03:28.390854Z"
  },
  {
    "id": 2,
    "description": "Take Azure Container Apps MS Learn",
    "details": "Take the ACA Learn module",
    "done": false,
    "createdAt": "2025-02-26T08:03:34.142249Z"
  }
]
```

If the response contains the items you created, you have successfully run the Quarkus application and connected to the remote PostgreSQL database.

Before continuing to packaging in the next unit, return to the terminal running Quarkus and press **Ctrl+C**. Keep that Bash shell open in the `todo` directory with all the exported variables intact. Don't rerun the random-name and password block; use this same shell for packaging and deployment.
