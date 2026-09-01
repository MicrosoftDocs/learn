Views are saved queries that you can create in your databases. A single view can reference one or more tables. And, just like a table, a view consists of rows and columns of data. You can use views as a source for your queries in much the same way as tables. However, views don't persistently store data; the definition of your view is unpacked at runtime and the source objects are queried.

The apparent similarity between a table and a view provides an important benefit. Your applications can be written to use views instead of the underlying tables, shielding the application from making changes to the tables. This provides you with an additional layer of security for your data.

As long as the view continues to present the same structure to the calling application, the application will also receive consistent results.  This way, views can be considered an application programming interface (API) to a database for purposes of retrieving data.

> [!NOTE]
> Views must be created by a database developer or administrator with appropriate permission in the database.

## Create a view

To create a view, you use the `CREATE VIEW` statement to name and store a single `SELECT` statement. You'd create a view using the following syntax:

```sql
CREATE [ OR ALTER ] VIEW [ schema_name . ] view_name [ ( column [ ,...n ] ) ]
[ WITH <view_attribute> [ ,...n ] ]
AS select_statement
[ WITH CHECK OPTION ]
[ ; ]
```

Use `OR ALTER` to create a new view or redefine an existing one without a separate `DROP VIEW` step. `WITH CHECK OPTION` prevents `INSERT` or `UPDATE` operations through the view from producing rows that fall outside the view's `SELECT` criteria.

The `WITH` clause supports the following view attributes:

| Option | Description |
|---|---|
| `SCHEMABINDING` | Binds the view to the schema of its base tables, preventing changes that would break the view. Required for indexed views. |
| `ENCRYPTION` | Encrypts the view definition in the system catalog so it can't be read. |
| `VIEW_METADATA` | Returns view metadata (rather than base-table metadata) to client APIs. |

> [!NOTE]
> The `ORDER BY` clause is not permitted in a view definition unless the view uses a TOP, OFFSET/FETCH, or FOR XML element.


For example, to create a view named **Sales.CustOrders** based on a custom `SELECT` statement that encompasses multiple tables, you could write the following query:

```sql
CREATE VIEW Sales.CustOrders
AS
SELECT
  O.custid, 
  DATEADD(month, DATEDIFF(month, 0, O.orderdate), 0) AS ordermonth,
  SUM(OD.qty) AS qty
FROM Sales.Orders AS O
  JOIN Sales.OrderDetails AS OD
    ON OD.orderid = O.orderid
GROUP BY custid, DATEADD(month, DATEDIFF(month, 0, O.orderdate), 0);
```

Notice that most of the code within the example consists of your `SELECT` statement. The `SELECT` statements inside view definitions can be as complex or simple as you want them to be.

## Query a view

To query a view and retrieve results from it, refer to it in the `FROM` clause of a `SELECT` statement, as you would refer to a table. For example, to return the customer ID, the order month, and the quantity of items from each order in your **Sales.CustOrders** view, you could run the following query:

```sql
SELECT custid, ordermonth, qty
FROM Sales.CustOrders;
```
