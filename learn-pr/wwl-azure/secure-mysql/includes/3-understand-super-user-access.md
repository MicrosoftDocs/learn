The first user that is created when an Azure Database for MySQL server is created is a **Service Administrator**. That user account has SUPER USER access to all resources in the subscription, including creating new users, monitoring the server, etc.

Because an Administrator account has full access to all resources, you should limit and monitor administrator accounts. In particular:

- Keep an inventory of all assigned administrator accounts.
- Assign a co-administrator to provide access when the first administrator is not available.
- Limit administrator accounts to the fewest number that is practical. If an administrator account is compromised, a hacker has full access to the server.
- Monitor behavior and follow up any abnormal account behavior.
- Assign additional administrator accounts only for the duration required to complete a task.

> [!NOTE]
> Administrators are added at the subscription level, and not the server level. In the Azure portal, navigate to the correct Subscription. From the left menu, select **Access control (IAM)**. Select **+Add** and **Add co-administrator**.

See Azure Security Center's Manage access and permissions for guidance on controlling and monitoring administrative accounts.

This server admin user has the following privileges:

```sql
SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER
```

You can then use the first server admin account to create more users and grant admin access to them. You can also use the server admin account to create less privileged users that have access to individual database schemas.

Azure Database for MySQL is a service, and not all roles or are supported, specifically:

- The **DBA** role is restricted. Use the administrator user account that is created with the server. This allows you to perform most DDL and DML statements.
- The **SUPER** privilege is restricted. Use the administrator user account that is created with the server.
- There is no **Root user** in Azure Database for MySQL. Instead, use the **Administrator** user role or **Owner**.

> [!NOTE]
> DEFINER requires super privileges to create and is restricted. If you re importing data using a backup, remove the CREATE DEFINER commands manually or by using the -skip-definer command when performing a [mysqlpump](https://dev.mysql.com/doc/refman/5.7/en/mysqlpump.html).
