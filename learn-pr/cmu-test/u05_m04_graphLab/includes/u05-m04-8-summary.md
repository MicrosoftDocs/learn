<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_8_summary.xml -->
##  Comparison of the Various Distributed Analytics Engines

Here we conclude our discussion of distributed analytics engines for the cloud in which we presented Hadoop MapReduce, Spark, and GraphLab as effective and popular frameworks for distributed programming. Each of these three engines take care of the following aspects of distributed computation on behalf of the user:

- Design and implement an appropriate programming model (message passing or shared memory) and resolve all the associated synchronization and consistency issues 
- Develop the computation model (synchronous or asynchronous) 
- Specify the parallelism model (graph parallel, data parallel, iterative) and encode the necessary partitioning and mapping algorithms 
- Design the underlying architectural structure (master-slave or peer to peer) 
- Implement an effective task/vertex scheduling strategy (push based or pull based)

Table 5.4 compares the three engines on each of these dimensions: MapReduce and Spark employ a data-parallel design, while GraphLab programs are executed in graph-parallel fashion. MapReduce and Spark both suggest synchronous computation models, while GraphLab make both synchronous and asynchronous engines available to the user. MapReduce suits applications relatively loosely connected or embarrassingly parallel (with little or no dependency/communication between parallel tasks) and that involve noniterative computations with large data volumes. Spark optimizes the MapReduce model for applications that need to iteratively apply Map and Reduce functions to data. On the other hand, GraphLab fits more strongly connected applications (with high degrees of dependency between parallel tasks/vertices) and that involve iterative computations with little data per a task/vertex. GraphLab also includes specific optimizations that allow for balanced and efficient distribution of work among nodes processing graphs that have power-law distribution, such as social and web-graphs.
||MapReduce|Spark|GraphLab|
|--|--|--|--|
|Programming Model|Message Passing|Message passing|Message Passing|
|Computation Model|Synchronous|Synchronous|Synchronous & Asynchronous|
|Parallelism Model|Data parallel|Iterative Data Parallel|Graph parallel|
|Architectural Model|Master-slave|Master-slave|Peer to peer|
|Task/Vertex Scheduling Model|Pull based|Pull based|Push based|

_Table 5.4: A comparison between the three distributed analytics engines, MapReduce, Pregel, and GraphLab_

##  Distributed Analytics Engines for the Cloud: GraphLab Summary

- GraphLab is a graph-parallel distributed analytics engine designed for machine-learning and data-mining (MLDM) applications.
- GraphLab programs are executed in two phases: the initialization phase and the execution phase.
- Computation in GraphLab is performed via a user-defined Gather, Apply, Scatter (GAS) operations which updates the values related to a vertex.
- GraphLab differs from Pregel in that the computation model is support both synchronous and asynchronous computation.
- GraphLab nodes are organized in a peer-to-peer fashion, although the first launched node is designated as the master engine and is used to monitor the system.
- GraphLab supports tunable consistency under the full, edge, and vertex consistency models through the use of different engines, in the order of decreasing consistency and increased parallelism.
- GraphLab provides three engines: synchronous, asynchronous and asynchronous-serializable.
- To achieve fault tolerance, GraphLab suggests using synchronous and asynchronous distributed checkpointing. 
- MapReduce and Spark are regarded as a data-parallel engines, while GraphLab is characterized as a graph-parallel engine.
- MapReduce suits more loosely connected/embarrassingly parallel applications, Spark suits iterative computations, and GraphLab suits more strongly connected applications that can be expressed in the graph abstraction.