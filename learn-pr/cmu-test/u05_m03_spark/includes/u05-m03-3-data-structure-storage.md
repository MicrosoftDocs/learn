<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m03_spark\x-oli-workbook_page\_u05_m03_3_data_structure_storage.xml -->
##  Spark Resilient Distributed Datasets

Spark relies on a special abstraction called resilient distributed datasets (RDDs). RDDs are in-memory read-only objects partitioned across the cluster. They let users control persistence and partitioning settings to optimize data placement and manipulate this data using a rich set of operators. An RDD is partitioned across machines either based on a range (partitioning of consecutive records) or the hash of a key in each record. Each partitioning method is optimal for a particular use case (hash partitioning speeds up joins by providing locality to records from different datasets that share keys; range partitions speed up access to a small filtered subset of the data). 

Despite not needing to exist on physical storage, RDDs can be fault-tolerant. However, they do not need to be replicated; rather they have a notion of lineage by which they “remember” the set of operations that were executed to construct them, allowing them to be rebuilt if they lose data. A handle to an RDD contains enough information to recompute it from a version of the data stored on-disk. 

All work in Spark is expressed either as creating new RDDs, transforming existing RDDs or running operations on RDDs. One important thing to realize about RDDs is that they are _lazily computed_ and _ephemeral_. Lazy computation is an optimization whereby many transformations are pipelined, and the RDD is computed only when it is first used with an “action”. Ephemeral means that RDDs may be materialized (computed and loaded in memory) when used in a parallel application but that they are subsequently discarded from memory. 
|Aspect|RDDs|Distributed Shared Memory|
|--|--|--|
|Reads|Coarse or Fine-Grained|Fine-Grained|
|Writes|Coarse-Grained|Fine-Grained|
|Consistency|Trivial (Immutable)|Up to Application / Runtime|
|Fault Recovery|Fine-Grained and low-overhead using lineage|Requires checkpoints and program rollback|
|Straggler Mitigation|Possible using backup tasks|Difficult|
|Work Placement|Automatic based on data locality|Up to Application (runtimes aim for transparency)|
|Behavior if not enough RAM|Similar to existing data flow systems|Poor performance (Swapping)|


The RDD abstraction is a type of distributed shared collection system, similar to traditional Distributed Shared Memory (DSM) systems. It may be interesting to compare the two abstractions. 

Unlike DSMs, which allow read/writes to individual memory locations, Spark only allows coarse-grained transformations of RDDs. Also, RDDs enable a low overhead recovery mechanism using lineage, unlike the coordinated checkpointing needed by DSM systems. Similar to MapReduce, stragglers can be mitigated using speculative execution of slow tasks. 

Next, let’s discuss the lifecycle of an RDD. 
##  Creating RDDs

By default, in the Spark programming model, an RDD is represented as a Scala object (though it could also be a Python or Java object). It can be constructed in several ways: 

1. From a file on a distributed file system like HDFS 
1. By parallelizing a collection/array and distributing it to many nodes 
1. By transforming an existing RDD (we will discuss transform operations below) 
1. By changing the persistence level of an existing RDD using one of two actions: 
    - _cache_: this is a hint to the framework to keep the RDD in-memory after the first computation to ensure reuse 
    - _save_: writes the data to a distributed filesystem like HDFS


Examples of creating new RDDs (these commands can be tried out in the Spark Scala shell): 

1. We load a text file ( `server.logs`) into a string RDD using the Python `textFile()` method. 
``` java
&gt;&gt;&gt; log_lines_RDD = sc.textFile("server.logs")
```


1. We parallelize an existing RDD:
``` java
&gt;&gt;&gt; greeting_lines_RDD = sc.parallelize(["hello", "world"]) 
```


##  Operations on RDDs

Once created, an RDD supports two types of operations (see Figure 5.34): 

1. _Transformations_: Operations that create new RDDs from existing ones 
1. _Actions_: Computations on an RDD that return a single object to the driver 

As mentioned earlier, Spark transformations are lazy by default, i.e. they are not computed immediately, rather they are batched and executed only when an action is executed. The execution of an action causes all RDDs in the lineage to be materialized. However, once the computation is completed, an RDD will persist only if explicitly required to by the program. 
![Figure 5.34 : Operations on RDDs](../media/RDD.png)

_Figure 5.34 : Operations on RDDs_


Here are some examples of transformations and actions: 
|Transformation|Meaning|Action|Meaning|
|--|--|--|--|
| `map(func)`|Return a new RDD formed by passing each element of the source through function func.| `reduce(func)`|Aggregate the elements of the dataset using function func (which takes two arguments and returns one). The function should be associative so that it can be computed correctly in parallel.|
| `filter(func)`|Return a new RDD by selecting those elements of the source on which func returns true.| `collect()`|Return all the elements of the RDD as an array at the driver program. This is usually useful after a filter or other operation that returns a sufficiently small subset of the data.|
| `join(otherDataset, [numTasks])`|When called on two RDDs of type `(K, V)` and `(K, W)` respectively, returns a RDD of `(K, (V, W))` pairs with all pairs of elements for each key.| `count()`|Return the number of elements in the RDD.|


We will explore these in more detail in the next page where we look at some sample programs. For now, let us look at a few simple examples to understand the basic operations allowed by an RDD. 

1. _Transformations_
``` text
&gt;&gt;&gt; log_lines_RDD = sc.textFile("server.logs")
&gt;&gt;&gt; xss_RDD =  log_lines_RDD.filter(lambda x: "%3C%73%63%72%69%70%74%3E" in x)
&gt;&gt;&gt; sqli_RDD =  log_lines_RDD.filter(lambda x: "bobby_tables" in x)
&gt;&gt;&gt; owasp_attacks_RDD = xss_RDD.union(sqli_RDD)
```


The Python code above filters `log_lines_RDD` to find attacks against a web server by searching for lines matching a particular signature string. 

`filter()` does not modify the original RDD, rather we now have 2 new RDDs. The `log_lines_RDD` can still be used in the future. `union()` is a transformation that acts on 2 RDDs to form a combined owasp_attacks_RDD . 

1. _Actions_
``` text
&gt;&gt;&gt; log_lines_RDD = sc.textFile("server.logs")
&gt;&gt;&gt; xss_RDD =  log_lines_RDD.filter(lambda x: "%3C%73%63%72%69%70%74%3E" in x)
&gt;&gt;&gt; sqli_RDD =  log_lines_RDD.filter(lambda x: "bobby_tables" in x)
&gt;&gt;&gt; owasp_attacks_RDD = xss_RDD.union(sqli_RDD)
```


Here, the Python code counts the number of attacks in our combined `owasp_attacks_RDD`. An action forces materialization. In many `examplesRDD.count()` is often used to force materialization during local testing of Spark code. 

Clearly, RDDs are best suited for batch operations where the same operations are applied to all elements of the dataset. Applications requiring asynchronous, fine-grained updates would need more specialized systems. Since they are immutable, the overhead of computing new RDDs for each additional input item is very high. Hence, even when dealing with real-time data inputs, Spark often batches the changes over short periods of time. 

1. _Persisting RDDs_
RDDs may be persisted in four ways:
    1. _In-memory as deserialized objects_: 
A deserialized object expresses a data structure as a set of bytes. Storing the raw deserialized RDD objects in-memory has the highest performance, since the framework can access the elements natively in code. However, there is a some overhead, since apart from the data, the metadata of the object is also stored. For e.g., Java objects are fast to access, but consume 2-5x more space than the raw data that they encapsulate. 

    1. 
_In-memory as serialized data_: 
By serializing the RDD, the associated data is stored in a well-defined format. This method is slower than storing deserialized objects, but is more memory-efficient than storing object graphs.


    1. _On-disk storage_: 
This helps store really large RDDs that do not fit in-memory but shouldn’t be continuously recomputed. 

    1. _Off-heap storage_: 
Off-heap storage is provided by a special memory-centric storage system called Tachyon, which enables cluster-wide reliable data sharing at memory-speed.




In all four cases, the RDD is stored in partitions across the workers. Each partition is an atomic piece of the dataset. When running out of memory because of a high rate of incoming data, in-memory RDD partitions are generally dealt with using an LRU eviction policy. However, if the least-recently used partition belongs to the same RDD as the arriving partition, it is not evicted to prevent thrashing. 

RDDs are recomputed by default for every action executed on them. In order to reuse an RDD in multiple actions, the RDD. `persist()` method can be called. RDDs can be persisted in several places as outlined in the following table: 
|Level|Space used|CPU time|In memory|On disk|Comments|
|--|--|--|--|--|--|
| `MEMORY_ONLY`|High|Low|Y|N||
| `MEMORY_ONLY_SER`|Low|High|Y|N||
| `MEMORY_AND_DISK`|High|Medium|Some|Some|Spills to disk if there is too much data to fit in memory.|
| `MEMORY_AND_DISK_SER`|Low|High|Some|Some|Spills to disk if there is too much data to fit in memory. Stores serialized representation in memory.|
| `DISK_ONLY`|Low|High|N|Y||


Spark also allows data to be persisted into a cluster-wide in-memory cache. When data is accessed frequently, for e.g. a small “hot” dataset or when running an iterative algorithm, this technique can be extremely useful to improve performance. RDDs also have an `unpersist()` method to remove it from the persistent store. 

Of course, to achieve all these properties using RDDs, we also must choose a suitable representation to store them. Any representation must be able to track lineage across a wide range of transformations, which users can combine in arbitrary ways. Spark uses a simple graph-based representation for RDDs. Each RDD is accessed through a common interface which exposes five features: a set of partitions (atomic pieces of the dataset), a set of dependencies (on parent RDDs), a function for computing the dataset based on its parent(s), metadata about the partitioner, and a list of preferred nodes where each partition can be accessed faster due to locality. 
|Operation|Meaning|
|--|--|
| `partitions()`|Return a list of Partition objects|
| `preferredLocations(p)`|List nodes where partition p can be accessed faster due to data locality|
| `dependencies()`|Return a list of dependencies|
| `iterator(p, parentIters)`|Compute the elements of partition p given iterators for its parent partitions|
| `partitioner()`|Return metadata specifying whether the RDD is hash/range partitioned|


Consider that our input dataset consists of files on HDFS. By default, `partitions()` returns a list for each HDFS block encompassed by the file. Each Partition object in this list is represented by the block’s offset. Since this is an HDFS system, `preferredLocations(p)` returns the list of nodes storing a local copy of the block. The `iterator(p, parentIters)` simply reads the block. 

At this stage, we have looked at RDDs and some of the basic operations on them. In the next pages, we will cover more detailed examples to understand how RDDs help Spark achieve very high performance for many types of applications and also how they enable fault tolerance and recovery. 