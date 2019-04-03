<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_6_Fault-Tolerance.xml -->
##  Fault Tolerance in GraphLab

To tolerate faults in the event of failures, GraphLab suggests using distributed checkpointing (see the section Main Challenges in Building Cloud Programs) and promotes two distributed checkpointing mechanisms: synchronous and asynchronous. To capture a distributed checkpoint, the synchronous mechanism suspends the entire execution of the update functions across cluster machines. By doing so, the mechanism flushes out all in-transit communication messages (induced internally by the engines) and takes a local checkpoint (snapshot) of all altered data at each machine since the last captured checkpoint. The captured local checkpoints collectively form a distributed checkpoint, which is then stored in files<sup>6</sup> in the engine's underlying storage layer (e.g., HDFS). In case of a machine/engine failure, the distributed checkpoint can be exploited to restart execution.

Although synchronous checkpointing is simple, it introduces a major inefficiency by suspending the entire GraphLab execution to capture a distributed checkpoint. To address this weakness, the asynchronous mechanism specifies at each cluster machine a checkpointing update function that executes on each vertex, collecting snapshots covering the period since the last saved snapshot. At each machine, checkpointing update functions proceed as shown in algorithm 2. They are prioritized over regular update functions (used by GraphLab user programs) and follow the edge consistency model. Hence, when the scope of a vertex _v_ is locked, as required by the edge consistency model, it remains so until algorithm 2 completes at _v_ before proceeding to another vertex. This asynchronous mechanism is based on the Chandy-Lamport checkpointing strategy and guarantees consistent distributed checkpoints. Finally, both synchronous and asynchronous checkpointing mechanisms are triggered by GraphLab at fixed intervals, computed as in Young's "A First Order Approximation to the Optimum Checkpoint Interval."

With fault tolerance, we close our discussion on GraphLab. This engine employs graph-parallel, shared-memory, asynchronous, and peer-to-peer models. It supports three levels of consistency that trade off parallelism against consistency, allowing users to select—from full consistency, edge consistency, and vertex consistency—a level that suits their application needs. It further ensures serializability (requisite for many machine-learning and data-mining [MLDM] algorithms) with respect to the appropriate consistency model. GraphLab also suggests two types of asynchronous engines, Chromatic and Locking. The Chromatic engine executes vertices partially asynchronously, while the Locking engine executes vertices fully asynchronously. The Chromatic engine uses graph coloring and promotes the color-step concept, which is analogous to the super-step concept in the bulk synchronous parallel model. In essence, GraphLab with the Chromatic engine and the edge consistency model can mimic Pregel. Finally, to achieve fault tolerance, GraphLab suggests using synchronous and asynchronous distributed checkpointing. 

______________________________________________________________________________________

_Algorithm 2:_ Capturing Checkpoint at vertex v

______________________________________________________________________________________

- _if_ v was already checkpointed _then_
    - Quit

- Save D<sub>v</sub> //save each vertex
- _foreach u ∈ N[v] do_ //loop over neighbors 
    - _if_ u was not checkpointed _then_
        - Save data on edge D<sub>(u↔v)</sub>
        - Schedule u for a checkpoint capturing


- Mark v as checkpointed 

______________________________________________________________________________________

<sup>6</sup>The distributed checkpoint consists of every local checkpoint captured at every cluster machine. Each local checkpoint can be stored in a file, and all files corresponding to local checkpoints can be associated together (in metadata) in order to indicate that they all belong to the same distributed checkpoint.

### References

1. _K. M. Chandy and L. Lamport (1985). Distributed Snapshots: Determining Global States of Distributed Systems ACM Trans. Comput. Syst., 3(1):63–75_
2. _J. W. Young (1974). A First Order Approximation to the Optimum Checkpoint Interval Commun. ACM, 17:530–531_