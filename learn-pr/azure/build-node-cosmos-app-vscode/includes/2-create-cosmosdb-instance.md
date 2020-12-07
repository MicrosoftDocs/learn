Azure Databases extension is a multi-model, globally distributed, NoSQL based database service. It stores data as containers of schemaless documents. Azure Databases extension enables you to distribute data globally, scale performance horizontally, and apply varying levels of consistency according to your organization's requirements. 

You create and manage Azure Databases extension using the Azure portal from a web browser, by writing your applications, and from within tools like Visual Studio Code.

In this unit, you'll learn more about how Azure Databases extension organizes data. You'll see how to use Visual Studio Code to create and maintain Azure Databases extension and containers.

## What is Azure Databases extension?

Azure Databases extension is a service that implements document databases. The data in a document must conform to JSON syntax. A JSON document can contain properties, subdocuments, and arrays of documents. The following example shows a JSON document that stores customer information, as part of a retail application. The **registeredAddress** property is an example of a subdocument:

```JSON
{
    customer: 103248,
    ccNumber: "**** **** **** 1234",
    registeredAddress: {
        number: 4444,
        street: "Some Street",
        city: "Some City",
        state: "Some state"
    },
    expiryDate: "03/31/2020"
}
```

Unlike a table in a relational database, documents in a Azure Databases extension don't follow any defined schema. So the same database can hold a variety of documents with different *shapes* and sizes. For example, you could store varying information about different customers in the same database. Perhaps you could record a complete address history as an array for a customer. You might record additional information, such as their credit worthiness.

> [!NOTE]
> Azure Databases extension adds some fields of its own to your documents. Many of these fields are used for internal purposes, and in most cases you shouldn't modify them directly. The exception is a field named **id**. Azure Databases extension uses this field to identify the document in the database, and each document must have a unique **id**. Azure Databases extension will generate a value for the **id** field automatically, but you can specify your value for each document if you prefer. Specifying your values is useful if you need to use your scheme for tracking documents.

Azure Databases extension provides APIs that let you create, update, delete, and query documents.

The Azure Databases extension service is organized as a hierarchy. At the top is a Azure Databases extension account. The Azure Databases extension account is the unit of security for a set of databases. The Azure Databases extension account specifies the location of the databases together with the security information required to access those databases.

Inside an account, you create one or more databases. You create one or more containers inside each database. You store documents in containers.

Each container is organized as a series of partitions. Partitions *roughly* correspond to the physical files on disk. A large partition might have its file, but several small partitions could be combined into a single file. Each document has a partition key that defines the partition to which it belongs. You use partitioning to store related documents together, and to help optimize the way you access data.

For example, in a retail database, if you store customer documents and the documents describing their orders in a container, you could consider partitioning the documents by customer ID. If you needed to fetch customer and order information together for a specific customer, you could fetch the data from the same partition.

### Azure Databases extension throughput

Azure Databases extension uses the concept of Request Units per second (RU/s) to manage the performance and cost of databases. This measure abstracts the underlying physical resources that need to be provisioned to support the required performance. When you create a database or container, you specify how many RU/s to allocate. You'll incur charges accordingly.

## Azure Databases extension APIs

Azure Databases extension supports several programmatic APIs. These APIs conform as closely as possible to the APIs used by other common NoSQL databases. The intention is to provide an easy migration pathway to Azure Databases extension from these databases, without developers having to learn a whole new paradigm, or make significant changes to their applications. The APIs currently supported are:

- MongoDB
- Cassandra
- Gremlin (a common graph DB API)
- Azure Table Storage
- SQL

The SQL API is a variant of the SQL language used by most relational database management systems. There are restrictions and adaptations for handling sets of schemaless documents rather than tables.

## Use Visual Studio Code to manage Azure Databases extension

If you're using Visual Studio Code as your development environment for building Azure Databases extension databases and applications, you can install the Azure Databases extension extension.

You install the extension from the Extensions Marketplace for Visual Studio Code.

The Azure Databases extension extension provides a graphical user interface that is integrated with Visual Studio Code. Using the extension, you can create, delete, and manage Azure Databases extension accounts, databases, containers, and documents.

:::image type="content" source="../media/2-cosmosdb-extension.png" alt-text="Screenshot of the Azure Databases extension extension in Visual Studio Code as user right-clicks on the Documents node for a contextual menu to create a new document." loc-scope="vs-code":::
