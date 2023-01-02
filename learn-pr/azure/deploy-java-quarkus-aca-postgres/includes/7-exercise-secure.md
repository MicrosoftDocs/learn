In this unit, you'll make sure the PostgreSQL database can only be access by the Quarkus application, not other external client. At the moment, we can access the database from any client (using Azure CLI and running Quarkus locally), which is not secure. So we will add a firewall rule to only allow IP addresses within the Azure Container Apps environment to access the database server.

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

## Change the access of the PostgreSQL server

Azure Database for PostgreSQL is secured by default. Its firewall usually do not allow incoming connections. But when we previously created the PostgreSQL server, we specified the `--public all` parameter to enable external access. This means that the firewall is open to the public. 

You can list the existing firewall rules with the following command:

```bash
az postgres flexible-server firewall-rule list \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group $AZ_RESOURCE_GROUP \
    --output table
```

To change that, we need to update the firewall rules of the PostgreSQL server.
In our case, it's just a matter of removing the public rule. To do that, execute the following command:

```bash
az postgres flexible-server firewall-rule delete \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group $AZ_RESOURCE_GROUP \
    --rule-name <name of the AllowAll firewall rule> \
    --yes
```

Now, execute another command to query the database:

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

You should see:

```bash
Unable to connect to flexible server
```

## Execute the Quarkus application

To make sure the Quarkus application still has access to the database, retrieve all the to-dos by using a new `cURL` request:

```bash
curl https://<value of $AZ_APP_URL>/api/todos
```

This command returns the list of all to-do items from the database. The PostgreSQL server is still accessible from the Quarkus application but not from the outside. 
