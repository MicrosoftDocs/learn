
A partition key has two components: **partition key path** and the **partition key value**. For example, consider an item `{ "userId" : "Andrew", "worksFor": "Microsoft" }` if you choose "userId" as the partition key, the following are the two partition key components:

* The partition key path (for example: "/userId"). The partition key path accepts alphanumeric and underscore(_) characters. You can also use nested objects by using the standard path notation(/).

* The partition key value (for example: "Andrew"). The partition key value can be of string or numeric types.

Selecting your partition key is a simple but important design choice in Azure Cosmos DB. Once you select your partition key, it is not possible to change it in-place. If you need to change your partition key, you should move your data to a new container with your new desired partition key.

For **all** containers, your partition key should:

* Be a property that has a value which does not change. If a property is your partition key, you can't update that property's value.

* Have a high cardinality. In other words, the property should have a wide range of possible values.

* Spread request unit (RU) consumption and data storage evenly across all logical partitions. This ensures even RU consumption and storage distribution across your physical partitions.

## Partition keys for read-heavy containers

For large read-heavy containers you might want to choose a partition key that appears frequently as a filter in your queries. Queries can be [efficiently routed to only the relevant physical partitions](/azure/cosmos-db/how-to-query-container#in-partition-query) by including the partition key in the filter predicate.

If most of your workload's requests are queries and most of your queries have an equality filter on the same property, this property can be a good partition key choice. 

However, if your container is small, you probably don't have enough physical partitions to need to worry about the performance impact of cross-partition queries. If your container could grow to more than a few physical partitions, then you should make sure you pick a partition key that minimizes cross-partition queries.

Your container will require more than a few physical partitions when either of the following are true:

* Your container will have over 30,000 RUs provisioned

* Your container will store over 100 GB of data

## Using item ID as the partition key

If your container has a property that has a wide range of possible values, it is likely a great partition key choice. One possible example of such a property is the *item ID*. For small read-heavy containers or write-heavy containers of any size, the *item ID* is naturally a great choice for the partition key.

The system property *item ID* exists in every item in your container. You may have other properties that represent a logical ID of your item. In many cases, these are also great partition key choices for the same reasons as the *item ID*.

The *item ID* is a great partition key choice for the following reasons:

* There are a wide range of possible values (one unique *item ID* per item).
* Because there is a unique *item ID* per item, the *item ID* does a great job at evenly balancing RU consumption and data storage.
* You can easily do efficient point reads since you'll always know an item's partition key if you know its *item ID*.

Some things to consider when selecting the *item ID* as the partition key include:

* If the *item ID* is the partition key, it will become a unique identifier throughout your entire container. You won't be able to have items that have a duplicate *item ID*.
* If you have a read-heavy container that has a lot of [physical partitions](/azure/cosmos-db/partitioning-overview#physical-partitions), queries will be more efficient if they have an equality filter with the *item ID*.
* You can't run stored procedures or triggers across multiple logical partitions.
