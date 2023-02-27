In this unit, you'll make sure the PostgreSQL database can only be access by the Quarkus application, not other external client. At the moment, we can access the database from any client (using Azure CLI and running Quarkus locally), which isn't secure. So we'll add a firewall rule to only allow IP addresses within the Azure Container Apps environment to access the database server.

## Access the PostgreSQL server from the CLI

First, let's make sure we can access the PostgreSQL server from the Azure CLI. To do that, execute the following command:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

You should be able to see the content of the database. That means the database is accessible from the outside.

## Remove the Permissive Firewall Rule

Azure Database for PostgreSQL is secured by default. Its firewall usually doesn't allow incoming connections. But when we previously created the PostgreSQL server, we specified the `--public all` parameter to enable external access. This means that the firewall is open to the public.

You can list the existing firewall rules with the following command:

```bash
az postgres flexible-server firewall-rule list \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --output table
```

You should see the following output:

```bash
StartIpAddress    EndIpAddress     Name                       ResourceGroup            
----------------  ---------------  -------------------------  -----------------------  
0.0.0.0           255.255.255.255  AllowAll_2023-1-3_10-20-4  rg-azure-deploy-quarkus  
```

With a firewall rule like this (the range of allowed IP addresses goes from `0.0.0.0` to `255.255.255.255`), any client can access the database. To make sure only the Quarkus application can access the database, we need to change that and update the firewall rules of the PostgreSQL server.
In our case, it's just a matter of removing the public rule. To do that, execute the following command:

```bash
az postgres flexible-server firewall-rule delete \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --rule-name <name of the AllowAll firewall rule> \
    --yes
```

Now, try to query the database by executing a SQL statement from the CLI:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

After a period of time, the call times out, and you should see:

```bash
Unable to connect to flexible server: connection to server failed: Operation timed out
```

Because we've removed all the firewall rules, even the Quarkus application has no access to the database now. If you try to retrieve the to-dos from the database, it will fail. Execute the following `cURL` request:

```bash
curl https://<value of $AZ_APP_URL>/api/todos
```

## Add a New Firewall Rule

We need to configure the firewall to only accept the access from the Quarkus application. To do that, we need to add a new firewall rule. To do that, execute the following command:

```bash
az postgres flexible-server firewall-rule create \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --rule-name "Allow_Azure-internal-IP-addresses" \
    --start-ip-address "0.0.0.0" \
    --end-ip-address "0.0.0.0"
```

Setting the `start-ip-address` and the `end-ip-address` to `0.0.0.0` allows all Azure-internal IP addresses but doesn't allow any external IP addresses. This is the best practice to secure the database from external access.
If you try to access the database from the CLI, it should fail:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

But if you try to retrieve the to-dos from the database from the Quarkus application running on Azure Container Apps, it will succeed:

```bash
curl https://<value of $AZ_APP_URL>/api/todos
```

This command returns the list of all to-do items from the database. The PostgreSQL server is still accessible from the Quarkus application running on an Azure service, but not from outside of Azure.
