Workspace roles and item permissions control broad access to a Fabric warehouse. For production environments, you often need finer control — restricting which users can read specific tables, insert rows into specific objects, or execute specific stored procedures. SQL granular permissions give you that precision.

Fabric warehouses support the standard SQL `GRANT`, `DENY`, and `REVOKE` statements. When a user has both a `GRANT` and a `DENY` on the same permission — from different roles, for example — `DENY` always wins.

## Table and view permissions

The four core data manipulation permissions apply to tables and views:

| Permission | What it allows |
|---|---|
| `SELECT` | Read data from the object. |
| `INSERT` | Add new rows to the object. |
| `UPDATE` | Modify existing rows in the object. |
| `DELETE` | Remove rows from the object. |

```sql
GRANT SELECT ON dbo.SalesReport TO [alice@contoso.com];
DENY SELECT ON dbo.Payroll TO [alice@contoso.com];
```

Within a table or view, you can also apply these permissions at the column level, which pairs naturally with column-level security.

## Function and stored procedure permissions

Functions and stored procedures have their own permission set:

| Permission | What it allows |
|---|---|
| `EXECUTE` | Run the function or stored procedure. |
| `ALTER` | Modify the definition of the object. |
| `CONTROL` | Full ownership-level rights over the object. |

```sql
GRANT EXECUTE ON dbo.usp_GetSalesData TO [bob@contoso.com];
DENY SELECT ON dbo.Sales TO [bob@contoso.com];
```

In many warehouse architectures, users interact with data only through stored procedures, not directly with tables. Granting `EXECUTE` on procedures while denying direct table access is an effective way to enforce a controlled data access pattern.

## Apply the principle of least privilege

Give each user or application only the permissions it needs to do its job — nothing more. In practice:

- An application that reads data through stored procedures should have `EXECUTE` permission on those procedures, not `SELECT` on the underlying tables.
- A reporting role that only needs to read data should have `SELECT` on specific views, not broad table access.
- Temporary elevated access should be revoked once the task is complete.

This approach limits the impact if a credential is compromised or a user accidentally runs a destructive query.
