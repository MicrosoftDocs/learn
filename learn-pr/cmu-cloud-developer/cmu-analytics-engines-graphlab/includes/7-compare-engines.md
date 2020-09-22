Here we conclude our discussion of distributed analytics engines for the cloud, in which we presented Hadoop MapReduce, Spark, and GraphLab as effective and popular frameworks for distributed programming. Each of these three engines takes care of the following aspects of distributed computation on behalf of the user:

- Design and implement an appropriate programming model (message passing or shared memory), and resolve all the associated synchronization and consistency issues 
- Develop the computation model (synchronous or asynchronous) 
- Specify the parallelism model (graph parallel, data parallel, iterative), and encode the necessary partitioning and mapping algorithms 
- Design the underlying architectural structure (master-subordinate or peer-to-peer) 
- Implement an effective task/vertex scheduling strategy (push-based or pull-based)

The following table compares the three engines on each of these dimensions. MapReduce and Spark employ a data-parallel design, while GraphLab programs are executed in graph-parallel fashion. MapReduce and Spark both suggest synchronous computation models, while GraphLab makes both synchronous and asynchronous engines available to the user. MapReduce suits applications that are relatively loosely connected or embarrassingly parallel (with little or no dependency/communication between parallel tasks) and that involve noniterative computations with large data volumes. Spark optimizes the MapReduce model for applications that need to iteratively apply map and reduce functions to data. On the other hand, GraphLab fits more strongly connected applications (with high degrees of dependency between parallel tasks/vertices) and applications that involve iterative computations with little data per task/vertex. GraphLab also includes specific optimizations that allow for balanced and efficient distribution of work among nodes processing graphs that have power-law distribution, such as social and web graphs.

Here's a comparison of distributed analytics engines:

| | MapReduce | Spark | GraphLab |
|---|---|---|---|
| **Programming model** | Message passing | Message passing | Message passing|
| **Computation model** | Synchronous | Synchronous | Synchronous and asynchronous|
| **Parallelism model** | Data parallel | Iterative data parallel | Graph parallel|
| **Architectural model** | Master-subordinate | Master-subordinate | Peer-to-peer |
| **Task or vertex scheduling model** | Pull based | Pull based | Push based |

***

