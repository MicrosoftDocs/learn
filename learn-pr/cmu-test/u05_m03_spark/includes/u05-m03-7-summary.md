<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m03_spark\x-oli-workbook_page\_u05_m03_7_summary.xml -->

##  Distributed Analytics Engines for the Cloud: Spark

- MapReduce is ill-suited towards certain types of applications which are iterative in nature. This is due to the heavy I/O cost involved in reading inputs from DFS and writing them back to DFS for each iteration.
- Spark is an optimized, in-memory framework suited towards iterative, interactive and streaming applications.
- Spark relies on Resilient Distributed Datasets (RDD), a distributed memory abstraction to support fault-tolerant, in-memory computations on large clusters.
- Spark can either be run in standalone mode, or in a cluster using either Mesos or YARN resource managers
- RDDs are in-memory read-only (immutable) objects partitioned across the cluster. 
- RDDs are fault tolerant by using a lineage tracking technique that keeps track of the sequence operations performed to transform on-disk data to its current form in memory.
- Dependencies in RDDs are classified as either narrow or wide dependencies.
- The Spark ecosystem includes Spark SQL, Spark Streaming, MLlib and GraphX.

##  Unit 5 Checkpoint Quiz