After you've added a linked service for your analytical store enabled Cosmos DB database, you can use it to query the data using a Spark pool in your Azure Synapse Analytics workspace.

## Loading Cosmos DB analytical data into a dataframe

For initial exploration or quick analysis of data from a Cosmos DB linked service, it's often easiest to load data from a container into a dataframe using a Spark-supported language like PySpark (A Spark-specific implementation of Python) or Scala (a Java-based language often used on Spark).

For example, the following PySpark code could be used to load a dataframe named **df** from the data in the **my-container** container connected to using the **my_linked_service** linked service, and display the first 10 rows of data:

```python
 df = spark.read
     .format("cosmos.olap")\
     .option("spark.synapse.linkedService", "my_linked_service")\
     .option("spark.cosmos.container", "my-container")\
     .load()

display(df.limit(10))
```

Let's suppose the **my-container** container is used to store items similar to the following example:

```json
{
    "productID": 123,
    "productName": "Widget",
    "id": "7248f072-11c3-42b1-a368-...",
    "_rid": "mjMaAL...==",
    "_self": "dbs/mjM...==/colls/mjMaAL...=/docs/mjMaAL...==/",
    "_etag": "\"54004b09-0000-2300-...\"",
    "_attachments": "attachments/",
    "_ts": 1655414791
}
```

The output from the PySpark code would be similar to the following table:

|_rid|_ts|productID|productName|id|_etag |
|--|--|--|--|--|--|
|mjMaAL...==|1655414791|123|Widget|7248f072-11c3-42b1-a368-...|54004b09-0000-2300-... |
|mjMaAL...==|1655414829|124|Wotsit|dc33131c-65c7-421a-a0f7-...|5400ca09-0000-2300-... |
|mjMaAL...==|1655414835|125|Thingumy|ce22351d-78c7-428a-a1h5-...|5400ca09-0000-2300-... |
|...|...|...|...|...|...|

The data is loaded from the analytical store in the container, not from the operational store; ensuring that there's no querying overhead on the operational store. The fields in the analytical data store include the application-defined fields (in this case **productID** and **productName**) and automatically created metadata fields.

After loading the dataframe, you can use its native methods to explore the data. For example, the following code creates a new dataframe containing only the **productID** and **productName** columns, ordered by the **productName**:

```python
products_df = df.select("productID", "productName").orderBy("productName")

display(products_df.limit(10))
```

The output of this code would look similar this table:

|productID|productName|
|--|--|
|125|Thingumy|
|123|Widget|
|124|Wotsit|
|...|...|

### Writing a dataframe to a Cosmos DB container

In most HTAP scenarios, you should use the linked service to read data into Spark from the analytical store. However you *can* write the contents of a dataframe to the container as shown in the following example:

```python
mydf.write.format("cosmos.oltp")\
    .option("spark.synapse.linkedService", "my_linked_service")\
    .option("spark.cosmos.container", "my-container")\
    .mode('append')\
    .save()
```

> [!NOTE]
> Writing a dataframe to a container updates the *operational* store and can have an impact on its performance. The changes are then synchronized to the analytical store.

## Using Spark SQL to query Cosmos DB analytical data

Spark SQL is a Spark API that provides SQL language syntax and relational database semantics in a Spark pool. You can use Spark SQL to define metadata for tables that can be queried using SQL.

For example, the following code creates a table named **Products** based on the hypothetical container used in the previous examples:

```sql
%%sql

-- Create a logical database in the Spark metastore
CREATE DATABASE mydb;

USE mydb;

-- Create a table from the Cosmos DB container
CREATE TABLE products using cosmos.olap options (
    spark.synapse.linkedService 'my_linked_service',
    spark.cosmos.container 'my-container'
);

-- Query the table
SELECT productID, productName
FROM products;
```

> [!TIP]
> The `%%sql` keyword at the beginning of the code is a *magic* that instructs the Spark pool to run the code as SQL rather than the default language (which is usually set to PySpark).

By using this approach, you can create a logical database in your Spark pool that you can then use to query the analytical data in Cosmos DB to support data analysis and reporting workloads without impacting the operational store in your Cosmos DB account.
