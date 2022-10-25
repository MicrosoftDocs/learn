Now that you've created a Key Vault, you'll need to add the MySQL database connection string to it.

The `MySqlConnection`object is configured using a connection string. A connection string contains key-value pairs separated by semicolons. For every key-value pair, the option name and its corresponding value are joined by an equality sign.

For example, for a `MySqlConnection`object configured to connect to a MySQL server at`137.0.0.1`, with a user name of root and a password `lnmop`. The default database for all statements will be the mydb`test`database.

```Bash
"server=137.0.0.1;uid=root;pwd=lnmop;database=mydbtest"
```

Add the username and password of the Azure Database for MySQL Single Server admin account as secrets to your Key Vault, run the following commands from the Git Bash prompt:

```Bash
az keyvault secret set \
    --name SPRING-DATASOURCE-USERNAME \
    --value myadmin@$SQL_SERVER_NAME \
    --vault-name $KEYVAULT_NAME

az keyvault secret set \
    --name SPRING-DATASOURCE-PASSWORD \
    --value $SQL_ADMIN_PASSWORD \
    --vault-name $KEYVAULT_NAME
```
