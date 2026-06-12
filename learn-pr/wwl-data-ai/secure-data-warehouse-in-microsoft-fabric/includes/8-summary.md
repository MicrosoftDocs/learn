In this module, you learned how to apply data protection controls to a Microsoft Fabric warehouse.

- **Dynamic data masking** obscures column values in query results without changing the underlying data. You define masking rules at the column level and control who can see real values using the `UNMASK` permission.
- **Row-level security** filters which rows a user can see at query time, using a filter predicate and a security policy. Predicates apply to all users — including admins — so always write an explicit exception for admin access.
- **Column-level security** restricts access to specific columns using `GRANT` and `DENY`. Power BI Direct Lake queries fall back to Direct Query mode when column-level security is applied to a table.
- **SQL granular permissions** control access at the object level — tables, views, functions, and stored procedures. Apply the principle of least privilege: grant only the permissions each user or application needs to do its job.

## Learn more

- [Security for data warehousing in Microsoft Fabric](/fabric/data-warehouse/security?azure-portal=true)
- [Dynamic data masking in Fabric data warehousing](/fabric/data-warehouse/dynamic-data-masking?azure-portal=true)
- [Row-level security in Fabric data warehousing](/fabric/data-warehouse/row-level-security?azure-portal=true)
- [Column-level security in Fabric data warehousing](/fabric/data-warehouse/column-level-security?azure-portal=true)
- [SQL granular permissions in Microsoft Fabric](/fabric/data-warehouse/sql-granular-permissions?azure-portal=true)