Because you deployed the Spring PetClinic application with the default H2 in-memory database, you might want to connect it to a more powerful, persistent database like PostgreSQL. Using a persistent database ensures that your application data is stored even when the application is restarted, providing greater durability and scalability for production use.

> [!NOTE]
> This unit is optional. You can skip it if you're already familiar with database configurations.

## Create the PostgreSQL server

Use the following commands to set environment variables used to create the database connections:

### [Bash](#tab/bash)

```bash
export POSTGRESQLSERVER="petclinic-server"
export DATABASE="petclinic"
```

### [PowerShell](#tab/powershell)

```powershell
$Env:POSTGRESQLSERVER = "petclinic-server"
$Env:DATABASE= "petclinic"
```

---

### Update spring.profiles.active for PostgreSQL

Use the following command to update the environment variables of the deployed container apps to set the database as PostgreSQL:

#### [Bash](#tab/bash)

```azurecli
az containerapp update \
    --resource-group $RESOURCE_GROUP \
    --name $APP_NAME \
    --set-env-vars "spring.profiles.active"="postgres"
```

#### [PowerShell](#tab/powershell)

```powershell
az containerapp update `
    --resource-group $RESOURCE_GROUP `
    --name $APP_NAME `
    --set-env-vars "spring.profiles.active"="postgres"
```

---

### Create a new database

To create a database within a new PostgreSQL flexible server instance, use the following steps:

1. Create a PostgreSQL flexible server by using the following command:

    #### [Bash](#tab/bash)

    ```azurecli
    az postgres flexible-server create \
        --resource-group $RESOURCE_GROUP \
        --name $POSTGRESQLSERVER
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    az postgres flexible-server create `
        --resource-group $RESOURCE_GROUP `
        --name $POSTGRESQLSERVER
    ```

    ---

1. Find the auto-generated admin username and password in the output, then save these credentials in a secure place. You can optionally use them later to connect and configure the database.

1. Create a new database in the PostgreSQL flexible server instance by using the following command:

    #### [Bash](#tab/bash)

    ```azurecli
    az postgres flexible-server db create \
        --resource-group $RESOURCE_GROUP \
        --database-name $DATABASE \
        --server-name $POSTGRESQLSERVER
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    az postgres flexible-server db create `
        --resource-group $RESOURCE_GROUP `
        --database-name $DATABASE `
        --server-name $POSTGRESQLSERVER
    ```

    ---

    For more information, see [Quickstart: Create an instance of Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/quickstart-create-server-cli).

### Connect via Service Connector

Next, connect your previously deployed container app to the PostgreSQL database by using the following steps:

1. In the Azure portal, navigate to your Azure Container Apps instance.
1. Go to **Settings** > **Service Connector**.
1. Select **Create**, and then fill out the connection form using the following details:
   - **Basic**:
      - For **Service type**, use **DB for PostgreSQL flexible server**.
      - For **PostgreSQL flexible server**, use **petclinic-server**.
      - For **PostgreSQL database**, use **petclinic**.
      - For **Client type**, use **SpringBoot**.
   - **Authentication**:
      - Select **Connection string**.
      - Fill in values for the **Username** and **Password** fields, and leave the other fields with their default settings.

    :::image type="content" source="../media/service-connector.png" alt-text="Screenshot of the Azure portal that shows the Service Connector (preview) page and the Create connection pane." lightbox="../media/service-connector.png":::

1. Confirm and deploy your changes.
1. After the deployment is ready, select **Validate** to validate your connection status.

For more information, see [Connect to PostgreSQL Database from a Java Quarkus Container App without secrets using a managed identity](/azure/container-apps/tutorial-java-quarkus-connect-managed-identity-postgresql-database).

## Validate the database setup

The configuration is complete. If you connect to your PostgreSQL database, you can see that the table was created, which should be similar to the one shown in the following example:

```output
           List of relations
| Schema | Name            | Type  |
|--------|-----------------|-------|
| public | owners          | table |
| public | pets            | table |
| public | specialties     | table |
| public | types           | table |
| public | vet_specialties | table |
| public | vets            | table |
| public | visits          | table |
```
