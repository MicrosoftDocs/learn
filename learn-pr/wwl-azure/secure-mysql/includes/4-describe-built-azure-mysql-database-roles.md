Azure role-based access control (RBAC) allows you to manage access to Azure resources by assigning Azure roles. RBAC works with three elements:

- **Security principal** - a user, group, service principle, or managed identity.
- **Role definition** - a set of permissions or restrictions.
- **Scope** - a context that access or restrictions are applied to.

When an Azure Database for MySQL server is created, it includes built-in server roles, and you can also create custom roles. Azure Database for MySQL allows you to view and change access to the server from the **Access control (IAM)** menu.

## Add role assignment

To assign a role definition to a user or group:

1. In the Azure portal navigate to your MySQL server. From the left menu, select **Access control (IAM)**.
1. Select **+ Add** from the top menu and select **Add role assignment**. A list of role definitions is displayed with a description of each.
1. Select the role definition you want to assign, and then select **Members**.
1. Select **Assign access to User, group, or service principal**.
1. Next to Members, select **+ Select members**. A list of users is displayed. Select one or more users or groups, and then choose **Select**.
1. To assign, select **Review + Assign**.

Use Azure RBAC to control access to the Azure Database for MySQL server. Within individual databases, use SQL queries to create users and configure user permissions.

> [!NOTE]
> Azure RBAC does not affect user permissions within the database. To create database users, you must sign in with admin credentials. Using a client tool such as MySQL Workbench, connect to your database server. To create a non-admin user, use the CREATE USER statement. Replace db_user with the user name, StrongPassword with a strong password, and testdb with your database name, then execute the following code:

```sql
CREATE USER 'db_user'@'%' IDENTIFIED BY 'StrongPassword!';

GRANT ALL PRIVILEGES ON testdb . * TO 'db_user'@'%';

FLUSH PRIVILEGES;
```

You can verify permissions by using the `SHOW GRANTS` statement, again replacing the placeholder values with your values:

```sql
USE testdb;

SHOW GRANTS FOR 'db_user'@'%';
```

To define what a user can do with a database, use the `GRANT` statement, replacing the placeholder values with your values:

```sql
CREATE USER 'new_master_user'@'%' IDENTIFIED BY 'StrongPassword!';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER ON *.*

TO 'new_master_user'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;
```

> [!NOTE]
> This article contains references to the term *slave*, a term that Microsoft no longer uses. When the term is removed from the software, we'll remove it from this article.
