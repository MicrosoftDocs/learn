<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u04_cloud_storage\_u04_m03_NoSQL_databases_case_studies\x-oli-workbook_page\_u04_m03_6_summary.xml -->

##  Case Studies: NoSQL Databases Summary

- Apache HBase is an open-source version of Google's BigTable distributed storage system. Both systems are distributed, scalable, high-performance, versioned databases.
- HBase organizes data into tables, with each row of a table being indexed by a key, and data are stored in columns. Multiple columns can be grouped together into column families.
- HBase columns do not need to be typed; columns can be added on demand. HBase stores data on a disk columnwise, making it a columnar database.
- Data stored in HBase rows are versioned; by default, operations apply to the newest version of the data.
- HBase supports the Get, Put, Scan, and Delete operations.
- HBase is organized as a cluster of nodes; one node is designated the master, and the others are known as regionservers. ZooKeeper is used to manage the cluster. HDFS is typically used to store data in HBase. 
- Data in a table are partitioned into regions and assigned individual regionservers; the HBase master keeps a record of the region assignments.
- HBase is not fully ACID compliant, particularly with operations that span rows. In such cases, subsequent requests for data from HBase can return stale data.
- HBase is best suited for big-data storage and supports fast access to multiple rows for aggregations. Multiple interfaces allow for connectivity to MapReduce and to<!-- or for --> Web applications.
- HBase does not support joins, and its consistency model must be considered<!-- taken into account --> while designing applications.
- MongoDB is a document store that stores doucuments in collections.
- MongoDB stores data internally using the Binary JSON (BSON) format.
- MongoDB can be scaled to multiple clusters using replication and sharding.
- MongoDB is popular for applications that require scale-out, have the need for fast, bulk writes, as well as data that needs to have geo-spatial indices.
- Cassandra is a fully distributed, structured key-value storage system, which uses<!-- takes --> multiple design aspects of BigTable and Dynamo.
- A table in Cassandra is known as a _column family_, with each record indexed by a key and consisting of columns; multiple columns can be grouped together into a super column.
- A row in Cassandra is returned as a sequence of nested key-value pairs.
- Typical operations in Cassandra include Gets, Inserts, and Deletes. They can be performed on individual rows, on groups of rows (a range), and on a group of columns (a slice).
- Cassandra runs on a cluster of nodes using decentralized, peer-to-peer architecture. Cassandra uses the local storage on each node to store data.
- Cassandra nodes are arranged into a token ring, and Cassandra automatically distributes rows among the various nodes in the cluster using the hash value of the key of each row through consistent hashing. Every node is aware of all other nodes in the token ring and automatically forwards client requests to the correct node.
- Cassandra replicates rows across nodes on the basis of a user-defined replication factor. 
- Every operation in Cassandra is performed with a user-defined consistency level. The consistency level provides a tunable tradeoff of consistency versus performance for every operation.
- Specialized algorithms in Cassandra are utilized to handle failure detection; Cassandra nodes can temporarily keep track of write requests to offline nodes and forward them when the node comes back online (hinted handoff).
- Cassandra's ACID properties are configurable on a per-operation basis.
- Cassandra is popular because of its feature set, and its tunable consistency model provides a great deal of flexibility in designing applications.
- DynamoDB is a managed NoSQL service provided by AWS.
- DynamoDB's data model allows for a key to be designated as the primary, no other schema is required.
- DynamoDB is a good choice for applications that require a low-latency key-value store.