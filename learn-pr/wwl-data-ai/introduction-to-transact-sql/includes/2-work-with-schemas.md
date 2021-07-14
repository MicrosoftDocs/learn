In SQL Server database systems, tables are defined within *schemas* to create logical namespaces in the database. For example, a **Customer** table might be defined in a **Sales** schema, while a **Product** table is defined in a **Production** schema. The database might track details of orders that customers have placed in an **Order** table in the **Sales** schema. You then might also need to track orders from suppliers for product components in an **Order** table in the **Production** schema.

:::image type="content" source="../media/schema.png" alt-text="A schema named Sales containing Order and Customer tables, and a schema named Production containing Order and Product tables":::

Database systems such as SQL Server use a hierarchical naming system. This multi-level naming helps to disambiguate tables with the same name in different schemas. The *fully qualified* name of an object includes the name of a database server instance in which the database is stored, the name of the database, the schema name, and the table name. For example: **Server1.StoreDB.Sales.Order**.

When working with tables within the context of a single database, it's common to refer to tables (and other objects) by including the schema name. For example, **Sales.Order**.
