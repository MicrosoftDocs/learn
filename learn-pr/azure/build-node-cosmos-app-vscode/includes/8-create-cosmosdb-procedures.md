You use stored procedures to manipulate one or more documents in a collection. With a stored procedure, you can create, modify, delete, and query data spanning one or many documents in a single logical operation. Stored procedures run using the Cosmos DB service rather than Node.js on a client. The JavaScript engine in Cosmos DB is optimized to get the best performance for stored procedures that generate many writes to the database.

In this unit, you'll learn how Cosmos DB stored procedures work, and the transactional semantics that they provide for multi-write operations. You'll see how to create a stored procedure and process data by using the JavaScript query API. You'll learn about the bounded execution model used by Cosmos DB. You'll see how to call a stored procedure from a Node.js application, how to pass parameters, and how to return results.

## What is a Cosmos DB stored procedure?

A Cosmos DB stored procedure is a JavaScript function that is run by Cosmos DB rather than by a client application. A stored procedure can read and write documents and perform bulk updates as a single request from a client application. The JavaScript engine is optimized to perform batch processing, such as modifying hundreds of documents at a time. Performing an operation that affects many documents from a client application would typically require many requests and network round-trips. Using a stored procedure, you can perform the same operation as a single client request.

A stored procedure belongs to a collection, and can only affect documents in that collection.

Stored procedures run in an environment that is isolated and sandboxed from other operations. Code running in one stored procedure in a collection in a Cosmos DB database cannot inadvertently affect other databases, collections, or server-side operations. When a stored procedure completes execution, its complete contextual environment is removed from its assigned memory-space and cannot be read by (or otherwise affect) code that is subsequently executed in the same memory address space.

Although a Cosmos DB stored procedure is written using JavaScript code, the sandboxed environment places restrictions on the operations it can perform. For example, a stored procure can't read or write files, make requests to external services, or send and receive input from sources outside of the calling environment. These restrictions are designed to protect the integrity of your databases (and those of other users) against external, possibly malicious, agents.

## How stored procedures use transactions

All the database operations carried out in the body of a single stored procedure are atomic, meaning that all the operations are treated as a single logical unit of work, also referred to as a transaction. You can use transactions to protect your data from inconsistencies caused by batches that fail part-way through processing; all the operations in a stored procedure must succeed, or if one operation fails then the preceding changes are undone.

Transactions in Cosmos DB only apply to a single partition of a collection. Since all the operations in a stored procedure are treated as a single transaction, it follows that each execution a stored procedure can only act on a single partition. When you run a stored procedure against a partitioned collection, you must supply the partition key for the target partition as an option to the procedure call.

You should consider how you plan to use stored procedures when you are designing your partitioning strategy, since you will not be able to write stored procedures that affect more than one partition in a single execution. Factors you might consider include:

- If you plan to use stored procedures to operate on one document at a time, then you are free to select any partitioning strategy; each document will always reside in a single partition.
- If you plan to use stored procedures to create, update, or delete documents in bulk, you can only change documents in one partition at a time. You should consider aligning your partitioning strategy accordingly, and you need to be prepared to execute your stored procedures once for each partition you want to affect.
- If you plan to use stored procedures to aggregate or otherwise summarize document properties, you cannot summarize documents from more than one partition in a single stored procedure call. You should consider aligning your partitioning strategy with any aggregations you need to compute, and you need to be prepared to execute your stored procedures once for each partition you want to summarize.

## Access data in a stored procedure

**NEED TO WORK ON THIS**

Stored procedures interact with the database through a well-defined object model that provides access to the current collection, context, request, and response objects. The most important functions are **getContext** and **getCollection**. These functions return the context and collection for the current request. The **collection** object returned by the **getCollection** function provides the following functions for manipulating documents:

- **createDocument**. This method takes a JSON object and adds it as a new document to the collection.
- **replaceDocument**. Use this method to replace a document with a new one. Cosmos DB doesn't support field-by-field modifications of a document. Instead, you overwrite a document with a new one containing the updated values.
- **deleteDocument**
- **queryDocuments**. Use this method to send a SQL request that retrieves matching documents from the collection.
- 

You can use these objects to perform requests that fetch, insert, modify, and delete documents.

```javascript
function clearStudentGrades(academicYear){

    var collection = getContext().getCollection();
    var collectionLink = collection.getSelfLink();
    var response = getContext().getResponse();

    var docQuery = {
        query: "",
        parameters: [
            { name: "", value: ""},
            { name: "" value: ""}
        ]
    };

    var options = );

    var isAccepted = collection.queryDocuments(collectionLink, docQuery, options, function(err, docs, options) {
        TBD
    }


```

Stored procedures need to execute queries and perform other operations against documents in the associated collection. You can use the API functions discussed in the previous unit and exercise, but Cosmos DB provides its own server-side JavaScript query API. The JavaScript query API allows you to compose queries using a fluent JavaScript interface. You can build queries programmatically, by passing predicates to function calls, chaining functions with a similar syntax to JavaScript’s Array built-in object. These queries can be efficiently parsed by the server-side JavaScript engine.

RETURN A response

## Bounded execution

## Call a stored procedure from a client application
