Cosmos DB data is partitioned both logically and physically. It is important to understand partitioning to achieve optimum performance.

You're at an advanced stage of planning for your migration to Cosmos DB. You want to ensure that the migrated system performs optimally for the costs that your will incur. You want to make sure that load is distributed evenly by planning your logical and physical data partitions carefully.

Here, you'll learn how to use partitions to create an efficient database design.

## Logical partitions

A logical partition is a group of items with the same partition key. You define the partition key when you create a collection in Data Explorer and specify the Partition Key or the Shard Key (dependent upon API). With the Cassandra API, the partition key is the primary key. With the Table API, the partition key is defined when each row is added.

It's important to select the correct key for the logical partition because each logical partition has a limit of 10-GB. Also, containers have a per-partition throughput limit specified at creation time. A good partition key would spread queries across logical partitions and is often a filter predicate in commonly used queries. Using a filter predicate as a partition key allows for efficient routing when the query is run.

## Physical partitions

Physical partitions each contain a replica of your data and an instance of the Cosmos DB database engine. This structure makes your data durable and highly available and throughput is divided equally amongst the local physical partitions.
Physical partitions are automatically created and configured, and it's not possible to control their size, location, or which logical partitions they contain. Logical partitions are not split between physical partitions.

## Hot partitions

If you select your partition key poorly, you can end up with queries disproportionately running against a small number of petitions. These are referred to as hot partitions. Furthermore, logical partitions have a limit of 10-GB each.

Although you cannot directly configure physical partitions, the logical partitioning key will have an effect because logical partitions are not split across physical partitions. For example, you are a Europe-wide vacation company and have created a logical partition based on holiday type. In the Summer, over 50% of queries are for Beach. In the winter, over 50% of queries are for Ski. Except for a few shoulder months, almost all queries hit just one logical partition and, therefore, one physical partition.

## Choose a partition key

There are several factors that you should consider when choosing a partition key:
* Using a unique partition key would avoid hot partitions but would result in expensive cross partition queries and prevent transactions that affect multiple documents, because transactions must be in the same logical partition.
* Using a partition key that causes a low number of partitions might cause the size limit of the logical partition to be reached or exceed the RU limit for the partition.
* Try to choose a partition key that spreads data evenly across logical partitions.
* Try to choose a partition key that ensures transactions that run in just one logical partition.
* Try to choose a partition key that produces the results of commonly used queries from just one logical partition for improved efficiency. For example, use a query filter predicate as a partitioning key.
