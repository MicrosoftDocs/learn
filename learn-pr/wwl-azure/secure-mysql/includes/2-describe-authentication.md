Authentication in Azure Database for MySQL is implemented by authenticating the username, the host from which the user is connecting from, and a password. The user account has permissions associated with it.

In Azure Database for MySQL user accounts have a password and role assigned to them, which have one or more associated permissions. The account defines who can connect to the MySQL server, and what they are allowed to do once they are connected. When each query is passed to the parser, the client account is checked to ensure it has the correct permissions to execute the query.

> [!NOTE]
> In the MySQL world the username and host name are two separate entities that work together. That means that the same username with a different host name is permitted.

Display the permissions for an account by running a query in MySQL Workbench:

```sql
SHOW GRANTS FOR 'account_name'
```
