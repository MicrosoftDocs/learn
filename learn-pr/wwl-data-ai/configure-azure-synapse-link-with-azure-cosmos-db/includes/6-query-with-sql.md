In addition to using a Spark pool, you can also query a Cosmos DB analytical container by using a built-in *serverless* SQL pool in Azure Synapse Analytics. To do this, you can use the `OPENROWSET` SQL function to connect to the linked service for your Cosmos DB database.

## Using OPENROWSET with an authentication key

By default, access to a Cosmos DB account is authenticated by an authentication key. You can use this key as part of a connection string in an `OPENROWSET` statement to connect through a linked service from a SQL pool, as shown in the following example:

```sql
SELECT *
FROM OPENROWSET(​
    'CosmosDB',
    'Account=my-cosmos-db;Database=my-db;Key=abcd1234....==',
    [my-container]) AS products_data
```

> [!TIP]
> You can find a primary and secondary key for your Cosmos DB account on its **Keys** page in the Azure portal.

The results of this query might look something like the following, including metadata and application-defined fields from the items in the Cosmos DB container:

|_rid|_ts|productID|productName|id|_etag |
|--|--|--|--|--|--|
|mjMaAL...==|1655414791|123|Widget|7248f072-11c3-42b1-a368-...|54004b09-0000-2300-... |
|mjMaAL...==|1655414829|124|Wotsit|dc33131c-65c7-421a-a0f7-...|5400ca09-0000-2300-... |
|mjMaAL...==|1655414835|125|Thingumy|ce22351d-78c7-428a-a1h5-...|5400ca09-0000-2300-... |
|...|...|...|...|...|...|

The data is retrieved from the analytical store, and the query doesn't impact the operational store.

## Using OPENROWSET with a credential

Instead of including the authentication key in each call to OPENROWSET, you can define a *credential* that encapsulates the authentication information for your Cosmos DB account, and use the credential in subsequent queries. To create a credential, use the `CREATE CREDENTIAL` statement as shown in this example:

```sql
 CREATE CREDENTIAL my_credential
 WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
 SECRET = 'abcd1234....==';
```

With the credential in place, you can use it in an `OPENROWSET` function like this:

```sql
SELECT *
FROM OPENROWSET(​PROVIDER = 'CosmosDB',
                CONNECTION = 'Account=my-cosmos-db;Database=my-db',
                OBJECT = 'my-container',
                SERVER_CREDENTIAL = 'my_credential'
) AS products_data
```

Once again, the results include metadata and application-defined fields from the analytical store:

|_rid|_ts|productID|productName|id|_etag |
|--|--|--|--|--|--|
|mjMaAL...==|1655414791|123|Widget|7248f072-11c3-42b1-a368-...|54004b09-0000-2300-... |
|mjMaAL...==|1655414829|124|Wotsit|dc33131c-65c7-421a-a0f7-...|5400ca09-0000-2300-... |
|mjMaAL...==|1655414835|125|Thingumy|ce22351d-78c7-428a-a1h5-...|5400ca09-0000-2300-... |
|...|...|...|...|...|...|

## Specifying a schema

The `OPENROWSET` syntax includes a `WITH` clause that you can use to define a schema for the resulting rowset. You can use this to specify individual fields and assign data types as shown in the following example:

```sql
 SELECT *
 FROM OPENROWSET(​PROVIDER = 'CosmosDB',
                 CONNECTION = 'Account=my-cosmos-db;Database=my-db',
                 OBJECT = 'my-container',
                 SERVER_CREDENTIAL = 'my_credential'
 )
 WITH (
    productID INT,
    productName VARCHAR(20)
 ) AS products_data
```

In this case, assuming the fields in the analytical store include **productID** and **productName**, the resulting rowset will resemble the following table:

|productID|productName|
|--|--|
|123|Widget|
|124|Wotsit|
|125|Thingumy|
|...|...|

You can of course specify individual column names in the `SELECT` clause (for example, `SELECT productID, productName ...`), so this ability to specify individual columns may seem of limited use. However, consider cases where the source JSON documents stored in the operational store include multiple levels of fields, as show in the following example:

```json
{
    "productID": 126,
    "productName": "Sprocket",
    "supplier": {
        "supplierName": "Contoso",
        "supplierPhone": "555-123-4567"
    }
    "id": "62588f072-11c3-42b1-a738-...",
    "_rid": "mjMaAL...==",
    ...
}
```

The `WITH` clause supports the inclusion of explicit JSON paths, enabling you to handle nested fields and to assign aliases to field names; as shown in this example:

```sql
 SELECT *
 FROM OPENROWSET(​PROVIDER = 'CosmosDB',
                 CONNECTION = 'Account=my-cosmos-db;Database=my-db',
                 OBJECT = 'my-container',
                 SERVER_CREDENTIAL = 'my_credential'
 )
 WITH (
    ProductNo INT '$.productID',
    ProductName VARCHAR(20) '$.productName',
    Supplier VARCHAR(20) '$.supplier.supplierName',
    SupplierPhoneNo VARCHAR(15) '$.supplier.supplierPhone'
 ) AS products_data
```

The results of this query would include the following row for product 126:

|ProductNo|ProductName| Supplier | SupplierPhoneNo |
|--|--|--|--|
|126|Sprocket|Contoso|555-123-4567|

## Creating a view in a database

If you need to query the same data frequently, or you need to use reporting and visualization tools that rely on `SELECT` statements that don't include the `OPENROWSET` function, you can use a *view* to abstract the data. To create a view, you should create a new database in which to define it (user-defined views in the **master** database aren't supported), as shown in the following example:

```sql
CREATE DATABASE sales_db
   COLLATE Latin1_General_100_BIN2_UTF8;
 GO;

 USE sales_db;
 GO;

 CREATE VIEW products
 AS
 SELECT *
 FROM OPENROWSET(​PROVIDER = 'CosmosDB',
                 CONNECTION = 'Account=my-cosmos-db;Database=my-db',
                 OBJECT = 'my-container',
                 SERVER_CREDENTIAL = 'my_credential'
 )
 WITH (
    ProductNo INT '$.productID',
    ProductName VARCHAR(20) '$.productName',
    Supplier VARCHAR(20) '$.supplier.supplierName',
    SupplierPhoneNo VARCHAR(15) '$.supplier.supplierPhone'
 ) AS products_data
 GO
```

> [!TIP]
> When creating a database that will access data in Cosmos DB, it's best to use a UTF-8 based collation to ensure compatibility with strings in Cosmos DB.

After the view has been created, users and client applications can query it like any other SQL view or table:

```sql
SELECT * FROM products;
```

## Considerations for Serverless SQL pools and Cosmos DB

When planning to use a serverless SQL pool to query data in a Cosmos DB analytical store, consider the following best practices:

- Provision your Cosmos DB analytical storage and any client applications (for example Microsoft Power BI) in the same region as serverless SQL pool.

    *Cosmos DB containers can be replicated to multiple regions. If you have a multi-region container, you can specify a `region` parameter in the OPENROWSET connection string to ensure queries are sent to a specific regional replica of the container.*

- When working with string columns, use the OPENROWSET function with the explicit WITH clause and specify an appropriate data length for the string data.