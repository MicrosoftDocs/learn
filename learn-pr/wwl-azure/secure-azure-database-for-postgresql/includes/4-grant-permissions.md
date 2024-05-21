To allow users access to databases hosted on your Azure Database for PostgreSQL server, you must create roles (users) and grant or deny privileges to database objects.

## Create database users in Azure Database for PostgreSQL

1. In Azure Data Studio (or your preferred client tool), connect to your Azure Database for PostgreSQL server with the admin sign-in credentials.
1. With the relevant database as the current database, use `CREATE ROLE` with the relevant options to create a new role (user).
1. As an example, the following query:
    1. Creates a new database named testdb.
    1. Creates a new user with a strong password.
    1. Grants connect privileges to the testdb database.

    ```sql
    CREATE DATABASE testdb;
    CREATE ROLE <db_user> WITH LOGIN NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION PASSWORD '<StrongPassword!>';
    GRANT CONNECT ON DATABASE testdb TO <db_user>;
    ```

    To try the query, you can replace the placeholders with your user information.

1. You can then grant more privileges to objects within the database. For example:

    ```sql
    GRANT SELECT ON ALL TABLES IN SCHEMA <schema_name> TO <db_user>;
    ```

The syntax for CREATE ROLE is:

```sql
CREATE ROLE name [ [ WITH ] option [ ... ] ]
```

WHERE ***option*** can be:

```sql
SUPERUSER | NOSUPERUSER
| CREATEDB | NOCREATEDB
| CREATEROLE | NOCREATEROLE
| INHERIT | NOINHERIT
| LOGIN | NOLOGIN
| REPLICATION | NOREPLICATION
| BYPASSRLS | NOBYPASSRLS
| CONNECTION LIMIT connlimit
| [ ENCRYPTED ] PASSWORD 'password' | PASSWORD NULL
| VALID UNTIL 'timestamp'
| IN ROLE role_name [, ...]
| ROLE role_name [, ...]
| ADMIN role_name [, ...]
```

The optional parameters are:

- **SUPERUSER | NOSUPERUSER** - You can't assign SUPERUSER privileges within Azure Database for PostgreSQL. If not specified, NOSUPERUSER is the default.
- **CREATEDB | NOCREATEDB** - whether the role can create databases. The default is NOCREATEDB.
- **CREATEROLE | NOCREATEROLE** - whether the role can create new roles, that is, execute CREATE ROLE. If CREATEROLE privilege if granted, the role can also alter and drop other roles. NOCREATEROLE is the default.
- **INHERIT | NOINHERIT** - whether the role inherits privileges of roles it's a direct or indirect member of. INHERIT is the default.
- **LOGIN | NOLOGIN** - whether a role is allowed to sign in. A role with the **LOGIN** attribute is a database user. Roles without the LOGIN attribute can be used for managing database privileges. **NOLOGIN** is the default.
- **REPLICATION | NOREPLICATION** - whether a role is a replication role. A role must have this attribute to connect to the server in replication mode and to create or drop replication slots. The REPLICATION attribute is a privileged role that should only be used for replication. NOREPLICATION is the default. You must be a member of azure_pg_admin to create this role.
- **BYPASSRLS | NOBYPASSRLS** - whether a role bypasses every row-level security (RLS) policy. NOBYPASSRLS is the default. You must be a member of azure_pg_admin to create this role.
- **CONNECTION LIMIT** connlimit - specifies how many concurrent connections a role that can sign in can make. -1 is the default. This parameter doesn't place a limit on concurrent connections.
- **[ ENCRYPTED ] PASSWORD 'password'| PASSWORD NULL** - sets the role's password. A password is only used by roles with the LOGIN attribute. If no password is specified, the password is NULL and password authentication fails. Alternatively, explicitly state PASSWORD NULL.
- **VALID UNTIL** 'timestamp'- the date and time after which the role's password is no longer valid. If omitted, there's no time limit on the password.
- **IN ROLE role_name** - one or more roles that the new role is added to as a new member. There isn't an option to add a new role as an administrator; use the GRANT command.
- **IN GROUP role_name** an obsolete alternative to IN ROLE.
- **ROLE role_name** - one or more roles are added as members of the new role. (This change in effect makes the new role a *group*.)
- **ADMIN role_name** - the ADMIN clause is like ROLE, but the named roles are added to the new role WITH ADMIN OPTION, giving them the right to grant membership in this role to others.

> [!NOTE]
> You can change attributes of a role with [ALTER ROLE](https://www.postgresql.org/docs/current/sql-alterrole.html) and remove a role with [DROP ROLE](https://www.postgresql.org/docs/current/sql-droprole.html).
