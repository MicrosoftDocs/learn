After creating a lake database, you can store data files that match the table schemas in the appropriate folders in the data lake, and query them using SQL.

## Using a serverless SQL pool

You can query a lake database in a SQL script by using a serverless SQL pool.

For example, suppose a lake database named **RetailDB** contains an **Customer** table. You could query it using a standard SELECT statement like this:

```sql
USE RetailDB;
GO

SELECT CustomerID, FirstName, LastName
FROM Customer
ORDER BY LastName;
```

There is no need to use an OPENROWSET function or include any additional code to access the data from the underlying file storage. The serverless SQl pool handles the mapping to the files for you.

## Using an Apache Spark pool

In addition to using a serverless SQl pool, you can work with lake database tables using Spark SQL in an Apache Spark pool.

For example, you could use the following code to insert a new customer record into the **Customer** table.

```sql
%%sql
INSERT INTO `RetailDB`.`Customer` VALUES (123, 'John', 'Yang')
```

You could then use the following code to query the table:

```sql
%%sql
SELECT * FROM `RetailDB`.`Customer` WHERE CustomerID = 123
```
