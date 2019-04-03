<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m03_spark\x-oli-workbook_page\_u05_m03_2_computation_programming_models.xml -->
##  Motivation

MapReduce and similar data-parallel frameworks fail to express many types of distributed applications efficiently. Spark targets a specific subset of these applications- those that reuse a working set of data across multiple rounds of computation. These applications fall in one of three categories: 

- Iterative jobs: Many algorithms (for e.g. most Machine Learning) fall in this category. Although MapReduce can express such computation, each job requires that the data be reloaded from disk, leading to a significant performance penalty. 
- Interactive jobs: Hadoop allows ad hoc queries to be performed on data using tools like Pig and Hive, which allow users to run MapReduce jobs using simple SQL interfaces. Unfortunately, these incur a very high latency because each job requires loading the entire dataset from disk. A faster querying platform is desirable. 
- Streaming jobs: Models that require periodic updates, such as incremental processing systems that periodically renew the stored parameters based on new inputs. 

Generally speaking, MapReduce lacks a data sharing abstraction for leveraging distributed memory. Such an abstraction would allow many applications to have concurrent data access to memory across the cluster. It also suffers from many performance problems due to its inefficient use of resources (e.g. poor memory utilization by spilling to disk after each job). 

One of the frameworks attempting to address these issues is Spark. Spark relies on a special abstraction called **resilient distributed datasets** (RDDs)  to support iterative, interactive and streaming applications. Before discussing RDDs, we first present a high-level overview of the Spark framework. 
##  An Overview of Spark

The goal of any distributed programming framework is to support the execution of a parallel computation across multiple nodes in a performant manner. Consider an iterative application that runs a machine learning algorithm on a large graph. Spark would store this graph as a **Resilient Distributed Dataset (RDD)** (Figure 5.32). The Spark Client would store the details of the program to be executed and map it to Spark-specific operations for a cluster, which comprises of many workers. There is a cluster manager that converts these operations into tasks and executes them on the worker nodes. Any cluster requires applications to be scheduled well to maximise the utilization and improve performance. Spark allows different policies to be used to schedule tasks on the cluster depending upon factors such as the priority, duration, and resources required by each task. 
![Figure 5.32 shows the most important parts of the Spark framework. ](../media/spark_overview.png)

_Figure 5.32 shows the most important parts of the Spark framework._


Spark is implemented in about 14,000 lines of Scala, a statically typed high-level programming language for the Java VM. 

Spark relies on resilient distributed datasets (RDDs), a distributed memory abstraction to support fault-tolerant, in-memory computations on large datasets. Programmers invoke operations on RDDs by passing closures (functions) to workers, which are copied to and executed at these workers. We will explore each part of this system in detail. 

Spark application developers write a driver program to connect to a cluster of workers. The driver defines one or more RDDs and invokes actions on them. The driver also tracks the RDDs’ lineage, which records the history of how this RDD is generated as a Directed Acyclic Graph (DAG). The workers are long-lived processes (running for the entire lifetime of an application) that can store RDD partitions in RAM across operations. 

The `SparkContext` object can connect to several types of cluster managers that handle the scheduling of applications and tasks (Figure 5.33). The cluster manager isolates multiple Spark programs from each other- each application has its own driver and runs on isolated executors coordinated by the cluster manager. Currently, Spark supports applications written in Scala, Java and Python. 
![Figure 5.33: Spark Architecture](../media/spark_cluster.png)

_Figure 5.33: Spark Architecture_


Each Spark application runs as an independent set of processes on a distributed cluster. The driver is the process that runs the main() function of the application and creates a `SparkContext` object. Spark applications are coordinated by the `SparkContext` object. The `SparkContext` in turn connects to a Cluster Manager, which allocates resources across all applications on the cluster. The `SparkContext` object also contains a number of implicit conversions and parameters for use with various Spark features. 

The system currently supports three cluster managers: 

- **Standalone** – a simple cluster manager, included with Spark, makes it easy to setup a cluster. A group of applications submitted in standalone mode will run in first-in-first-out (FIFO) order and each application will try to use all available nodes. 
- **Apache Mesos** – a general cluster manager that can also run Hadoop MapReduce and other distributed applications. Mesos allows static and dynamic sharing of CPU cores between applications. 
- **Hadoop YARN** – covered earlier. Spark supports two deployment modes in YARN. In yarn-cluster mode, the Spark driver runs inside an application master process, which is managed by YARN. Thus the client’s only role is to initiate the application. In yarn-client mode, the driver runs in the client process and the Application Master (AM) is only used to request resources from YARN. When run on YARN, Spark supports Dynamic Resource Allocation, which returns the idle resources allocated to an application back to the global pool. 

Once the `SparkContext` connects to the `ClusterManager`, Spark acquires executors on the worker nodes, which are the actual processes that run computation and store data. After executor is acquired, the Java/Python/Scala code is sent to the executor and run as tasks. Notice that each application has its own executor processes, which run tasks in multiple threads. The executor exists for the entire application lifecycle. 

An advantage of this approach is that applications are isolated from each other. Scheduling decisions are made by individual drivers independent of other applications. Also, executors for different applications are isolated as each one runs in a separate JVM. The disadvantage is that it is more difficult to share data between applications. 

The driver is the process where the `main()` method of the program runs. It has two main roles: 

1. Converting the user program into tasks: At a high-level, a Spark program implicitly creates a logical directed acyclic graph (DAG) of operations. The driver converts this into a physical execution plan. Several optimizations are performed at this point, converting the execution graph into a set of stages, where each stage encompasses multiple tasks. 
1. Scheduling tasks on executors: Once a physical execution plan is created, the driver schedules the running of individual tasks on executors. The driver maintains a global view of all executors. 

Executors are worker processes that are created when the Spark application starts and they run until it ends. Executors run the tasks scheduled by the driver and return the results. Each executor consists of a `BlockManager` which provides in-memory storage for caching RDDs. 

The core of Spark is the execution and storage of Resilient Distributed Datasets, which is explained next. 

|A Note on the Spark Shell|
|--|
| Apart from writing programs, Spark also provides an interactive shell. This provides an easy way to explore Spark’s APIs and allows a tool for interactive analysis of large datasets. The shell supports both Python and Scala (but not Java). |


### References

1. _Zaharia, Matei and Chowdhury, Mosharaf and Franklin, Michael J and Shenker, Scott and Stoica, Ion (2010). Spark: cluster computing with working sets Proceedings of the 2nd USENIX conference on Hot topics in cloud computing_
2. _Zaharia, Matei and Chowdhury, Mosharaf and Das, Tathagata and Dave, Ankur and Ma, Justin and McCauley, Murphy and Franklin, Michael J and Shenker, Scott and Stoica, Ion (2012). Resilient distributed datasets: A fault-tolerant abstraction for in-memory cluster computing Proceedings of the 9th USENIX conference on Networked Systems Design and Implementation_
3. _Hindman, Benjamin and Konwinski, Andy and Zaharia, Matei and Ghodsi, Ali and Joseph, Anthony D and Katz, Randy H and Shenker, Scott and Stoica, Ion (2012). Mesos: A Platform for Fine-Grained Resource Sharing in the Data Center. NSDI_
4. _Vavilapalli, Vinod Kumar and Murthy, Arun C and Douglas, Chris and Agarwal, Sharad and Konar, Mahadev and Evans, Robert and Graves, Thomas and Lowe, Jason and Shah, Hitesh and Seth, Siddharth and others (2013). Apache hadoop yarn: Yet another resource negotiator Proceedings of the 4th annual Symposium on Cloud Computing_