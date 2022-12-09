In this unit, you'll configure your Quarkus application to be deployed through Maven. Then you'll create and deploy to an Azure Container Apps instance.

## Configure a firewall rule for your PostgreSQL server

```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

```bash
az postgres flexible-server firewall-rule list \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group $AZ_RESOURCE_GROUP \
    --output table
```

```bash
az postgres flexible-server firewall-rule delete \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --resource-group $AZ_RESOURCE_GROUP \
    --rule-name <name of the AllowAll firewall rule> \
    --yes
```


```bash
az postgres flexible-server execute \
    --name "$AZ_POSTGRES_SERVER_NAME" \
    --database-name "$AZ_POSTGRES_DB_NAME" \
    --admin-user "$AZ_POSTGRES_USERNAME" \
    --admin-password "$AZ_POSTGRES_PASSWORD" \
    --querytext "select * from Todo" \
    --output table
```

```bash
Unable to connect to flexible server
```


```bash
curl https://<value of $APP_URL>/api/todos
```


Azure Database for PostgreSQL is secured by default. Its firewall allows no incoming connections. So add a firewall rule to allow the local IP address to access the database server.

