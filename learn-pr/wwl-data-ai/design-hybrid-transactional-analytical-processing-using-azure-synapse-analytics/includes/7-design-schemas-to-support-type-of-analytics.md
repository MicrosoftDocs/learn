Now that you understand how the data is transformed and represented in the analytical store, there are some additional considerations that you would wish to take into account when you model your data to enable it to more comfortably support analytical queries of the analytical store.

## Mixed entity types per container

You may want to mix different document entity types (entities) in the same container, which is useful to efficiently retrieve data for both entities using a single query. For example, you could put both customer profile and sales order data in the same container and partition it by customerId. In such a situation, you would usually add a field to your documents that identifies the entity type of each document to differentiate between them at query time. In the following sample documents, you will see that the type is added for this purpose in the following example documents: 

```json
{
  "id": "54AB87A7-BDB9-4FAE-A668-AA9F43E26628",
  "type": "customer",
  "name": "Franklin Ye",
  "customerId": "54AB87A7-BDB9-4FAE-A668-AA9F43E26628",
  "address": {
    "streetNo": 15850,
    "streetName": "NE 40th St.",
    "postcode": 98052
  }
}


{
  "_id": "000C23D8-B8BC-432E-9213-6473DFDA2BC5",
  "type": "salesOrder",
  "customerId": "54AB87A7-BDB9-4FAE-A668-AA9F43E26628",
  "orderDate": "2014-02-16T00:00:00",
  "shipDate": "2014-02-23T00:00:00",
  "details": [
    {
      "sku": "BK-R64Y-42",
      "name": "Road-550-W Yellow, 42",
      "price": 1120.49,
      "quantity": 1
    }
  ]
}
```

The following query on against the transactional store would return the customer details and all orders associated with this one customer.

```sql
SELECT * FROM c WHERE c.customerID = "54AB87A7-BDB9-4FAE-A668-AA9F43E26628"
```

Whilst this approach to modeling is potentially useful for your Cosmos DB transactional store queries. All documents within a single container are mapped to a single analytical store, leading to sparsely populated column stores with the different data types needing to be further separated at the time of running an analytical query.

Recommendation: As with many design decisions, there is a trade-off between the efficiency of querying the transactional store and the ease of querying the analytical store. Carefully evaluate the usefulness of storing a mix of different document entity types in the same container to your transactional workloads. If you choose to do so, you will be required to filter by the property entity type property you selected.

## Embedding entity arrays

When optimizing transactional data models, we choose to embed entities within an array in a document, especially for read heavy workloads where: 

- There are contained relationships between entities.
- There are one-to-few relationships between entities.
- There is embedded data that changes infrequently.
- There is embedded data that will not grow without bound.
- There is embedded data that is queried frequently together.

Due to the fact that there are one to few relationships between the embedded entities that are represented within a single document, and that these are mapped to a single column within a single row within the analytical store. The entire embedded entity array will reside within a single column value, and need to be translated from its JSON representation at the time of querying in order to retrieve embedded entity values, irrespective of which of the two modes of schema representation being used.

Recommendation: Again, a balance needs to be struck between the usefulness of the entity embedding within the transactional application and the added complexity of writing queries against embedded JSON documents for your application.

## Partitioning of data

All data within an Azure Cosmos DB container is partitioned based on the partition key, and applies to both the transactional store and the analytical store. Boundaries for parallelizing workloads are based on this partition key. 

The orderliness associated when data appears in the analytical store for a query is only guaranteed within a partition.  As an example, when documents (1) (2) (3) are inserted in the transactional store into a single partition, they are guaranteed to be present in the analytical store in the order in which they were inserted.
