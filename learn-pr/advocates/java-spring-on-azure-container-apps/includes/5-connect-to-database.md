Because you deployed the Spring PetClinic application with the default H2 in-memory database, you might want to connect it to a more powerful, persistent database like PostgreSQL. Using a persistent database ensures that your application data is stored even when the application is restarted, providing greater durability and scalability for production use.

> [!NOTE]
> This unit is optional. You can skip it if you're already familiar with database configurations.

## Create the PostgreSQL server

The Azure Database for PostgreSQL flexible server name becomes part of the server's public DNS name (`<name>.postgres.database.azure.com`), so it must be globally unique across Azure. The following commands append a random number to the server name so the value is unique for your run:

### [Bash](#tab/bash)

```bash
export POSTGRESQLSERVER="petclinic-$RANDOM"
export DATABASE="petclinic"
```

### [PowerShell](#tab/powershell)

```powershell
$Env:POSTGRESQLSERVER = "petclinic-$(Get-Random -Maximum 99999)"
$Env:DATABASE = "petclinic"
```

---

### Create a new database

To create a database within a new PostgreSQL flexible server instance, use the following steps:

> [!IMPORTANT]
> The `--public-access 0.0.0.0` option in the next command creates the `AllowAllAzureServicesAndResourcesWithinAzureIps` firewall rule on the PostgreSQL flexible server (start IP and end IP both set to `0.0.0.0`). That rule allows connection attempts from any Azure service in **any** Azure subscription — including subscriptions owned by other Azure customers — not just yours. The rule is used here only because it's the simplest way for the container app and the PostgreSQL flexible server to reach each other inside a short walkthrough. For production workloads, use private networking (VNet integration) or private endpoints, or replace the rule with an explicit allowlist that names only the container app's outbound IP addresses. Also create a least-privileged application database user for the container app rather than reusing the auto-generated server **admin** credentials. For more information, see [Add firewall rules](/azure/postgresql/network/how-to-networking-servers-deployed-public-access-add-firewall-rules) and [Networking with public access (allowed IP addresses)](/azure/postgresql/flexible-server/concepts-networking-public).

1. Create a PostgreSQL flexible server by using the following command. The command uses the location variable that you set in the previous unit, enables public access from Azure services so the container app can reach the server, and lets the CLI auto-generate admin credentials:

    #### [Bash](#tab/bash)

    ```azurecli
    az postgres flexible-server create \
        --resource-group $RESOURCE_GROUP \
        --name $POSTGRESQLSERVER \
        --location $LOCATION \
        --public-access 0.0.0.0
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    az postgres flexible-server create `
        --resource-group $Env:RESOURCE_GROUP `
        --name $Env:POSTGRESQLSERVER `
        --location $Env:LOCATION `
        --public-access 0.0.0.0
    ```

    ---

1. Find the auto-generated admin user name and password in the previous command's output. The password is shown only once and can't be retrieved later from the server resource. If you lose it, reset it with `az postgres flexible-server update --resource-group $RESOURCE_GROUP --name $POSTGRESQLSERVER --admin-password <new-password>` (Bash) or the corresponding `$Env:` form in PowerShell. Capture the credentials into environment variables that the later container app commands use. Use an interactive `read` or `Read-Host` prompt so the shell doesn't interpret special characters such as `"`, `$`, or `\` that the generated password might contain:

    #### [Bash](#tab/bash)

    ```bash
    read -r -p "Paste the PostgreSQL admin user name: " PGADMINUSER
    export PGADMINUSER
    read -r -s -p "Paste the PostgreSQL admin password: " PGADMINPASSWORD
    echo
    export PGADMINPASSWORD
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    $Env:PGADMINUSER = Read-Host -Prompt "Paste the PostgreSQL admin user name"
    $securePgPassword = Read-Host -Prompt "Paste the PostgreSQL admin password" -AsSecureString
    $Env:PGADMINPASSWORD = [System.Net.NetworkCredential]::new('', $securePgPassword).Password
    ```

    ---

1. Create a new database in the PostgreSQL flexible server instance by using the following command:

    #### [Bash](#tab/bash)

    ```azurecli
    az postgres flexible-server db create \
        --resource-group $RESOURCE_GROUP \
        --name $DATABASE \
        --server-name $POSTGRESQLSERVER
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    az postgres flexible-server db create `
        --resource-group $Env:RESOURCE_GROUP `
        --name $Env:DATABASE `
        --server-name $Env:POSTGRESQLSERVER
    ```

    ---

    For more information, see [Quickstart: Create an instance of Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/quickstart-create-server-cli).

### Configure the container app to use PostgreSQL

> [!IMPORTANT]
> Support for Service Connector (preview) on Azure Container Apps ended on March 30, 2026. New Service Connector connections can't be created on container apps after that date. The following steps configure the same Spring Boot connection by using Azure Container Apps secrets and environment variables, which is the migration path that Microsoft recommends. For more information, see [Connect a container app to a cloud service with Service Connector](/azure/container-apps/service-connector).

Use the following steps to point the deployed container app at the new PostgreSQL flexible server. The steps activate the `postgres` Spring profile, store the database password as an Azure Container Apps secret, and set the connection environment variables that the PetClinic `application-postgres.properties` file reads (`POSTGRES_URL`, `POSTGRES_USER`, and `POSTGRES_PASS`).

1. Store the PostgreSQL admin password as a Container Apps secret on the deployed container app by using the following command:

    #### [Bash](#tab/bash)

    ```azurecli
    az containerapp secret set \
        --resource-group $RESOURCE_GROUP \
        --name $APP_NAME \
        --secrets "postgres-password=$PGADMINPASSWORD"
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    az containerapp secret set `
        --resource-group $Env:RESOURCE_GROUP `
        --name $Env:APP_NAME `
        --secrets "postgres-password=$Env:PGADMINPASSWORD"
    ```

    ---

1. Activate the `postgres` Spring profile and set the database connection environment variables on the container app by using the following command. The `POSTGRES_PASS` value uses `secretref:` to read the password from the secret you created in the previous step. The JDBC URL includes `?sslmode=require` so the connection is encrypted with TLS, which Azure Database for PostgreSQL flexible server requires for all client connections. The module uses `?sslmode=require` for walkthrough simplicity; see the note that follows for the additional change you need for production workloads.

    > [!IMPORTANT]
    > `sslmode=require` only tells the PostgreSQL JDBC driver to refuse a connection that isn't encrypted with TLS. In this mode the driver doesn't validate the server certificate, so the connection isn't protected against a man-in-the-middle attacker who can present a substitute certificate. For production workloads, change the `?sslmode=require` suffix on `POSTGRES_URL` to `?sslmode=verify-full`, which is the PostgreSQL JDBC value for full certificate-chain and hostname verification. (The Azure Database for PostgreSQL TLS overview page describes this same concept as `verify-all`; the value that the JDBC driver actually accepts is `verify-full`.) Use `?sslmode=verify-ca` only when you can't make clients connect by using a hostname that matches the server certificate, for example because of a private DNS configuration. Both modes require the PostgreSQL JDBC driver to trust the root CAs that Azure Database for PostgreSQL flexible server currently chains to. Configure that trust either by pointing the driver at a PEM file with the `sslrootcert` connection parameter (or the default `~/.postgresql/root.crt` / `%APPDATA%\postgresql\root.crt` file the driver loads when `sslrootcert` isn't set), or by configuring a Java trust store when using the appropriate JDBC SSL factory. For the full Java truststore configuration steps, including the `keytool -importcert` commands for the current root CAs, see [Connect clients with TLS security to your database](/azure/postgresql/security/security-tls-how-to-connect#combine-and-update-root-ca-certificates-for-java-applications) and the [Recommended configurations for TLS](/azure/postgresql/security/security-tls#recommended-configurations-for-tls) in the Azure Database for PostgreSQL TLS overview.

    #### [Bash](#tab/bash)

    ```azurecli
    az containerapp update \
        --resource-group $RESOURCE_GROUP \
        --name $APP_NAME \
        --set-env-vars \
            "spring.profiles.active=postgres" \
            "POSTGRES_URL=jdbc:postgresql://$POSTGRESQLSERVER.postgres.database.azure.com:5432/$DATABASE?sslmode=require" \
            "POSTGRES_USER=$PGADMINUSER" \
            "POSTGRES_PASS=secretref:postgres-password"
    ```

    #### [PowerShell](#tab/powershell)

    ```powershell
    az containerapp update `
        --resource-group $Env:RESOURCE_GROUP `
        --name $Env:APP_NAME `
        --set-env-vars `
            "spring.profiles.active=postgres" `
            "POSTGRES_URL=jdbc:postgresql://$($Env:POSTGRESQLSERVER).postgres.database.azure.com:5432/$($Env:DATABASE)?sslmode=require" `
            "POSTGRES_USER=$Env:PGADMINUSER" `
            "POSTGRES_PASS=secretref:postgres-password"
    ```

    ---

    The container app picks up the new environment variables on its next revision and connects to the PostgreSQL flexible server by using the connection string built from `POSTGRES_URL`, the admin user name in `POSTGRES_USER`, and the password resolved from the `postgres-password` secret. The PostgreSQL server firewall already allows access from Azure services because the `az postgres flexible-server create` command earlier in this unit sets `--public-access 0.0.0.0`.

For more information, see [Manage secrets in Azure Container Apps](/azure/container-apps/manage-secrets) and [Manage environment variables on Azure Container Apps](/azure/container-apps/environment-variables).

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
