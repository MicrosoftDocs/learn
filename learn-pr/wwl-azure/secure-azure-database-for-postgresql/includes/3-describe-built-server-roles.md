PostgreSQL manages database access using roles. A role can be a database user, or a group of users. Roles can:

- Own database objects such as tables or functions.
- Assign privileges on those objects to other roles.
- Grant membership to another role, allowing the member role to have their privileges.

Your Azure Database for PostgreSQL server is created with three default roles:

- azure_pg_admin
- azuresu
- your server admin user - part of the azure_pg_admin role

View all the server roles by executing the following query:

```sql
SELECT * FROM pg_roles;
```

> [!NOTE]
> Azure Database for PostgreSQL is a managed PaaS service and only Microsoft users have the azuresu (super user) role.

When you created your server, a server admin user was also created. This user automatically became a member of the **azure_pg_admin** role. The Azure Database for PostgreSQL server admin user has the following privileges: LOGIN, NOSUPERUSER, INHERIT, CREATEDB, CREATEROLE, REPLICATION

Now, the server admin user account that you created when the server was created, can:

- Create more users and grant those users into the **azure_pg_admin** role.
- Create less privileged users and roles that have access to individual databases and schemas.

PostgreSQL includes some default roles that can be assigned to users. These include commonly needed privileges for access:

- pg_read_all_settings
- pg_signal_backend
- pg_read_server_files
- pg_write_server_files
- pg_execute_server_program

There are also more specialist roles:

- pg_monitor
- pg_read_all_stats
- pg_stat_scan_tables
- replication

## Create admin users in Azure Database for PostgreSQL

1. In Azure Data Studio (or your preferred client tool), connect to your Azure Database for PostgreSQL server with the admin sign-in credentials.
1. Edit the following SQL code by replacing the placeholders with your username and password:

```sql
CREATE ROLE <new_user> WITH LOGIN NOSUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION PASSWORD '<StrongPassword!>';
GRANT azure_pg_admin TO <new_user>;
```
