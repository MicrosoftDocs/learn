Azure Cosmos DB supports multiple APIs, enabling developers to easily migrate data from commonly used NoSQL stores and apply their existing programming skills. When you provision a new Cosmos DB instance, you select the API that you want to use. The choice of API depends on many factors including, the type of data to be stored, the need to support existing applications, and the API skills of the developers who will work with the data store.

## Core (SQL) API

The native API in Cosmos DB manages data in JSON document format, and despite being a NoSQL data storage solution, uses SQL syntax to work with the data.

A SQL query for a Cosmos DB database containing customer data might look similar to this:

```sql
SELECT *
FROM customers c
WHERE c.id = "joe@litware.com"
```

The result of this query consists of one or more JSON documents, as shown here:

```json
{
   "id": "joe@litware.com",
   "name": "Joe Jones",
   "address": {
        "street": "1 Main St.",
        "city": "Seattle"
    }
}
```

## MongoDB API

MongoDB is a popular open source database in which data is stored in Binary JSON (BSON) format. The Azure Cosmos DB MongoDB API enables developers to use MongoDB client libraries to and code to work with data in Azure Cosmos DB.

MongoDB Query Language (MQL) uses a compact, object-oriented syntax in which developers use *objects* to call *methods*. For example, the following query uses the **find** method to query the **products** collection in the **db** object:

```javascript
db.products.find({id: 123})
```

The results of this query consist of JSON documents, similar to this:

```json
{
   "id": 123,
   "name": "Hammer",
   "price": 2.99}
}
```

## Table API

 The Table API is used to work with data in key-value tables, similar to Azure Table Storage. The Azure Cosmos DB Table API offers greater scalability and performance than Azure Table Storage.

 For example, you might define a table named **Customers** like this:

| PartitionKey | RowKey | Name | Email |
| --- | --- | --- | --- |
| 1 | 123 | Joe Jones | joe@litware.com |
| 1 | 124 | Samir Nadoy | samir@northwind.com |

You can then use the Cosmos DB Table API through one of the language-specific SDKs to make calls to your service endpoint to retrieve data from the table. For example, the following request returns the row containing the record for *Samir Nadoy* in the table above:

```text
https://endpoint/Customers(PartitionKey='1',RowKey='124')
```

## Cassandra API

 The Cassandra API is compatible with Apache Cassandra, which is a popular open source database that uses a column-family storage structure. Column families are tables, similar to those in a relational database, with the exception that it's not mandatory for every row to have the same columns.

For example, you might create an **Employees** table like this:

| ID | Name | Manager |
| --- | --- | --- |
| 1 | Sue Smith | |
| 2 | Ben Chan | Sue Smith |

Cassandra supports a syntax based on SQL, so a client application could retrieve the record for *Ben Chan* like this:

```sql
SELECT * FROM Employees WHERE ID = 2
```

## Gremlin API

 The Gremlin API is used with data in a graph structure; in which entities are defined as *vertices* that form nodes in connected graph. Nodes are connected by *edges* that represent relationships, like this:
 
 ![A graph showing employees and departments and the connections between them](../media/graph.png)
 
 The example in the image shows two kinds of vertex (employee and department) and edges that connect them (employee "Ben" reports to employee "Sue", and both employees work in the "Hardware" department).

 Gremlin syntax includes functions to operate on vertices and edges, enabling you to insert, update, delete, and query data in the graph.  For example, you could use the following code to add a new employee named *Alice* that reports to the employee with ID **1** (*Sue*)

```
g.addV('employee').property('id', '3').property('firstName', 'Alice')
g.V('3').addE('reports to').to(g.V('1'))
```

The following query returns all of the *employee* vertices, in order of ID.

 ```
 g.V().hasLabel('employee').order().by('id')
 ```
