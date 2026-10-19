In this unit, you replace the PostgreSQL firewall rule that permits connection attempts from all public IPv4 addresses with the Azure-services exception. The database retains its public endpoint. The exception allows Azure services and resources, including this Quarkus application, to attempt authenticated connections; it doesn't restrict access to this application or Container Apps environment.

Continue in the same local Bash shell, or WSL on Windows, with the `AZ_*` variables from the previous exercises. Run the database checks from a non-Azure public source network. Use Azure CLI 2.87.0 or later, and don't rerun the resource-name or password setup.

## Access the PostgreSQL server by using the CLI

First, confirm that you can query the PostgreSQL server from your current client network:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password="$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

Verify that the query returns the to-do items you created earlier. This confirms connectivity from the source network of your shell, not from every client network. Resolve any query error before changing the firewall so that you have a working baseline for the later tests.

## Remove the permissive firewall rule

When you created the new PostgreSQL server, `--public-access All` enabled its public endpoint and created one firewall rule for all public IPv4 addresses.

> [!NOTE]
> These firewall commands use the parameter names introduced in [Azure CLI 2.87.0](/azure/postgresql/release-notes/release-notes-cli#june-02-2026---version-2870): `--server-name` identifies the server and `--name` identifies the firewall rule. The separate `az postgres flexible-server execute` command still uses `--name` for the server. For syntax details, see the [firewall command reference](/cli/azure/postgres/flexible-server/firewall-rule?view=azure-cli-latest&preserve-view=true).

Resolve any failed firewall command before continuing; a rejected command doesn't change the firewall. List the existing rules on your exercise-owned server:

```bash
az postgres flexible-server firewall-rule list \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --output table
```

Find the rule whose `StartIpAddress` is `0.0.0.0` and `EndIpAddress` is `255.255.255.255`. The generated name in the `Name` column varies. This should be the only rule on the new server used in this module. If the result differs, confirm that you're using the exercise-owned server and resolve the discrepancy before continuing. Don't delete unrelated rules from an existing or shared server.

This range permits any public IPv4 source address to attempt a database connection. Clients still need valid PostgreSQL credentials. Remove this rule before adding the Azure-services exception later in the exercise.

PostgreSQL firewall updates can take up to five minutes to apply. Allow time after each successful change before checking connectivity. Repeat the CLI query in a new invocation to test a fresh database connection; an HTTP request to the application is a separate application-level check.

In the following command, replace `<allow-all-rule-name>` with the actual `Name` of the all-addresses rule you just listed. Remove the angle brackets, keep the quotation marks, and delete only that rule:

```bash
az postgres flexible-server firewall-rule delete \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --name "<allow-all-rule-name>" \
    --yes
```

After the deletion succeeds, list the rules again:

```bash
az postgres flexible-server firewall-rule list \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --output table
```

The successful list command should now return no rules. If the command fails or any rule remains, resolve that result before proceeding. An empty list confirms the configured rules, but not that the network update has propagated.

After allowing propagation time, make a new direct database connection by running the query again:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password="$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

After the deletion takes effect, a new database connection should be rejected. Error text depends on the client and network path; for example, PostgreSQL can report that there's no matching `pg_hba.conf` entry. Don't expect a particular timeout message. A successful query immediately after deletion can mean that the firewall change is still propagating.

This no-rule stage intentionally blocks new database connections from the application after the change takes effect. The application's HTTPS endpoint remains public. Quarkus uses pooled database connections, so an HTTP request doesn't necessarily open a new database connection. Inspect the HTTP status and body, but don't use one immediate response as proof that firewall propagation has completed:

```bash
curl --include "https://$AZ_APP_URL/api/todos"
```

The `--include` option displays the HTTP response headers as well as the body. By default, curl doesn't treat an HTTP error status as a command failure, so inspect the status instead of relying on its exit code. For details, see the [curl manual](https://curl.se/docs/manpage.html).

## Add the Azure-services exception

Add the Azure-services exception so that the deployed application can reconnect to the database:

```bash
az postgres flexible-server firewall-rule create \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --name "Allow_Azure-services" \
    --start-ip-address "0.0.0.0" \
    --end-ip-address "0.0.0.0"
```

The starting and ending values `0.0.0.0` enable **Allow public access from any Azure service within Azure to this server**, as described in [PostgreSQL firewall rules](/azure/postgresql/security/security-firewall-rules). This is a service-defined exception on the database's public endpoint, not a private IP address range.

> [!IMPORTANT]
> The exception also permits connection attempts from Azure resources in other customers' subscriptions. It doesn't identify the Quarkus application or restrict access to one environment, subscription, or tenant. Clients must still authenticate. This exercise doesn't configure private networking or application-only access.

After creation succeeds, list the rules again:

```bash
az postgres flexible-server firewall-rule list \
    --server-name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --output table
```

The only rule on this new server should now be `Allow_Azure-services`, with both `StartIpAddress` and `EndIpAddress` set to `0.0.0.0`. If the command fails or the rules don't match this result, resolve the discrepancy before testing connectivity. Allow up to five minutes for the change to take effect.

## Verify database and application access

After allowing propagation time, run the following command in a new invocation from your local development computer on a non-Azure public source network. Use the same working database credentials as the initial query. The database connection should be denied when no other firewall rule permits that source address.

Firewall rules evaluate the source address, not whether the client is Azure CLI. Don't use [Azure Cloud Shell](/azure/cloud-shell/overview) for this negative test: the Azure-services exception can permit its connection. A successful query from an Azure-hosted client with valid credentials doesn't show that the firewall update failed.

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password="$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

After allowing time for the Azure-services exception to take effect, retrieve the to-do items through the deployed application. Check for HTTP 200 and a JSON array containing the to-do items you created earlier:

```bash
curl --include "https://$AZ_APP_URL/api/todos"
```

If a fresh database connection still has an unexpected result after the propagation window, inspect the actual firewall rules and the client's source network before changing credentials. An application response without HTTP 200 and the expected JSON data doesn't pass the positive check.

Direct PostgreSQL connections from non-Azure source addresses are blocked when no other rule permits them. Azure-origin clients with valid database credentials can still connect. The application's HTTPS API remains public; these checks don't establish application-only database isolation.
