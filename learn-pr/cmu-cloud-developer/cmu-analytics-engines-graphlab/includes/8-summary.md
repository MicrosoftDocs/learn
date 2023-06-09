- GraphLab is a graph-parallel distributed analytics engine designed for machine-learning and data-mining (MLDM) applications.
- GraphLab programs are executed in two phases: the initialization phase and the execution phase.
- Computation in GraphLab is performed via a user-defined Gather, Apply, Scatter (GAS) operation, which updates the values related to a vertex.
- GraphLab differs from Pregel in that the computation model supports both synchronous and asynchronous computation.
- GraphLab nodes are organized in a peer-to-peer fashion, although the first launched node is designated as the master engine and is used to monitor the system.
- GraphLab supports tunable consistency under the full, edge, and vertex consistency models through the use of different engines, in the order of decreasing consistency and increased parallelism.
- GraphLab provides three engines: synchronous, asynchronous, and asynchronous-serializable.
- To achieve fault tolerance, GraphLab suggests using synchronous and asynchronous distributed checkpointing. 
- MapReduce and Spark are regarded as a data-parallel engines, while GraphLab is characterized as a graph-parallel engine.
- MapReduce suits more loosely connected/embarrassingly parallel applications, Spark suits iterative computations, and GraphLab suits more strongly connected applications that can be expressed in the graph abstraction.
