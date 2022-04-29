While it is straightforward to add bulk support to your applications, there are a couple of best practices.

## Configure the partition key

You are not required to provide the partition key for many of the operations on the Container class; the SDK will determine it automatically from your class. However, this will add to your overhead in a bulk scenario and could create needless complexity. It’s a good practice to provide the partition key to the operation if you already have it.

## Use stream API in serialize-deserialize scenarios

If you are building an API, avoid unnecessary serialization and deserialization. For example, you are sometimes forced to deserialize and serialize going to and from some database platforms. With Azure Cosmos DB SQL API, you can use the Stream variants of common item operations to avoid unnecessary performance overhead. This is especially true when using the bulk features of the SDK.

## Configure worker task per partition key

If your items are already separated into logical partition keys, you can create a list of worker tasks per partition key. Each worker task in that list can then spawn child tasks for each operation within that logical partition key. This setup would de facto create a hierarchy of tasks which coordination of per item operations.
