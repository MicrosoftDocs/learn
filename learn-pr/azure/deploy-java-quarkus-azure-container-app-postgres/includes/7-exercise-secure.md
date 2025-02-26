In this unit, you ensure that the PostgreSQL database can be accessed only by the Quarkus application, and not by other external clients. You can currently access the database from any client by using Azure CLI and running Quarkus locally. This configuration isn't secure. You need to add a firewall rule to allow only IP addresses within the Azure Container Apps environment to access the database server.

## Access the PostgreSQL server by using the CLI

First, make sure you can access the PostgreSQL server by using the Azure CLI. To do that, run this command:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

You should be able to see the content of the database. If you can, the database can be accessed outside of the environment.

## Remove the permissive firewall rule

Azure Database for PostgreSQL provides security by default. Its firewall usually doesn't allow incoming connections. But when you created the PostgreSQL server, you specified the `--public-access "All"` parameter to enable external access, which configured the firewall to be open to the public.

You can list the existing firewall rules by running this command:

```bash
az postgres flexible-server firewall-rule list \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --output table
```

You should see the following output:

```bash
EndIpAddress     Name                       ResourceGroup            StartIpAddress
---------------  -------------------------  -----------------------  ----------------
255.255.255.255  AllowAll_2023-1-3_10-20-4  rgazure-deploy-quarkus  0.0.0.0
```

Notice that the range of allowed IP addresses is `0.0.0.0` through `255.255.255.255`. A firewall rule like this allows any client to access the database. To ensure that only the Quarkus application can access the database, you need to update the firewall rules of the PostgreSQL server.
In this case, it's just a matter of removing the public rule. To remove it, run the following command:

```bash
az postgres flexible-server firewall-rule delete \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --rule-name <name of the AllowAll firewall rule> \
    --yes
```

Now try to query the database by running a SQL statement from the CLI:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

The call eventually times out. You should see this message:

```bash
Unable to connect to flexible server: connection to server failed: Operation timed out
```

Because you removed all the firewall rules, now even the Quarkus application can't access the database. If you try to retrieve the to-dos from the database, the request fails. Run the following cURL request:

```bash
curl https://$AZ_APP_URL/api/todos
```

## Add a new firewall rule

You need to configure the firewall to allow access to only the Quarkus application. You need to add a new firewall rule. To add the rule, run this command:

```bash
az postgres flexible-server firewall-rule create \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --rule-name "Allow_Azure-internal-IP-addresses" \
    --start-ip-address "0.0.0.0" \
    --end-ip-address "0.0.0.0"
```

Setting the `start-ip-address` and the `end-ip-address` to `0.0.0.0` allows access from all Azure-internal IP addresses but doesn't allow access from external IP addresses. This practice helps to secure the database from external access.

If you try to access the database from the CLI by running the following command, the attempt should fail:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

But if you try use the following command to retrieve the to-dos from the database via the Quarkus application that's running on Container Apps, the attempt succeeds:

```bash
curl https://$AZ_APP_URL/api/todos
```

This command returns the list of all to-do items from the database. The PostgreSQL server can be accessed from the Quarkus application that's running on an Azure service, but it can't be accessed from outside of Azure.
